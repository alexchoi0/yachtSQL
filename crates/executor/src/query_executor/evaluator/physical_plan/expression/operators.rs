use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::{BinaryOp, Expr};

use super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(in crate::query_executor::evaluator::physical_plan) fn evaluate_and(
        left: &Expr,
        right: &Expr,
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        let left_val = Self::evaluate_expr(left, batch, row_idx)?;

        if left_val.is_null() {
            let right_val = Self::evaluate_expr(right, batch, row_idx)?;
            if let Some(false) = right_val.as_bool() {
                return Ok(Value::bool_val(false));
            }
            return Ok(Value::null());
        }

        if let Some(b) = left_val.as_bool() {
            if !b {
                return Ok(Value::bool_val(false));
            }
            return Self::evaluate_expr(right, batch, row_idx);
        }

        Err(Error::TypeMismatch {
            expected: "BOOL".to_string(),
            actual: left_val.data_type().to_string(),
        })
    }

    pub(in crate::query_executor::evaluator::physical_plan) fn evaluate_or(
        left: &Expr,
        right: &Expr,
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        let left_val = Self::evaluate_expr(left, batch, row_idx)?;

        if left_val.is_null() {
            let right_val = Self::evaluate_expr(right, batch, row_idx)?;
            if let Some(true) = right_val.as_bool() {
                return Ok(Value::bool_val(true));
            }
            return Ok(Value::null());
        }

        if let Some(b) = left_val.as_bool() {
            if b {
                return Ok(Value::bool_val(true));
            }
            return Self::evaluate_expr(right, batch, row_idx);
        }

        Err(Error::TypeMismatch {
            expected: "BOOL".to_string(),
            actual: left_val.data_type().to_string(),
        })
    }

    pub(super) fn int64_arithmetic(
        op: &crate::optimizer::expr::BinaryOp,
        l: i64,
        r: i64,
    ) -> Result<crate::types::Value> {
        match op {
            BinaryOp::Add => l.checked_add(r).map(Value::int64).ok_or_else(|| {
                crate::error::Error::ExecutionError("INT64 overflow in addition".to_string())
            }),
            BinaryOp::Subtract => l.checked_sub(r).map(Value::int64).ok_or_else(|| {
                crate::error::Error::ExecutionError("INT64 overflow in subtraction".to_string())
            }),
            BinaryOp::Multiply => l.checked_mul(r).map(Value::int64).ok_or_else(|| {
                crate::error::Error::ExecutionError("INT64 overflow in multiplication".to_string())
            }),
            BinaryOp::Divide if r != 0 => Ok(Value::int64(l / r)),
            BinaryOp::Divide => Err(crate::error::Error::ExecutionError(
                "Division by zero".to_string(),
            )),
            BinaryOp::Modulo if r != 0 => Ok(Value::int64(l % r)),
            BinaryOp::Modulo => Err(crate::error::Error::ExecutionError(
                "Modulo by zero".to_string(),
            )),
            _ => Err(crate::error::Error::unsupported_feature(format!(
                "Operator {:?} not supported for Int64 arithmetic",
                op
            ))),
        }
    }

    pub(super) fn float64_arithmetic(
        op: &crate::optimizer::expr::BinaryOp,
        l: f64,
        r: f64,
    ) -> Result<crate::types::Value> {
        match op {
            BinaryOp::Add => Ok(Value::float64(l + r)),
            BinaryOp::Subtract => Ok(Value::float64(l - r)),
            BinaryOp::Multiply => Ok(Value::float64(l * r)),
            BinaryOp::Divide => Ok(Value::float64(l / r)),
            _ => Err(crate::error::Error::unsupported_feature(format!(
                "Operator {:?} not supported for Float64 arithmetic",
                op
            ))),
        }
    }

    pub(super) fn numeric_comparison<T: PartialOrd>(
        op: &crate::optimizer::expr::BinaryOp,
        l: T,
        r: T,
    ) -> Result<bool> {
        match op {
            BinaryOp::Equal => Ok(l == r),
            BinaryOp::NotEqual => Ok(l != r),
            BinaryOp::LessThan => Ok(l < r),
            BinaryOp::LessThanOrEqual => Ok(l <= r),
            BinaryOp::GreaterThan => Ok(l > r),
            BinaryOp::GreaterThanOrEqual => Ok(l >= r),
            _ => Err(crate::error::Error::unsupported_feature(format!(
                "Operator {:?} not a comparison operator",
                op
            ))),
        }
    }

    pub(crate) fn evaluate_binary_op(
        left: &crate::types::Value,
        op: &crate::optimizer::expr::BinaryOp,
        right: &crate::types::Value,
    ) -> Result<crate::types::Value> {
        if left.is_null() || right.is_null() {
            return Ok(Value::null());
        }

        if let (Some(l), Some(r)) = (left.as_i64(), right.as_i64()) {
            return match op {
                BinaryOp::Equal
                | BinaryOp::NotEqual
                | BinaryOp::LessThan
                | BinaryOp::LessThanOrEqual
                | BinaryOp::GreaterThan
                | BinaryOp::GreaterThanOrEqual => {
                    Self::numeric_comparison(op, l, r).map(Value::bool_val)
                }

                _ => Self::int64_arithmetic(op, l, r),
            };
        }

        if let (Some(l), Some(r)) = (left.as_f64(), right.as_f64()) {
            return match op {
                BinaryOp::Equal
                | BinaryOp::NotEqual
                | BinaryOp::LessThan
                | BinaryOp::LessThanOrEqual
                | BinaryOp::GreaterThan
                | BinaryOp::GreaterThanOrEqual => {
                    Self::numeric_comparison(op, l, r).map(Value::bool_val)
                }

                _ => Self::float64_arithmetic(op, l, r),
            };
        }

        if let (Some(l), Some(r)) = (left.as_f64(), right.as_i64()) {
            return match op {
                BinaryOp::Equal
                | BinaryOp::NotEqual
                | BinaryOp::LessThan
                | BinaryOp::LessThanOrEqual
                | BinaryOp::GreaterThan
                | BinaryOp::GreaterThanOrEqual => {
                    Self::numeric_comparison(op, l, r as f64).map(Value::bool_val)
                }

                _ => Self::float64_arithmetic(op, l, r as f64),
            };
        }

        if let (Some(l), Some(r)) = (left.as_i64(), right.as_f64()) {
            return match op {
                BinaryOp::Equal
                | BinaryOp::NotEqual
                | BinaryOp::LessThan
                | BinaryOp::LessThanOrEqual
                | BinaryOp::GreaterThan
                | BinaryOp::GreaterThanOrEqual => {
                    Self::numeric_comparison(op, l as f64, r).map(Value::bool_val)
                }

                _ => Self::float64_arithmetic(op, l as f64, r),
            };
        }

        if let (Some(l), Some(r)) = (left.as_str(), right.as_str()) {
            return match op {
                BinaryOp::Equal => Ok(Value::bool_val(l.eq_ignore_ascii_case(r))),
                BinaryOp::NotEqual => Ok(Value::bool_val(!l.eq_ignore_ascii_case(r))),
                BinaryOp::LessThan => Ok(Value::bool_val(l < r)),
                BinaryOp::LessThanOrEqual => Ok(Value::bool_val(l <= r)),
                BinaryOp::GreaterThan => Ok(Value::bool_val(l > r)),
                BinaryOp::GreaterThanOrEqual => Ok(Value::bool_val(l >= r)),
                BinaryOp::Concat => {
                    let mut result = l.to_string();
                    result.push_str(r);
                    Ok(Value::string(result))
                }
                BinaryOp::Like => Ok(Value::bool_val(crate::pattern_matching::matches_pattern(
                    l, r,
                ))),
                BinaryOp::NotLike => Ok(Value::bool_val(
                    !crate::pattern_matching::matches_pattern(l, r),
                )),
                BinaryOp::ILike => Ok(Value::bool_val(
                    crate::pattern_matching::matches_pattern_case_insensitive(l, r),
                )),
                BinaryOp::NotILike => Ok(Value::bool_val(
                    !crate::pattern_matching::matches_pattern_case_insensitive(l, r),
                )),
                BinaryOp::SimilarTo | BinaryOp::NotSimilarTo => {
                    let matches =
                        crate::pattern_matching::matches_similar_to(l, r).map_err(|e| {
                            crate::error::Error::invalid_query(format!(
                                "Invalid SIMILAR TO pattern: {}",
                                e
                            ))
                        })?;
                    let result = matches!(op, BinaryOp::SimilarTo) == matches;
                    Ok(Value::bool_val(result))
                }
                BinaryOp::RegexMatch | BinaryOp::RegexNotMatch => {
                    let matches = crate::pattern_matching::matches_regex(l, r)
                        .map_err(crate::error::Error::InvalidQuery)?;
                    let result = matches!(op, BinaryOp::RegexMatch) == matches;
                    Ok(Value::bool_val(result))
                }
                BinaryOp::RegexMatchI | BinaryOp::RegexNotMatchI => {
                    let matches = crate::pattern_matching::matches_regex_case_insensitive(l, r)
                        .map_err(crate::error::Error::InvalidQuery)?;
                    let result = matches!(op, BinaryOp::RegexMatchI) == matches;
                    Ok(Value::bool_val(result))
                }
                _ => Err(crate::error::Error::unsupported_feature(format!(
                    "Operator {:?} not supported for String",
                    op
                ))),
            };
        }

        if let (Some(l), Some(r)) = (left.as_bool(), right.as_bool()) {
            return match op {
                BinaryOp::And => Ok(Value::bool_val(l && r)),
                BinaryOp::Or => Ok(Value::bool_val(l || r)),
                BinaryOp::Equal => Ok(Value::bool_val(l == r)),
                BinaryOp::NotEqual => Ok(Value::bool_val(l != r)),
                _ => Err(crate::error::Error::unsupported_feature(format!(
                    "Operator {:?} not supported for Bool",
                    op
                ))),
            };
        }

        if let (Some(l), Some(r)) = (left.as_bytes(), right.as_bytes()) {
            return match op {
                BinaryOp::Equal => Ok(Value::bool_val(l == r)),
                BinaryOp::NotEqual => Ok(Value::bool_val(l != r)),
                BinaryOp::LessThan => Ok(Value::bool_val(l < r)),
                BinaryOp::LessThanOrEqual => Ok(Value::bool_val(l <= r)),
                BinaryOp::GreaterThan => Ok(Value::bool_val(l > r)),
                BinaryOp::GreaterThanOrEqual => Ok(Value::bool_val(l >= r)),
                BinaryOp::Concat => {
                    let mut result = l.to_vec();
                    result.extend_from_slice(r);
                    Ok(Value::bytes(result))
                }
                _ => Err(crate::error::Error::unsupported_feature(format!(
                    "Operator {:?} not supported for Bytes",
                    op
                ))),
            };
        }

        if let (Some(l), Some(r)) = (left.as_numeric(), right.as_numeric()) {
            return crate::query_executor::execution::evaluate_numeric_op(&l, op, &r);
        }

        if let (Some(l), Some(r_i64)) = (left.as_numeric(), right.as_i64()) {
            use rust_decimal::Decimal;
            let r_dec = Decimal::from(r_i64);
            return crate::query_executor::execution::evaluate_numeric_op(&l, op, &r_dec);
        }
        if let (Some(l_i64), Some(r)) = (left.as_i64(), right.as_numeric()) {
            use rust_decimal::Decimal;
            let l_dec = Decimal::from(l_i64);
            return crate::query_executor::execution::evaluate_numeric_op(&l_dec, op, &r);
        }

        if let (Some(l), Some(r_f64)) = (left.as_numeric(), right.as_f64()) {
            use rust_decimal::Decimal;

            if let Some(r_dec) = Decimal::from_f64_retain(r_f64) {
                return crate::query_executor::execution::evaluate_numeric_op(&l, op, &r_dec);
            } else {
                let l_f64 = l.to_string().parse::<f64>().unwrap_or(0.0);
                return Self::float64_arithmetic(op, l_f64, r_f64);
            }
        }
        if let (Some(l_f64), Some(r)) = (left.as_f64(), right.as_numeric()) {
            use rust_decimal::Decimal;

            if let Some(l_dec) = Decimal::from_f64_retain(l_f64) {
                return crate::query_executor::execution::evaluate_numeric_op(&l_dec, op, &r);
            } else {
                let r_f64 = r.to_string().parse::<f64>().unwrap_or(0.0);
                return Self::float64_arithmetic(op, l_f64, r_f64);
            }
        }

        match op {
            BinaryOp::VectorL2Distance => {
                crate::query_executor::execution::evaluate_vector_l2_distance(left, right)
            }
            BinaryOp::VectorInnerProduct => {
                crate::query_executor::execution::evaluate_vector_inner_product(left, right)
            }
            BinaryOp::VectorCosineDistance => {
                crate::query_executor::execution::evaluate_vector_cosine_distance(left, right)
            }

            BinaryOp::ArrayContains => yachtsql_functions::array::array_contains_array(left, right),
            BinaryOp::ArrayContainedBy => {
                yachtsql_functions::array::array_contained_by(left, right)
            }
            BinaryOp::ArrayOverlap => yachtsql_functions::array::array_overlap(left, right),

            BinaryOp::GeometricDistance => yachtsql_functions::geometric::distance(left, right),
            BinaryOp::GeometricContains => yachtsql_functions::geometric::contains(left, right),
            BinaryOp::GeometricContainedBy => {
                yachtsql_functions::geometric::contained_by(left, right)
            }
            BinaryOp::GeometricOverlap => yachtsql_functions::geometric::overlaps(left, right),
            _ => Err(crate::error::Error::TypeMismatch {
                expected: left.data_type().to_string(),
                actual: right.data_type().to_string(),
            }),
        }
    }

    pub(crate) fn evaluate_unary_op(
        op: &crate::optimizer::expr::UnaryOp,
        operand: &crate::types::Value,
    ) -> Result<crate::types::Value> {
        use yachtsql_optimizer::expr::UnaryOp;

        match op {
            UnaryOp::IsNull => Ok(Value::bool_val(operand.is_null())),
            UnaryOp::IsNotNull => Ok(Value::bool_val(!operand.is_null())),
            UnaryOp::Not => {
                if operand.is_null() {
                    return Ok(Value::null());
                }
                if let Some(b) = operand.as_bool() {
                    return Ok(Value::bool_val(!b));
                }
                Err(crate::error::Error::TypeMismatch {
                    expected: "BOOL".to_string(),
                    actual: operand.data_type().to_string(),
                })
            }
            UnaryOp::Negate => {
                if operand.is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = operand.as_i64() {
                    return i.checked_neg().map(Value::int64).ok_or_else(|| {
                        crate::error::Error::ExecutionError(format!(
                            "INT64 overflow: cannot negate {} (INT64::MIN)",
                            i
                        ))
                    });
                }
                if let Some(f) = operand.as_f64() {
                    return Ok(Value::float64(-f));
                }
                if let Some(n) = operand.as_numeric() {
                    return Ok(Value::numeric(-n));
                }
                Err(crate::error::Error::TypeMismatch {
                    expected: "numeric".to_string(),
                    actual: operand.data_type().to_string(),
                })
            }
            UnaryOp::Plus => {
                if operand.is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = operand.as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = operand.as_f64() {
                    return Ok(Value::float64(f));
                }
                if let Some(n) = operand.as_numeric() {
                    return Ok(Value::numeric(n));
                }
                Err(crate::error::Error::TypeMismatch {
                    expected: "numeric".to_string(),
                    actual: operand.data_type().to_string(),
                })
            }
        }
    }
}
