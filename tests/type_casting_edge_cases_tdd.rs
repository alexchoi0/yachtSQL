#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

mod common;
use common::*;

#[test]
fn test_cast_int64_max_to_float64() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE limits (id INT64, max_int INT64)")
        .unwrap();
    executor
        .execute_sql(&format!("INSERT INTO limits VALUES (1, {})", i64::MAX))
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(max_int AS FLOAT64) as max_float FROM limits")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let float_val = result.column(1).unwrap().get(0).unwrap().as_f64().unwrap();
    assert!(float_val > 0.0);
}

#[test]
fn test_cast_int64_min_to_float64() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE limits (id INT64, min_int INT64)")
        .unwrap();
    executor
        .execute_sql(&format!("INSERT INTO limits VALUES (1, {})", i64::MIN))
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(min_int AS FLOAT64) as min_float FROM limits")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let float_val = result.column(1).unwrap().get(0).unwrap().as_f64().unwrap();
    assert!(float_val < 0.0);
}

#[test]
fn test_cast_null_int_to_string() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) as str_val FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}

#[test]
fn test_cast_null_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(text AS INT64) as int_val FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}

#[test]
fn test_cast_null_preserves_through_chain() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}

#[test]
fn test_cast_float_to_int_truncates() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, f FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = result.column(1).unwrap();
    assert_eq!(vals.get(0).unwrap().as_i64().unwrap(), 3);
    assert_eq!(vals.get(1).unwrap().as_i64().unwrap(), -3);
    assert_eq!(vals.get(2).unwrap().as_i64().unwrap(), 3);
    assert_eq!(vals.get(3).unwrap().as_i64().unwrap(), -3);
}

#[test]
fn test_cast_int_to_float_exact_small_values() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, i INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 42), (2, -42), (3, 0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = result.column(1).unwrap();
    assert_float_eq(vals.get(0).unwrap().as_f64().unwrap(), 42.0, 0.0001);
    assert_float_eq(vals.get(1).unwrap().as_f64().unwrap(), -42.0, 0.0001);
    assert_float_eq(vals.get(2).unwrap().as_f64().unwrap(), 0.0, 0.0001);
}

#[test]
fn test_cast_invalid_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 'abc')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(text AS INT64) FROM data");

    assert_error_contains(result, &["invalid", "parse", "integer", "abc"]);
}

#[test]
fn test_cast_empty_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(text AS INT64) FROM data");

    assert_error_contains(result, &["invalid", "empty", "parse"]);
}

#[test]
fn test_cast_whitespace_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '  ')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(text AS INT64) FROM data");

    assert_error_contains(result, &["invalid", "parse", "integer"]);
}

#[test]
fn test_cast_partial_number_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '123abc')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(text AS INT64) FROM data");

    assert_error_contains(result, &["invalid", "parse"]);
}

#[test]
fn test_cast_float_string_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '3.14')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(text AS INT64) FROM data");

    assert_error_contains(result, &["invalid", "parse", "integer"]);
}

#[test]
fn test_implicit_coercion_int_plus_float() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, i INT64, f FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10, 3.5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT i + f as sum FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let sum = result.column(0).unwrap().get(0).unwrap().as_f64().unwrap();
    assert_float_eq(sum, 13.5, 0.0001);
}

#[test]
fn test_implicit_coercion_in_comparison() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, i INT64, f FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data WHERE i = f ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        1
    );
}

#[test]
fn test_implicit_coercion_int_multiply_float() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, i INT64, f FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 3, 2.5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT i * f as product FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let product = result.column(0).unwrap().get(0).unwrap().as_f64().unwrap();
    assert_float_eq(product, 7.5, 0.0001);
}

#[test]
fn test_cast_in_arithmetic_expression() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10, '5')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a + CAST(b AS INT64) as sum FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        15
    );
}

#[test]
fn test_cast_in_case_expression() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, category STRING, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id,
                CASE WHEN category = 'A' THEN CAST(value AS INT64)
                     ELSE 0
                END as parsed_value
         FROM data
         ORDER BY id",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = result.column(1).unwrap();
    assert_eq!(vals.get(0).unwrap().as_i64().unwrap(), 100);
    assert_eq!(vals.get(1).unwrap().as_i64().unwrap(), 0);
    assert_eq!(vals.get(2).unwrap().as_i64().unwrap(), 200);
}

#[test]
fn test_cast_in_where_clause() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text_num STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        1
    );
    assert_eq!(
        result.column(0).unwrap().get(1).unwrap().as_i64().unwrap(),
        2
    );
}

#[test]
fn test_cast_before_aggregate() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text_num STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SUM(CAST(text_num AS INT64)) as total FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        60
    );
}

#[test]
fn test_sequential_casts_roundtrip() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        42
    );
}

#[test]
fn test_sequential_casts_with_precision_loss() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, large INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 9007199254740993)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let roundtrip = result.column(0).unwrap().get(0).unwrap().as_i64().unwrap();

    assert!((roundtrip - 9007199254740993).abs() < 10);
}

#[test]
fn test_cast_bool_to_int() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, flag BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, true), (2, false), (3, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = result.column(1).unwrap();
    assert_eq!(vals.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(vals.get(1).unwrap().as_i64().unwrap(), 0);
    assert!(vals.get(2).unwrap().is_null());
}

#[test]
fn test_cast_int_to_bool() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, num INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 5);
    let vals = result.column(1).unwrap();
    assert!(!vals.get(0).unwrap().as_bool().unwrap());
    assert!(vals.get(1).unwrap().as_bool().unwrap());
    assert!(vals.get(2).unwrap().as_bool().unwrap());
    assert!(vals.get(3).unwrap().as_bool().unwrap());
    assert!(vals.get(4).unwrap().is_null());
}

#[test]
fn test_cast_string_to_bool() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, text STRING)")
        .unwrap();
    executor.execute_sql("INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0')").unwrap();

    let result = executor
        .execute_sql("SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 6);
    let vals = result.column(1).unwrap();
    assert!(vals.get(0).unwrap().as_bool().unwrap());
    assert!(!vals.get(1).unwrap().as_bool().unwrap());
    assert!(vals.get(2).unwrap().as_bool().unwrap());
    assert!(!vals.get(3).unwrap().as_bool().unwrap());
}
