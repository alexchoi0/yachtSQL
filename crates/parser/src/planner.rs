use sqlparser::ast::{self, SetExpr, Statement, TableFactor};
use yachtsql_common::error::{Error, Result};
use yachtsql_common::types::DataType;
use yachtsql_ir::{
    AlterTableOp, Assignment, ColumnDef, Expr, JoinType, LogicalPlan, PlanField, PlanSchema,
    SetOperationType, SetQuantifier, SortExpr,
};
use yachtsql_storage::Schema;

use crate::CatalogProvider;
use crate::expr_planner::ExprPlanner;

pub struct Planner<'a, C: CatalogProvider> {
    catalog: &'a C,
}

impl<'a, C: CatalogProvider> Planner<'a, C> {
    pub fn new(catalog: &'a C) -> Self {
        Self { catalog }
    }

    pub fn plan_statement(&self, stmt: &Statement) -> Result<LogicalPlan> {
        match stmt {
            Statement::Query(query) => self.plan_query(query),
            Statement::Insert(insert) => self.plan_insert(insert),
            Statement::Update {
                table,
                assignments,
                selection,
                ..
            } => self.plan_update(table, assignments, selection.as_ref()),
            Statement::Delete(delete) => self.plan_delete(delete),
            Statement::CreateTable(create) => self.plan_create_table(create),
            Statement::Drop {
                object_type,
                names,
                if_exists,
                ..
            } => self.plan_drop(object_type, names, *if_exists),
            Statement::Truncate { table_names, .. } => self.plan_truncate(table_names),
            Statement::AlterTable {
                name, operations, ..
            } => self.plan_alter_table(name, operations),
            _ => Err(Error::unsupported(format!(
                "Unsupported statement: {:?}",
                stmt
            ))),
        }
    }

    fn plan_query(&self, query: &ast::Query) -> Result<LogicalPlan> {
        let mut plan = self.plan_set_expr(&query.body)?;

        if let Some(ref order_by) = query.order_by {
            plan = self.plan_order_by(plan, order_by)?;
        }

        if let Some(ref limit_clause) = query.limit_clause {
            let (limit_val, offset_val) = match limit_clause {
                ast::LimitClause::LimitOffset { limit, offset, .. } => {
                    let l = limit
                        .as_ref()
                        .map(|e| self.extract_limit_value(e))
                        .transpose()?;
                    let o = offset
                        .as_ref()
                        .map(|o| self.extract_offset_value(o))
                        .transpose()?;
                    (l, o)
                }
                ast::LimitClause::OffsetCommaLimit { offset, limit } => {
                    let l = self.extract_limit_value(limit)?;
                    let o = self.extract_limit_value(offset)?;
                    (Some(l), Some(o))
                }
            };
            plan = LogicalPlan::Limit {
                input: Box::new(plan),
                limit: limit_val,
                offset: offset_val,
            };
        }

        Ok(plan)
    }

    fn plan_set_expr(&self, set_expr: &SetExpr) -> Result<LogicalPlan> {
        match set_expr {
            SetExpr::Select(select) => self.plan_select(select),
            SetExpr::Values(values) => self.plan_values(values),
            SetExpr::Query(query) => self.plan_query(query),
            SetExpr::SetOperation {
                op,
                set_quantifier,
                left,
                right,
            } => self.plan_set_operation(op, set_quantifier, left, right),
            _ => Err(Error::unsupported(format!(
                "Unsupported set expression: {:?}",
                set_expr
            ))),
        }
    }

    fn plan_set_operation(
        &self,
        op: &ast::SetOperator,
        quantifier: &ast::SetQuantifier,
        left: &SetExpr,
        right: &SetExpr,
    ) -> Result<LogicalPlan> {
        let left_plan = self.plan_set_expr(left)?;
        let right_plan = self.plan_set_expr(right)?;

        let left_schema = left_plan.schema();
        let right_schema = right_plan.schema();

        if left_schema.field_count() != right_schema.field_count() {
            return Err(Error::invalid_query(format!(
                "Set operation requires both sides to have the same number of columns. Left has {}, right has {}",
                left_schema.field_count(),
                right_schema.field_count()
            )));
        }

        let ir_op = match op {
            ast::SetOperator::Union => SetOperationType::Union,
            ast::SetOperator::Intersect => SetOperationType::Intersect,
            ast::SetOperator::Except | ast::SetOperator::Minus => SetOperationType::Except,
        };

        let ir_quantifier = match quantifier {
            ast::SetQuantifier::All => SetQuantifier::All,
            ast::SetQuantifier::Distinct | ast::SetQuantifier::None => SetQuantifier::Distinct,
            ast::SetQuantifier::ByName => return Err(Error::unsupported("SET operation BY NAME")),
            ast::SetQuantifier::AllByName => {
                return Err(Error::unsupported("SET operation ALL BY NAME"));
            }
            ast::SetQuantifier::DistinctByName => {
                return Err(Error::unsupported("SET operation DISTINCT BY NAME"));
            }
        };

        let schema = left_schema.clone();

        Ok(LogicalPlan::SetOperation {
            left: Box::new(left_plan),
            right: Box::new(right_plan),
            op: ir_op,
            quantifier: ir_quantifier,
            schema,
        })
    }

