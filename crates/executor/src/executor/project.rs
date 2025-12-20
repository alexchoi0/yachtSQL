use yachtsql_common::error::Result;
use yachtsql_common::types::Value;
use yachtsql_ir::{BinaryOp, Expr, LogicalPlan, PlanSchema};
use yachtsql_optimizer::optimize;
use yachtsql_storage::{Record, Schema, Table};

use super::{PlanExecutor, plan_schema_to_schema};
use crate::ir_evaluator::IrEvaluator;
use crate::plan::ExecutorPlan;

impl<'a> PlanExecutor<'a> {
    pub fn execute_project(
        &mut self,
        input: &ExecutorPlan,
        expressions: &[Expr],
        schema: &PlanSchema,
    ) -> Result<Table> {
        let input_table = self.execute_plan(input)?;
        let input_schema = input_table.schema().clone();

        if expressions
            .iter()
            .any(Self::expr_contains_subquery_or_scalar_subquery)
        {
            self.execute_project_with_subqueries(&input_table, expressions, schema)
        } else {
            let evaluator = IrEvaluator::new(&input_schema);
            let result_schema = plan_schema_to_schema(schema);
            let mut result = Table::empty(result_schema);

            for record in input_table.rows()? {
                let mut row = Vec::with_capacity(expressions.len());
                for expr in expressions {
                    let val = evaluator.evaluate(expr, &record)?;
                    row.push(val);
                }
                result.push_row(row)?;
            }

            Ok(result)
        }
    }

    fn execute_project_with_subqueries(
        &mut self,
        input_table: &Table,
        expressions: &[Expr],
        schema: &PlanSchema,
    ) -> Result<Table> {
        let input_schema = input_table.schema().clone();
        let result_schema = plan_schema_to_schema(schema);
        let mut result = Table::empty(result_schema);

        for record in input_table.rows()? {
            let mut row = Vec::with_capacity(expressions.len());
            for expr in expressions {
                let val = self.eval_expr_with_subqueries(expr, &input_schema, &record)?;
                row.push(val);
            }
            result.push_row(row)?;
        }

        Ok(result)
    }

    fn eval_expr_with_subqueries(
        &mut self,
        expr: &Expr,
        schema: &Schema,
        record: &Record,
    ) -> Result<Value> {
        match expr {
            Expr::Subquery(plan) | Expr::ScalarSubquery(plan) => {
                self.eval_scalar_subquery_with_outer(plan, record)
            }
            Expr::ArraySubquery(plan) => self.eval_array_subquery_with_outer(plan, record),
            Expr::BinaryOp { left, op, right } => {
                let left_val = self.eval_expr_with_subqueries(left, schema, record)?;
                let right_val = self.eval_expr_with_subqueries(right, schema, record)?;
                self.eval_binary_op_values(left_val, *op, right_val)
            }
            Expr::UnaryOp { op, expr: inner } => {
                let val = self.eval_expr_with_subqueries(inner, schema, record)?;
                self.eval_unary_op_value(*op, val)
            }
            Expr::ScalarFunction { name, args } => {
                let arg_vals: Vec<Value> = args
                    .iter()
                    .map(|a| self.eval_expr_with_subqueries(a, schema, record))
                    .collect::<Result<_>>()?;
                let evaluator = IrEvaluator::new(schema);
                evaluator.eval_scalar_function_with_values(name, &arg_vals)
            }
            Expr::Cast {
                expr: inner,
                data_type,
                safe,
            } => {
                let val = self.eval_expr_with_subqueries(inner, schema, record)?;
                IrEvaluator::cast_value(val, data_type, *safe)
            }
            _ => {
                let evaluator = IrEvaluator::new(schema);
                evaluator.evaluate(expr, record)
            }
        }
    }

    fn eval_scalar_subquery(&mut self, plan: &LogicalPlan) -> Result<Value> {
        let physical = optimize(plan)?;
        let executor_plan = ExecutorPlan::from_physical(&physical);
        let result_table = self.execute_plan(&executor_plan)?;

        if result_table.is_empty() {
            return Ok(Value::Null);
        }

        let rows: Vec<_> = result_table.rows()?.into_iter().collect();
        if rows.is_empty() {
            return Ok(Value::Null);
        }

        let first_row = &rows[0];
        let values = first_row.values();
        if values.is_empty() {
            return Ok(Value::Null);
        }

        Ok(values[0].clone())
    }

