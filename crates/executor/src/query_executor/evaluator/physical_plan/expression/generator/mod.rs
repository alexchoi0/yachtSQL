mod generate_uuid;
mod generate_uuid_array;

use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(super) fn evaluate_generator_function(
        name: &str,
        args: &[Expr],
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        match name {
            "GENERATE_UUID" => Self::eval_generate_uuid(args),
            "GENERATE_UUID_ARRAY" => Self::eval_generate_uuid_array(args, batch, row_idx),
            _ => Err(Error::unsupported_feature(format!(
                "Unknown generator function: {}",
                name
            ))),
        }
    }
}
