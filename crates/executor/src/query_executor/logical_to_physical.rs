use std::cell::RefCell;
use std::collections::HashMap;
use std::rc::Rc;

use yachtsql_core::error::{Error, Result};
use yachtsql_ir::plan::{LogicalPlan, PlanNode};

use super::evaluator::physical_plan::{
    AggregateExec, AggregateStrategy, ArrayJoinExec, CteExec, DistinctExec, DistinctOnExec,
    EmptyRelationExec, ExceptExec, ExecutionPlan, FilterExec, HashJoinExec, IndexScanExec,
    IntersectExec, JoinStrategy, LateralJoinExec, LimitExec, MergeExec, MergeJoinExec,
    NestedLoopJoinExec, PhysicalPlan, PivotAggregateFunction, PivotExec, ProjectionWithExprExec,
    SampleSize, SamplingMethod, SortAggregateExec, SortExec, SubqueryScanExec, TableSampleExec,
    TableScanExec, TableValuedFunctionExec, UnionExec, UnnestExec, UnpivotExec, WindowExec,
};
use super::returning::{
    ReturningColumn, ReturningColumnOrigin, ReturningExpressionItem, ReturningSpec,
};

#[allow(dead_code)]
pub struct LogicalToPhysicalPlanner {
    storage: Rc<RefCell<yachtsql_storage::Storage>>,

    cte_plans: RefCell<HashMap<String, Rc<dyn ExecutionPlan>>>,
}

impl LogicalToPhysicalPlanner {
    fn infer_projection_schema(
        &self,
        expressions: &[(yachtsql_ir::expr::Expr, Option<String>)],
        input_schema: &yachtsql_storage::Schema,
    ) -> Result<yachtsql_storage::Schema> {
        use yachtsql_storage::{Field, Schema};

        let mut fields = Vec::with_capacity(expressions.len());

        for (idx, (expr, alias)) in expressions.iter().enumerate() {
            let data_type = ProjectionWithExprExec::infer_expr_type_with_schema(expr, input_schema)
                .unwrap_or(yachtsql_core::types::DataType::String);

            let field_name = if let Some(alias) = alias {
                alias.clone()
            } else {
                match expr {
                    yachtsql_ir::expr::Expr::Column { name, .. } => name.clone(),
                    _ => format!("expr_{}", idx),
                }
            };

            fields.push(Field::nullable(field_name, data_type));
        }

        Ok(Schema::from_fields(fields))
    }

    fn collect_table_names(&self, node: &PlanNode) -> std::collections::HashSet<String> {
        let mut tables = std::collections::HashSet::new();
        self.collect_table_names_recursive(node, &mut tables);
        tables
    }

    fn collect_table_names_recursive(
        &self,
        node: &PlanNode,
        tables: &mut std::collections::HashSet<String>,
    ) {
        match node {
            PlanNode::Scan {
                table_name, alias, ..
            } => {
                if let Some(alias) = alias {
                    tables.insert(alias.clone());
                }
                tables.insert(table_name.clone());
            }
            _ => {
                for child in node.children() {
                    self.collect_table_names_recursive(child, tables);
                }
            }
        }
    }

    fn get_expr_table(&self, expr: &yachtsql_ir::expr::Expr) -> Option<String> {
        match expr {
            yachtsql_ir::expr::Expr::Column { table, .. } => table.clone(),
            _ => None,
        }
    }

    fn parse_join_conditions(
        &self,
        expr: &yachtsql_ir::expr::Expr,
        left_tables: &std::collections::HashSet<String>,
    ) -> Vec<(yachtsql_ir::expr::Expr, yachtsql_ir::expr::Expr)> {
        use yachtsql_ir::expr::{BinaryOp, Expr};

        match expr {
            Expr::BinaryOp {
                left,
                op: BinaryOp::Equal,
                right,
            } => {
                let left_table = self.get_expr_table(left);
                let right_table = self.get_expr_table(right);

                let left_is_left_side = left_table
                    .as_ref()
                    .is_some_and(|t| left_tables.contains(t));
                let right_is_left_side = right_table
                    .as_ref()
                    .is_some_and(|t| left_tables.contains(t));

                if left_is_left_side && !right_is_left_side {
                    vec![((**left).clone(), (**right).clone())]
                } else if right_is_left_side && !left_is_left_side {
                    vec![((**right).clone(), (**left).clone())]
                } else {
                    vec![((**left).clone(), (**right).clone())]
                }
            }

            Expr::BinaryOp {
                left,
                op: BinaryOp::And,
                right,
            } => {
                let mut conditions = Vec::new();
                conditions.extend(self.parse_join_conditions(left, left_tables));
                conditions.extend(self.parse_join_conditions(right, left_tables));
                conditions
            }

            _ => Vec::new(),
        }
    }
}