    fn plan_select(&self, select: &ast::Select) -> Result<LogicalPlan> {
        let mut plan = self.plan_from(&select.from)?;

        if let Some(ref selection) = select.selection {
            let predicate = ExprPlanner::plan_expr(selection, plan.schema())?;
            plan = LogicalPlan::Filter {
                input: Box::new(plan),
                predicate,
            };
        }

        let has_aggregates = self.has_aggregates(&select.projection);
        let has_group_by =
            !matches!(select.group_by, ast::GroupByExpr::Expressions(ref e, _) if e.is_empty());

        if has_aggregates || has_group_by {
            plan = self.plan_aggregate(plan, select)?;
        } else {
            plan = self.plan_projection(plan, &select.projection)?;
        }

        if let Some(ref having) = select.having {
            let predicate = ExprPlanner::plan_expr(having, plan.schema())?;
            plan = LogicalPlan::Filter {
                input: Box::new(plan),
                predicate,
            };
        }

        if select.distinct.is_some() {
            plan = LogicalPlan::Distinct {
                input: Box::new(plan),
            };
        }

        Ok(plan)
    }

    fn plan_from(&self, from: &[ast::TableWithJoins]) -> Result<LogicalPlan> {
        if from.is_empty() {
            return Ok(LogicalPlan::Empty {
                schema: PlanSchema::new(),
            });
        }

        let first = &from[0];
        let mut plan = self.plan_table_factor(&first.relation)?;

        for join in &first.joins {
            let right = self.plan_table_factor(&join.relation)?;
            plan = self.plan_join(plan, right, &join.join_operator)?;
        }

        for table_with_joins in from.iter().skip(1) {
            let right = self.plan_table_factor(&table_with_joins.relation)?;
            let combined_schema = plan.schema().clone().merge(right.schema().clone());
            plan = LogicalPlan::Join {
                left: Box::new(plan),
                right: Box::new(right),
                join_type: JoinType::Cross,
                condition: None,
                schema: combined_schema,
            };

            for join in &table_with_joins.joins {
                let right = self.plan_table_factor(&join.relation)?;
                plan = self.plan_join(plan, right, &join.join_operator)?;
            }
        }

        Ok(plan)
    }

    fn plan_table_factor(&self, factor: &TableFactor) -> Result<LogicalPlan> {
        match factor {
            TableFactor::Table { name, alias, .. } => {
                let table_name = name.to_string();
                let storage_schema = self
                    .catalog
                    .get_table_schema(&table_name)
                    .ok_or_else(|| Error::table_not_found(&table_name))?;

                let alias_name = alias.as_ref().map(|a| a.name.value.as_str());
                let schema = self.storage_schema_to_plan_schema(
                    &storage_schema,
                    alias_name.or(Some(&table_name)),
                );

                Ok(LogicalPlan::Scan {
                    table_name,
                    schema,
                    projection: None,
                })
            }
            TableFactor::Derived {
                subquery, alias, ..
            } => {
                let plan = self.plan_query(subquery)?;
                if let Some(a) = alias {
                    let schema = self.rename_schema(plan.schema(), &a.name.value);
                    Ok(LogicalPlan::Project {
                        input: Box::new(plan.clone()),
                        expressions: plan
                            .schema()
                            .fields
                            .iter()
                            .enumerate()
                            .map(|(i, f)| Expr::Column {
                                table: None,
                                name: f.name.clone(),
                                index: Some(i),
                            })
                            .collect(),
                        schema,
                    })
                } else {
                    Ok(plan)
                }
            }
            _ => Err(Error::unsupported(format!(
                "Unsupported table factor: {:?}",
                factor
            ))),
        }
    }

