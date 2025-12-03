#![allow(dead_code)]
#![allow(unused_variables)]

mod common;
use common::*;

fn setup_sales_table(executor: &mut yachtsql::QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS sales").unwrap();
    executor
        .execute_sql(
            "CREATE TABLE sales (
                id INT64,
                month INT64,
                revenue INT64,
                product STRING
            )",
        )
        .unwrap();
}

fn setup_stock_prices_table(executor: &mut yachtsql::QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS stock_prices")
        .unwrap();
    executor
        .execute_sql(
            "CREATE TABLE stock_prices (
                symbol STRING,
                trade_date DATE,
                price FLOAT64
            )",
        )
        .unwrap();
}

#[test]
fn test_lag_basic() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_i64(&result, 1, 0), 100);
    assert!(is_null(&result, 2, 0));

    assert_eq!(get_i64(&result, 0, 1), 2);
    assert_eq!(get_i64(&result, 1, 1), 150);
    assert_eq!(get_i64(&result, 2, 1), 100);

    assert_eq!(get_i64(&result, 0, 2), 3);
    assert_eq!(get_i64(&result, 1, 2), 200);
    assert_eq!(get_i64(&result, 2, 2), 150);
}

#[test]
fn test_lag_with_default_value() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1, 0) OVER (ORDER BY month) as prev_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_i64(&result, 1, 0), 100);
    assert_eq!(get_i64(&result, 2, 0), 0);

    assert_eq!(get_i64(&result, 2, 1), 100);

    assert_eq!(get_i64(&result, 2, 2), 150);
}

#[test]
fn test_lag_with_offset_greater_than_one() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 2) OVER (ORDER BY month) as two_months_ago
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert!(is_null(&result, 2, 0));

    assert!(is_null(&result, 2, 1));

    assert_eq!(get_i64(&result, 2, 2), 100);
}

#[test]
fn test_lag_with_partition_by() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 1, 80, 'Gadget'),
                (4, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                LAG(revenue, 1) OVER (PARTITION BY product ORDER BY month) as prev_revenue
            FROM sales
            ORDER BY product, month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Gadget");
    assert_eq!(get_i64(&result, 1, 0), 1);
    assert_eq!(get_i64(&result, 2, 0), 80);
    assert!(is_null(&result, 3, 0));

    assert_eq!(get_string(&result, 0, 1), "Gadget");
    assert_eq!(get_i64(&result, 1, 1), 2);
    assert_eq!(get_i64(&result, 2, 1), 120);
    assert_eq!(get_i64(&result, 3, 1), 80);

    assert_eq!(get_string(&result, 0, 2), "Widget");
    assert_eq!(get_i64(&result, 1, 2), 1);
    assert_eq!(get_i64(&result, 2, 2), 100);
    assert!(is_null(&result, 3, 2));

    assert_eq!(get_string(&result, 0, 3), "Widget");
    assert_eq!(get_i64(&result, 1, 3), 2);
    assert_eq!(get_i64(&result, 2, 3), 150);
    assert_eq!(get_i64(&result, 3, 3), 100);
}

#[test]
fn test_lag_calculating_change() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1, 0) OVER (ORDER BY month) as prev_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 0);

    assert_eq!(get_i64(&result, 2, 1), 100);

    assert_eq!(get_i64(&result, 2, 2), 150);
}

#[test]
fn test_lag_with_prev_revenue() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert!(is_null(&result, 2, 0));

    assert_eq!(get_i64(&result, 2, 1), 100);

    assert_eq!(get_i64(&result, 2, 2), 150);
}

#[test]
fn test_lead_basic() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_i64(&result, 1, 0), 100);
    assert_eq!(get_i64(&result, 2, 0), 150);

    assert_eq!(get_i64(&result, 0, 1), 2);
    assert_eq!(get_i64(&result, 1, 1), 150);
    assert_eq!(get_i64(&result, 2, 1), 200);

    assert_eq!(get_i64(&result, 0, 2), 3);
    assert_eq!(get_i64(&result, 1, 2), 200);
    assert!(is_null(&result, 2, 2));
}

#[test]
fn test_lead_with_default_value() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LEAD(revenue, 1, 0) OVER (ORDER BY month) as next_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 150);

    assert_eq!(get_i64(&result, 2, 1), 200);

    assert_eq!(get_i64(&result, 2, 2), 0);
}

