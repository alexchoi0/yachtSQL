use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_case_simple_when_then() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE orders (id INT64, amount INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO orders VALUES (1, 100)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO orders VALUES (2, 50)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO orders VALUES (3, 200)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN amount > 100 THEN 'high' ELSE 'normal' END AS category FROM orders",
    );
    assert!(result.is_ok(), "CASE WHEN failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string().trim_matches('\''), "normal");
    assert_eq!(rows[1][1].to_string().trim_matches('\''), "normal");
    assert_eq!(rows[2][1].to_string().trim_matches('\''), "high");
}

#[test]
fn test_case_multiple_when() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE scores (name STRING, score INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO scores VALUES ('Alice', 95)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO scores VALUES ('Bob', 85)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO scores VALUES ('Charlie', 70)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO scores VALUES ('David', 60)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT name, CASE \
            WHEN score >= 90 THEN 'A' \
            WHEN score >= 80 THEN 'B' \
            WHEN score >= 70 THEN 'C' \
            ELSE 'F' \
        END AS grade FROM scores",
    );
    assert!(result.is_ok(), "Multiple WHEN CASE failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 4);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string().trim_matches('\''), "A");
    assert_eq!(rows[1][1].to_string().trim_matches('\''), "B");
    assert_eq!(rows[2][1].to_string().trim_matches('\''), "C");
    assert_eq!(rows[3][1].to_string().trim_matches('\''), "F");
}

#[test]
fn test_case_with_operand() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE products (name STRING, category STRING, price INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO products VALUES ('Laptop', 'electronics', 1000)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO products VALUES ('Shirt', 'clothing', 50)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO products VALUES ('Book', 'media', 20)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT name, CASE category \
            WHEN 'electronics' THEN price * 1.2 \
            WHEN 'clothing' THEN price * 1.1 \
            ELSE price \
        END AS final_price FROM products",
    );
    assert!(result.is_ok(), "CASE with operand failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "1200");

    let val1: f64 = rows[1][1]
        .to_string()
        .parse()
        .expect("Failed to parse float");
    assert!((val1 - 55.0).abs() < 0.001, "Expected ~55, got {}", val1);
    assert_eq!(rows[2][1].to_string(), "20");
}

#[test]
fn test_case_without_else() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE items (id INT64, status STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO items VALUES (1, 'active')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO items VALUES (2, 'inactive')")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN status = 'active' THEN 'yes' END AS is_active FROM items",
    );
    assert!(result.is_ok(), "CASE without ELSE failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string().trim_matches('\''), "yes");
    assert_eq!(rows[1][1].to_string(), "NULL");
}

#[test]
fn test_case_returns_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (x INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO data VALUES (5)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO data VALUES (15)")
        .expect("INSERT failed");

    let result =
        executor.execute_sql("SELECT CASE WHEN x < 10 THEN 1 ELSE 0 END AS is_small FROM data");
    assert!(result.is_ok(), "CASE returning INT failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "1");
    assert_eq!(rows[1][0].to_string(), "0");
}

#[test]
fn test_case_with_arithmetic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE sales (product STRING, units INT64, price INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO sales VALUES ('A', 100, 10)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO sales VALUES ('B', 50, 20)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT product, CASE \
            WHEN units > 75 THEN units * price * 0.9 \
            ELSE units * price \
        END AS revenue FROM sales",
    );
    assert!(result.is_ok(), "CASE with arithmetic failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "900");
    assert_eq!(rows[1][1].to_string(), "1000");
}

#[test]
fn test_case_in_where_clause() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE employees (name STRING, salary INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO employees VALUES ('Alice', 50000)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO employees VALUES ('Bob', 75000)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO employees VALUES ('Charlie', 100000)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT name FROM employees WHERE CASE WHEN salary > 60000 THEN 1 ELSE 0 END = 1",
    );
    assert!(result.is_ok(), "CASE in WHERE failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "Bob");
    assert_eq!(rows[1][0].to_string().trim_matches('\''), "Charlie");
}

#[test]
fn test_case_with_string_functions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (name STRING, role STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO users VALUES ('alice', 'admin')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO users VALUES ('bob', 'user')")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT CASE WHEN role = 'admin' THEN UPPER(name) ELSE name END AS display_name FROM users",
    );
    assert!(
        result.is_ok(),
        "CASE with string functions failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "ALICE");
    assert_eq!(rows[1][0].to_string().trim_matches('\''), "bob");
}

#[test]
fn test_nested_case() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE items (type STRING, priority INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO items VALUES ('urgent', 1)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO items VALUES ('normal', 5)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO items VALUES ('urgent', 10)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT CASE type \
            WHEN 'urgent' THEN CASE WHEN priority < 5 THEN 'critical' ELSE 'high' END \
            ELSE 'medium' \
        END AS level FROM items",
    );
    assert!(result.is_ok(), "Nested CASE failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "critical");
    assert_eq!(rows[1][0].to_string().trim_matches('\''), "medium");
    assert_eq!(rows[2][0].to_string().trim_matches('\''), "high");
}

#[test]
fn test_case_with_null_handling() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO data VALUES (1, 10)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO data VALUES (2, NULL)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN value IS NULL THEN 0 ELSE value END AS safe_value FROM data",
    );
    assert!(
        result.is_ok(),
        "CASE with NULL handling failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "10");
    assert_eq!(rows[1][1].to_string(), "0");
}