    fn plan_join(
        &self,
        left: LogicalPlan,
        right: LogicalPlan,
        join_op: &ast::JoinOperator,
    ) -> Result<LogicalPlan> {
        let (join_type, condition) = match join_op {
            ast::JoinOperator::Inner(constraint) => (
                JoinType::Inner,
                self.extract_join_condition(constraint, &left, &right)?,
            ),
            ast::JoinOperator::LeftOuter(constraint) => (
                JoinType::Left,
                self.extract_join_condition(constraint, &left, &right)?,
            ),
            ast::JoinOperator::RightOuter(constraint) => (
                JoinType::Right,
                self.extract_join_condition(constraint, &left, &right)?,
            ),
            ast::JoinOperator::FullOuter(constraint) => (
                JoinType::Full,
                self.extract_join_condition(constraint, &left, &right)?,
            ),
            ast::JoinOperator::CrossJoin(_) => (JoinType::Cross, None),
            _ => {
                return Err(Error::unsupported(format!(
                    "Unsupported join type: {:?}",
                    join_op
                )));
            }
        };

        let schema = left.schema().clone().merge(right.schema().clone());

        Ok(LogicalPlan::Join {
            left: Box::new(left),
            right: Box::new(right),
            join_type,
            condition,
            schema,
        })
    }

    fn extract_join_condition(
        &self,
        constraint: &ast::JoinConstraint,
        left: &LogicalPlan,
        right: &LogicalPlan,
    ) -> Result<Option<Expr>> {
        match constraint {
            ast::JoinConstraint::On(expr) => {
                let combined_schema = left.schema().clone().merge(right.schema().clone());
                Ok(Some(ExprPlanner::plan_expr(expr, &combined_schema)?))
            }
            ast::JoinConstraint::None => Ok(None),
            _ => Err(Error::unsupported(format!(
                "Unsupported join constraint: {:?}",
                constraint
            ))),
        }
    }

    fn plan_projection(
        &self,
        input: LogicalPlan,
        items: &[ast::SelectItem],
    ) -> Result<LogicalPlan> {
        let mut expressions = Vec::new();
        let mut fields = Vec::new();

        for item in items {
            match item {
                ast::SelectItem::UnnamedExpr(expr) => {
                    let planned_expr = ExprPlanner::plan_expr(expr, input.schema())?;
                    let name = self.expr_name(expr);
                    let data_type = self.infer_expr_type(&planned_expr, input.schema());
                    fields.push(PlanField::new(name, data_type));
                    expressions.push(planned_expr);
                }
                ast::SelectItem::ExprWithAlias { expr, alias } => {
                    let planned_expr = ExprPlanner::plan_expr(expr, input.schema())?;
                    let data_type = self.infer_expr_type(&planned_expr, input.schema());
                    fields.push(PlanField::new(alias.value.clone(), data_type));
                    expressions.push(planned_expr);
                }
                ast::SelectItem::Wildcard(_) => {
                    for (i, field) in input.schema().fields.iter().enumerate() {
                        expressions.push(Expr::Column {
                            table: field.table.clone(),
                            name: field.name.clone(),
                            index: Some(i),
                        });
                        fields.push(field.clone());
                    }
                }
                ast::SelectItem::QualifiedWildcard(name, _) => {
                    let table_name = name.to_string();
                    for (i, field) in input.schema().fields.iter().enumerate() {
                        if field.table.as_ref().is_some_and(|t| t == &table_name) {
                            expressions.push(Expr::Column {
                                table: field.table.clone(),
                                name: field.name.clone(),
                                index: Some(i),
                            });
                            fields.push(field.clone());
                        }
                    }
                }
            }
        }

        Ok(LogicalPlan::Project {
            input: Box::new(input),
            expressions,
            schema: PlanSchema::from_fields(fields),
        })
    }

