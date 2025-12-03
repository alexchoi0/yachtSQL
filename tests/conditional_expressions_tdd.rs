#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

#[test]
fn test_case_searched_simple() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (5), (15), (25)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT value, CASE WHEN value < 10 THEN 'low' WHEN value < 20 THEN 'medium' ELSE 'high' END as category FROM test ORDER BY value"
    ).unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_case_searched_no_else() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (5), (15)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT value, CASE WHEN value < 10 THEN 'low' END as category FROM test ORDER BY value"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_case_searched_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (NULL), (10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE WHEN value IS NULL THEN 'null' ELSE 'not null' END as status FROM test ORDER BY status"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_case_searched_with_complex_conditions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (5, 10), (15, 5)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE WHEN a > b THEN 'a bigger' WHEN b > a THEN 'b bigger' ELSE 'equal' END as comparison FROM test"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_case_simple_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (status STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES ('A'), ('B'), ('C')")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT status, CASE status WHEN 'A' THEN 'Active' WHEN 'B' THEN 'Blocked' ELSE 'Unknown' END as description FROM test ORDER BY status"
    ).unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_case_simple_integers() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (code INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1), (2), (3)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT code, CASE code WHEN 1 THEN 'one' WHEN 2 THEN 'two' ELSE 'other' END as name FROM test ORDER BY code"
    ).unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_case_simple_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (NULL), (10)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE value WHEN NULL THEN 'is null' ELSE 'not null' END as status FROM test",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_case_simple_no_match_no_else() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CASE value WHEN 1 THEN 'one' WHEN 2 THEN 'two' END as name FROM test")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_case_nested() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (type STRING, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES ('A', 5), ('B', 15)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE type WHEN 'A' THEN CASE WHEN value < 10 THEN 'A-small' ELSE 'A-large' END ELSE 'other' END as category FROM test ORDER BY type"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_if_true_condition() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (15)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT IF(value > 10, 'yes', 'no') as result FROM test")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_if_false_condition() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO test VALUES (5)").unwrap();

    let result = executor
        .execute_sql("SELECT IF(value > 10, 'yes', 'no') as result FROM test")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_if_null_condition() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT IF(value > 10, 'yes', 'no') as result FROM test")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_if_with_calculations() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (price INT64, discount INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (100, 10), (100, 0)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT IF(discount > 0, price - discount, price) as final_price FROM test ORDER BY final_price"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_if_wrong_argument_count() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT IF(value > 10, 'yes') FROM test");

    assert!(result.is_err());
}

#[test]
fn test_case_with_if() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (type STRING, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES ('A', 5), ('B', 15)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE type WHEN 'A' THEN IF(value < 10, 'A-low', 'A-high') ELSE 'other' END as category FROM test ORDER BY type"
    ).unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_nested_conditionals() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (NULL, 10), (5, NULL), (5, 10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE WHEN a IS NULL THEN CASE WHEN b IS NULL THEN 'both null' ELSE 'a null' END ELSE CASE WHEN b IS NULL THEN 'b null' ELSE 'neither null' END END as status FROM test ORDER BY status"
    ).unwrap();

    assert_eq!(result.num_rows(), 3);
}
