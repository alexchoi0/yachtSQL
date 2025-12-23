use yachtsql::QueryExecutor;

use crate::assert_table_eq;
use crate::common::create_executor;

fn setup_simple_table(executor: &mut QueryExecutor) {
    executor
        .execute_sql("CREATE TABLE items (id INT64, name STRING, quantity INT64)")
        .unwrap();
}

fn setup_table_with_defaults(executor: &mut QueryExecutor) {
    executor
        .execute_sql("CREATE TABLE orders (id INT64, status STRING DEFAULT 'pending', amount INT64 DEFAULT 0)")
        .unwrap();
}

fn setup_nullable_table(executor: &mut QueryExecutor) {
    executor
        .execute_sql("CREATE TABLE contacts (id INT64, email STRING, phone STRING)")
        .unwrap();
}

#[test]
fn test_insert_single_row() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Widget', 100)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM items").unwrap();

    assert_table_eq!(result, [[1, "Widget", 100]]);
}

#[test]
fn test_insert_multiple_rows() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO items VALUES (1, 'Widget', 100), (2, 'Gadget', 50), (3, 'Gizmo', 75)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM items ORDER BY id")
        .unwrap();

    assert_table_eq!(
        result,
        [[1, "Widget", 100], [2, "Gadget", 50], [3, "Gizmo", 75],]
    );
}

#[test]
fn test_insert_with_column_list() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items (id, name, quantity) VALUES (1, 'Widget', 100)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM items").unwrap();

    assert_table_eq!(result, [[1, "Widget", 100]]);
}

#[test]
fn test_insert_with_reordered_columns() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items (quantity, name, id) VALUES (100, 'Widget', 1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, quantity FROM items")
        .unwrap();

    assert_table_eq!(result, [[1, "Widget", 100]]);
}

#[test]
fn test_insert_partial_columns() {
    let mut executor = create_executor();
    setup_nullable_table(&mut executor);

    executor
        .execute_sql("INSERT INTO contacts (id, email) VALUES (1, 'test@example.com')")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM contacts").unwrap();

    assert_table_eq!(result, [[1, "test@example.com", null]]);
}

#[test]
fn test_insert_with_null_value() {
    let mut executor = create_executor();
    setup_nullable_table(&mut executor);

    executor
        .execute_sql("INSERT INTO contacts VALUES (1, 'test@example.com', NULL)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM contacts").unwrap();

    assert_table_eq!(result, [[1, "test@example.com", null]]);
}

#[test]
fn test_insert_with_default_keyword() {
    let mut executor = create_executor();
    setup_table_with_defaults(&mut executor);

    executor
        .execute_sql("INSERT INTO orders (id, status, amount) VALUES (1, DEFAULT, DEFAULT)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM orders").unwrap();

    assert_table_eq!(result, [[1, "pending", 0]]);
}

#[test]
fn test_insert_default_values() {
    let mut executor = create_executor();
    setup_table_with_defaults(&mut executor);

    executor
        .execute_sql("INSERT INTO orders (id) VALUES (1)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM orders").unwrap();

    assert_table_eq!(result, [[1, "pending", 0]]);
}

#[test]
fn test_insert_with_expression() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Widget', 50 + 50)")
        .unwrap();

    let result = executor.execute_sql("SELECT quantity FROM items").unwrap();

    assert_table_eq!(result, [[100]]);
}

#[test]
fn test_insert_multiple_statements() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Widget', 100)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO items VALUES (2, 'Gadget', 50)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM items ORDER BY id")
        .unwrap();

    assert_table_eq!(result, [[1, "Widget", 100], [2, "Gadget", 50],]);
}

#[test]
fn test_insert_into_empty_table() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    let result_before = executor.execute_sql("SELECT COUNT(*) FROM items").unwrap();
    assert_table_eq!(result_before, [[0]]);

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Widget', 100)")
        .unwrap();

    let result_after = executor.execute_sql("SELECT COUNT(*) FROM items").unwrap();
    assert_table_eq!(result_after, [[1]]);
}

#[test]
fn test_insert_with_subquery() {
    let mut executor = create_executor();
    setup_simple_table(&mut executor);

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Widget', 100), (2, 'Gadget', 50)")
        .unwrap();

    executor
        .execute_sql("CREATE TABLE items_copy (id INT64, name STRING, quantity INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO items_copy SELECT * FROM items WHERE quantity > 60")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM items_copy").unwrap();

    assert_table_eq!(result, [[1, "Widget", 100]]);
}

#[test]
fn test_insert_with_expression_default() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE events (id INT64, name STRING, created_date DATE DEFAULT CURRENT_DATE())",
        )
        .unwrap();

    executor
        .execute_sql("INSERT INTO events (id, name) VALUES (1, 'login')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, created_date IS NOT NULL AS has_date FROM events")
        .unwrap();

    assert_table_eq!(result, [[1, "login", true]]);
}

#[test]
fn test_insert_select_with_unnest() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE numbers (n INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO numbers SELECT * FROM UNNEST([1, 2, 3]) AS n")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers ORDER BY n")
        .unwrap();

    assert_table_eq!(result, [[1], [2], [3]]);
}

#[test]
fn test_insert_select_with_cte() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE results (id INT64, value INT64)")
        .unwrap();

    executor
        .execute_sql(
            "WITH src AS (SELECT 1 AS id, 100 AS value UNION ALL SELECT 2, 200)
             INSERT INTO results SELECT * FROM src",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM results ORDER BY id")
        .unwrap();

    assert_table_eq!(result, [[1, 100], [2, 200]]);
}

#[test]
fn test_insert_with_nested_struct() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE orders (
                id INT64,
                customer STRUCT<name STRING, address STRUCT<city STRING, zip STRING>>
            )",
        )
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO orders VALUES (
                1,
                STRUCT('John Doe', STRUCT('New York', '10001'))
            )",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, customer FROM orders")
        .unwrap();

    assert_table_eq!(result, [[1, {"John Doe", {"New York", "10001"}}]]);
}

#[test]
fn test_insert_values_with_subquery() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE config (key STRING, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO config VALUES ('max', 100)")
        .unwrap();

    executor
        .execute_sql("CREATE TABLE computed (id INT64, max_value INT64)")
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO computed VALUES (1, (SELECT value FROM config WHERE key = 'max'))",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM computed").unwrap();

    assert_table_eq!(result, [[1, 100]]);
}

#[test]
fn test_insert_with_range_function() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT RANGE_START(RANGE(DATE '2024-01-01', DATE '2024-12-31'))")
        .unwrap();

    assert_table_eq!(result, [["2024-01-01"]]);
}