impl LogicalToPhysicalPlanner {
    pub fn new(storage: Rc<RefCell<yachtsql_storage::Storage>>) -> Self {
        Self {
            storage,
            cte_plans: RefCell::new(HashMap::new()),
        }
    }

    pub fn create_physical_plan(&self, logical_plan: &LogicalPlan) -> Result<PhysicalPlan> {
        let root_exec = self.plan_node_to_exec(logical_plan.root())?;
        Ok(PhysicalPlan::new(root_exec))
    }

    fn plan_node_to_exec(&self, node: &PlanNode) -> Result<Rc<dyn ExecutionPlan>> {
        match node {
            PlanNode::Scan {
                table_name,
                alias,
                projection: _,
            } => {
                {
                    let cte_plans = self.cte_plans.borrow();
                    if let Some(cte_plan) = cte_plans.get(table_name) {
                        return Ok(Rc::new(SubqueryScanExec::new(Rc::clone(cte_plan))));
                    }
                }

                let storage = self.storage.borrow_mut();

                let (dataset_name, table_id) = if let Some(dot_pos) = table_name.find('.') {
                    let dataset = &table_name[..dot_pos];
                    let table = &table_name[dot_pos + 1..];
                    (dataset, table)
                } else {
                    ("default", table_name.as_str())
                };

                let dataset = storage.get_dataset(dataset_name).ok_or_else(|| {
                    Error::DatasetNotFound(format!("Dataset '{}' not found", dataset_name))
                })?;

                let table = dataset.get_table(table_id).ok_or_else(|| {
                    Error::TableNotFound(format!("Table '{}' not found", table_id))
                })?;

                let source_table = alias.as_ref().unwrap_or(table_name);
                let schema = table.schema().with_source_table(source_table);
                drop(storage);

                Ok(Rc::new(TableScanExec::new(
                    schema,
                    table_name.clone(),
                    Rc::clone(&self.storage),
                )))
            }

            PlanNode::IndexScan {
                table_name,
                alias,
                index_name,
                predicate,
                projection: _,
            } => {
                let storage = self.storage.borrow_mut();

                let (dataset_name, table_id) = if let Some(dot_pos) = table_name.find('.') {
                    let dataset = &table_name[..dot_pos];
                    let table = &table_name[dot_pos + 1..];
                    (dataset, table)
                } else {
                    ("default", table_name.as_str())
                };

                let dataset = storage.get_dataset(dataset_name).ok_or_else(|| {
                    Error::DatasetNotFound(format!("Dataset '{}' not found", dataset_name))
                })?;

                let table = dataset.get_table(table_id).ok_or_else(|| {
                    Error::TableNotFound(format!("Table '{}' not found", table_id))
                })?;

                let source_table = alias.as_ref().unwrap_or(table_name);
                let schema = table.schema().with_source_table(source_table);
                drop(storage);

                Ok(Rc::new(IndexScanExec::new(
                    schema,
                    table_name.clone(),
                    index_name.clone(),
                    predicate.clone(),
                    Rc::clone(&self.storage),
                )))
            }

            PlanNode::Filter { input, predicate } => {
                let input_exec = self.plan_node_to_exec(input)?;

                Ok(Rc::new(FilterExec::new(input_exec, predicate.clone())))
            }

            PlanNode::Projection { input, expressions } => {
                let input_exec = self.plan_node_to_exec(input)?;
                let input_schema = input_exec.schema();

                let output_schema = self.infer_projection_schema(expressions, input_schema)?;

                Ok(Rc::new(ProjectionWithExprExec::new(
                    input_exec,
                    output_schema,
                    expressions.clone(),
                )))
            }

            PlanNode::Join {
                left,
                right,
                on,
                join_type,
            } => {
                let left_exec = self.plan_node_to_exec(left)?;
                let right_exec = self.plan_node_to_exec(right)?;

                let left_tables = self.collect_table_names(left);
                let join_conditions = self.parse_join_conditions(on, &left_tables);
                let is_equi_join = !join_conditions.is_empty();

                let left_stats = left_exec.statistics();
                let right_stats = right_exec.statistics();

                let left_sorted = left_stats.is_sorted;
                let right_sorted = right_stats.is_sorted;
                let left_rows = left_stats.num_rows;

                let strategy = JoinStrategy::select(
                    left_sorted,
                    right_sorted,
                    is_equi_join,
                    None,
                    left_rows,
                );

                match strategy {
                    JoinStrategy::Merge => {
                        Ok(Rc::new(MergeJoinExec::new(
                            left_exec,
                            right_exec,
                            join_type.clone(),
                            join_conditions,
                        )?))
                    }
                    JoinStrategy::NestedLoop => {
                        Ok(Rc::new(NestedLoopJoinExec::new(
                            left_exec,
                            right_exec,
                            join_type.clone(),
                            Some(on.clone()),
                        )?))
                    }
                    JoinStrategy::Hash | JoinStrategy::IndexNestedLoop { .. } => {
                        Ok(Rc::new(HashJoinExec::new(
                            left_exec,
                            right_exec,
                            join_type.clone(),
                            join_conditions,
                        )?))
                    }
                }
            }

            PlanNode::LateralJoin {
                left,
                right,
                on: _,
                join_type,
            } => {
                let left_exec = self.plan_node_to_exec(left)?;

                Ok(Rc::new(LateralJoinExec::new(
                    left_exec,
                    (**right).clone(),
                    join_type.clone(),
                    Rc::clone(&self.storage),
                )?))
            }

            PlanNode::Aggregate {
                group_by,
                aggregates,
                input,
                grouping_metadata: _,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;

                let agg_with_aliases: Vec<(yachtsql_ir::expr::Expr, Option<String>)> =
                    aggregates.iter().map(|expr| (expr.clone(), None)).collect();

                let input_stats = input_exec.statistics();
                let input_sorted = input_stats.is_sorted;

                let input_sort_columns: Vec<String> = input_stats
                    .sort_columns
                    .clone()
                    .unwrap_or_default();

                let group_by_columns: Vec<String> = group_by
                    .iter()
                    .filter_map(|expr| {
                        if let yachtsql_ir::expr::Expr::Column { name, .. } = expr {
                            Some(name.clone())
                        } else {
                            None
                        }
                    })
                    .collect();

                let strategy =
                    AggregateStrategy::select_with_columns(input_sorted, &input_sort_columns, &group_by_columns);

                match strategy {
                    AggregateStrategy::Sort => Ok(Rc::new(SortAggregateExec::new(
                        input_exec,
                        group_by.clone(),
                        agg_with_aliases,
                        None,
                    )?)),
                    AggregateStrategy::Hash => Ok(Rc::new(AggregateExec::new(
                        input_exec,
                        group_by.clone(),
                        agg_with_aliases,
                        None,
                    )?)),
                }
            }

            PlanNode::Sort { order_by, input } => {
                let input_exec = self.plan_node_to_exec(input)?;

                Ok(Rc::new(SortExec::new(input_exec, order_by.clone())?))
            }

            PlanNode::Limit {
                limit,
                offset,
                input,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;
                Ok(Rc::new(LimitExec::new(input_exec, *limit, *offset)))
            }

            PlanNode::Distinct { input } => {
                let input_exec = self.plan_node_to_exec(input)?;
                Ok(Rc::new(DistinctExec::new(input_exec)))
            }

            PlanNode::DistinctOn { expressions, input } => {
                let input_exec = self.plan_node_to_exec(input)?;

                Ok(Rc::new(DistinctOnExec::new(
                    input_exec,
                    expressions.clone(),
                )))
            }

            PlanNode::Union { left, right, all } => {
                let left_exec = self.plan_node_to_exec(left)?;
                let right_exec = self.plan_node_to_exec(right)?;
                Ok(Rc::new(UnionExec::new(left_exec, right_exec, *all)?))
            }

            PlanNode::Intersect { left, right, all } => {
                let left_exec = self.plan_node_to_exec(left)?;
                let right_exec = self.plan_node_to_exec(right)?;
                Ok(Rc::new(IntersectExec::new(left_exec, right_exec, *all)?))
            }

            PlanNode::Except { left, right, all } => {
                let left_exec = self.plan_node_to_exec(left)?;
                let right_exec = self.plan_node_to_exec(right)?;
                Ok(Rc::new(ExceptExec::new(left_exec, right_exec, *all)?))
            }

            PlanNode::Merge {
                target_table,
                target_alias,
                source,
                source_alias,
                on_condition,
                when_matched,
                when_not_matched,
                when_not_matched_by_source,
                returning,
            } => {
                let source_exec = self.plan_node_to_exec(source)?;

                let returning_spec = self.convert_returning_clause(returning)?;

                let storage = Rc::clone(&self.storage);

                let fk_enforcer =
                    Rc::new(crate::query_executor::enforcement::ForeignKeyEnforcer::new());

                Ok(Rc::new(MergeExec::new(
                    target_table.clone(),
                    target_alias.clone(),
                    source_exec,
                    source_alias.clone(),
                    on_condition.clone(),
                    when_matched.clone(),
                    when_not_matched.clone(),
                    when_not_matched_by_source.clone(),
                    returning_spec,
                    storage,
                    fk_enforcer,
                )?))
            }

            PlanNode::Unnest {
                array_expr,
                alias,
                with_offset,
                offset_alias,
            } => {
                use yachtsql_storage::{Field, Schema};

                let element_name = alias.clone().unwrap_or_else(|| "value".to_string());

                let element_type = self.infer_unnest_element_type(array_expr);

                let mut fields = vec![Field::nullable(element_name, element_type)];

                if *with_offset {
                    let offset_name = offset_alias
                        .clone()
                        .unwrap_or_else(|| "ordinality".to_string());
                    fields.push(Field::nullable(
                        offset_name,
                        yachtsql_core::types::DataType::Int64,
                    ));
                }

                let schema = Schema::from_fields(fields);

                let optimizer_expr = self.convert_ir_expr_to_optimizer(array_expr);

                Ok(Rc::new(UnnestExec {
                    schema,
                    array_expr: optimizer_expr,
                    with_offset: *with_offset,
                }))
            }

            PlanNode::Cte {
                name,
                cte_plan,
                input,
                recursive: _,
                use_union_all: _,
                materialization_hint,
            } => {
                let cte_exec = self.plan_node_to_exec(cte_plan)?;

                self.cte_plans
                    .borrow_mut()
                    .insert(name.clone(), Rc::clone(&cte_exec));

                let input_exec = self.plan_node_to_exec(input)?;

                self.cte_plans.borrow_mut().remove(name);

                let materialized = match materialization_hint {
                    Some(sqlparser::ast::CteAsMaterialized::Materialized) => true,
                    Some(sqlparser::ast::CteAsMaterialized::NotMaterialized) => false,
                    None => true,
                };

                Ok(Rc::new(CteExec::new(cte_exec, input_exec, materialized)))
            }

            PlanNode::EmptyRelation => {
                let schema = yachtsql_storage::Schema::from_fields(vec![]);
                Ok(Rc::new(EmptyRelationExec::new(schema)))
            }

            PlanNode::Window {
                window_exprs,
                input,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;

                Ok(Rc::new(WindowExec::new(input_exec, window_exprs.clone())?))
            }

            PlanNode::SubqueryScan { subquery, alias: _ } => {
                let subquery_exec = self.plan_node_to_exec(subquery)?;

                Ok(Rc::new(SubqueryScanExec::new(subquery_exec)))
            }

            PlanNode::ArrayJoin {
                input,
                arrays,
                is_left,
                is_unaligned,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;
                Ok(Rc::new(ArrayJoinExec::new(
                    input_exec,
                    arrays.clone(),
                    *is_left,
                    *is_unaligned,
                )?))
            }

            PlanNode::TableSample {
                input,
                method,
                size,
                seed,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;

                let physical_method = match method {
                    yachtsql_ir::plan::SamplingMethod::Bernoulli => SamplingMethod::Bernoulli,
                    yachtsql_ir::plan::SamplingMethod::System => SamplingMethod::System,
                };

                let physical_size = match size {
                    yachtsql_ir::plan::SampleSize::Percent(p) => SampleSize::Percent(*p),
                    yachtsql_ir::plan::SampleSize::Rows(r) => SampleSize::Rows(*r),
                };

                Ok(Rc::new(TableSampleExec::new(
                    input_exec,
                    physical_method,
                    physical_size,
                    *seed,
                )?))
            }

            PlanNode::Pivot {
                input,
                aggregate_expr,
                aggregate_function,
                pivot_column,
                pivot_values,
                group_by_columns,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;

                let agg_fn = PivotAggregateFunction::from_name(aggregate_function)?;

                Ok(Rc::new(PivotExec::new(
                    input_exec,
                    aggregate_expr.clone(),
                    agg_fn,
                    pivot_column.clone(),
                    pivot_values.clone(),
                    group_by_columns.clone(),
                )?))
            }

            PlanNode::Unpivot {
                input,
                value_column,
                name_column,
                unpivot_columns,
            } => {
                let input_exec = self.plan_node_to_exec(input)?;

                Ok(Rc::new(UnpivotExec::new(
                    input_exec,
                    value_column.clone(),
                    name_column.clone(),
                    unpivot_columns.clone(),
                )?))
            }

            PlanNode::TableValuedFunction {
                function_name,
                args,
                alias: _,
            } => {
                use yachtsql_storage::{Field, Schema};

                let schema = match function_name.to_uppercase().as_str() {
                    "EACH" => Schema::from_fields(vec![
                        Field::nullable("key", yachtsql_core::types::DataType::String),
                        Field::nullable("value", yachtsql_core::types::DataType::String),
                    ]),
                    "SKEYS" => Schema::from_fields(vec![Field::nullable(
                        "key",
                        yachtsql_core::types::DataType::String,
                    )]),
                    "SVALS" => Schema::from_fields(vec![Field::nullable(
                        "value",
                        yachtsql_core::types::DataType::String,
                    )]),
                    _ => {
                        return Err(Error::UnsupportedFeature(format!(
                            "Table-valued function '{}' not yet supported in optimizer path",
                            function_name
                        )));
                    }
                };

                Ok(Rc::new(TableValuedFunctionExec::new(
                    schema,
                    function_name.clone(),
                    args.clone(),
                    Rc::clone(&self.storage),
                )))
            }

            _ => Err(Error::UnsupportedFeature(format!(
                "Physical plan conversion not yet implemented for {:?}",
                node
            ))),
        }
    }

