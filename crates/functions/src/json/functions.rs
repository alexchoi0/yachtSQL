use std::str::FromStr;

use rust_decimal::Decimal;
use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::{DataType, Value};
use yachtsql_parser::{JSON_VALUE_OPTIONS_PREFIX, JsonValueRewriteOptions};

use super::conversion::sql_to_json_fallible;
use super::parser::{DEFAULT_MAX_DEPTH, DEFAULT_MAX_SIZE, parse_json_with_limits};

#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub enum JsonOnBehavior {
    #[default]
    Null,
    Error,
    Default,
}

#[derive(Debug, Clone, Default)]
pub struct JsonValueEvalOptions {
    pub returning: Option<String>,
    pub on_empty: JsonOnBehavior,
    pub on_error: JsonOnBehavior,
    pub on_empty_default_expr: Option<String>,
    pub on_error_default_expr: Option<String>,
    pub on_empty_default_value: Option<Value>,
    pub on_error_default_value: Option<Value>,
}

impl JsonValueEvalOptions {
    pub fn from_literal(value: &Value) -> Result<Self> {
        if let Some(s) = value.as_str() {
            if !s.starts_with(JSON_VALUE_OPTIONS_PREFIX) {
                return Err(Error::invalid_query(
                    "Invalid JSON_VALUE options literal".to_string(),
                ));
            }

            let payload = &s[JSON_VALUE_OPTIONS_PREFIX.len()..];
            if payload.is_empty() {
                return Ok(JsonValueEvalOptions::default());
            }

            let mut options = JsonValueEvalOptions::default();

            for segment in payload.split(';') {
                if segment.is_empty() {
                    continue;
                }
                let mut parts = segment.splitn(2, '=');
                let key = parts.next().unwrap_or("").trim().to_ascii_uppercase();
                let raw_value = parts.next().unwrap_or("").trim();
                let value = raw_value.to_ascii_uppercase();

                match key.as_str() {
                    "T" => {
                        if value.is_empty() {
                            return Err(Error::invalid_query(
                                "JSON_VALUE RETURNING option requires a value".to_string(),
                            ));
                        }
                        options.returning = Some(value);
                    }
                    "E" => {
                        options.on_empty = match value.as_str() {
                            "NULL" => JsonOnBehavior::Null,
                            "ERROR" => JsonOnBehavior::Error,
                            "DEFAULT" => JsonOnBehavior::Default,
                            other => {
                                return Err(Error::invalid_query(format!(
                                    "Unsupported JSON_VALUE ON EMPTY behaviour '{}'",
                                    other
                                )));
                            }
                        };
                    }
                    "O" => {
                        options.on_error = match value.as_str() {
                            "NULL" => JsonOnBehavior::Null,
                            "ERROR" => JsonOnBehavior::Error,
                            "DEFAULT" => JsonOnBehavior::Default,
                            other => {
                                return Err(Error::invalid_query(format!(
                                    "Unsupported JSON_VALUE ON ERROR behaviour '{}'",
                                    other
                                )));
                            }
                        };
                    }
                    "ED" => {
                        if raw_value.is_empty() {
                            return Err(Error::invalid_query(
                                "JSON_VALUE ON EMPTY DEFAULT requires an expression".to_string(),
                            ));
                        }
                        options.on_empty = JsonOnBehavior::Default;
                        options.on_empty_default_expr = Some(raw_value.replace("''", "'"));
                    }
                    "OD" => {
                        if raw_value.is_empty() {
                            return Err(Error::invalid_query(
                                "JSON_VALUE ON ERROR DEFAULT requires an expression".to_string(),
                            ));
                        }
                        options.on_error = JsonOnBehavior::Default;
                        options.on_error_default_expr = Some(raw_value.replace("''", "'"));
                    }
                    other => {
                        return Err(Error::invalid_query(format!(
                            "Unknown JSON_VALUE option key '{}'",
                            other
                        )));
                    }
                }
            }

            return Ok(options);
        }

        Err(Error::invalid_query(format!(
            "JSON_VALUE options must be a STRING literal, found {}",
            value.data_type()
        )))
    }