#[test]
fn test_lead_with_offset_greater_than_one() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LEAD(revenue, 2) OVER (ORDER BY month) as two_months_ahead
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 200);

    assert!(is_null(&result, 2, 1));

    assert!(is_null(&result, 2, 2));
}

#[test]
fn test_lead_with_partition_by() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 1, 80, 'Gadget'),
                (4, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                LEAD(revenue, 1) OVER (PARTITION BY product ORDER BY month) as next_revenue
            FROM sales
            ORDER BY product, month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Gadget");
    assert_eq!(get_i64(&result, 3, 0), 120);

    assert_eq!(get_string(&result, 0, 1), "Gadget");
    assert!(is_null(&result, 3, 1));

    assert_eq!(get_string(&result, 0, 2), "Widget");
    assert_eq!(get_i64(&result, 3, 2), 150);

    assert_eq!(get_string(&result, 0, 3), "Widget");
    assert!(is_null(&result, 3, 3));
}

#[test]
fn test_lead_for_forecasting() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 120, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LEAD(revenue, 1) OVER (ORDER BY month) as forecasted_next
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 150);

    assert_eq!(get_i64(&result, 2, 1), 120);

    assert!(is_null(&result, 2, 2));
}

#[test]
fn test_lag_and_lead_together() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue,
                revenue,
                LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert!(is_null(&result, 1, 0));
    assert_eq!(get_i64(&result, 2, 0), 100);
    assert_eq!(get_i64(&result, 3, 0), 150);

    assert_eq!(get_i64(&result, 1, 1), 100);
    assert_eq!(get_i64(&result, 2, 1), 150);
    assert_eq!(get_i64(&result, 3, 1), 200);

    assert_eq!(get_i64(&result, 1, 2), 150);
    assert_eq!(get_i64(&result, 2, 2), 200);
    assert!(is_null(&result, 3, 2));
}

#[test]
fn test_lag_and_lead_for_moving_avg() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue,
                LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert!(is_null(&result, 2, 0));
    assert_eq!(get_i64(&result, 3, 0), 150);

    assert_eq!(get_i64(&result, 2, 2), 150);
    assert!(is_null(&result, 3, 2));
}

#[test]
fn test_lag_lead_with_defaults_for_local_check() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 200, 'Widget'),
                (3, 3, 150, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1, 0) OVER (ORDER BY month) as prev_or_zero,
                LEAD(revenue, 1, 0) OVER (ORDER BY month) as next_or_zero
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 0);
    assert_eq!(get_i64(&result, 3, 0), 200);

    assert_eq!(get_i64(&result, 2, 1), 100);
    assert_eq!(get_i64(&result, 3, 1), 150);

    assert_eq!(get_i64(&result, 2, 2), 200);
    assert_eq!(get_i64(&result, 3, 2), 0);
}

#[test]
fn test_first_value_basic() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 180, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                FIRST_VALUE(revenue) OVER (ORDER BY month) as first_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    for i in 0..4 {
        assert_eq!(
            get_i64(&result, 2, i),
            100,
            "Row {} should have first_revenue=100",
            i
        );
    }
}

#[test]
fn test_first_value_with_partition_by() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 1, 80, 'Gadget'),
                (4, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) as first_revenue_in_product
            FROM sales
            ORDER BY product, month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Gadget");
    assert_eq!(get_i64(&result, 3, 0), 80);
    assert_eq!(get_string(&result, 0, 1), "Gadget");
    assert_eq!(get_i64(&result, 3, 1), 80);

    assert_eq!(get_string(&result, 0, 2), "Widget");
    assert_eq!(get_i64(&result, 3, 2), 100);
    assert_eq!(get_string(&result, 0, 3), "Widget");
    assert_eq!(get_i64(&result, 3, 3), 100);
}

#[test]
fn test_first_value_with_explicit_frame() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                FIRST_VALUE(revenue) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                ) as first_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        assert_eq!(
            get_i64(&result, 2, i),
            100,
            "Row {} should have first_revenue=100",
            i
        );
    }
}

#[test]
fn test_first_value_baseline_comparison() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                FIRST_VALUE(revenue) OVER (ORDER BY month) as baseline
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        assert_eq!(get_i64(&result, 2, i), 100);
    }
}

#[test]
fn test_last_value_with_rows_frame() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAST_VALUE(revenue) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as last_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        assert_eq!(
            get_i64(&result, 2, i),
            200,
            "Row {} should have last_revenue=200",
            i
        );
    }
}

