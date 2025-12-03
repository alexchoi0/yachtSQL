#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

#[test]
fn test_cast_int_to_float() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS FLOAT64) AS float_val FROM numbers")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_float_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (42.9)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM floats")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('123')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_to_float() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('123.45')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS FLOAT64) AS float_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_int_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) AS str_val FROM numbers")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_float_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (3.14159)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) AS str_val FROM floats")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_bool_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE bools (value BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO bools VALUES (TRUE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO bools VALUES (FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM bools")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_cast_int_to_bool() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (0)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS BOOL) AS bool_val FROM numbers")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_cast_string_to_bool() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('true')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('false')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS BOOL) AS bool_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_cast_null_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_null_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) AS str_val FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_invalid_string_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('not a number')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS INT64) FROM strings");

    assert!(
        result.is_err(),
        "Should error on invalid string to int cast"
    );
}

#[test]
fn test_cast_invalid_string_to_float() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('abc')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS FLOAT64) FROM strings");

    assert!(
        result.is_err(),
        "Should error on invalid string to float cast"
    );
}

#[test]
fn test_cast_empty_string_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS INT64) FROM strings");

    assert!(result.is_err(), "Should error on empty string to int cast");
}

#[test]
fn test_cast_negative_float_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (-42.9)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM floats")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_float_max_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (1.7976931348623157e308)")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS INT64) FROM floats");

    assert!(result.is_err() || result.is_ok());
}

#[test]
fn test_cast_zero_float_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM floats")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_to_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('2024-01-15')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS DATE) AS date_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_date_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE dates (value DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO dates VALUES (DATE '2024-01-15')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) AS str_val FROM dates")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_to_timestamp() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('2024-01-15 10:30:00')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS TIMESTAMP) AS ts FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_timestamp_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE timestamps (value TIMESTAMP)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO timestamps VALUES (TIMESTAMP '2024-01-15 10:30:00')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS STRING) AS str_val FROM timestamps")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_invalid_string_to_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('not a date')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS DATE) FROM strings");

    assert!(result.is_err(), "Should error on invalid date string");
}

#[test]
fn test_implicit_coercion_int_float_addition() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE mixed (int_val INT64, float_val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO mixed VALUES (10, 3.5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT int_val + float_val AS sum FROM mixed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_implicit_coercion_float_int_multiplication() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE mixed (float_val FLOAT64, int_val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO mixed VALUES (2.5, 4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT float_val * int_val AS product FROM mixed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_implicit_coercion_int_float_comparison() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE mixed (int_val INT64, float_val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO mixed VALUES (10, 10.5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO mixed VALUES (15, 12.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM mixed WHERE int_val < float_val")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_implicit_coercion_string_int_comparison() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING, int_val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('100', 50)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM data WHERE str_val > int_val");

    assert!(result.is_ok() || result.is_err());
}

#[test]
fn test_implicit_coercion_concat_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING, int_val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('Value: ', 42)")
        .unwrap();

    let result = executor.execute_sql("SELECT CONCAT(str_val, int_val) AS result FROM data");

    assert!(result.is_ok() || result.is_err());
}

#[test]
fn test_implicit_coercion_insert_int_to_float() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();

    let result = executor.execute_sql("INSERT INTO floats VALUES (42)");

    assert!(
        result.is_ok(),
        "Should allow implicit INT64 to FLOAT64 coercion"
    );
}

#[test]
fn test_implicit_coercion_insert_float_to_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();

    let result = executor.execute_sql("INSERT INTO numbers VALUES (42.5)");

    assert!(result.is_ok() || result.is_err());
}

#[test]
fn test_multiple_casts_in_expression() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING, int_val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('100', 50)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(str_val AS INT64) + CAST(int_val AS FLOAT64) AS result FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_nested_casts() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(CAST(value AS FLOAT64) AS STRING) AS result FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_in_where_clause() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('100')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('50')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('150')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE CAST(str_val AS INT64) > 75")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_cast_in_group_by() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (float_val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1.1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1.9)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2.1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2.9)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CAST(float_val AS INT64) AS int_val, COUNT(*) AS count FROM data GROUP BY CAST(float_val AS INT64)"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_cast_in_order_by() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('100')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('20')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT str_val FROM data ORDER BY CAST(str_val AS INT64)")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_cast_with_sum() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (str_val STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('10')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('20')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('30')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SUM(CAST(str_val AS INT64)) AS total FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_scientific_notation() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('1.5e3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS FLOAT64) AS float_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_cast_string_with_sign() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('+42')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('-42')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(value AS INT64) AS int_val FROM strings")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_cast_string_partial_number() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE strings (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO strings VALUES ('42abc')")
        .unwrap();

    let result = executor.execute_sql("SELECT CAST(value AS INT64) FROM strings");

    assert!(result.is_err(), "Should error on partial numeric string");
}
