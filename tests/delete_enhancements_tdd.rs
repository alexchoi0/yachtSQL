#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

mod common;
use common::{assert_batch_rows, setup_executor};
use yachtsql::Value;

#[test]
fn test_delete_with_inner_join() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE customers (id INT64, status STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1, 100, 50.0), (2, 101, 75.0), (3, 100, 30.0)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO customers VALUES (100, 'inactive'), (101, 'active')")
        .unwrap();

    executor
        .execute_sql(
            "DELETE o FROM orders o
         INNER JOIN customers c ON o.customer_id = c.id
         WHERE c.status = 'inactive'",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM orders ORDER BY id")
        .unwrap();

    assert_batch_rows(&result, vec![vec![Value::int64(2)]]);
}

#[test]
fn test_delete_with_left_join() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (id INT64, user_id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (100, 1), (101, 2)")
        .unwrap();

    executor
        .execute_sql(
            "DELETE u FROM users u
         LEFT JOIN orders o ON u.id = o.user_id
         WHERE o.id IS NULL",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT name FROM users ORDER BY id")
        .unwrap();

    assert_batch_rows(
        &result,
        vec![vec![Value::from_str("Alice")], vec![Value::from_str("Bob")]],
    );
}

#[test]
fn test_delete_with_self_join() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE employees (id INT64, name STRING, manager_id INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO employees VALUES (1, 'Alice', NULL), (2, 'Bob', 1), (3, 'Charlie', 2), (4, 'David', 1)").unwrap();

    executor
        .execute_sql(
            "DELETE e FROM employees e
         INNER JOIN employees m ON e.manager_id = m.id
         WHERE m.name = 'Bob'",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT name FROM employees ORDER BY id")
        .unwrap();

    assert_batch_rows(
        &result,
        vec![
            vec![Value::from_str("Alice")],
            vec![Value::from_str("Bob")],
            vec![Value::from_str("David")],
        ],
    );
}

#[test]
fn test_delete_returning_all_columns() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE logs (id INT64, level STRING, message STRING)")
        .unwrap();
    executor.execute_sql("INSERT INTO logs VALUES (1, 'DEBUG', 'msg1'), (2, 'ERROR', 'msg2'), (3, 'DEBUG', 'msg3')").unwrap();

    let result = executor
        .execute_sql(
            "DELETE FROM logs
         WHERE level = 'DEBUG'
         RETURNING *",
        )
        .unwrap();

    assert_batch_rows(
        &result,
        vec![
            vec![
                Value::int64(1),
                Value::from_str("DEBUG"),
                Value::from_str("msg1"),
            ],
            vec![
                Value::int64(3),
                Value::from_str("DEBUG"),
                Value::from_str("msg3"),
            ],
        ],
    );

    let remaining = executor.execute_sql("SELECT COUNT(*) FROM logs").unwrap();
    assert_batch_rows(&remaining, vec![vec![Value::int64(1)]]);
}

#[test]
fn test_delete_returning_specific_columns() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE archive (id INT64, data STRING, created_at INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO archive VALUES (1, 'old', 100), (2, 'old', 200), (3, 'new', 300)")
        .unwrap();

    let result = executor
        .execute_sql(
            "DELETE FROM archive
         WHERE data = 'old'
         RETURNING id, data",
        )
        .unwrap();

    assert_batch_rows(
        &result,
        vec![
            vec![Value::int64(1), Value::from_str("old")],
            vec![Value::int64(2), Value::from_str("old")],
        ],
    );
}

#[test]
fn test_delete_returning_no_rows_deleted() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE items (id INT64, status STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO items VALUES (1, 'active'), (2, 'active')")
        .unwrap();

    let result = executor
        .execute_sql(
            "DELETE FROM items
         WHERE status = 'deleted'
         RETURNING *",
        )
        .unwrap();

    assert_batch_rows(&result, vec![]);

    let remaining = executor.execute_sql("SELECT COUNT(*) FROM items").unwrap();
    assert_batch_rows(&remaining, vec![vec![Value::int64(2)]]);
}

#[test]
fn test_delete_returning_with_order_by() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE queue (id INT64, priority INT64, task STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO queue VALUES (1, 10, 'low'), (2, 50, 'med'), (3, 100, 'high')")
        .unwrap();

    let result = executor
        .execute_sql(
            "DELETE FROM queue
         WHERE priority >= 50
         RETURNING id, task
         ORDER BY priority DESC
         LIMIT 1",
        )
        .unwrap();

    assert_batch_rows(
        &result,
        vec![vec![Value::int64(3), Value::from_str("high")]],
    );
}

