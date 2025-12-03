#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor, RecordBatch, Value};

fn new_pg_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn first_cell(batch: &RecordBatch) -> Value {
    batch.column(0).unwrap().get(0).unwrap()
}

fn cell(batch: &RecordBatch, col: usize, row: usize) -> Value {
    batch.column(col).unwrap().get(row).unwrap()
}

#[test]
fn test_filter_clause_count_basic() {
    let mut executor = new_pg_executor();

    executor
        .execute_sql("CREATE TABLE events(flag BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO events(flag) VALUES (TRUE), (FALSE), (TRUE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COUNT(*) FILTER (WHERE flag) AS true_count FROM events")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(first_cell(&result).as_i64().unwrap(), 2);
}

#[test]
fn test_filter_clause_sum_multiple_conditions() {
    let mut executor = new_pg_executor();

    executor
        .execute_sql("CREATE TABLE sales(category TEXT, amount INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO sales(category, amount) VALUES
             ('A', 10),
             ('A', 15),
             ('B', 20),
             ('C', 5)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                 SUM(amount) FILTER (WHERE category = 'A') AS sum_a,
                 SUM(amount) FILTER (WHERE category = 'B') AS sum_b,
                 SUM(amount) FILTER (WHERE category = 'D') AS sum_d
             FROM sales",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(cell(&result, 0, 0).as_f64().unwrap() as i64, 25);
    assert_eq!(cell(&result, 1, 0).as_f64().unwrap() as i64, 20);
    assert!(cell(&result, 2, 0).is_null());
}

#[test]
fn test_filter_clause_with_group_by() {
    let mut executor = new_pg_executor();

    executor
        .execute_sql("CREATE TABLE orders(region TEXT, product TEXT, amount INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO orders(region, product, amount) VALUES
             ('US', 'phone', 100),
             ('US', 'laptop', 250),
             ('EU', 'phone', 80),
             ('EU', 'phone', 70),
             ('APAC', 'tablet', 60)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT region,
                    SUM(amount) FILTER (WHERE product = 'phone') AS phone_total
             FROM orders
             GROUP BY region
             ORDER BY region",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let regions: Vec<_> = (0..result.num_rows())
        .map(|row| cell(&result, 0, row).as_str().unwrap().to_string())
        .collect();
    assert_eq!(regions, vec!["APAC", "EU", "US"]);

    assert!(cell(&result, 1, 0).is_null());
    assert_eq!(cell(&result, 1, 1).as_f64().unwrap() as i64, 150);
    assert_eq!(cell(&result, 1, 2).as_f64().unwrap() as i64, 100);
}

#[test]
fn test_filter_clause_condition_all_null() {
    let mut executor = new_pg_executor();

    executor
        .execute_sql("CREATE TABLE metrics(value INT64, flag BOOL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO metrics(value, flag) VALUES (1, NULL), (2, NULL), (3, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SUM(value) FILTER (WHERE flag = TRUE) AS total FROM metrics")
        .unwrap();

    assert!(first_cell(&result).is_null());
}

#[test]
fn test_filter_clause_rejects_aggregate_in_condition() {
    let mut executor = new_pg_executor();

    executor
        .execute_sql("CREATE TABLE readings(val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO readings(val) VALUES (1), (2), (3)")
        .unwrap();

    let err = executor
        .execute_sql("SELECT SUM(val) FILTER (WHERE SUM(val) > 10) FROM readings")
        .unwrap_err();

    let message = err.to_string();
    assert!(message.contains("FILTER"));
    assert!(message.to_lowercase().contains("aggregate"));
}
