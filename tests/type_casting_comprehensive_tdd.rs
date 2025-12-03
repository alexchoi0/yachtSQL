#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_cast_float_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (f FLOAT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (42.7)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(f AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(42), "Should truncate to 42");
}

#[test]
fn test_cast_string_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('123')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(123));
}

#[test]
fn test_cast_bool_to_int64_true() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (b BOOL)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (TRUE)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(b AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(1), "TRUE should cast to 1");
}

#[test]
fn test_cast_bool_to_int64_false() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (b BOOL)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(b AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(0), "FALSE should cast to 0");
}

#[test]
fn test_cast_null_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (v INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (NULL)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(v AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(value.is_null(), "NULL should remain NULL");
}

#[test]
fn test_cast_invalid_string_to_int64_should_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('not_a_number')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(s AS INT64) FROM t");

    assert!(
        result.is_err(),
        "Invalid string should error when casting to INT64"
    );
}

#[test]
fn test_cast_int64_to_float64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (42)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(i AS FLOAT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - 42.0).abs() < 1e-10);
    } else {
        panic!("Expected Float64");
    }
}

#[test]
fn test_cast_string_to_float64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('3.14159')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS FLOAT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - std::f64::consts::PI).abs() < 1e-5);
    } else {
        panic!("Expected Float64");
    }
}

#[test]
fn test_cast_bool_to_float64_true() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (b BOOL)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (TRUE)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(b AS FLOAT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - 1.0).abs() < 1e-10);
    } else {
        panic!("Expected Float64");
    }
}

#[test]
fn test_cast_scientific_notation_string_to_float64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('1.5e3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS FLOAT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - 1500.0).abs() < 1e-10);
    } else {
        panic!("Expected Float64");
    }
}

#[test]
fn test_cast_int64_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (42)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(i AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_str(), Some("42"));
}

#[test]
fn test_cast_float64_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (f FLOAT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (3.14)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(f AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    let s = value.as_str().unwrap();
    assert!(s.starts_with("3.14"));
}

#[test]
fn test_cast_bool_to_string_true() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (b BOOL)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (TRUE)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(b AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    let s = value.as_str().unwrap().to_uppercase();
    assert!(s == "TRUE" || s == "1" || s == "T");
}

#[test]
fn test_cast_bool_to_string_false() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (b BOOL)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(b AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    let s = value.as_str().unwrap().to_uppercase();
    assert!(s == "FALSE" || s == "0" || s == "F");
}

#[test]
fn test_cast_null_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (NULL)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(i AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(value.is_null(), "NULL should remain NULL");
}

#[test]
fn test_cast_date_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (d DATE)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (DATE '2025-10-22')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(d AS STRING) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    let s = value.as_str().unwrap();
    assert!(s.contains("2025") && s.contains("10") && s.contains("22"));
}

#[test]
fn test_cast_int64_to_bool_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (0)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(i AS BOOL) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(false), "0 should be FALSE");
}

#[test]
fn test_cast_int64_to_bool_nonzero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (42)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(i AS BOOL) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(true), "Non-zero should be TRUE");
}

#[test]
fn test_cast_string_to_bool_true() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('true')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS BOOL) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(true));
}

#[test]
fn test_cast_string_to_bool_false() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('false')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS BOOL) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(false));
}

#[test]
fn test_cast_string_to_bool_case_insensitive() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('TRUE')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS BOOL) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(true), "Should be case-insensitive");
}

#[test]
fn test_cast_string_to_date_iso_format() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('2025-10-22')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS DATE) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(value.as_date().is_some(), "Should be a DATE value");
}

#[test]
fn test_cast_timestamp_to_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE t (ts TIMESTAMP)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (TIMESTAMP '2025-10-22 14:30:00')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(ts AS DATE) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(value.as_date().is_some(), "Should be a DATE value");
}

#[test]
fn test_cast_invalid_string_to_date_should_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('not-a-date')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(s AS DATE) FROM t");

    assert!(result.is_err(), "Invalid date string should error");
}