    fn infer_returning_expr_type(
        &self,
        expr: &yachtsql_ir::expr::Expr,
    ) -> Result<yachtsql_core::types::DataType> {
        use yachtsql_ir::expr::Expr;
        match expr {
            Expr::Column { .. } => Ok(yachtsql_core::types::DataType::String),

            Expr::Function { name, args, .. }
                if name.as_str().eq_ignore_ascii_case("merge_action") && args.is_empty() =>
            {
                Ok(yachtsql_core::types::DataType::String)
            }

            _ => Ok(yachtsql_core::types::DataType::String),
        }
    }

    fn convert_returning_clause(
        &self,
        returning: &Option<Vec<(yachtsql_ir::expr::Expr, Option<String>)>>,
    ) -> Result<ReturningSpec> {
        match returning {
            None => Ok(ReturningSpec::None),
            Some(items) if items.is_empty() => Ok(ReturningSpec::None),
            Some(items)
                if items.len() == 1 && matches!(&items[0].0, yachtsql_ir::expr::Expr::Wildcard) =>
            {
                Ok(ReturningSpec::AllColumns)
            }
            Some(items) => {
                let mut all_columns = true;
                for (expr, _) in items {
                    if !matches!(expr, yachtsql_ir::expr::Expr::Column { .. }) {
                        all_columns = false;
                        break;
                    }
                }

                if all_columns {
                    let columns = items
                        .iter()
                        .map(|(expr, alias)| {
                            if let yachtsql_ir::expr::Expr::Column { name, table, .. } = expr {
                                let origin = match table.as_deref() {
                                    Some("target") | Some("t") => ReturningColumnOrigin::Target,
                                    Some("source") | Some("s") => ReturningColumnOrigin::Source,
                                    Some(table_name) => {
                                        ReturningColumnOrigin::Table(table_name.to_string())
                                    }
                                    None => ReturningColumnOrigin::Target,
                                };
                                Ok(ReturningColumn {
                                    source_name: name.clone(),
                                    output_name: alias.clone().unwrap_or_else(|| name.clone()),
                                    origin,
                                })
                            } else {
                                Err(Error::internal("Expected column reference"))
                            }
                        })
                        .collect::<Result<Vec<_>>>()?;
                    Ok(ReturningSpec::Columns(columns))
                } else {
                    let expr_items = items
                        .iter()
                        .map(|(expr, alias)| {
                            let data_type = self.infer_returning_expr_type(expr)?;
                            let origin = ReturningColumnOrigin::Expression;
                            Ok(ReturningExpressionItem {
                                expr: expr.clone(),
                                output_name: alias.clone(),
                                data_type,
                                origin,
                            })
                        })
                        .collect::<Result<Vec<_>>>()?;
                    Ok(ReturningSpec::Expressions(expr_items))
                }
            }
        }
    }