    fn plan_aggregate(&self, input: LogicalPlan, select: &ast::Select) -> Result<LogicalPlan> {
        let mut group_by_exprs = Vec::new();
        let mut aggregate_exprs = Vec::new();
        let mut fields = Vec::new();
        let mut grouping_sets: Option<Vec<Vec<usize>>> = None;

        match &select.group_by {
            ast::GroupByExpr::All(_) => {}
            ast::GroupByExpr::Expressions(exprs, _) => {
                let (all_exprs, sets) = self.extract_grouping_sets(exprs, input.schema())?;

                for (i, (planned, name)) in all_exprs.iter().enumerate() {
                    let data_type = self.infer_expr_type(planned, input.schema());
                    fields.push(PlanField::new(name.clone(), data_type));
                    group_by_exprs.push(planned.clone());
                    let _ = i;
                }

                if !sets.is_empty() {
                    grouping_sets = Some(sets);
                }
            }
        }

        for item in &select.projection {
            match item {
                ast::SelectItem::UnnamedExpr(expr)
                | ast::SelectItem::ExprWithAlias { expr, .. } => {
                    if self.is_aggregate_expr(expr) {
                        let planned = ExprPlanner::plan_expr(expr, input.schema())?;
                        let name = match item {
                            ast::SelectItem::ExprWithAlias { alias, .. } => alias.value.clone(),
                            _ => self.expr_name(expr),
                        };
                        let data_type = self.infer_expr_type(&planned, input.schema());
                        fields.push(PlanField::new(name, data_type));
                        aggregate_exprs.push(planned);
                    }
                }
                _ => {}
            }
        }

        Ok(LogicalPlan::Aggregate {
            input: Box::new(input),
            group_by: group_by_exprs,
            aggregates: aggregate_exprs,
            schema: PlanSchema::from_fields(fields),
            grouping_sets,
        })
    }

    #[allow(clippy::type_complexity)]
    fn extract_grouping_sets(
        &self,
        exprs: &[ast::Expr],
        schema: &PlanSchema,
    ) -> Result<(Vec<(Expr, String)>, Vec<Vec<usize>>)> {
        let mut all_exprs: Vec<(Expr, String)> = Vec::new();
        let mut expr_indices: std::collections::HashMap<String, usize> =
            std::collections::HashMap::new();
        let mut grouping_sets: Vec<Vec<usize>> = Vec::new();
        let mut has_grouping_modifier = false;
        let mut regular_group_by_indices: Vec<usize> = Vec::new();

        for expr in exprs {
            match expr {
                ast::Expr::Rollup(rollup_exprs) => {
                    has_grouping_modifier = true;
                    let flat_exprs: Vec<ast::Expr> =
                        rollup_exprs.iter().flatten().cloned().collect();
                    let indices = self.add_exprs_to_list(
                        &mut all_exprs,
                        &mut expr_indices,
                        &flat_exprs,
                        schema,
                    )?;
                    let sets = self.expand_rollup(&indices);
                    grouping_sets.extend(sets);
                }
                ast::Expr::Cube(cube_exprs) => {
                    has_grouping_modifier = true;
                    let flat_exprs: Vec<ast::Expr> = cube_exprs.iter().flatten().cloned().collect();
                    let indices = self.add_exprs_to_list(
                        &mut all_exprs,
                        &mut expr_indices,
                        &flat_exprs,
                        schema,
                    )?;
                    let sets = self.expand_cube(&indices);
                    grouping_sets.extend(sets);
                }
                ast::Expr::GroupingSets(sets_exprs) => {
                    has_grouping_modifier = true;
                    for set_vec in sets_exprs {
                        let indices = self.add_exprs_to_list(
                            &mut all_exprs,
                            &mut expr_indices,
                            set_vec,
                            schema,
                        )?;
                        grouping_sets.push(indices);
                    }
                }
                _ => {
                    let index =
                        self.add_expr_to_list(&mut all_exprs, &mut expr_indices, expr, schema)?;
                    regular_group_by_indices.push(index);
                }
            }
        }

        if has_grouping_modifier && !regular_group_by_indices.is_empty() {
            let mut expanded_sets = Vec::new();
            for set in &grouping_sets {
                let mut new_set = regular_group_by_indices.clone();
                new_set.extend(set.iter());
                expanded_sets.push(new_set);
            }
            grouping_sets = expanded_sets;
        }

        Ok((all_exprs, grouping_sets))
    }

    fn add_expr_to_list(
        &self,
        all_exprs: &mut Vec<(Expr, String)>,
        expr_indices: &mut std::collections::HashMap<String, usize>,
        expr: &ast::Expr,
        schema: &PlanSchema,
    ) -> Result<usize> {
        let name = self.expr_name(expr);
        if let Some(&idx) = expr_indices.get(&name) {
            return Ok(idx);
        }
        let planned = ExprPlanner::plan_expr(expr, schema)?;
        let idx = all_exprs.len();
        all_exprs.push((planned, name.clone()));
        expr_indices.insert(name, idx);
        Ok(idx)
    }

