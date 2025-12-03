use std::rc::Rc;

use yachtsql_core::error::Error;
use yachtsql_core::types::{DataType, Value};

use super::FunctionRegistry;
use crate::scalar::ScalarFunctionImpl;

pub(super) fn register(registry: &mut FunctionRegistry) {
    register_sign(registry);
    register_extrema(registry);
    register_basic_math(registry);
    register_rounding(registry);
    register_exponential(registry);
    register_trigonometric(registry);
    register_constants(registry);
}

fn register_sign(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "SIGN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "SIGN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i.signum()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::int64(f.signum() as i64));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );
}

fn register_extrema(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "GREATEST".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "GREATEST".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: true,
            evaluator: |args| extrema(args, true),
        }),
    );

    registry.register_scalar(
        "LEAST".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "LEAST".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: true,
            evaluator: |args| extrema(args, false),
        }),
    );
}

fn extrema(args: &[Value], pick_max: bool) -> yachtsql_core::error::Result<Value> {
    if args.is_empty() {
        return Err(Error::invalid_query(
            "LEAST/GREATEST require at least one argument".to_string(),
        ));
    }

    let non_null: Vec<&Value> = args.iter().filter(|value| !value.is_null()).collect();
    if non_null.is_empty() {
        return Ok(Value::null());
    }

    let mut best = non_null[0].clone();
    for value in &non_null[1..] {
        let order = compare_values(&best, value)?;
        let should_replace = match order {
            std::cmp::Ordering::Less => pick_max,
            std::cmp::Ordering::Greater => !pick_max,
            std::cmp::Ordering::Equal => false,
        };
        if should_replace {
            best = (*value).clone();
        }
    }

    Ok(best.clone())
}

fn compare_values<'a>(
    lhs: &'a Value,
    rhs: &'a Value,
) -> yachtsql_core::error::Result<std::cmp::Ordering> {
    if let (Some(a), Some(b)) = (lhs.as_i64(), rhs.as_i64()) {
        return Ok(a.cmp(&b));
    }

    if let (Some(a), Some(b)) = (lhs.as_f64(), rhs.as_f64()) {
        return Ok(a.partial_cmp(&b).unwrap_or(std::cmp::Ordering::Equal));
    }

    if let (Some(a), Some(b)) = (lhs.as_i64(), rhs.as_f64()) {
        return Ok((a as f64)
            .partial_cmp(&b)
            .unwrap_or(std::cmp::Ordering::Equal));
    }

    if let (Some(a), Some(b)) = (lhs.as_f64(), rhs.as_i64()) {
        return Ok(a
            .partial_cmp(&(b as f64))
            .unwrap_or(std::cmp::Ordering::Equal));
    }

    if let (Some(a), Some(b)) = (lhs.as_str(), rhs.as_str()) {
        return Ok(a.cmp(b));
    }

    Err(Error::TypeMismatch {
        expected: "Comparable numeric or string types".to_string(),
        actual: format!("{}, {}", lhs.data_type(), rhs.data_type()),
    })
}

fn register_basic_math(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "ABS".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ABS".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i.abs()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.abs()));
                }
                if let Some(d) = args[0].as_numeric() {
                    return Ok(Value::numeric(d.abs()));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "MOD".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "MOD".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args.len() != 2 {
                    return Err(Error::invalid_query(
                        "MOD requires exactly 2 arguments".to_string(),
                    ));
                }
                if args[0].is_null() || args[1].is_null() {
                    return Ok(Value::null());
                }

                if let (Some(a), Some(b)) = (args[0].as_i64(), args[1].as_i64()) {
                    if b == 0 {
                        return Err(Error::invalid_query("Division by zero in MOD".to_string()));
                    }
                    return Ok(Value::int64(a.rem_euclid(b)));
                }

                if let (Some(a), Some(b)) = (args[0].as_f64(), args[1].as_f64()) {
                    if b == 0.0 {
                        return Err(Error::invalid_query("Division by zero in MOD".to_string()));
                    }
                    return Ok(Value::float64(a.rem_euclid(b)));
                }

                if let (Some(a), Some(b)) = (args[0].as_i64(), args[1].as_f64()) {
                    if b == 0.0 {
                        return Err(Error::invalid_query("Division by zero in MOD".to_string()));
                    }
                    return Ok(Value::float64((a as f64).rem_euclid(b)));
                }

                if let (Some(a), Some(b)) = (args[0].as_f64(), args[1].as_i64()) {
                    if b == 0 {
                        return Err(Error::invalid_query("Division by zero in MOD".to_string()));
                    }
                    return Ok(Value::float64(a.rem_euclid(b as f64)));
                }

                Err(Error::TypeMismatch {
                    expected: "NUMERIC, NUMERIC".to_string(),
                    actual: format!("{}, {}", args[0].data_type(), args[1].data_type()),
                })
            },
        }),
    );

    registry.register_scalar(
        "SQRT".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "SQRT".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    if i < 0 {
                        return Err(Error::invalid_query(
                            "Cannot take square root of negative number".to_string(),
                        ));
                    }
                    return Ok(Value::float64((i as f64).sqrt()));
                }
                if let Some(f) = args[0].as_f64() {
                    if f < 0.0 {
                        return Err(Error::invalid_query(
                            "Cannot take square root of negative number".to_string(),
                        ));
                    }
                    return Ok(Value::float64(f.sqrt()));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "CBRT".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "CBRT".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).cbrt()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.cbrt()));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );
}

