use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;
use yachtsql_optimizer::BinaryOp;
use yachtsql_optimizer::expr::Expr;
use yachtsql_storage::Schema;

use super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(crate) fn compute_column_occurrence_indices(
        expressions: &[(Expr, Option<String>)],
    ) -> Vec<usize> {
        let mut occurrence_tracker: std::collections::HashMap<String, usize> =
            std::collections::HashMap::new();

        expressions
            .iter()
            .map(|(expr, _)| {
                if let Expr::Column { name, .. } = expr {
                    let idx = *occurrence_tracker.get(name).unwrap_or(&0);
                    occurrence_tracker.insert(name.clone(), idx + 1);
                    idx
                } else {
                    0
                }
            })
            .collect()
    }

    fn find_column_by_occurrence(
        schema: &Schema,
        col_name: &str,
        occurrence_index: usize,
    ) -> Result<usize> {
        let mut count = 0;
        for (idx, field) in schema.fields().iter().enumerate() {
            if field.name == col_name {
                if count == occurrence_index {
                    return Ok(idx);
                }
                count += 1;
            }
        }
        Err(Error::column_not_found(format!(
            "Column '{}' (occurrence {}) not found",
            col_name, occurrence_index
        )))
    }

    pub(crate) fn evaluate_expr_with_occurrence(
        expr: &Expr,
        batch: &RecordBatch,
        row_idx: usize,
        occurrence_index: usize,
        dialect: crate::DialectType,
    ) -> Result<Value> {
        match expr {
            Expr::Column { name, table: _ } => {
                let col_idx =
                    Self::find_column_by_occurrence(batch.schema(), name, occurrence_index)?;
                let column = batch
                    .column(col_idx)
                    .ok_or_else(|| Error::column_not_found(name.clone()))?;
                column.get(row_idx)
            }
            _ => Self::evaluate_expr_internal(expr, batch, row_idx, dialect),
        }
    }

    pub(crate) fn evaluate_expr(expr: &Expr, batch: &RecordBatch, row_idx: usize) -> Result<Value> {
        Self::evaluate_expr_internal(expr, batch, row_idx, crate::DialectType::PostgreSQL)
    }

    pub(super) fn evaluate_expr_internal(
        expr: &Expr,
        batch: &RecordBatch,
        row_idx: usize,
        _dialect: crate::DialectType,
    ) -> Result<Value> {
        match expr {
            Expr::Column { name, table: _ } => Self::evaluate_column(name, batch, row_idx),

            Expr::Literal(lit) => Self::evaluate_literal(lit, batch, row_idx),

            Expr::Wildcard => Ok(Value::int64(1)),

            Expr::BinaryOp { left, op, right } => match op {
                BinaryOp::And => Self::evaluate_and(left, right, batch, row_idx),
                BinaryOp::Or => Self::evaluate_or(left, right, batch, row_idx),
                _ => {
                    let left_val = Self::evaluate_expr(left, batch, row_idx)?;
                    let right_val = Self::evaluate_expr(right, batch, row_idx)?;
                    Self::evaluate_binary_op(&left_val, op, &right_val)
                }
            },

            Expr::Case {
                operand,
                when_then,
                else_expr,
            } => Self::evaluate_case(operand, when_then, else_expr, batch, row_idx),

            Expr::Cast { expr, data_type } => {
                let value = Self::evaluate_expr(expr, batch, row_idx)?;
                Self::cast_value(value, data_type)
            }

            Expr::TryCast { expr, data_type } => {
                let value = Self::evaluate_expr(expr, batch, row_idx)?;
                Ok(Self::try_cast_value(value, data_type))
            }

            Expr::UnaryOp { op, expr } => {
                let operand = Self::evaluate_expr(expr, batch, row_idx)?;
                Self::evaluate_unary_op(op, &operand)
            }

            Expr::Function { name, args } => {
                let func_name = name.as_str();

                Self::evaluate_function_by_category(func_name, args, batch, row_idx)
            }

            Expr::Aggregate {
                name,
                args,
                distinct: _,
                ..
            } => {
                let agg_name = format!(
                    "{}({})",
                    name.as_str(),
                    args.iter()
                        .map(|a| match a {
                            Expr::Column { name, .. } => name.clone(),
                            Expr::Literal(lit) => format!("{:?}", lit),
                            _ => "*".to_string(),
                        })
                        .collect::<Vec<_>>()
                        .join(", ")
                );

                if let Some(col_idx) = batch
                    .schema()
                    .fields()
                    .iter()
                    .position(|f| f.name == agg_name || f.name == name.as_str())
                {
                    batch
                        .column(col_idx)
                        .ok_or_else(|| Error::column_not_found(&agg_name))?
                        .get(row_idx)
                } else {
                    if args.len() == 1 {
                        Self::compute_aggregate_over_batch(name.as_str(), &args[0], batch)
                    } else {
                        Err(Error::unsupported_feature(format!(
                            "Aggregate expression {} requires pre-computed values",
                            agg_name
                        )))
                    }
                }
            }

            Expr::ArrayIndex {
                array,
                index,
                safe: _,
            } => Self::evaluate_array_index(array, index, batch, row_idx),

            Expr::ArraySlice { array, start, end } => {
                Self::evaluate_array_slice(array, start, end, batch, row_idx)
            }

            Expr::Tuple(exprs) => Self::evaluate_tuple_as_struct(exprs, batch, row_idx),

            Expr::StructLiteral { fields } => Self::evaluate_struct_literal(fields, batch, row_idx),

            Expr::StructFieldAccess { expr, field } => {
                Self::evaluate_struct_field_access(expr, field, batch, row_idx)
            }

            Expr::Grouping { column: _ } => Self::evaluate_grouping(),

            Expr::Between {
                expr,
                low,
                high,
                negated,
            } => {
                let val = Self::evaluate_expr(expr, batch, row_idx)?;
                let low_val = Self::evaluate_expr(low, batch, row_idx)?;
                let high_val = Self::evaluate_expr(high, batch, row_idx)?;

                let result = if val.is_null() || low_val.is_null() || high_val.is_null() {
                    Value::null()
                } else if let (Some(v), Some(l), Some(h)) =
                    (val.as_i64(), low_val.as_i64(), high_val.as_i64())
                {
                    Value::bool_val(v >= l && v <= h)
                } else if let (Some(v), Some(l), Some(h)) =
                    (val.as_f64(), low_val.as_f64(), high_val.as_f64())
                {
                    Value::bool_val(v >= l && v <= h)
                } else if let (Some(v), Some(l), Some(h)) =
                    (val.as_str(), low_val.as_str(), high_val.as_str())
                {
                    Value::bool_val(v >= l && v <= h)
                } else if let (Some(v), Some(l), Some(h)) =
                    (val.as_date(), low_val.as_date(), high_val.as_date())
                {
                    Value::bool_val(v >= l && v <= h)
                } else if let (Some(v), Some(l), Some(h)) = (
                    val.as_timestamp(),
                    low_val.as_timestamp(),
                    high_val.as_timestamp(),
                ) {
                    Value::bool_val(v >= l && v <= h)
                } else {
                    Value::null()
                };

                Ok(if *negated {
                    if let Some(b) = result.as_bool() {
                        Value::bool_val(!b)
                    } else {
                        result
                    }
                } else {
                    result
                })
            }
            Expr::InList {
                expr,
                list,
                negated,
            } => {
                let val = Self::evaluate_expr(expr, batch, row_idx)?;

                let mut found = false;
                let mut has_null = false;

                for item in list {
                    let item_val = Self::evaluate_expr(item, batch, row_idx)?;
                    if item_val.is_null() {
                        has_null = true;
                        continue;
                    }
                    if val == item_val {
                        found = true;
                        break;
                    }
                }

                let result = if found {
                    Value::bool_val(true)
                } else if has_null {
                    Value::null()
                } else {
                    Value::bool_val(false)
                };

                Ok(if *negated {
                    if let Some(b) = result.as_bool() {
                        Value::bool_val(!b)
                    } else if result.is_null() {
                        Value::null()
                    } else {
                        result
                    }
                } else {
                    result
                })
            }

            Expr::Subquery { plan } => Self::evaluate_scalar_subquery_expr(plan),

            Expr::ScalarSubquery { subquery } => Self::evaluate_scalar_subquery_expr(subquery),

            Expr::Exists { plan, negated } => Self::evaluate_exists_subquery_expr(plan, *negated),

            Expr::InSubquery {
                expr,
                plan,
                negated,
            } => Self::evaluate_in_subquery_expr(expr, plan, *negated, batch, row_idx),

            Expr::TupleInList {
                tuple,
                list,
                negated,
            } => Self::evaluate_tuple_in_list_with_coercion(tuple, list, *negated, batch, row_idx),

            Expr::TupleInSubquery {
                tuple,
                plan,
                negated,
            } => Self::evaluate_tuple_in_subquery_expr(tuple, plan, *negated, batch, row_idx),

            Expr::AnyOp {
                left,
                compare_op,
                right,
            } => Self::evaluate_any_op_expr(left, compare_op, right, batch, row_idx),

            Expr::AllOp {
                left,
                compare_op,
                right,
            } => Self::evaluate_all_op_expr(left, compare_op, right, batch, row_idx),

            _ => Err(Error::unsupported_feature(format!(
                "Expression evaluation not yet implemented for: {:?}",
                expr
            ))),
        }
    }

    fn evaluate_function_by_category(
        func_name: &str,
        args: &[Expr],
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        if matches!(
            func_name,
            "CONCAT"
                | "TRIM"
                | "LTRIM"
                | "RTRIM"
                | "UPPER"
                | "LOWER"
                | "REPLACE"
                | "SUBSTR"
                | "SUBSTRING"
                | "LENGTH"
                | "CHAR_LENGTH"
                | "CHARACTER_LENGTH"
                | "SPLIT"
                | "STARTS_WITH"
                | "ENDS_WITH"
                | "REGEXP_CONTAINS"
                | "REGEXP_REPLACE"
                | "REGEXP_EXTRACT"
                | "POSITION"
                | "STRPOS"
                | "LEFT"
                | "RIGHT"
                | "REPEAT"
                | "REVERSE"
                | "LPAD"
                | "RPAD"
                | "ASCII"
                | "CHR"
                | "INITCAP"
                | "TRANSLATE"
                | "FORMAT"
                | "QUOTE_IDENT"
                | "QUOTE_LITERAL"
        ) {
            return Self::evaluate_string_function(func_name, args, batch, row_idx);
        }

        if matches!(
            func_name,
            "ARRAY_LENGTH"
                | "ARRAY_CONCAT"
                | "ARRAY_CAT"
                | "ARRAY_REVERSE"
                | "ARRAY_APPEND"
                | "ARRAY_PREPEND"
                | "ARRAY_POSITION"
                | "ARRAY_CONTAINS"
                | "ARRAY_REMOVE"
                | "ARRAY_REPLACE"
                | "ARRAY_SORT"
                | "ARRAY_DISTINCT"
                | "GENERATE_ARRAY"
                | "GENERATE_DATE_ARRAY"
                | "GENERATE_TIMESTAMP_ARRAY"
        ) {
            return Self::evaluate_array_function(func_name, args, batch, row_idx);
        }

        if matches!(
            func_name,
            "SIGN"
                | "ABS"
                | "CEIL"
                | "CEILING"
                | "FLOOR"
                | "ROUND"
                | "TRUNC"
                | "TRUNCATE"
                | "MOD"
                | "POWER"
                | "POW"
                | "SQRT"
                | "EXP"
                | "LN"
                | "LOG"
                | "LOG10"
                | "SIN"
                | "COS"
                | "TAN"
                | "ASIN"
                | "ACOS"
                | "ATAN"
                | "ATAN2"
                | "DEGREES"
                | "RADIANS"
                | "PI"
                | "RANDOM"
                | "RAND"
                | "SAFE_DIVIDE"
                | "SAFE_MULTIPLY"
                | "SAFE_ADD"
                | "SAFE_SUBTRACT"
                | "SAFE_NEGATE"
        ) {
            return Self::evaluate_math_function(func_name, args, batch, row_idx);
        }

        if matches!(
            func_name,
            "CURRENT_DATE"
                | "CURRENT_TIMESTAMP"
                | "NOW"
                | "CURRENT_TIME"
                | "DATE_ADD"
                | "DATE_SUB"
                | "DATE_DIFF"
                | "EXTRACT"
                | "DATE_PART"
                | "DATE_TRUNC"
                | "TIMESTAMP_TRUNC"
                | "FORMAT_DATE"
                | "FORMAT_TIMESTAMP"
                | "PARSE_DATE"
                | "PARSE_TIMESTAMP"
                | "STR_TO_DATE"
                | "MAKE_DATE"
                | "MAKE_TIMESTAMP"
                | "AGE"
                | "DATE"
                | "TIMESTAMP_DIFF"
                | "INTERVAL_LITERAL"
                | "YEAR"
                | "MONTH"
                | "DAY"
                | "HOUR"
                | "MINUTE"
                | "SECOND"
                | "QUARTER"
                | "WEEK"
                | "ISOWEEK"
                | "DAYOFWEEK"
                | "DAYOFYEAR"
                | "DAYOFMONTH"
                | "WEEKDAY"
                | "LAST_DAY"
        ) {
            return Self::evaluate_datetime_function(func_name, args, batch, row_idx);
        }

        if func_name.starts_with("JSON")
            || func_name.starts_with("IS_JSON")
            || func_name.starts_with("IS_NOT_JSON")
        {
            return Self::evaluate_json_function(func_name, args, batch, row_idx);
        }

        if matches!(
            func_name,
            "MD5" | "SHA1" | "SHA256" | "SHA512" | "FARM_FINGERPRINT" | "TO_HEX" | "FROM_HEX"
        ) || func_name.starts_with("NET.")
        {
            return Self::evaluate_crypto_hash_network_function(func_name, args, batch, row_idx);
        }

        if func_name.starts_with("AEAD.")
            || func_name.starts_with("DETERMINISTIC_")
            || func_name.starts_with("KEYS.")
        {
            return Self::evaluate_encryption_function(func_name, args, batch, row_idx);
        }

        if matches!(
            func_name,
            "COALESCE" | "IFNULL" | "NULLIF" | "IF" | "IIF" | "DECODE" | "GREATEST" | "LEAST"
        ) {
            return Self::evaluate_conditional_function(func_name, args, batch, row_idx);
        }

        if matches!(func_name, "GENERATE_UUID" | "GENERATE_UUID_ARRAY") {
            return Self::evaluate_generator_function(func_name, args, batch, row_idx);
        }

        if matches!(func_name, "TO_NUMBER" | "TO_CHAR") {
            return Self::evaluate_conversion_function(func_name, args, batch, row_idx);
        }

        if func_name.starts_with("YACHTSQL.") {
            return Self::evaluate_system_function(func_name, args, batch, row_idx);
        }

        Err(Error::unsupported_feature(format!(
            "Unknown function: {}",
            func_name
        )))
    }

    fn compute_aggregate_over_batch(
        agg_name: &str,
        arg: &Expr,
        batch: &RecordBatch,
    ) -> Result<Value> {
        let num_rows = batch.num_rows();
        if num_rows == 0 {
            return Ok(match agg_name.to_uppercase().as_str() {
                "COUNT" => Value::int64(0),
                _ => Value::null(),
            });
        }

        let mut values = Vec::with_capacity(num_rows);
        for row_idx in 0..num_rows {
            let val = Self::evaluate_expr(arg, batch, row_idx)?;
            values.push(val);
        }

        match agg_name.to_uppercase().as_str() {
            "COUNT" => {
                let count = values.iter().filter(|v| !v.is_null()).count();
                Ok(Value::int64(count as i64))
            }
            "SUM" => {
                let mut sum_int: i64 = 0;
                let mut sum_float: f64 = 0.0;
                let mut has_float = false;
                let mut has_value = false;

                for v in &values {
                    if !v.is_null() {
                        has_value = true;
                        if let Some(i) = v.as_i64() {
                            sum_int += i;
                            sum_float += i as f64;
                        } else if let Some(f) = v.as_f64() {
                            has_float = true;
                            sum_float += f;
                        }
                    }
                }

                if !has_value {
                    Ok(Value::null())
                } else if has_float {
                    Ok(Value::float64(sum_float))
                } else {
                    Ok(Value::int64(sum_int))
                }
            }
            "AVG" => {
                let mut sum: f64 = 0.0;
                let mut count: usize = 0;

                for v in &values {
                    if !v.is_null() {
                        if let Some(n) = v.as_f64() {
                            sum += n;
                            count += 1;
                        } else if let Some(i) = v.as_i64() {
                            sum += i as f64;
                            count += 1;
                        }
                    }
                }

                if count == 0 {
                    Ok(Value::null())
                } else {
                    Ok(Value::float64(sum / count as f64))
                }
            }
            "MIN" => {
                let mut min_val: Option<Value> = None;
                for v in values {
                    if !v.is_null() {
                        min_val = Some(match min_val {
                            None => v,
                            Some(cur) => {
                                let cur_f = cur.as_f64().or_else(|| cur.as_i64().map(|i| i as f64));
                                let v_f = v.as_f64().or_else(|| v.as_i64().map(|i| i as f64));
                                match (cur_f, v_f) {
                                    (Some(c), Some(vv)) if vv < c => v,
                                    _ => cur,
                                }
                            }
                        });
                    }
                }
                Ok(min_val.unwrap_or_else(Value::null))
            }
            "MAX" => {
                let mut max_val: Option<Value> = None;
                for v in values {
                    if !v.is_null() {
                        max_val = Some(match max_val {
                            None => v,
                            Some(cur) => {
                                let cur_f = cur.as_f64().or_else(|| cur.as_i64().map(|i| i as f64));
                                let v_f = v.as_f64().or_else(|| v.as_i64().map(|i| i as f64));
                                match (cur_f, v_f) {
                                    (Some(c), Some(vv)) if vv > c => v,
                                    _ => cur,
                                }
                            }
                        });
                    }
                }
                Ok(max_val.unwrap_or_else(Value::null))
            }
            "ARRAY_AGG" => {
                let non_null_values: Vec<Value> =
                    values.into_iter().filter(|v| !v.is_null()).collect();
                Ok(Value::array(non_null_values))
            }
            _ => Err(Error::unsupported_feature(format!(
                "Aggregate function {} not supported in expression context",
                agg_name
            ))),
        }
    }
}