    fn add_exprs_to_list(
        &self,
        all_exprs: &mut Vec<(Expr, String)>,
        expr_indices: &mut std::collections::HashMap<String, usize>,
        exprs: &[ast::Expr],
        schema: &PlanSchema,
    ) -> Result<Vec<usize>> {
        let mut indices = Vec::new();
        for expr in exprs {
            let idx = self.add_expr_to_list(all_exprs, expr_indices, expr, schema)?;
            indices.push(idx);
        }
        Ok(indices)
    }

    fn expand_rollup(&self, indices: &[usize]) -> Vec<Vec<usize>> {
        let mut sets = Vec::new();
        for i in (0..=indices.len()).rev() {
            sets.push(indices[..i].to_vec());
        }
        sets
    }

    fn expand_cube(&self, indices: &[usize]) -> Vec<Vec<usize>> {
        let n = indices.len();
        let mut sets = Vec::new();
        for mask in 0..(1 << n) {
            let mut set = Vec::new();
            for (i, &idx) in indices.iter().enumerate() {
                if mask & (1 << i) != 0 {
                    set.push(idx);
                }
            }
            sets.push(set);
        }
        sets
    }

    fn plan_order_by(&self, input: LogicalPlan, order_by: &ast::OrderBy) -> Result<LogicalPlan> {
        let mut sort_exprs = Vec::new();

        let exprs = match &order_by.kind {
            ast::OrderByKind::All(_) => return Err(Error::unsupported("ORDER BY ALL")),
            ast::OrderByKind::Expressions(exprs) => exprs,
        };

        for order_expr in exprs {
            let expr = ExprPlanner::plan_expr(&order_expr.expr, input.schema())?;
            let asc = order_expr.options.asc.unwrap_or(true);
            let nulls_first = order_expr.options.nulls_first.unwrap_or(!asc);
            sort_exprs.push(SortExpr {
                expr,
                asc,
                nulls_first,
            });
        }

        Ok(LogicalPlan::Sort {
            input: Box::new(input),
            sort_exprs,
        })
    }

    fn plan_values(&self, values: &ast::Values) -> Result<LogicalPlan> {
        let mut rows = Vec::new();
        let empty_schema = PlanSchema::new();

        for row in &values.rows {
            let mut exprs = Vec::new();
            for expr in row {
                exprs.push(ExprPlanner::plan_expr(expr, &empty_schema)?);
            }
            rows.push(exprs);
        }

        let schema = if let Some(first_row) = rows.first() {
            let fields: Vec<PlanField> = first_row
                .iter()
                .enumerate()
                .map(|(i, expr)| {
                    let data_type = self.infer_expr_type(expr, &empty_schema);
                    PlanField::new(format!("column{}", i + 1), data_type)
                })
                .collect();
            PlanSchema::from_fields(fields)
        } else {
            PlanSchema::new()
        };

        Ok(LogicalPlan::Values {
            values: rows,
            schema,
        })
    }

    fn plan_insert(&self, insert: &ast::Insert) -> Result<LogicalPlan> {
        let table_name = insert.table.to_string();

        let columns: Vec<String> = insert.columns.iter().map(|c| c.value.clone()).collect();

        let source = if let Some(ref src) = insert.source {
            self.plan_query(src)?
        } else {
            return Err(Error::parse_error("INSERT requires a source"));
        };

        Ok(LogicalPlan::Insert {
            table_name,
            columns,
            source: Box::new(source),
        })
    }

    fn plan_update(
        &self,
        table: &ast::TableWithJoins,
        assignments: &[ast::Assignment],
        selection: Option<&ast::Expr>,
    ) -> Result<LogicalPlan> {
        let table_name = match &table.relation {
            TableFactor::Table { name, .. } => name.to_string(),
            _ => return Err(Error::parse_error("UPDATE requires a table name")),
        };

        let storage_schema = self
            .catalog
            .get_table_schema(&table_name)
            .ok_or_else(|| Error::table_not_found(&table_name))?;
        let schema = self.storage_schema_to_plan_schema(&storage_schema, Some(&table_name));

        let mut plan_assignments = Vec::new();
        for assign in assignments {
            let column = match &assign.target {
                ast::AssignmentTarget::ColumnName(names) => names.to_string(),
                ast::AssignmentTarget::Tuple(parts) => parts
                    .iter()
                    .map(|p| p.to_string())
                    .collect::<Vec<_>>()
                    .join(", "),
            };
            let value = ExprPlanner::plan_expr(&assign.value, &schema)?;
            plan_assignments.push(Assignment { column, value });
        }

        let filter = selection
            .map(|s| ExprPlanner::plan_expr(s, &schema))
            .transpose()?;

        Ok(LogicalPlan::Update {
            table_name,
            assignments: plan_assignments,
            filter,
        })
    }