    fn infer_unnest_element_type(
        &self,
        expr: &yachtsql_ir::expr::Expr,
    ) -> yachtsql_core::types::DataType {
        use yachtsql_core::types::DataType;
        use yachtsql_ir::expr::Expr;

        match expr {
            Expr::Literal(yachtsql_ir::expr::LiteralValue::Array(elements)) => {
                if let Some(first) = elements.first() {
                    self.infer_literal_type(first)
                } else {
                    DataType::String
                }
            }

            Expr::Literal(yachtsql_ir::expr::LiteralValue::Null) => DataType::String,

            Expr::Cast { data_type, .. } => self.cast_data_type_to_data_type(data_type),

            _ => DataType::Int64,
        }
    }

    fn cast_data_type_to_data_type(
        &self,
        cast_type: &yachtsql_ir::expr::CastDataType,
    ) -> yachtsql_core::types::DataType {
        use yachtsql_core::types::DataType;
        use yachtsql_ir::expr::CastDataType;

        match cast_type {
            CastDataType::Int64 => DataType::Int64,
            CastDataType::Float64 => DataType::Float64,
            CastDataType::Numeric(prec) => DataType::Numeric(*prec),
            CastDataType::String => DataType::String,
            CastDataType::Bytes => DataType::Bytes,
            CastDataType::Date => DataType::Date,
            CastDataType::DateTime => DataType::DateTime,
            CastDataType::Time => DataType::Time,
            CastDataType::Timestamp => DataType::Timestamp,
            CastDataType::TimestampTz => DataType::Timestamp,
            CastDataType::Bool => DataType::Bool,
            CastDataType::Json => DataType::Json,
            CastDataType::Array(inner) => {
                DataType::Array(Box::new(self.cast_data_type_to_data_type(inner)))
            }
            CastDataType::Geography => DataType::Geography,
            CastDataType::Uuid => DataType::Uuid,
            CastDataType::Interval => DataType::Interval,
            CastDataType::Vector(dim) => DataType::Vector(*dim),
            CastDataType::Hstore => DataType::Hstore,
            CastDataType::MacAddr => DataType::MacAddr,
            CastDataType::MacAddr8 => DataType::MacAddr8,
            CastDataType::Custom(name) => DataType::Custom(name.clone()),
        }
    }