    pub(crate) fn handle_empty(&self, path: &str) -> Result<Value> {
        match self.on_empty {
            JsonOnBehavior::Null => Ok(Value::null()),
            JsonOnBehavior::Error => Err(Error::InvalidOperation(format!(
                "JSON_VALUE path '{}' returned no value",
                path
            ))),
            JsonOnBehavior::Default => {
                let default_value = if let Some(value) = &self.on_empty_default_value {
                    value.clone()
                } else if let Some(expr_sql) = &self.on_empty_default_expr {
                    parse_json_default_literal(expr_sql)?
                } else {
                    return Err(Error::InvalidOperation(
                        "JSON_VALUE ON EMPTY DEFAULT could not be evaluated".to_string(),
                    ));
                };

                self.convert_returning(default_value).map_err(|reason| {
                    Error::InvalidOperation(format!(
                        "JSON_VALUE ON EMPTY DEFAULT conversion failed: {}",
                        reason
                    ))
                })
            }
        }
    }

    pub(crate) fn handle_error(&self, path: &str, reason: String) -> Result<Value> {
        match self.on_error {
            JsonOnBehavior::Null => Ok(Value::null()),
            JsonOnBehavior::Error => Err(Error::InvalidOperation(format!(
                "JSON_VALUE error at path '{}': {}",
                path, reason
            ))),
            JsonOnBehavior::Default => {
                let default_value = if let Some(value) = &self.on_error_default_value {
                    value.clone()
                } else if let Some(expr_sql) = &self.on_error_default_expr {
                    parse_json_default_literal(expr_sql)?
                } else {
                    return Err(Error::InvalidOperation(
                        "JSON_VALUE ON ERROR DEFAULT could not be evaluated".to_string(),
                    ));
                };

                self.convert_returning(default_value)
                    .map_err(|conversion_reason| {
                        Error::InvalidOperation(format!(
                            "JSON_VALUE ON ERROR DEFAULT conversion failed: {}",
                            conversion_reason
                        ))
                    })
            }
        }
    }

    pub(crate) fn convert_returning(&self, value: Value) -> std::result::Result<Value, String> {
        if value.is_null() {
            return Ok(Value::null());
        }

        match self.returning.as_deref() {
            None => {
                if value.as_i64().is_some()
                    || value.as_f64().is_some()
                    || value.as_numeric().is_some()
                {
                    return Ok(value);
                }

                if value.as_str().is_some() {
                    return Ok(value);
                }
                if let Some(b) = value.as_bool() {
                    return Ok(Value::string(b.to_string()));
                }
                if let Some(j) = value.as_json() {
                    return Ok(Value::string(j.to_string()));
                }
                Err(format!("Cannot convert {:?} to STRING", value))
            }
            Some("STRING") => {
                if value.as_str().is_some() {
                    return Ok(value);
                }
                if let Some(i) = value.as_i64() {
                    return Ok(Value::string(i.to_string()));
                }
                if let Some(f) = value.as_f64() {
                    return Ok(Value::string(f.to_string()));
                }
                if let Some(b) = value.as_bool() {
                    return Ok(Value::string(b.to_string()));
                }
                if let Some(n) = value.as_numeric() {
                    return Ok(Value::string(n.to_string()));
                }
                if let Some(j) = value.as_json() {
                    return Ok(Value::string(j.to_string()));
                }
                Err(format!("Cannot convert {:?} to STRING", value))
            }
            Some("FLOAT64") => {
                if value.as_f64().is_some() {
                    return Ok(value);
                }
                if let Some(i) = value.as_i64() {
                    return Ok(Value::float64(i as f64));
                }
                if let Some(n) = value.as_numeric() {
                    let parsed = n
                        .to_string()
                        .parse::<f64>()
                        .map_err(|_| format!("Cannot convert NUMERIC {} to FLOAT64", n))?;
                    return Ok(Value::float64(parsed));
                }
                if let Some(s) = value.as_str() {
                    return s
                        .trim()
                        .parse::<f64>()
                        .map(Value::float64)
                        .map_err(|_| format!("Cannot convert '{}' to FLOAT64", s));
                }
                Err(format!("Cannot convert {:?} to FLOAT64", value))
            }
            Some("INT64") => {
                if value.as_i64().is_some() {
                    return Ok(value);
                }
                if let Some(f) = value.as_f64() {
                    if (f.fract()).abs() > f64::EPSILON {
                        return Err(format!("Cannot convert non-integer FLOAT64 {} to INT64", f));
                    } else {
                        return Ok(Value::int64(f as i64));
                    }
                }
                if let Some(s) = value.as_str() {
                    return s
                        .trim()
                        .parse::<i64>()
                        .map(Value::int64)
                        .map_err(|_| format!("Cannot convert '{}' to INT64", s));
                }
                Err(format!("Cannot convert {:?} to INT64", value))
            }
            Some(other) => Err(format!("Unsupported RETURNING type {}", other)),
        }
    }

