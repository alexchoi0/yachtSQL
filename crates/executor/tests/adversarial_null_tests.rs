use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_deeply_nested_null_logic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64, c INT64, d INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL, 10, 0, 20)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (10, 10, 10, 20)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE ((a > 5 AND b > 5) OR c > 5) AND (d > 5 OR a > 5)")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        1,
        "Deeply nested NULL logic should filter correctly"
    );
}

#[test]
fn test_multiple_not_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (val INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE NOT (NOT (val > 5))")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        1,
        "Double NOT with NULL should filter correctly"
    );
}

#[test]
fn test_null_in_complex_comparison_chain() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64, val INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL, NULL, 10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (5, 50, 10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE a > 0 AND b < 100 AND val = 10")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        1,
        "NULL in comparison chain should filter correctly"
    );
}

#[test]
fn test_null_with_or_short_circuit_impossible() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (0, NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (0, 10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE a > 5 OR b > 5")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        1,
        "FALSE OR NULL should return NULL, not short-circuit"
    );
}

#[test]
fn test_null_and_with_false_short_circuit() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (0, NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE a > 5 AND b > 5")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        0,
        "FALSE AND NULL = FALSE, TRUE AND NULL = NULL"
    );
}

#[test]
fn test_null_comparison_in_subexpression() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (val INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10)")
        .unwrap();
    executor.execute_sql("INSERT INTO test VALUES (3)").unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE (val = NULL) OR (val > 5)")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        1,
        "NULL comparison in OR should work correctly"
    );
}

#[test]
fn test_all_null_comparisons_in_and() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64, c INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL, NULL, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE a > 0 AND b < 100 AND c = 50")
        .unwrap();

    assert_eq!(
        result.num_rows(),
        0,
        "All NULL ANDs should return NULL → false"
    );
}

#[test]
fn test_mixed_null_and_false_in_or() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64, c INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (NULL, 0, NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10, 0, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE a > 5 OR b > 5 OR c > 5")
        .unwrap();

    assert_eq!(result.num_rows(), 1, "Mixed NULL and FALSE in OR");
}
