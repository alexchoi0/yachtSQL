use yachtsql_core::error::Result;
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(in crate::query_executor::evaluator::physical_plan) fn eval_to_number(
        args: &[Expr],
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        Self::validate_arg_count("TO_NUMBER", args, 1)?;
        let val = Self::evaluate_expr(&args[0], batch, row_idx)?;
        crate::functions::scalar::eval_to_number(&val)
    }
}

#[cfg(test)]
mod tests {
    use yachtsql_core::types::{DataType, Value};
    use yachtsql_optimizer::expr::Expr;
    use yachtsql_storage::{Field, Schema};

    use super::*;
    use crate::query_executor::evaluator::physical_plan::expression::test_utils::*;
    use crate::tests::support::assert_error_contains;

    fn schema_with_string() -> Schema {
        Schema::from_fields(vec![Field::nullable("val", DataType::String)])
    }

    #[test]
    fn converts_valid_string_to_number() {
        let batch = create_batch(
            schema_with_string(),
            vec![vec![Value::string("123.45".to_string())]],
        );
        let args = vec![Expr::column("val")];
        let result = ProjectionWithExprExec::eval_to_number(&args, &batch, 0).expect("success");
        assert_eq!(result, Value::float64(123.45));
    }

    #[test]
    fn propagates_null() {
        let batch = create_batch(schema_with_string(), vec![vec![Value::null()]]);
        let args = vec![Expr::column("val")];
        let result = ProjectionWithExprExec::eval_to_number(&args, &batch, 0).expect("success");
        assert_eq!(result, Value::null());
    }

    #[test]
    fn validates_argument_count() {
        let batch = create_batch(schema_with_string(), vec![vec![Value::string("1".into())]]);
        let err =
            ProjectionWithExprExec::eval_to_number(&[], &batch, 0).expect_err("missing arguments");
        assert_error_contains(&err, "TO_NUMBER");
    }

    #[test]
    fn errors_on_invalid_number_string() {
        let batch = create_batch(
            schema_with_string(),
            vec![vec![Value::string("not-a-number".to_string())]],
        );
        let args = vec![Expr::column("val")];
        let err =
            ProjectionWithExprExec::eval_to_number(&args, &batch, 0).expect_err("invalid number");
        let msg = err.to_string();
        assert!(
            msg.contains("parse") || msg.contains("invalid") || msg.contains("number"),
            "expected parse error, got: {}",
            msg
        );
    }
}