    fn eval_scalar_subquery_with_outer(
        &mut self,
        plan: &LogicalPlan,
        outer_record: &Record,
    ) -> Result<Value> {
        let bound_plan = Self::bind_outer_columns(plan, outer_record);
        self.eval_scalar_subquery(&bound_plan)
    }

    fn eval_array_subquery(&mut self, plan: &LogicalPlan) -> Result<Value> {
        let physical = optimize(plan)?;
        let executor_plan = ExecutorPlan::from_physical(&physical);
        let result_table = self.execute_plan(&executor_plan)?;

        let rows: Vec<_> = result_table.rows()?.into_iter().collect();
        let values: Vec<Value> = rows
            .iter()
            .filter_map(|r| r.values().first().cloned())
            .collect();

        Ok(Value::Array(values))
    }

    fn eval_array_subquery_with_outer(
        &mut self,
        plan: &LogicalPlan,
        outer_record: &Record,
    ) -> Result<Value> {
        let bound_plan = Self::bind_outer_columns(plan, outer_record);
        self.eval_array_subquery(&bound_plan)
    }

    fn bind_outer_columns(plan: &LogicalPlan, outer_record: &Record) -> LogicalPlan {
        match plan {
            LogicalPlan::Filter { input, predicate } => LogicalPlan::Filter {
                input: Box::new(Self::bind_outer_columns(input, outer_record)),
                predicate: Self::bind_expr_outer_columns(predicate, outer_record),
            },
            LogicalPlan::Project {
                input,
                expressions,
                schema,
            } => LogicalPlan::Project {
                input: Box::new(Self::bind_outer_columns(input, outer_record)),
                expressions: expressions
                    .iter()
                    .map(|e| Self::bind_expr_outer_columns(e, outer_record))
                    .collect(),
                schema: schema.clone(),
            },
            LogicalPlan::Aggregate {
                input,
                group_by,
                aggregates,
                schema,
            } => LogicalPlan::Aggregate {
                input: Box::new(Self::bind_outer_columns(input, outer_record)),
                group_by: group_by
                    .iter()
                    .map(|e| Self::bind_expr_outer_columns(e, outer_record))
                    .collect(),
                aggregates: aggregates
                    .iter()
                    .map(|e| Self::bind_expr_outer_columns(e, outer_record))
                    .collect(),
                schema: schema.clone(),
            },
            LogicalPlan::Sort { input, sort_exprs } => LogicalPlan::Sort {
                input: Box::new(Self::bind_outer_columns(input, outer_record)),
                sort_exprs: sort_exprs.clone(),
            },
            LogicalPlan::Limit {
                input,
                limit,
                offset,
            } => LogicalPlan::Limit {
                input: Box::new(Self::bind_outer_columns(input, outer_record)),
                limit: *limit,
                offset: *offset,
            },
            _ => plan.clone(),
        }
    }