#[test]
fn test_case_with_column_comparison() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE inventory (product STRING, stock INT64, threshold INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO inventory VALUES ('A', 100, 50)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO inventory VALUES ('B', 20, 50)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO inventory VALUES ('C', 75, 75)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT product, CASE \
            WHEN stock > threshold THEN 'overstocked' \
            WHEN stock < threshold THEN 'understocked' \
            ELSE 'balanced' \
        END AS status FROM inventory",
    );
    assert!(
        result.is_ok(),
        "CASE with column comparison failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string().trim_matches('\''), "overstocked");
    assert_eq!(rows[1][1].to_string().trim_matches('\''), "understocked");
    assert_eq!(rows[2][1].to_string().trim_matches('\''), "balanced");
}

#[test]
fn test_case_boolean_result() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE tests (name STRING, score INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO tests VALUES ('Test1', 80)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO tests VALUES ('Test2', 55)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT name, CASE WHEN score >= 60 THEN true ELSE false END AS passed FROM tests",
    );
    assert!(
        result.is_ok(),
        "CASE with boolean result failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "true");
    assert_eq!(rows[1][1].to_string(), "false");
}

#[test]
fn test_multiple_case_in_select() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE metrics (metric STRING, value INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO metrics VALUES ('cpu', 85)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO metrics VALUES ('memory', 45)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT metric, \
            CASE WHEN value > 80 THEN 'critical' ELSE 'ok' END AS status, \
            CASE WHEN value > 50 THEN value - 50 ELSE 0 END AS over_threshold \
        FROM metrics",
    );
    assert!(
        result.is_ok(),
        "Multiple CASE in SELECT failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);
    assert_eq!(batch.num_columns(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string().trim_matches('\''), "critical");
    assert_eq!(rows[0][2].to_string(), "35");
    assert_eq!(rows[1][1].to_string().trim_matches('\''), "ok");
    assert_eq!(rows[1][2].to_string(), "0");
}

#[test]
fn test_case_with_complex_conditions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE orders (id INT64, amount INT64, customer_type STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO orders VALUES (1, 1000, 'premium')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO orders VALUES (2, 500, 'regular')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO orders VALUES (3, 2000, 'premium')")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT id, CASE \
            WHEN customer_type = 'premium' AND amount > 1500 THEN amount * 0.8 \
            WHEN customer_type = 'premium' THEN amount * 0.9 \
            WHEN amount > 1000 THEN amount * 0.95 \
            ELSE amount \
        END AS discounted_amount FROM orders",
    );
    assert!(
        result.is_ok(),
        "CASE with complex conditions failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 3);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "900");
    assert_eq!(rows[1][1].to_string(), "500");
    assert_eq!(rows[2][1].to_string(), "1600");
}
