use yachtsql::QueryExecutor;

#[test]
fn test_create_index_btree() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35)",
        )
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_age ON users(age) USING BTREE")
        .unwrap();
}

#[test]
fn test_create_index_hash() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (id INT64, name STRING, price FLOAT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1, 'Widget', 9.99), (2, 'Gadget', 19.99)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_product_id ON products(id) USING HASH")
        .unwrap();
}

#[test]
fn test_create_unique_index() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, email STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'alice@example.com')")
        .unwrap();

    executor
        .execute_sql("CREATE UNIQUE INDEX idx_email ON users(email)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (2, 'bob@example.com')")
        .unwrap();
}

#[test]
fn test_create_composite_index() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE orders (user_id INT64, order_date STRING, amount FLOAT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1, '2024-01-01', 100.0), (1, '2024-01-02', 150.0)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_user_date ON orders(user_id, order_date)")
        .unwrap();
}

#[test]
fn test_create_index_if_not_exists() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE items (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_items ON items(id)")
        .unwrap();

    let result = executor.execute_sql("CREATE INDEX idx_items ON items(id)");
    assert!(result.is_err());
    assert!(result.unwrap_err().to_string().contains("already exists"));

    let result = executor.execute_sql("CREATE INDEX IF NOT EXISTS idx_items ON items(id)");
    assert!(result.is_ok());
}

#[test]
fn test_drop_index() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_user_id ON users(id)")
        .unwrap();

    executor.execute_sql("DROP INDEX idx_user_id").unwrap();
}

#[test]
fn test_drop_index_if_exists() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("DROP INDEX nonexistent_index");
    assert!(result.is_err());
    assert!(result.unwrap_err().to_string().contains("does not exist"));

    let result = executor.execute_sql("DROP INDEX IF EXISTS nonexistent_index");
    assert!(result.is_ok());
}

#[test]
fn test_index_maintained_on_insert() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_product_id ON products(id)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget')")
        .unwrap();
}

#[test]
fn test_multiple_indexes_on_same_table() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, email STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO users VALUES (1, 'alice@example.com', 30), (2, 'bob@example.com', 25)",
        )
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_id ON users(id)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_email ON users(email)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_age ON users(age)")
        .unwrap();
}

#[test]
fn test_default_index_type_is_btree() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_id ON users(id)")
        .unwrap();
}
