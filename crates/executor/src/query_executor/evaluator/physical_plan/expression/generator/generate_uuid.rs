use yachtsql_core::error::Result;
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::super::ProjectionWithExprExec;

impl ProjectionWithExprExec {
    pub(in crate::query_executor::evaluator::physical_plan) fn eval_generate_uuid(
        args: &[Expr],
    ) -> Result<Value> {
        Self::validate_zero_args("GENERATE_UUID", args)?;
        crate::functions::generator::generate_uuid()
    }
}

#[cfg(test)]
mod tests {
    use uuid::Uuid;
    use yachtsql_core::types::Value;
    use yachtsql_optimizer::expr::Expr;

    use super::*;
    use crate::tests::support::assert_error_contains;

    #[test]
    fn generates_uuid_value() {
        let result = ProjectionWithExprExec::eval_generate_uuid(&[]).expect("success");
        if let Some(s) = result.as_str() {
            Uuid::parse_str(&s).expect("valid UUID string");
        } else {
            panic!("Expected String")
        }
    }

    #[test]
    fn generates_different_uuids_on_each_call() {
        let uuid1 = ProjectionWithExprExec::eval_generate_uuid(&[]).expect("success");
        let uuid2 = ProjectionWithExprExec::eval_generate_uuid(&[]).expect("success");
        assert_ne!(uuid1, uuid2, "UUIDs should be unique");
    }

    #[test]
    fn validates_zero_arguments() {
        use yachtsql_optimizer::expr::LiteralValue;
        let args = vec![Expr::literal(LiteralValue::Int64(1))];
        let err = ProjectionWithExprExec::eval_generate_uuid(&args).expect_err("extra argument");
        assert_error_contains(&err, "GENERATE_UUID");
    }
}