    fn plan_delete(&self, delete: &ast::Delete) -> Result<LogicalPlan> {
        let table_name = match &delete.from {
            ast::FromTable::WithFromKeyword(tables) => {
                tables.first().and_then(|t| match &t.relation {
                    TableFactor::Table { name, .. } => Some(name.to_string()),
                    _ => None,
                })
            }
            ast::FromTable::WithoutKeyword(tables) => {
                tables.first().and_then(|t| match &t.relation {
                    TableFactor::Table { name, .. } => Some(name.to_string()),
                    _ => None,
                })
            }
        }
        .ok_or_else(|| Error::parse_error("DELETE requires a table name"))?;

        let storage_schema = self
            .catalog
            .get_table_schema(&table_name)
            .ok_or_else(|| Error::table_not_found(&table_name))?;
        let schema = self.storage_schema_to_plan_schema(&storage_schema, Some(&table_name));

        let filter = delete
            .selection
            .as_ref()
            .map(|s| ExprPlanner::plan_expr(s, &schema))
            .transpose()?;

        Ok(LogicalPlan::Delete { table_name, filter })
    }

    fn plan_create_table(&self, create: &ast::CreateTable) -> Result<LogicalPlan> {
        let table_name = create.name.to_string();

        let columns: Vec<ColumnDef> = create
            .columns
            .iter()
            .map(|col| {
                let data_type = self.sql_type_to_data_type(&col.data_type);
                let nullable = !col
                    .options
                    .iter()
                    .any(|o| matches!(o.option, ast::ColumnOption::NotNull));
                ColumnDef {
                    name: col.name.value.clone(),
                    data_type,
                    nullable,
                }
            })
            .collect();

        Ok(LogicalPlan::CreateTable {
            table_name,
            columns,
            if_not_exists: create.if_not_exists,
            or_replace: create.or_replace,
        })
    }

    fn plan_drop(
        &self,
        object_type: &ast::ObjectType,
        names: &[ast::ObjectName],
        if_exists: bool,
    ) -> Result<LogicalPlan> {
        match object_type {
            ast::ObjectType::Table => {
                let table_name = names
                    .first()
                    .map(|n| n.to_string())
                    .ok_or_else(|| Error::parse_error("DROP TABLE requires a table name"))?;

                Ok(LogicalPlan::DropTable {
                    table_name,
                    if_exists,
                })
            }
            _ => Err(Error::unsupported(format!(
                "Unsupported DROP object type: {:?}",
                object_type
            ))),
        }
    }

    fn plan_truncate(&self, table_names: &[ast::TruncateTableTarget]) -> Result<LogicalPlan> {
        let table_name = table_names
            .first()
            .map(|t| t.name.to_string())
            .ok_or_else(|| Error::parse_error("TRUNCATE requires a table name"))?;

        Ok(LogicalPlan::Truncate { table_name })
    }

    fn plan_alter_table(
        &self,
        name: &ast::ObjectName,
        operations: &[ast::AlterTableOperation],
    ) -> Result<LogicalPlan> {
        let table_name = name.to_string();

        let operation = operations
            .first()
            .ok_or_else(|| Error::parse_error("ALTER TABLE requires an operation"))?;

        let op = match operation {
            ast::AlterTableOperation::AddColumn { column_def, .. } => {
                let data_type = self.sql_type_to_data_type(&column_def.data_type);
                let nullable = !column_def
                    .options
                    .iter()
                    .any(|o| matches!(o.option, ast::ColumnOption::NotNull));
                AlterTableOp::AddColumn {
                    column: ColumnDef {
                        name: column_def.name.value.clone(),
                        data_type,
                        nullable,
                    },
                }
            }
            ast::AlterTableOperation::DropColumn { column_names, .. } => {
                let name = column_names
                    .first()
                    .map(|c| c.value.clone())
                    .unwrap_or_default();
                AlterTableOp::DropColumn { name }
            }
            ast::AlterTableOperation::RenameColumn {
                old_column_name,
                new_column_name,
            } => AlterTableOp::RenameColumn {
                old_name: old_column_name.value.clone(),
                new_name: new_column_name.value.clone(),
            },
            ast::AlterTableOperation::RenameTable {
                table_name: new_name,
            } => AlterTableOp::RenameTable {
                new_name: new_name.to_string(),
            },
            _ => {
                return Err(Error::unsupported(format!(
                    "Unsupported ALTER TABLE operation: {:?}",
                    operation
                )));
            }
        };

        Ok(LogicalPlan::AlterTable {
            table_name,
            operation: op,
        })
    }

