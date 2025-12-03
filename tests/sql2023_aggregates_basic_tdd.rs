#![allow(dead_code)]
#![allow(unused_variables)]

mod common;
use common::*;

fn get_numeric_as_i64(result: &yachtsql::RecordBatch, col: usize, row: usize) -> i64 {
    let val = result.column(col).unwrap().get(row).unwrap();
    if let Some(i) = val.as_i64() {
        i
    } else if let Some(n) = val.as_numeric() {
        n.try_into().unwrap()
    } else if let Some(f) = val.as_f64() {
        f as i64
    } else {
        panic!("Expected INT64, NUMERIC, or FLOAT64, got {:?}", val);
    }
}

fn setup_sales_summary(executor: &mut yachtsql::QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS sales_summary")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE sales_summary (category STRING, amount INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO sales_summary VALUES
            ('A', 100),
            ('A', 150),
            ('B', 200),
            ('B', 120),
            ('C', 300)",
        )
        .unwrap();
}

fn setup_optional_sales(executor: &mut yachtsql::QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS optional_sales")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE optional_sales (id INT64, amount INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO optional_sales VALUES
            (1, 100),
            (2, NULL),
            (3, 200)",
        )
        .unwrap();
}

fn setup_empty_sales(executor: &mut yachtsql::QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS empty_sales")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE empty_sales (id INT64, amount INT64)")
        .unwrap();
}

#[test]
fn test_count_all_rows() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql("SELECT COUNT(*) AS total_rows FROM sales_summary")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let count = get_i64(&result, 0, 0);
    assert_eq!(count, 5);
}

#[test]
fn test_count_non_null_column() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql("SELECT COUNT(category) AS category_count FROM sales_summary")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let count = get_i64(&result, 0, 0);
    assert_eq!(count, 5);
}

#[test]
fn test_sum_amount() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql("SELECT SUM(amount) AS total_amount FROM sales_summary")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let sum = get_numeric_as_i64(&result, 0, 0);
    assert_eq!(sum, 870);
}

#[test]
fn test_avg_amount() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql("SELECT AVG(amount) AS average_amount FROM sales_summary")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();

    if let Some(f) = val.as_f64() {
        assert_float_eq(f, 174.0, 0.001);
    } else if let Some(n) = val.as_numeric() {
        let f: f64 = n.try_into().unwrap();
        assert_float_eq(f, 174.0, 0.001);
    } else {
        panic!("Expected FLOAT64 or NUMERIC for AVG, got {:?}", val);
    }
}

#[test]
fn test_min_max_amount() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT MIN(amount) AS min_amount, MAX(amount) AS max_amount FROM sales_summary",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let min_amount = get_i64(&result, 0, 0);
    let max_amount = get_i64(&result, 1, 0);
    assert_eq!(min_amount, 100);
    assert_eq!(max_amount, 300);
}

#[test]
fn test_group_by_category() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT category, COUNT(*) AS order_count, SUM(amount) AS total_amount
             FROM sales_summary
             GROUP BY category
             ORDER BY category",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_string(&result, 0, 0), "A");
    assert_eq!(get_i64(&result, 1, 0), 2);
    assert_eq!(get_numeric_as_i64(&result, 2, 0), 250);

    assert_eq!(get_string(&result, 0, 1), "B");
    assert_eq!(get_i64(&result, 1, 1), 2);
    assert_eq!(get_numeric_as_i64(&result, 2, 1), 320);

    assert_eq!(get_string(&result, 0, 2), "C");
    assert_eq!(get_i64(&result, 1, 2), 1);
    assert_eq!(get_numeric_as_i64(&result, 2, 2), 300);
}

#[test]
fn test_having_total_over_two_hundred() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT category, SUM(amount) AS total_amount
             FROM sales_summary
             GROUP BY category
             HAVING SUM(amount) > 200
             ORDER BY category",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_string(&result, 0, 0), "A");
    assert_eq!(get_numeric_as_i64(&result, 1, 0), 250);

    assert_eq!(get_string(&result, 0, 1), "B");
    assert_eq!(get_numeric_as_i64(&result, 1, 1), 320);

    assert_eq!(get_string(&result, 0, 2), "C");
    assert_eq!(get_numeric_as_i64(&result, 1, 2), 300);
}

#[test]
fn test_distinct_amounts() {
    let mut executor = setup_executor();
    setup_sales_summary(&mut executor);

    let result = executor
        .execute_sql("SELECT COUNT(DISTINCT amount) AS distinct_amounts FROM sales_summary")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let count = get_i64(&result, 0, 0);
    assert_eq!(count, 5);
}

#[test]
fn test_count_with_nulls() {
    let mut executor = setup_executor();
    setup_optional_sales(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT COUNT(amount) AS non_null_count, COUNT(*) AS total_rows
             FROM optional_sales",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let non_null_count = get_i64(&result, 0, 0);
    let total_rows = get_i64(&result, 1, 0);
    assert_eq!(non_null_count, 2);
    assert_eq!(total_rows, 3);
}

#[test]
fn test_aggregates_empty_table() {
    let mut executor = setup_executor();
    setup_empty_sales(&mut executor);

    let result = executor
        .execute_sql("SELECT COUNT(*) AS total_rows, SUM(amount) AS total_amount FROM empty_sales")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let total_rows = get_i64(&result, 0, 0);
    assert_eq!(total_rows, 0);

    let sum_col = result.column(1).unwrap();
    let sum_val = sum_col.get(0).unwrap();
    assert!(sum_val.is_null(), "SUM on empty table should be NULL");
}
