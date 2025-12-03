use yachtsql_core::error::Result;
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(in crate::query_executor::evaluator::physical_plan) fn eval_interval_literal(
        _args: &[Expr],
        _batch: &RecordBatch,
        _row_idx: usize,
    ) -> Result<Value> {
        Ok(Value::null())
    }
}

#[cfg(test)]
mod tests {
    use yachtsql_core::types::{DataType, Value};
    use yachtsql_optimizer::expr::Expr;
    use yachtsql_storage::{Field, Schema};

    use super::*;
    use crate::query_executor::evaluator::physical_plan::expression::test_utils::*;

    #[test]
    fn returns_null() {
        let schema = Schema::from_fields(vec![Field::nullable("val", DataType::Int64)]);
        let batch = create_batch(schema, vec![vec![Value::int64(1)]]);
        let args = vec![Expr::column("val")];
        let result =
            ProjectionWithExprExec::eval_interval_literal(&args, &batch, 0).expect("success");
        assert_eq!(result, Value::null());
    }

    #[test]
    fn returns_null_with_no_args() {
        let schema = Schema::new();
        let batch = create_batch(schema, vec![vec![]]);
        let result =
            ProjectionWithExprExec::eval_interval_literal(&[], &batch, 0).expect("success");
        assert_eq!(result, Value::null());
    }
}