fn register_rounding(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "CEIL".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "CEIL".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::int64(f.ceil() as i64));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "CEILING".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "CEILING".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::int64(f.ceil() as i64));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "FLOOR".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "FLOOR".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::int64(f.floor() as i64));
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "ROUND".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ROUND".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: true,
            evaluator: |args| {
                if args.is_empty() || args.len() > 2 {
                    return Err(Error::invalid_query(
                        "ROUND requires 1 or 2 arguments".to_string(),
                    ));
                }

                let decimals = if args.len() == 2 {
                    if args[1].is_null() {
                        return Ok(Value::null());
                    }
                    if let Some(d) = args[1].as_i64() {
                        d
                    } else {
                        return Err(Error::TypeMismatch {
                            expected: "INT64".to_string(),
                            actual: args[1].data_type().to_string(),
                        });
                    }
                } else {
                    0
                };

                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    let multiplier = 10_f64.powi(decimals as i32);
                    let rounded = (f * multiplier).round() / multiplier;
                    if decimals == 0 {
                        return Ok(Value::int64(rounded as i64));
                    } else {
                        return Ok(Value::float64(rounded));
                    }
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "TRUNC".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "TRUNC".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: true,
            evaluator: |args| {
                if args.is_empty() || args.len() > 2 {
                    return Err(Error::invalid_query(
                        "TRUNC requires 1 or 2 arguments".to_string(),
                    ));
                }

                let decimals = if args.len() == 2 {
                    if args[1].is_null() {
                        return Ok(Value::null());
                    }
                    if let Some(d) = args[1].as_i64() {
                        d
                    } else {
                        return Err(Error::TypeMismatch {
                            expected: "INT64".to_string(),
                            actual: args[1].data_type().to_string(),
                        });
                    }
                } else {
                    0
                };

                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    let multiplier = 10_f64.powi(decimals as i32);
                    let truncated = (f * multiplier).trunc() / multiplier;
                    if decimals == 0 {
                        return Ok(Value::int64(truncated as i64));
                    } else {
                        return Ok(Value::float64(truncated));
                    }
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );

    registry.register_scalar(
        "TRUNCATE".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "TRUNCATE".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Int64,
            variadic: true,
            evaluator: |args| {
                if args.is_empty() || args.len() > 2 {
                    return Err(Error::invalid_query(
                        "TRUNCATE requires 1 or 2 arguments".to_string(),
                    ));
                }

                let decimals = if args.len() == 2 {
                    if args[1].is_null() {
                        return Ok(Value::null());
                    }
                    if let Some(d) = args[1].as_i64() {
                        d
                    } else {
                        return Err(Error::TypeMismatch {
                            expected: "INT64".to_string(),
                            actual: args[1].data_type().to_string(),
                        });
                    }
                } else {
                    0
                };

                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::int64(i));
                }
                if let Some(f) = args[0].as_f64() {
                    let multiplier = 10_f64.powi(decimals as i32);
                    let truncated = (f * multiplier).trunc() / multiplier;
                    if decimals == 0 {
                        return Ok(Value::int64(truncated as i64));
                    } else {
                        return Ok(Value::float64(truncated));
                    }
                }
                return Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                });
            },
        }),
    );
}