    pub fn inferred_return_type(&self) -> DataType {
        match self.returning.as_deref() {
            Some("FLOAT64") => DataType::Float64,
            Some("INT64") => DataType::Int64,
            Some("BOOL") => DataType::Bool,
            Some("NUMERIC") => DataType::Numeric(None),
            Some("STRING") | None => DataType::String,
            _ => DataType::String,
        }
    }

    pub fn from_rewrite(options: &JsonValueRewriteOptions) -> Result<Self> {
        let mut eval = JsonValueEvalOptions::default();

        if let Some(ret) = &options.returning {
            eval.returning = Some(ret.to_ascii_uppercase());
        }

        if let Some(on_empty) = &options.on_empty {
            match on_empty.to_ascii_uppercase().as_str() {
                "NULL" => eval.on_empty = JsonOnBehavior::Null,
                "ERROR" => eval.on_empty = JsonOnBehavior::Error,
                "DEFAULT" => {
                    eval.on_empty = JsonOnBehavior::Default;
                    eval.on_empty_default_expr = options.on_empty_default.clone();
                }
                other => {
                    return Err(Error::invalid_query(format!(
                        "Unsupported JSON_VALUE ON EMPTY behaviour '{}'",
                        other
                    )));
                }
            }
        }

        if let Some(on_error) = &options.on_error {
            match on_error.to_ascii_uppercase().as_str() {
                "NULL" => eval.on_error = JsonOnBehavior::Null,
                "ERROR" => eval.on_error = JsonOnBehavior::Error,
                "DEFAULT" => {
                    eval.on_error = JsonOnBehavior::Default;
                    eval.on_error_default_expr = options.on_error_default.clone();
                }
                other => {
                    return Err(Error::invalid_query(format!(
                        "Unsupported JSON_VALUE ON ERROR behaviour '{}'",
                        other
                    )));
                }
            }
        }

        Ok(eval)
    }
}

pub(crate) fn parse_json_default_literal(expr_sql: &str) -> Result<Value> {
    let parsed_expr = parse_sql_default_expression(expr_sql)?;
    literal_default_expr_to_value(&parsed_expr)
}

fn parse_sql_default_expression(expr_sql: &str) -> Result<sqlparser::ast::Expr> {
    let dialect = sqlparser::dialect::GenericDialect {};
    let mut tokenizer = sqlparser::tokenizer::Tokenizer::new(&dialect, expr_sql);

    let tokens = tokenizer.tokenize().map_err(|e| {
        Error::invalid_query(format!(
            "Failed to tokenize JSON_VALUE DEFAULT expression '{}': {}",
            expr_sql, e
        ))
    })?;

    let mut parser = sqlparser::parser::Parser::new(&dialect).with_tokens(tokens);
    parser.parse_expr().map_err(|e| {
        Error::invalid_query(format!(
            "Failed to parse JSON_VALUE DEFAULT expression '{}': {}",
            expr_sql, e
        ))
    })
}

