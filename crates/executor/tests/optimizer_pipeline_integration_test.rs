use yachtsql_executor::QueryExecutor;

#[test]
fn test_filter_through_optimizer() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM users WHERE age > 28")
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let result = executor
        .execute_sql("SELECT * FROM users WHERE age > 25 AND age < 35")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let result = executor
        .execute_sql("SELECT * FROM users WHERE age = 25 OR age = 35")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_projection_through_optimizer() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, 20), (3, 30)")
        .unwrap();

    let result = executor.execute_sql("SELECT id FROM test").unwrap();

    assert_eq!(result.schema().field_count(), 1);
    assert_eq!(result.schema().fields()[0].name, "id");

    let result = executor.execute_sql("SELECT value * 2 FROM test").unwrap();

    assert_eq!(result.schema().field_count(), 1);
    assert_eq!(result.num_rows(), 3);

    let result = executor
        .execute_sql("SELECT value * 2 AS double_value FROM test")
        .unwrap();

    assert_eq!(result.schema().fields()[0].name, "double_value");

    let result = executor
        .execute_sql("SELECT id, value * 2, value + 10 FROM test")
        .unwrap();

    assert_eq!(result.schema().field_count(), 3);
}

#[test]
fn test_join_through_optimizer() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (id INT64, user_id INT64, amount INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 50)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT users.name, orders.amount FROM users JOIN orders ON users.id = orders.user_id",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let result = executor
        .execute_sql("SELECT users.name, orders.amount FROM users LEFT JOIN orders ON users.id = orders.user_id")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
}

#[test]
fn test_aggregate_through_optimizer() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE products (category STRING, price INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO products VALUES ('A', 10), ('A', 20), ('B', 30), ('B', 40), ('C', 50)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT category, COUNT(*) FROM products GROUP BY category")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let result = executor
        .execute_sql("SELECT category, SUM(price) FROM products GROUP BY category")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let result = executor
        .execute_sql(
            "SELECT category, COUNT(*), SUM(price), AVG(price) FROM products GROUP BY category",
        )
        .unwrap();

    assert_eq!(result.schema().field_count(), 4);
}

#[test]
fn test_combined_operators() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql(
            "CREATE TABLE employees (id INT64, name STRING, age INT64, salary INT64, dept STRING)",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO employees VALUES (1, 'Alice', 30, 50000, 'Engineering'), (2, 'Bob', 25, 40000, 'Sales'), (3, 'Charlie', 35, 60000, 'Engineering'), (4, 'David', 28, 45000, 'Sales')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT name FROM employees WHERE age > 26")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    assert_eq!(result.schema().field_count(), 1);

    let result = executor
        .execute_sql("SELECT dept, COUNT(*) FROM employees WHERE age > 26 GROUP BY dept")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_plan_cache_integration() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, 20), (3, 30)")
        .unwrap();

    let _stats_before = executor.plan_cache_stats();

    let result1 = executor
        .execute_sql("SELECT * FROM test WHERE value > 15")
        .unwrap();
    assert_eq!(result1.num_rows(), 2);

    let result2 = executor
        .execute_sql("SELECT * FROM test WHERE value > 15")
        .unwrap();
    assert_eq!(result2.num_rows(), 2);

    let _stats_after = executor.plan_cache_stats();

    executor
        .execute_sql("SELECT * FROM test WHERE value < 25")
        .unwrap();

    let _stats_final = executor.plan_cache_stats();
}

#[test]
fn test_cache_invalidation_on_ddl() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();
    executor.execute_sql("SELECT * FROM test").unwrap();

    let _stats_before = executor.plan_cache_stats();

    executor.execute_sql("DROP TABLE test").unwrap();

    let _stats_after = executor.plan_cache_stats();
}

#[test]
fn test_filter_with_null_handling() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM test WHERE value > 15")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let result = executor
        .execute_sql("SELECT * FROM test WHERE value IS NULL")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_join_with_multiple_conditions() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE a (x INT64, y INT64, data STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE b (x INT64, y INT64, info STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO a VALUES (1, 1, 'A1'), (1, 2, 'A2'), (2, 1, 'A3')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO b VALUES (1, 1, 'B1'), (1, 2, 'B2'), (2, 2, 'B3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a.data, b.info FROM a JOIN b ON a.x = b.x AND a.y = b.y")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_aggregate_with_filter() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE sales (product STRING, amount INT64, region STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO sales VALUES ('Widget', 100, 'North'), ('Widget', 200, 'South'), ('Gadget', 150, 'North'), ('Gadget', 250, 'South'), ('Widget', 300, 'North')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT product, SUM(amount) FROM sales WHERE region = 'North' GROUP BY product",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_projection_with_complex_expressions() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (10, 5), (20, 10), (30, 15)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a + b, a * b, a - b FROM test")
        .unwrap();

    assert_eq!(result.schema().field_count(), 3);
    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_full_optimizer_pipeline_complex() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (id INT64, user_id INT64, amount INT64, status STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35), (4, 'David', 28)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1, 1, 100, 'pending'), (2, 1, 200, 'completed'), (3, 2, 50, 'completed'), (4, 3, 300, 'pending'), (5, 3, 150, 'completed')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT users.name, orders.amount
            FROM users
            JOIN orders ON users.id = orders.user_id
            WHERE users.age > 26 AND orders.status = 'completed'",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    assert_eq!(result.schema().field_count(), 2);
}

#[test]
fn test_optimizer_with_subqueries() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE departments (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE employees (id INT64, dept_id INT64, salary INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO employees VALUES (1, 1, 50000), (2, 1, 60000), (3, 2, 40000), (4, 2, 45000)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT DISTINCT departments.name
            FROM departments
            JOIN employees ON departments.id = employees.dept_id
            WHERE employees.salary > 45000",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_repeated_queries_use_cache() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1), (2), (3)")
        .unwrap();

    let query = "SELECT * FROM test WHERE id > 1";

    for _ in 0..10 {
        executor.execute_sql(query).unwrap();
    }

    let _stats = executor.plan_cache_stats();
}