fn register_exponential(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "EXP".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "EXP".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).exp()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.exp()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "LN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "LN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    if i <= 0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64((i as f64).ln()));
                    }
                }
                if let Some(f) = args[0].as_f64() {
                    if f <= 0.0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(f.ln()));
                    }
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "LOG".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "LOG".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: true,
            evaluator: |args| {
                if args.is_empty() || args.len() > 2 {
                    return Err(Error::invalid_query(
                        "LOG requires 1 or 2 arguments".to_string(),
                    ));
                }

                if args.len() == 1 {
                    if args[0].is_null() {
                        return Ok(Value::null());
                    }
                    if let Some(i) = args[0].as_i64() {
                        if i <= 0 {
                            return Err(Error::invalid_query(
                                "Cannot take logarithm of non-positive number".to_string(),
                            ));
                        } else {
                            return Ok(Value::float64((i as f64).ln()));
                        }
                    }
                    if let Some(f) = args[0].as_f64() {
                        if f <= 0.0 {
                            return Err(Error::invalid_query(
                                "Cannot take logarithm of non-positive number".to_string(),
                            ));
                        } else {
                            return Ok(Value::float64(f.ln()));
                        }
                    }
                    return Err(Error::TypeMismatch {
                        expected: "NUMERIC".to_string(),
                        actual: args[0].data_type().to_string(),
                    });
                } else {
                    let base = if args[0].is_null() {
                        return Ok(Value::null());
                    } else if let Some(i) = args[0].as_i64() {
                        i as f64
                    } else if let Some(f) = args[0].as_f64() {
                        f
                    } else {
                        return Err(Error::TypeMismatch {
                            expected: "NUMERIC".to_string(),
                            actual: args[0].data_type().to_string(),
                        });
                    };

                    let value = if args[1].is_null() {
                        return Ok(Value::null());
                    } else if let Some(i) = args[1].as_i64() {
                        i as f64
                    } else if let Some(f) = args[1].as_f64() {
                        f
                    } else {
                        return Err(Error::TypeMismatch {
                            expected: "NUMERIC".to_string(),
                            actual: args[1].data_type().to_string(),
                        });
                    };

                    if value <= 0.0 || base <= 0.0 || base == 1.0 {
                        return Err(Error::invalid_query(
                            "Invalid base or value for logarithm".to_string(),
                        ));
                    } else {
                        Ok(Value::float64(value.log(base)))
                    }
                }
            },
        }),
    );

    registry.register_scalar(
        "LOG10".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "LOG10".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    if i <= 0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64((i as f64).log10()));
                    }
                }
                if let Some(f) = args[0].as_f64() {
                    if f <= 0.0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(f.log10()));
                    }
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "LOG2".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "LOG2".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    if i <= 0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64((i as f64).log2()));
                    }
                }
                if let Some(f) = args[0].as_f64() {
                    if f <= 0.0 {
                        return Err(Error::invalid_query(
                            "Cannot take logarithm of non-positive number".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(f.log2()));
                    }
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "POWER".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "POWER".to_string(),
            arg_types: vec![DataType::Float64, DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() || args[1].is_null() {
                    return Ok(Value::null());
                }

                let (base_f64, exp_f64) = match (
                    args[0].as_i64(),
                    args[0].as_f64(),
                    args[1].as_i64(),
                    args[1].as_f64(),
                ) {
                    (Some(base), _, Some(exp), _) => (base as f64, exp as f64),
                    (_, Some(base), _, Some(exp)) => (base, exp),
                    (Some(base), _, _, Some(exp)) => (base as f64, exp),
                    (_, Some(base), Some(exp), _) => (base, exp as f64),
                    _ => {
                        return Err(Error::TypeMismatch {
                            expected: "NUMERIC, NUMERIC".to_string(),
                            actual: format!("{}, {}", args[0].data_type(), args[1].data_type()),
                        })
                    }
                };


                if base_f64 < 0.0 && exp_f64.fract() != 0.0 {
                    return Err(Error::invalid_query(
                        "Cannot raise negative number to fractional power (would produce complex result)".to_string(),
                    ));
                }

                let result = base_f64.powf(exp_f64);


                if result.is_nan() {
                    return Err(Error::invalid_query(
                        "POWER operation resulted in NaN".to_string(),
                    ));
                }

                Ok(Value::float64(result))
            },
        }),
    );

    registry.register_scalar(
        "POW".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "POW".to_string(),
            arg_types: vec![DataType::Float64, DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() || args[1].is_null() {
                    return Ok(Value::null());
                }

                let (base_f64, exp_f64) = match (
                    args[0].as_i64(),
                    args[0].as_f64(),
                    args[1].as_i64(),
                    args[1].as_f64(),
                ) {
                    (Some(base), _, Some(exp), _) => (base as f64, exp as f64),
                    (_, Some(base), _, Some(exp)) => (base, exp),
                    (Some(base), _, _, Some(exp)) => (base as f64, exp),
                    (_, Some(base), Some(exp), _) => (base, exp as f64),
                    _ => {
                        return Err(Error::TypeMismatch {
                            expected: "NUMERIC, NUMERIC".to_string(),
                            actual: format!("{}, {}", args[0].data_type(), args[1].data_type()),
                        })
                    }
                };


                if base_f64 < 0.0 && exp_f64.fract() != 0.0 {
                    return Err(Error::invalid_query(
                        "Cannot raise negative number to fractional power (would produce complex result)".to_string(),
                    ));
                }

                let result = base_f64.powf(exp_f64);


                if result.is_nan() {
                    return Err(Error::invalid_query(
                        "POW operation resulted in NaN".to_string(),
                    ));
                }

                Ok(Value::float64(result))
            },
        }),
    );
}