#[test]
fn test_cast_string_to_timestamp() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('2025-10-22 14:30:00')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS TIMESTAMP) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        value.as_timestamp().is_some(),
        "Should be a TIMESTAMP value"
    );
}

#[test]
fn test_cast_date_to_timestamp() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (d DATE)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (DATE '2025-10-22')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(d AS TIMESTAMP) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        value.as_timestamp().is_some(),
        "Should be a TIMESTAMP value"
    );
}

#[test]
fn test_cast_negative_float_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (f FLOAT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (-42.9)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(f AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(-42), "Should truncate towards zero");
}

#[test]
fn test_cast_float_with_fraction_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (f FLOAT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (42.999)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(f AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(42), "Should truncate, not round");
}

#[test]
fn test_cast_very_small_float_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (f FLOAT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (0.5)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(f AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(0), "Should truncate to 0");
}

#[test]
fn test_implicit_coercion_int64_plus_float64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE t (i INT64, f FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (10, 3.5)")
        .unwrap();

    let result = executor.execute_sql("SELECT i + f FROM t").unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - 13.5).abs() < 1e-10);
    } else {
        panic!("INT64 + FLOAT64 should result in FLOAT64");
    }
}

#[test]
fn test_implicit_coercion_in_comparison() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (10)").unwrap();

    let result = executor.execute_sql("SELECT i > 5.5 FROM t").unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_bool(), Some(true), "10 > 5.5 should be true");
}

#[test]
fn test_multiple_casts_in_select() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (v STRING)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES ('42')").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(v AS INT64) as i, CAST(v AS FLOAT64) as f FROM t")
        .unwrap();

    assert_eq!(result.num_columns(), 2);

    let col0 = result.column(0).unwrap();
    assert_eq!(col0.get(0).unwrap().as_i64(), Some(42));

    let col1 = result.column(1).unwrap();
    if let Some(f) = col1.get(0).unwrap().as_f64() {
        assert!((f - 42.0).abs() < 1e-10);
    }
}

#[test]
fn test_nested_casts() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (i INT64)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES (42)").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(CAST(i AS STRING) AS INT64) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(42), "Nested cast should work");
}

#[test]
fn test_cast_in_arithmetic_expression() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES ('10')").unwrap();

    let result = executor
        .execute_sql("SELECT CAST(s AS INT64) + 5 FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert_eq!(value.as_i64(), Some(15));
}

#[test]
fn test_cast_in_where_clause() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('10'), ('20'), ('5')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT s FROM t WHERE CAST(s AS INT64) > 7")
        .unwrap();

    assert_eq!(result.num_rows(), 2, "Should find '10' and '20'");
}

#[test]
fn test_cast_in_order_by() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('100'), ('20'), ('3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT s FROM t ORDER BY CAST(s AS INT64)")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_cast_with_sum() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('10'), ('20'), ('30')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SUM(CAST(s AS INT64)) FROM t")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    if let Some(f) = value.as_f64() {
        assert!((f - 60.0).abs() < 1e-10, "SUM should be 60.0");
    } else {
        panic!("Expected Float64 from SUM");
    }
}

#[test]
fn test_cast_empty_string_to_int64_should_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor.execute_sql("INSERT INTO t VALUES ('')").unwrap();

    let result = executor.execute_sql("SELECT CAST(s AS INT64) FROM t");

    assert!(result.is_err(), "Empty string should not cast to INT64");
}

#[test]
fn test_cast_whitespace_string_to_int64_should_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('   ')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(s AS INT64) FROM t");

    assert!(result.is_err(), "Whitespace should not cast to INT64");
}

#[test]
fn test_cast_partial_number_string_should_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor.execute_sql("CREATE TABLE t (s STRING)").unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES ('42abc')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(s AS INT64) FROM t");

    assert!(result.is_err(), "Partial number should error");
}