    fn storage_schema_to_plan_schema(&self, schema: &Schema, table: Option<&str>) -> PlanSchema {
        let fields = schema
            .fields()
            .iter()
            .map(|f| PlanField {
                name: f.name.clone(),
                data_type: f.data_type.clone(),
                nullable: f.is_nullable(),
                table: table.map(String::from),
            })
            .collect();
        PlanSchema::from_fields(fields)
    }

    fn rename_schema(&self, schema: &PlanSchema, new_table: &str) -> PlanSchema {
        let fields = schema
            .fields
            .iter()
            .map(|f| PlanField {
                name: f.name.clone(),
                data_type: f.data_type.clone(),
                nullable: f.nullable,
                table: Some(new_table.to_string()),
            })
            .collect();
        PlanSchema::from_fields(fields)
    }

    fn sql_type_to_data_type(&self, sql_type: &ast::DataType) -> DataType {
        Self::convert_sql_type(sql_type)
    }

    fn convert_sql_type(sql_type: &ast::DataType) -> DataType {
        match sql_type {
            ast::DataType::Boolean | ast::DataType::Bool => DataType::Bool,
            ast::DataType::Int64 | ast::DataType::BigInt(_) => DataType::Int64,
            ast::DataType::Float64 | ast::DataType::Double(_) => DataType::Float64,
            ast::DataType::Numeric(info) | ast::DataType::Decimal(info) => {
                let ps = match info {
                    ast::ExactNumberInfo::PrecisionAndScale(p, s) => Some((*p as u8, *s as u8)),
                    ast::ExactNumberInfo::Precision(p) => Some((*p as u8, 0)),
                    ast::ExactNumberInfo::None => None,
                };
                DataType::Numeric(ps)
            }
            ast::DataType::String(_) | ast::DataType::Varchar(_) | ast::DataType::Text => {
                DataType::String
            }
            ast::DataType::Bytes(_) | ast::DataType::Bytea => DataType::Bytes,
            ast::DataType::Date => DataType::Date,
            ast::DataType::Time(..) => DataType::Time,
            ast::DataType::Datetime(_) => DataType::DateTime,
            ast::DataType::Timestamp(..) => DataType::Timestamp,
            ast::DataType::JSON | ast::DataType::JSONB => DataType::Json,
            ast::DataType::Array(inner) => {
                let element_type = match inner {
                    ast::ArrayElemTypeDef::AngleBracket(dt) => Self::convert_sql_type(dt),
                    ast::ArrayElemTypeDef::SquareBracket(dt, _) => Self::convert_sql_type(dt),
                    ast::ArrayElemTypeDef::Parenthesis(dt) => Self::convert_sql_type(dt),
                    ast::ArrayElemTypeDef::None => DataType::Unknown,
                };
                DataType::Array(Box::new(element_type))
            }
            ast::DataType::Interval { .. } => DataType::Interval,
            _ => DataType::Unknown,
        }
    }

    fn has_aggregates(&self, items: &[ast::SelectItem]) -> bool {
        items.iter().any(|item| match item {
            ast::SelectItem::UnnamedExpr(expr) | ast::SelectItem::ExprWithAlias { expr, .. } => {
                self.is_aggregate_expr(expr)
            }
            _ => false,
        })
    }

    fn is_aggregate_expr(&self, expr: &ast::Expr) -> bool {
        Self::check_aggregate_expr(expr)
    }

    fn check_aggregate_expr(expr: &ast::Expr) -> bool {
        match expr {
            ast::Expr::Function(func) => {
                let name = func.name.to_string().to_uppercase();
                matches!(
                    name.as_str(),
                    "COUNT"
                        | "SUM"
                        | "AVG"
                        | "MIN"
                        | "MAX"
                        | "ARRAY_AGG"
                        | "STRING_AGG"
                        | "ANY_VALUE"
                )
            }
            ast::Expr::BinaryOp { left, right, .. } => {
                Self::check_aggregate_expr(left) || Self::check_aggregate_expr(right)
            }
            ast::Expr::UnaryOp { expr, .. } => Self::check_aggregate_expr(expr),
            ast::Expr::Nested(inner) => Self::check_aggregate_expr(inner),
            _ => false,
        }
    }

