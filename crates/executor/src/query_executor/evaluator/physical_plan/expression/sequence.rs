use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::{ProjectionWithExprExec, SEQUENCE_REGISTRY_CONTEXT};
use crate::Table;

impl ProjectionWithExprExec {
    pub(in crate::query_executor::evaluator::physical_plan) fn evaluate_sequence_function(
        func_name: &str,
        args: &[Expr],
        batch: &Table,
        row_idx: usize,
    ) -> Result<Value> {
        let storage_rc = SEQUENCE_REGISTRY_CONTEXT
            .with(|ctx| ctx.borrow().clone())
            .ok_or_else(|| {
                Error::InternalError("Sequence registry context not available".to_string())
            })?;

        match func_name {
            "NEXTVAL" => {
                if args.len() != 1 {
                    return Err(Error::InvalidOperation(format!(
                        "NEXTVAL expects exactly 1 argument, got {}",
                        args.len()
                    )));
                }

                let seq_name_value = Self::evaluate_expr_internal(
                    &args[0],
                    batch,
                    row_idx,
                    crate::DialectType::PostgreSQL,
                )?;
                let seq_name = seq_name_value.as_str().ok_or_else(|| {
                    Error::InvalidOperation("NEXTVAL expects a string sequence name".to_string())
                })?;

                let (dataset_id, seq_id) = parse_sequence_name(seq_name);

                let mut storage_ref = storage_rc.borrow_mut();
                let dataset = storage_ref.get_dataset_mut(&dataset_id).ok_or_else(|| {
                    Error::invalid_query(format!("Sequence '{}' does not exist", seq_name))
                })?;

                let next_value = dataset.sequences_mut().nextval(&seq_id)?;
                Ok(Value::int64(next_value))
            }

            "CURRVAL" => {
                if args.len() != 1 {
                    return Err(Error::InvalidOperation(format!(
                        "CURRVAL expects exactly 1 argument, got {}",
                        args.len()
                    )));
                }

                let seq_name_value = Self::evaluate_expr_internal(
                    &args[0],
                    batch,
                    row_idx,
                    crate::DialectType::PostgreSQL,
                )?;
                let seq_name = seq_name_value.as_str().ok_or_else(|| {
                    Error::InvalidOperation("CURRVAL expects a string sequence name".to_string())
                })?;

                let (dataset_id, seq_id) = parse_sequence_name(seq_name);

                let storage_ref = storage_rc.borrow();
                let dataset = storage_ref.get_dataset(&dataset_id).ok_or_else(|| {
                    Error::invalid_query(format!("Sequence '{}' does not exist", seq_name))
                })?;

                let curr_value = dataset.sequences().currval(&seq_id)?;
                Ok(Value::int64(curr_value))
            }

            "SETVAL" => {
                if args.len() < 2 || args.len() > 3 {
                    return Err(Error::InvalidOperation(format!(
                        "SETVAL expects 2 or 3 arguments, got {}",
                        args.len()
                    )));
                }

                let seq_name_value = Self::evaluate_expr_internal(
                    &args[0],
                    batch,
                    row_idx,
                    crate::DialectType::PostgreSQL,
                )?;
                let seq_name = seq_name_value.as_str().ok_or_else(|| {
                    Error::InvalidOperation("SETVAL expects a string sequence name".to_string())
                })?;

                let new_value = Self::evaluate_expr_internal(
                    &args[1],
                    batch,
                    row_idx,
                    crate::DialectType::PostgreSQL,
                )?;
                let new_value = new_value.as_i64().ok_or_else(|| {
                    Error::InvalidOperation("SETVAL expects an integer value".to_string())
                })?;

                let is_called = if args.len() == 3 {
                    let is_called_value = Self::evaluate_expr_internal(
                        &args[2],
                        batch,
                        row_idx,
                        crate::DialectType::PostgreSQL,
                    )?;
                    is_called_value.as_bool().unwrap_or(true)
                } else {
                    true
                };

                let (dataset_id, seq_id) = parse_sequence_name(seq_name);

                let mut storage_ref = storage_rc.borrow_mut();
                let dataset = storage_ref.get_dataset_mut(&dataset_id).ok_or_else(|| {
                    Error::invalid_query(format!("Sequence '{}' does not exist", seq_name))
                })?;

                let result = dataset
                    .sequences_mut()
                    .setval(&seq_id, new_value, is_called)?;
                Ok(Value::int64(result))
            }

            "LASTVAL" => {
                if !args.is_empty() {
                    return Err(Error::InvalidOperation(format!(
                        "LASTVAL expects no arguments, got {}",
                        args.len()
                    )));
                }

                let storage_ref = storage_rc.borrow();
                let dataset = storage_ref.get_dataset("default").ok_or_else(|| {
                    Error::InvalidOperation(
                        "LASTVAL is not yet defined in this session".to_string(),
                    )
                })?;

                let last_value = dataset.sequences().lastval()?;
                Ok(Value::int64(last_value))
            }

            _ => Err(Error::unsupported_feature(format!(
                "Unknown sequence function: {}",
                func_name
            ))),
        }
    }
}

fn parse_sequence_name(name: &str) -> (String, String) {
    if let Some((schema, seq_name)) = name.split_once('.') {
        (schema.to_string(), seq_name.to_string())
    } else {
        ("default".to_string(), name.to_string())
    }
}