#[test]
fn test_delete_from_multiple_tables() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE orders (id INT64, customer_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE order_items (order_id INT64, product_id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1, 100), (2, 101)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO order_items VALUES (1, 200), (1, 201), (2, 202)")
        .unwrap();

    executor
        .execute_sql(
            "DELETE orders, order_items
         FROM orders
         INNER JOIN order_items ON orders.id = order_items.order_id
         WHERE orders.customer_id = 100",
        )
        .unwrap();

    let orders_result = executor
        .execute_sql("SELECT id FROM orders ORDER BY id")
        .unwrap();
    assert_batch_rows(&orders_result, vec![vec![Value::int64(2)]]);

    let items_result = executor
        .execute_sql("SELECT order_id FROM order_items ORDER BY order_id")
        .unwrap();
    assert_batch_rows(&items_result, vec![vec![Value::int64(2)]]);
}

#[test]
fn test_delete_with_null_in_join_condition() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE items (id INT64, category_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE categories (id INT64, deleted BOOL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO items VALUES (1, 10), (2, NULL), (3, 20)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO categories VALUES (10, true), (20, false)")
        .unwrap();

    executor
        .execute_sql(
            "DELETE i FROM items i
         INNER JOIN categories c ON i.category_id = c.id
         WHERE c.deleted = true",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM items ORDER BY id")
        .unwrap();

    assert_batch_rows(&result, vec![vec![Value::int64(2)], vec![Value::int64(3)]]);
}

#[test]
fn test_delete_all_rows() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE temp (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO temp VALUES (1, 'a'), (2, 'b'), (3, 'c')")
        .unwrap();

    executor.execute_sql("DELETE FROM temp").unwrap();

    let result = executor.execute_sql("SELECT COUNT(*) FROM temp").unwrap();
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        0
    );
}

#[test]
fn test_delete_with_complex_where_clause() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE events (id INT64, type STRING, timestamp INT64, processed BOOL)")
        .unwrap();
    executor.execute_sql("INSERT INTO events VALUES (1, 'A', 100, true), (2, 'B', 200, false), (3, 'A', 150, true), (4, 'A', 180, false)").unwrap();

    executor
        .execute_sql(
            "DELETE FROM events
         WHERE type = 'A'
         AND timestamp < 150
         AND processed = true",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM events ORDER BY id")
        .unwrap();

    assert_batch_rows(
        &result,
        vec![
            vec![Value::int64(2)],
            vec![Value::int64(3)],
            vec![Value::int64(4)],
        ],
    );
}

#[test]
fn test_delete_with_subquery_in_where() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE products (id INT64, price FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (1, 100), (2, 200), (3, 150), (4, 180)")
        .unwrap();

    executor
        .execute_sql(
            "DELETE FROM products
         WHERE price < (SELECT AVG(price) FROM products)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM products ORDER BY id")
        .unwrap();

    assert_batch_rows(&result, vec![vec![Value::int64(2)], vec![Value::int64(4)]]);
}

#[should_panic(expected = "does not exist")]
fn test_delete_nonexistent_table_error() {
    let mut executor = setup_executor();

    executor
        .execute_sql("DELETE FROM nonexistent_table WHERE id = 1")
        .unwrap();
}

#[should_panic(expected = "does not exist")]
fn test_delete_nonexistent_column_in_where_error() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();
    executor
        .execute_sql("DELETE FROM test WHERE nonexistent_column = 1")
        .unwrap();
}

#[test]
fn test_delete_with_limit() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE logs (id INT64, level STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO logs VALUES (1, 'DEBUG'), (2, 'DEBUG'), (3, 'DEBUG'), (4, 'ERROR')",
        )
        .unwrap();

    executor
        .execute_sql(
            "DELETE FROM logs
         WHERE level = 'DEBUG'
         LIMIT 2",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT COUNT(*) FROM logs WHERE level = 'DEBUG'")
        .unwrap();

    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        1
    );
}

#[test]
fn test_delete_no_rows_affected() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10), (2, 20)")
        .unwrap();

    executor
        .execute_sql("DELETE FROM data WHERE id > 1000")
        .unwrap();

    let result = executor.execute_sql("SELECT COUNT(*) FROM data").unwrap();
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        2
    );
}

#[test]
fn test_delete_with_foreign_key_cascade() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE parents (id INT64 PRIMARY KEY)")
        .unwrap();
    executor.execute_sql("CREATE TABLE children (id INT64, parent_id INT64, FOREIGN KEY (parent_id) REFERENCES parents(id) ON DELETE CASCADE)").unwrap();

    executor
        .execute_sql("INSERT INTO parents VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO children VALUES (10, 1), (11, 1), (12, 2)")
        .unwrap();

    executor
        .execute_sql("DELETE FROM parents WHERE id = 1")
        .unwrap();

    let children_result = executor
        .execute_sql("SELECT id FROM children ORDER BY id")
        .unwrap();

    assert_batch_rows(&children_result, vec![vec![Value::int64(12)]]);
}