#[test]
fn test_last_value_with_default_frame() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAST_VALUE(revenue) OVER (ORDER BY month) as last_with_default_frame
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 100);
    assert_eq!(get_i64(&result, 2, 1), 150);
    assert_eq!(get_i64(&result, 2, 2), 200);
}

#[test]
fn test_last_value_with_partition_by() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 1, 80, 'Gadget'),
                (4, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                LAST_VALUE(revenue) OVER (
                    PARTITION BY product
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as last_revenue_in_product
            FROM sales
            ORDER BY product, month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Gadget");
    assert_eq!(get_i64(&result, 3, 0), 120);
    assert_eq!(get_string(&result, 0, 1), "Gadget");
    assert_eq!(get_i64(&result, 3, 1), 120);

    assert_eq!(get_string(&result, 0, 2), "Widget");
    assert_eq!(get_i64(&result, 3, 2), 150);
    assert_eq!(get_string(&result, 0, 3), "Widget");
    assert_eq!(get_i64(&result, 3, 3), 150);
}

#[test]
fn test_first_and_last_value_together() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                FIRST_VALUE(revenue) OVER w as first_val,
                LAST_VALUE(revenue) OVER w as last_val
            FROM sales
            WINDOW w AS (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        assert_eq!(get_i64(&result, 2, i), 100, "Row {} first_val", i);
        assert_eq!(get_i64(&result, 3, i), 200, "Row {} last_val", i);
    }
}

#[test]
fn test_nth_value_second() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 180, 'Widget'),
                (5, 5, 220, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                NTH_VALUE(revenue, 2) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as second_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    for i in 0..5 {
        assert_eq!(
            get_i64(&result, 2, i),
            150,
            "Row {} should have second_revenue=150",
            i
        );
    }
}

#[test]
fn test_nth_value_third() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 180, 'Widget'),
                (5, 5, 220, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                NTH_VALUE(revenue, 3) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as third_revenue
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    for i in 0..5 {
        assert_eq!(
            get_i64(&result, 2, i),
            200,
            "Row {} should have third_revenue=200",
            i
        );
    }
}

#[test]
fn test_nth_value_with_partition_by() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 1, 80, 'Gadget'),
                (5, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                NTH_VALUE(revenue, 2) OVER (
                    PARTITION BY product
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as second_revenue_in_product
            FROM sales
            ORDER BY product, month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert_eq!(get_string(&result, 0, 0), "Gadget");
    assert_eq!(get_i64(&result, 3, 0), 120);
    assert_eq!(get_string(&result, 0, 1), "Gadget");
    assert_eq!(get_i64(&result, 3, 1), 120);

    assert_eq!(get_string(&result, 0, 2), "Widget");
    assert_eq!(get_i64(&result, 3, 2), 150);
}

#[test]
fn test_nth_value_exceeds_row_count() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 1, 80, 'Gadget'),
                (5, 2, 120, 'Gadget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                NTH_VALUE(revenue, 10) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as tenth_revenue
            FROM sales",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    for i in 0..5 {
        assert!(
            is_null(&result, 2, i),
            "Row {} should have tenth_revenue=NULL",
            i
        );
    }
}

#[test]
fn test_nth_value_median() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 250, 'Widget'),
                (5, 5, 300, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                NTH_VALUE(revenue, 3) OVER (
                    ORDER BY revenue
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as median_revenue
            FROM sales
            LIMIT 1",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert_eq!(get_i64(&result, 0, 0), 200);
}

#[test]
fn test_running_comparison_with_first_value() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 250, 'Widget'),
                (5, 5, 300, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                FIRST_VALUE(revenue) OVER (ORDER BY month) as baseline,
                LAG(revenue, 1) OVER (ORDER BY month) as prev,
                LEAD(revenue, 1) OVER (ORDER BY month) as next
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert_eq!(get_i64(&result, 2, 0), 100);
    assert!(is_null(&result, 3, 0));
    assert_eq!(get_i64(&result, 4, 0), 150);

    for i in 0..5 {
        assert_eq!(get_i64(&result, 2, i), 100);
    }
}