    fn infer_literal_type(&self, expr: &yachtsql_ir::expr::Expr) -> yachtsql_core::types::DataType {
        use yachtsql_core::types::DataType;
        use yachtsql_ir::expr::{Expr, LiteralValue};

        match expr {
            Expr::Literal(lit) => match lit {
                LiteralValue::Null => DataType::String,
                LiteralValue::Boolean(_) => DataType::Bool,
                LiteralValue::Int64(_) => DataType::Int64,
                LiteralValue::Float64(_) => DataType::Float64,
                LiteralValue::Numeric(_) => DataType::Numeric(None),
                LiteralValue::String(_) => DataType::String,
                LiteralValue::Bytes(_) => DataType::Bytes,
                LiteralValue::Date(_) => DataType::Date,
                LiteralValue::Timestamp(_) => DataType::Timestamp,
                LiteralValue::Json(_) => DataType::Json,
                LiteralValue::Uuid(_) => DataType::Uuid,
                LiteralValue::Vector(v) => DataType::Vector(v.len()),
                LiteralValue::Interval(_) => DataType::Interval,
                LiteralValue::Range(_) => {
                    DataType::Range(yachtsql_core::types::RangeType::Int8Range)
                }
                LiteralValue::Point(_) => DataType::Point,
                LiteralValue::PgBox(_) => DataType::PgBox,
                LiteralValue::Circle(_) => DataType::Circle,
                LiteralValue::Array(_) => DataType::String,
                LiteralValue::MacAddr(_) => DataType::MacAddr,
                LiteralValue::MacAddr8(_) => DataType::MacAddr8,
            },
            _ => DataType::String,
        }
    }

    fn convert_ir_expr_to_optimizer(
        &self,
        expr: &yachtsql_ir::expr::Expr,
    ) -> yachtsql_optimizer::expr::Expr {
        expr.clone()
    }
}