    fn bind_expr_outer_columns(expr: &Expr, outer_record: &Record) -> Expr {
        match expr {
            Expr::OuterColumn { index, depth, .. } => {
                if *depth == 0 && *index < outer_record.values().len() {
                    Expr::Literal(Self::outer_value_to_literal(&outer_record.values()[*index]))
                } else {
                    expr.clone()
                }
            }
            Expr::BinaryOp { left, op, right } => Expr::BinaryOp {
                left: Box::new(Self::bind_expr_outer_columns(left, outer_record)),
                op: *op,
                right: Box::new(Self::bind_expr_outer_columns(right, outer_record)),
            },
            Expr::UnaryOp { op, expr: inner } => Expr::UnaryOp {
                op: *op,
                expr: Box::new(Self::bind_expr_outer_columns(inner, outer_record)),
            },
            Expr::ScalarFunction { name, args } => Expr::ScalarFunction {
                name: name.clone(),
                args: args
                    .iter()
                    .map(|a| Self::bind_expr_outer_columns(a, outer_record))
                    .collect(),
            },
            Expr::Aggregate {
                func,
                args,
                distinct,
                filter,
                order_by,
                limit,
                ignore_nulls,
            } => Expr::Aggregate {
                func: func.clone(),
                args: args
                    .iter()
                    .map(|a| Self::bind_expr_outer_columns(a, outer_record))
                    .collect(),
                distinct: *distinct,
                filter: filter
                    .as_ref()
                    .map(|f| Box::new(Self::bind_expr_outer_columns(f, outer_record))),
                order_by: order_by.clone(),
                limit: *limit,
                ignore_nulls: *ignore_nulls,
            },
            Expr::Case {
                operand,
                when_clauses,
                else_result,
            } => Expr::Case {
                operand: operand
                    .as_ref()
                    .map(|o| Box::new(Self::bind_expr_outer_columns(o, outer_record))),
                when_clauses: when_clauses
                    .iter()
                    .map(|w| yachtsql_ir::WhenClause {
                        condition: Self::bind_expr_outer_columns(&w.condition, outer_record),
                        result: Self::bind_expr_outer_columns(&w.result, outer_record),
                    })
                    .collect(),
                else_result: else_result
                    .as_ref()
                    .map(|e| Box::new(Self::bind_expr_outer_columns(e, outer_record))),
            },
            Expr::Cast {
                expr: inner,
                data_type,
                safe,
            } => Expr::Cast {
                expr: Box::new(Self::bind_expr_outer_columns(inner, outer_record)),
                data_type: data_type.clone(),
                safe: *safe,
            },
            Expr::Alias { expr: inner, name } => Expr::Alias {
                expr: Box::new(Self::bind_expr_outer_columns(inner, outer_record)),
                name: name.clone(),
            },
            Expr::Struct { fields } => Expr::Struct {
                fields: fields
                    .iter()
                    .map(|(name, e)| (name.clone(), Self::bind_expr_outer_columns(e, outer_record)))
                    .collect(),
            },
            _ => expr.clone(),
        }
    }

    fn outer_value_to_literal(value: &Value) -> yachtsql_ir::Literal {
        use chrono::{Datelike, Timelike};
        use yachtsql_ir::Literal;
        match value {
            Value::Null => Literal::Null,
            Value::Bool(b) => Literal::Bool(*b),
            Value::Int64(i) => Literal::Int64(*i),
            Value::Float64(f) => Literal::Float64(*f),
            Value::String(s) => Literal::String(s.clone()),
            Value::Bytes(b) => Literal::Bytes(b.clone()),
            Value::Numeric(d) => Literal::Numeric(*d),
            Value::Date(d) => Literal::Date(d.num_days_from_ce()),
            Value::Time(t) => Literal::Time(t.num_seconds_from_midnight() as i64),
            Value::DateTime(dt) => Literal::Datetime(dt.and_utc().timestamp()),
            Value::Timestamp(ts) => Literal::Timestamp(ts.timestamp()),
            Value::Array(arr) => {
                Literal::Array(arr.iter().map(Self::outer_value_to_literal).collect())
            }
            Value::Struct(fields) => Literal::Struct(
                fields
                    .iter()
                    .map(|(name, val)| (name.clone(), Self::outer_value_to_literal(val)))
                    .collect(),
            ),
            Value::Json(j) => Literal::Json(j.clone()),
            Value::Interval(i) => Literal::Interval {
                months: i.months,
                days: i.days,
                nanos: i.nanos,
            },
            Value::Geography(_) | Value::Range(_) | Value::Default => Literal::Null,
        }
    }

