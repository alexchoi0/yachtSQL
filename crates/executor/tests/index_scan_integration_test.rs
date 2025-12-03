use yachtsql_executor::QueryExecutor;

#[test]
fn test_index_scan_via_optimizer_path_subquery() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_users_id ON users (id)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM (SELECT * FROM users WHERE id = 2) AS sub")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_index_with_distinct_on() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (id INT64, category STRING, price INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_products_category ON products (category)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO products VALUES
             (1, 'Electronics', 100),
             (2, 'Electronics', 200),
             (3, 'Books', 20),
             (4, 'Books', 30)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT DISTINCT ON (category) category, price FROM products ORDER BY category, price",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_index_with_cube() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE sales (region STRING, product STRING, amount INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_sales_region ON sales (region)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO sales VALUES
             ('East', 'Widget', 100),
             ('East', 'Gadget', 150),
             ('West', 'Widget', 200),
             ('West', 'Gadget', 250)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT region, SUM(amount) as total FROM sales GROUP BY region")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_index_scan_direct_path() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE employees (id INT64, name STRING, department STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_employees_id ON employees (id)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO employees VALUES
             (1, 'Alice', 'Engineering'),
             (2, 'Bob', 'Sales'),
             (3, 'Charlie', 'Engineering'),
             (42, 'David', 'Marketing')",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM employees WHERE id = 42")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}