#[test]
fn test_multi_step_lag_lead() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, 150, 'Widget'),
                (3, 3, 200, 'Widget'),
                (4, 4, 250, 'Widget'),
                (5, 5, 300, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as lag_1,
                LAG(revenue, 2) OVER (ORDER BY month) as lag_2,
                LAG(revenue, 3) OVER (ORDER BY month) as lag_3,
                LEAD(revenue, 1) OVER (ORDER BY month) as lead_1,
                LEAD(revenue, 2) OVER (ORDER BY month) as lead_2
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert!(is_null(&result, 2, 0));
    assert!(is_null(&result, 3, 0));
    assert!(is_null(&result, 4, 0));
    assert_eq!(get_i64(&result, 5, 0), 150);
    assert_eq!(get_i64(&result, 6, 0), 200);

    assert_eq!(get_i64(&result, 2, 4), 250);
    assert_eq!(get_i64(&result, 3, 4), 200);
    assert_eq!(get_i64(&result, 4, 4), 150);
    assert!(is_null(&result, 5, 4));
    assert!(is_null(&result, 6, 4));
}

#[test]
fn test_stock_price_analysis() {
    let mut executor = setup_executor();
    setup_stock_prices_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO stock_prices VALUES
                ('AAPL', DATE '2024-01-01', 150.00),
                ('AAPL', DATE '2024-01-02', 152.50),
                ('AAPL', DATE '2024-01-03', 151.00),
                ('AAPL', DATE '2024-01-04', 153.75),
                ('AAPL', DATE '2024-01-05', 155.00)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                trade_date,
                price,
                LAG(price, 1) OVER (ORDER BY trade_date) as prev_price,
                FIRST_VALUE(price) OVER (ORDER BY trade_date) as period_start,
                LAST_VALUE(price) OVER (
                    ORDER BY trade_date
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as period_end
            FROM stock_prices
            ORDER BY trade_date",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert!(is_null(&result, 2, 0));
    assert_float_eq(get_f64(&result, 3, 0), 150.0, 0.01);
    assert_float_eq(get_f64(&result, 4, 0), 155.0, 0.01);

    assert_float_eq(get_f64(&result, 2, 1), 150.0, 0.01);
}

#[test]
fn test_single_row() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql("INSERT INTO sales VALUES (1, 1, 100, 'Widget')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as prev,
                LEAD(revenue, 1) OVER (ORDER BY month) as next,
                FIRST_VALUE(revenue) OVER (ORDER BY month) as first_val,
                LAST_VALUE(revenue) OVER (
                    ORDER BY month
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) as last_val
            FROM sales",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_i64(&result, 1, 0), 100);
    assert!(is_null(&result, 2, 0));
    assert!(is_null(&result, 3, 0));
    assert_eq!(get_i64(&result, 4, 0), 100);
    assert_eq!(get_i64(&result, 5, 0), 100);
}

#[test]
fn test_null_values_in_data() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO sales VALUES
                (1, 1, 100, 'Widget'),
                (2, 2, NULL, 'Widget'),
                (3, 3, 200, 'Widget')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 1) OVER (ORDER BY month) as prev,
                LEAD(revenue, 1) OVER (ORDER BY month) as next
            FROM sales
            ORDER BY month",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_i64(&result, 1, 0), 100);
    assert!(is_null(&result, 2, 0));
    assert!(is_null(&result, 3, 0));

    assert_eq!(get_i64(&result, 0, 1), 2);
    assert!(is_null(&result, 1, 1));
    assert_eq!(get_i64(&result, 2, 1), 100);
    assert_eq!(get_i64(&result, 3, 1), 200);

    assert_eq!(get_i64(&result, 0, 2), 3);
    assert_eq!(get_i64(&result, 1, 2), 200);
    assert!(is_null(&result, 2, 2));
    assert!(is_null(&result, 3, 2));
}

#[test]
fn test_empty_partition() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql("INSERT INTO sales VALUES (1, 1, 100, 'Widget')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                product,
                month,
                revenue,
                LAG(revenue, 1) OVER (PARTITION BY product ORDER BY month) as prev
            FROM sales
            WHERE product = 'Gadget'",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_large_offset() {
    let mut executor = setup_executor();
    setup_sales_table(&mut executor);

    executor
        .execute_sql("INSERT INTO sales VALUES (1, 1, 100, 'Widget')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                month,
                revenue,
                LAG(revenue, 100) OVER (ORDER BY month) as far_back,
                LEAD(revenue, 100) OVER (ORDER BY month) as far_ahead
            FROM sales",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert!(is_null(&result, 2, 0));
    assert!(is_null(&result, 3, 0));
}