fn register_trigonometric(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "SIN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "SIN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).sin()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.sin()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "COS".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "COS".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).cos()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.cos()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "TAN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "TAN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).tan()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.tan()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "ASIN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ASIN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    let val = i as f64;
                    if !(-1.0..=1.0).contains(&val) {
                        return Err(Error::invalid_query(
                            "ASIN input must be in range [-1, 1]".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(val.asin()));
                    }
                }
                if let Some(f) = args[0].as_f64() {
                    if !(-1.0..=1.0).contains(&f) {
                        return Err(Error::invalid_query(
                            "ASIN input must be in range [-1, 1]".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(f.asin()));
                    }
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "ACOS".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ACOS".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    let val = i as f64;
                    if !(-1.0..=1.0).contains(&val) {
                        return Err(Error::invalid_query(
                            "ACOS input must be in range [-1, 1]".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(val.acos()));
                    }
                }
                if let Some(f) = args[0].as_f64() {
                    if !(-1.0..=1.0).contains(&f) {
                        return Err(Error::invalid_query(
                            "ACOS input must be in range [-1, 1]".to_string(),
                        ));
                    } else {
                        return Ok(Value::float64(f.acos()));
                    }
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "ATAN".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ATAN".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).atan()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.atan()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "ATAN2".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "ATAN2".to_string(),
            arg_types: vec![DataType::Float64, DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() || args[1].is_null() {
                    return Ok(Value::null());
                }

                match (
                    args[0].as_i64(),
                    args[0].as_f64(),
                    args[1].as_i64(),
                    args[1].as_f64(),
                ) {
                    (Some(y), _, Some(x), _) => Ok(Value::float64((y as f64).atan2(x as f64))),
                    (_, Some(y), _, Some(x)) => Ok(Value::float64(y.atan2(x))),
                    (Some(y), _, _, Some(x)) => Ok(Value::float64((y as f64).atan2(x))),
                    (_, Some(y), Some(x), _) => Ok(Value::float64(y.atan2(x as f64))),
                    _ => Err(Error::TypeMismatch {
                        expected: "NUMERIC, NUMERIC".to_string(),
                        actual: format!("{}, {}", args[0].data_type(), args[1].data_type()),
                    }),
                }
            },
        }),
    );

    registry.register_scalar(
        "SINH".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "SINH".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).sinh()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.sinh()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "COSH".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "COSH".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).cosh()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.cosh()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "TANH".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "TANH".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).tanh()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.tanh()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "RADIANS".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "RADIANS".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).to_radians()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.to_radians()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );

    registry.register_scalar(
        "DEGREES".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "DEGREES".to_string(),
            arg_types: vec![DataType::Float64],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |args| {
                if args[0].is_null() {
                    return Ok(Value::null());
                }
                if let Some(i) = args[0].as_i64() {
                    return Ok(Value::float64((i as f64).to_degrees()));
                }
                if let Some(f) = args[0].as_f64() {
                    return Ok(Value::float64(f.to_degrees()));
                }
                Err(Error::TypeMismatch {
                    expected: "NUMERIC".to_string(),
                    actual: args[0].data_type().to_string(),
                })
            },
        }),
    );
}

fn register_constants(registry: &mut FunctionRegistry) {
    registry.register_scalar(
        "PI".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "PI".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |_| Ok(Value::float64(std::f64::consts::PI)),
        }),
    );

    registry.register_scalar(
        "E".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "E".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |_| Ok(Value::float64(std::f64::consts::E)),
        }),
    );

    registry.register_scalar(
        "RANDOM".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "RANDOM".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |_| {
                use rand::Rng;
                let mut rng = rand::thread_rng();
                Ok(Value::float64(rng.r#gen::<f64>()))
            },
        }),
    );

    registry.register_scalar(
        "RAND".to_string(),
        Rc::new(ScalarFunctionImpl {
            name: "RAND".to_string(),
            arg_types: vec![],
            return_type: DataType::Float64,
            variadic: false,
            evaluator: |_| {
                use rand::Rng;
                let mut rng = rand::thread_rng();
                Ok(Value::float64(rng.r#gen::<f64>()))
            },
        }),
    );
}