    fn expr_name(&self, expr: &ast::Expr) -> String {
        match expr {
            ast::Expr::Identifier(ident) => ident.value.clone(),
            ast::Expr::CompoundIdentifier(parts) => {
                parts.last().map(|p| p.value.clone()).unwrap_or_default()
            }
            ast::Expr::Function(func) => func.name.to_string(),
            _ => format!("{}", expr),
        }
    }

    fn infer_expr_type(&self, expr: &Expr, schema: &PlanSchema) -> DataType {
        Self::compute_expr_type(expr, schema)
    }

    fn compute_expr_type(expr: &Expr, schema: &PlanSchema) -> DataType {
        match expr {
            Expr::Literal(lit) => lit.data_type(),
            Expr::Column { name, index, .. } => if let Some(idx) = index {
                schema.fields.get(*idx).map(|f| f.data_type.clone())
            } else {
                schema.field(name).map(|f| f.data_type.clone())
            }
            .unwrap_or(DataType::Unknown),
            Expr::BinaryOp { left, op, right } => {
                use yachtsql_ir::BinaryOp;
                match op {
                    BinaryOp::Eq
                    | BinaryOp::NotEq
                    | BinaryOp::Lt
                    | BinaryOp::LtEq
                    | BinaryOp::Gt
                    | BinaryOp::GtEq
                    | BinaryOp::And
                    | BinaryOp::Or => DataType::Bool,
                    BinaryOp::Concat => DataType::String,
                    _ => {
                        let left_type = Self::compute_expr_type(left, schema);
                        let right_type = Self::compute_expr_type(right, schema);
                        if left_type == DataType::Float64 || right_type == DataType::Float64 {
                            DataType::Float64
                        } else if left_type == DataType::Int64 || right_type == DataType::Int64 {
                            DataType::Int64
                        } else {
                            left_type
                        }
                    }
                }
            }
            Expr::UnaryOp { op, expr } => {
                use yachtsql_ir::UnaryOp;
                match op {
                    UnaryOp::Not => DataType::Bool,
                    _ => Self::compute_expr_type(expr, schema),
                }
            }
            Expr::Aggregate { func, .. } => {
                use yachtsql_ir::AggregateFunction;
                match func {
                    AggregateFunction::Count => DataType::Int64,
                    AggregateFunction::Avg => DataType::Float64,
                    AggregateFunction::Sum | AggregateFunction::Min | AggregateFunction::Max => {
                        DataType::Float64
                    }
                    AggregateFunction::ArrayAgg => DataType::Array(Box::new(DataType::Unknown)),
                    AggregateFunction::StringAgg => DataType::String,
                    AggregateFunction::AnyValue => DataType::Unknown,
                }
            }
            Expr::Cast { data_type, .. } => data_type.clone(),
            Expr::IsNull { .. }
            | Expr::InList { .. }
            | Expr::Between { .. }
            | Expr::Like { .. } => DataType::Bool,
            Expr::Alias { expr, .. } => Self::compute_expr_type(expr, schema),
            _ => DataType::Unknown,
        }
    }

    fn extract_limit_value(&self, limit: &ast::Expr) -> Result<usize> {
        match limit {
            ast::Expr::Value(v) => match &v.value {
                ast::Value::Number(n, _) => n
                    .parse()
                    .map_err(|_| Error::parse_error(format!("Invalid LIMIT value: {}", n))),
                _ => Err(Error::parse_error("LIMIT must be a number")),
            },
            _ => Err(Error::parse_error("LIMIT must be a literal number")),
        }
    }

    fn extract_offset_value(&self, offset: &ast::Offset) -> Result<usize> {
        match &offset.value {
            ast::Expr::Value(v) => match &v.value {
                ast::Value::Number(n, _) => n
                    .parse()
                    .map_err(|_| Error::parse_error(format!("Invalid OFFSET value: {}", n))),
                _ => Err(Error::parse_error("OFFSET must be a number")),
            },
            _ => Err(Error::parse_error("OFFSET must be a literal number")),
        }
    }
}