fn literal_default_expr_to_value(expr: &sqlparser::ast::Expr) -> Result<Value> {
    use sqlparser::ast::{Expr as SqlExpr, UnaryOperator, Value as SqlValue};

    match expr {
        SqlExpr::Value(sql_value) => match &sql_value.value {
            SqlValue::SingleQuotedString(s)
            | SqlValue::DoubleQuotedString(s)
            | SqlValue::NationalStringLiteral(s) => Ok(Value::string(s.clone())),
            SqlValue::Boolean(b) => Ok(Value::bool_val(*b)),
            SqlValue::Null => Ok(Value::null()),
            SqlValue::Number(num_str, _) => parse_numeric_literal(num_str),
            other => Err(Error::unsupported_feature(format!(
                "Unsupported JSON_VALUE DEFAULT literal '{}'",
                other
            ))),
        },
        SqlExpr::UnaryOp { op, expr } => {
            let inner = literal_default_expr_to_value(expr)?;
            match op {
                UnaryOperator::Plus => Ok(inner),
                UnaryOperator::Minus => {
                    if let Some(i) = inner.as_i64() {
                        return Ok(Value::int64(-i));
                    }
                    if let Some(f) = inner.as_f64() {
                        return Ok(Value::float64(-f));
                    }
                    if let Some(d) = inner.as_numeric() {
                        return Ok(Value::numeric(-d));
                    }
                    Err(Error::unsupported_feature(
                        "JSON_VALUE DEFAULT supports negation for numeric literals only"
                            .to_string(),
                    ))
                }
                _ => Err(Error::unsupported_feature(
                    "JSON_VALUE DEFAULT only supports unary plus/minus".to_string(),
                )),
            }
        }
        SqlExpr::BinaryOp { .. } => Err(Error::unsupported_feature(
            "JSON_VALUE DEFAULT currently supports literal expressions only".to_string(),
        )),
        _ => Err(Error::unsupported_feature(
            "JSON_VALUE DEFAULT currently supports literal expressions only".to_string(),
        )),
    }
}

fn parse_numeric_literal(literal: &str) -> Result<Value> {
    if !literal.contains(['.', 'e', 'E'])
        && let Ok(int_val) = literal.parse::<i64>()
    {
        return Ok(Value::int64(int_val));
    }

    if let Ok(decimal) = Decimal::from_str(literal) {
        return Ok(Value::numeric(decimal));
    }

    if let Ok(float_val) = literal.parse::<f64>() {
        return Ok(Value::float64(float_val));
    }

    Err(Error::invalid_query(format!(
        "Invalid numeric literal '{}'",
        literal
    )))
}

pub fn to_json(value: &Value) -> Result<Value> {
    if value.is_null() {
        return Ok(Value::null());
    }

    if value.as_json().is_some() {
        return Ok(value.clone());
    }

    match sql_to_json_fallible(value) {
        Ok(json_val) => Ok(Value::json(json_val)),
        Err(_) => Err(Error::unsupported_feature(format!(
            "TO_JSON unsupported type for value {:?}",
            value.data_type()
        ))),
    }
}

pub fn to_json_string(value: &Value) -> Result<Value> {
    let json_val = to_json(value)?;

    if json_val.is_null() {
        return Ok(Value::null());
    }

    if let Some(j) = json_val.as_json() {
        return serde_json::to_string(&j)
            .map(Value::string)
            .map_err(|e| Error::InvalidOperation(format!("Failed to stringify JSON: {}", e)));
    }
    Ok(json_val)
}

pub fn parse_json(value: &Value) -> Result<Value> {
    if value.is_null() {
        return Ok(Value::null());
    }

    if let Some(json_val) = value.as_json() {
        return Ok(Value::json(json_val.clone()));
    }

    if let Some(s) = value.as_str() {
        return parse_json_with_limits(s, DEFAULT_MAX_DEPTH, DEFAULT_MAX_SIZE)
            .map(Value::json)
            .map_err(|e| Error::InvalidOperation(format!("Failed to parse JSON string: {}", e)));
    }

    Err(Error::InvalidOperation(
        "PARSE_JSON requires a STRING expression".to_string(),
    ))
}

pub use super::extract::*;
pub use super::postgres::*;
pub use super::predicates::*;