    fn eval_binary_op_values(&self, left: Value, op: BinaryOp, right: Value) -> Result<Value> {
        use yachtsql_ir::BinaryOp::*;
        match op {
            Add => match (&left, &right) {
                (Value::Int64(l), Value::Int64(r)) => Ok(Value::Int64(l + r)),
                (Value::Float64(l), Value::Float64(r)) => Ok(Value::Float64(*l + *r)),
                (Value::Int64(l), Value::Float64(r)) => {
                    Ok(Value::Float64(ordered_float::OrderedFloat(*l as f64) + *r))
                }
                (Value::Float64(l), Value::Int64(r)) => {
                    Ok(Value::Float64(*l + ordered_float::OrderedFloat(*r as f64)))
                }
                _ => Ok(Value::Null),
            },
            Sub => match (&left, &right) {
                (Value::Int64(l), Value::Int64(r)) => Ok(Value::Int64(l - r)),
                (Value::Float64(l), Value::Float64(r)) => Ok(Value::Float64(*l - *r)),
                (Value::Int64(l), Value::Float64(r)) => {
                    Ok(Value::Float64(ordered_float::OrderedFloat(*l as f64) - *r))
                }
                (Value::Float64(l), Value::Int64(r)) => {
                    Ok(Value::Float64(*l - ordered_float::OrderedFloat(*r as f64)))
                }
                _ => Ok(Value::Null),
            },
            Mul => match (&left, &right) {
                (Value::Int64(l), Value::Int64(r)) => Ok(Value::Int64(l * r)),
                (Value::Float64(l), Value::Float64(r)) => Ok(Value::Float64(*l * *r)),
                (Value::Int64(l), Value::Float64(r)) => {
                    Ok(Value::Float64(ordered_float::OrderedFloat(*l as f64) * *r))
                }
                (Value::Float64(l), Value::Int64(r)) => {
                    Ok(Value::Float64(*l * ordered_float::OrderedFloat(*r as f64)))
                }
                _ => Ok(Value::Null),
            },
            Div => match (&left, &right) {
                (Value::Int64(l), Value::Int64(r)) if *r != 0 => Ok(Value::Float64(
                    ordered_float::OrderedFloat(*l as f64 / *r as f64),
                )),
                (Value::Float64(l), Value::Float64(r)) if r.0 != 0.0 => Ok(Value::Float64(*l / *r)),
                (Value::Int64(l), Value::Float64(r)) if r.0 != 0.0 => {
                    Ok(Value::Float64(ordered_float::OrderedFloat(*l as f64) / *r))
                }
                (Value::Float64(l), Value::Int64(r)) if *r != 0 => {
                    Ok(Value::Float64(*l / ordered_float::OrderedFloat(*r as f64)))
                }
                _ => Ok(Value::Null),
            },
            And => {
                let l = left.as_bool().unwrap_or(false);
                let r = right.as_bool().unwrap_or(false);
                Ok(Value::Bool(l && r))
            }
            Or => {
                let l = left.as_bool().unwrap_or(false);
                let r = right.as_bool().unwrap_or(false);
                Ok(Value::Bool(l || r))
            }
            Eq => Ok(Value::Bool(left == right)),
            NotEq => Ok(Value::Bool(left != right)),
            Lt => Ok(Value::Bool(left < right)),
            LtEq => Ok(Value::Bool(left <= right)),
            Gt => Ok(Value::Bool(left > right)),
            GtEq => Ok(Value::Bool(left >= right)),
            _ => Ok(Value::Null),
        }
    }

    fn eval_unary_op_value(&self, op: yachtsql_ir::UnaryOp, val: Value) -> Result<Value> {
        use yachtsql_ir::UnaryOp::*;
        match op {
            Not => Ok(Value::Bool(!val.as_bool().unwrap_or(false))),
            Minus => match val {
                Value::Int64(n) => Ok(Value::Int64(-n)),
                Value::Float64(f) => Ok(Value::Float64(-f)),
                _ => Ok(Value::Null),
            },
            Plus => Ok(val),
            BitwiseNot => match val {
                Value::Int64(n) => Ok(Value::Int64(!n)),
                _ => Ok(Value::Null),
            },
        }
    }

    fn expr_contains_subquery_or_scalar_subquery(expr: &Expr) -> bool {
        match expr {
            Expr::Subquery(_) | Expr::ScalarSubquery(_) | Expr::ArraySubquery(_) => true,
            Expr::BinaryOp { left, right, .. } => {
                Self::expr_contains_subquery_or_scalar_subquery(left)
                    || Self::expr_contains_subquery_or_scalar_subquery(right)
            }
            Expr::UnaryOp { expr, .. } => Self::expr_contains_subquery_or_scalar_subquery(expr),
            Expr::ScalarFunction { args, .. } => args
                .iter()
                .any(Self::expr_contains_subquery_or_scalar_subquery),
            Expr::Cast { expr, .. } => Self::expr_contains_subquery_or_scalar_subquery(expr),
            Expr::Case {
                operand,
                when_clauses,
                else_result,
            } => {
                operand
                    .as_ref()
                    .is_some_and(|o| Self::expr_contains_subquery_or_scalar_subquery(o))
                    || when_clauses.iter().any(|w| {
                        Self::expr_contains_subquery_or_scalar_subquery(&w.condition)
                            || Self::expr_contains_subquery_or_scalar_subquery(&w.result)
                    })
                    || else_result
                        .as_ref()
                        .is_some_and(|e| Self::expr_contains_subquery_or_scalar_subquery(e))
            }
            Expr::Alias { expr, .. } => Self::expr_contains_subquery_or_scalar_subquery(expr),
            _ => false,
        }
    }
}
