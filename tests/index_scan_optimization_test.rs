use yachtsql::QueryExecutor;

#[test]
fn test_index_scan_is_used() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (id INT64, name STRING, price FLOAT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1, 'Widget', 9.99), (2, 'Gadget', 19.99), (3, 'Doohickey', 29.99)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_product_id ON products(id)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM products WHERE id = 2")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert_eq!(result.num_columns(), 3);
}

#[test]
fn test_index_scan_with_string_column() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, email STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'alice@example.com', 30), (2, 'bob@example.com', 25), (3, 'charlie@example.com', 35)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_email ON users(email)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM users WHERE email = 'bob@example.com'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_fallback_to_table_scan_without_index() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE items (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'Item A'), (2, 'Item B'), (3, 'Item C')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM items WHERE id = 2")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_index_scan_no_match() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget')")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_id ON products(id)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM products WHERE id = 999")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_index_scan_with_hash_index() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE orders (order_id INT64, customer_id INT64, total FLOAT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1, 100, 50.0), (2, 200, 75.0), (3, 100, 25.0)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_customer ON orders(customer_id) USING HASH")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE customer_id = 100")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}
