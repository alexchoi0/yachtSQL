use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_select_arithmetic_add() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO test VALUES (10, 20)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO test VALUES (5, 15)")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT a + b AS sum FROM test");
    assert!(result.is_ok(), "SELECT a + b failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2, "Expected 2 rows");

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "30");
    assert_eq!(rows[1][0].to_string(), "20");
}

#[test]
fn test_select_arithmetic_multiply() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE prices (item STRING, price INT64, quantity INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO prices VALUES ('apple', 5, 10)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO prices VALUES ('banana', 3, 20)")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT item, price * quantity AS total FROM prices");
    assert!(
        result.is_ok(),
        "SELECT with multiplication failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "50");
    assert_eq!(rows[1][1].to_string(), "60");
}

#[test]
fn test_select_arithmetic_divide() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (total INT64, count INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO data VALUES (100, 4)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO data VALUES (60, 3)")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT total / count AS average FROM data");
    assert!(result.is_ok(), "SELECT with division failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "25");
    assert_eq!(rows[1][0].to_string(), "20");
}

#[test]
fn test_select_string_upper() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE names (name STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO names VALUES ('alice')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO names VALUES ('bob')")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT UPPER(name) AS upper_name FROM names");
    assert!(result.is_ok(), "SELECT with UPPER() failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();

    let row0_str = rows[0][0].to_string().trim_matches('\'').to_string();
    let row1_str = rows[1][0].to_string().trim_matches('\'').to_string();
    assert_eq!(row0_str, "ALICE");
    assert_eq!(row1_str, "BOB");
}

#[test]
fn test_select_string_lower() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE names (name STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO names VALUES ('ALICE')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO names VALUES ('BOB')")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT LOWER(name) AS lower_name FROM names");
    assert!(result.is_ok(), "SELECT with LOWER() failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "alice");
    assert_eq!(rows[1][0].to_string().trim_matches('\''), "bob");
}

#[test]
fn test_select_string_concat() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (first_name STRING, last_name STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO users VALUES ('John', 'Doe')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO users VALUES ('Jane', 'Smith')")
        .expect("INSERT failed");

    let result =
        executor.execute_sql("SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM users");
    assert!(result.is_ok(), "SELECT with CONCAT() failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "John Doe");
    assert_eq!(rows[1][0].to_string().trim_matches('\''), "Jane Smith");
}

#[test]
fn test_select_string_concat_operator() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (first_name STRING, last_name STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO users VALUES ('John', 'Doe')")
        .expect("INSERT failed");

    let result =
        executor.execute_sql("SELECT first_name || ' ' || last_name AS full_name FROM users");
    assert!(
        result.is_ok(),
        "SELECT with || operator failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "John Doe");
}

#[test]
fn test_select_string_length() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE words (word STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO words VALUES ('hello')")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO words VALUES ('world')")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT word, LENGTH(word) AS len FROM words");
    assert!(result.is_ok(), "SELECT with LENGTH() failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 2);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][1].to_string(), "5");
    assert_eq!(rows[1][1].to_string(), "5");
}

#[test]
fn test_select_string_substring() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE words (word STRING)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO words VALUES ('hello world')")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT SUBSTRING(word, 1, 5) AS first_five FROM words");
    assert!(
        result.is_ok(),
        "SELECT with SUBSTRING() failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "hello");
}

#[test]
fn test_select_mixed_expressions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE products (name STRING, price INT64, quantity INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO products VALUES ('Widget', 10, 5)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT name, price, quantity, price * quantity AS total, UPPER(name) AS upper_name FROM products"
    );
    assert!(
        result.is_ok(),
        "SELECT with mixed expressions failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);
    assert_eq!(batch.num_columns(), 5);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "Widget");
    assert_eq!(rows[0][1].to_string(), "10");
    assert_eq!(rows[0][2].to_string(), "5");
    assert_eq!(rows[0][3].to_string(), "50");
    assert_eq!(rows[0][4].to_string().trim_matches('\''), "WIDGET");
}

#[test]
fn test_select_expression_with_where() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE sales (product STRING, price INT64, quantity INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO sales VALUES ('A', 10, 5)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO sales VALUES ('B', 20, 3)")
        .expect("INSERT failed");
    executor
        .execute_sql("INSERT INTO sales VALUES ('C', 5, 10)")
        .expect("INSERT failed");

    let result = executor.execute_sql(
        "SELECT product, price * quantity AS total FROM sales WHERE price * quantity > 50",
    );
    assert!(
        result.is_ok(),
        "SELECT with expression and WHERE failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string().trim_matches('\''), "B");
    assert_eq!(rows[0][1].to_string(), "60");
}

#[test]
fn test_select_complex_arithmetic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE calc (a INT64, b INT64, c INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO calc VALUES (10, 5, 2)")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT a + b * c AS result FROM calc");
    assert!(
        result.is_ok(),
        "SELECT with complex arithmetic failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "20");
}

#[test]
fn test_select_expression_aliases() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (x INT64, y INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO test VALUES (3, 4)")
        .expect("INSERT failed");

    let result =
        executor.execute_sql("SELECT x + y AS sum, x * y AS product, x - y AS diff FROM test");
    assert!(
        result.is_ok(),
        "SELECT with aliased expressions failed: {:?}",
        result
    );
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);
    assert_eq!(batch.num_columns(), 3);

    let schema = batch.schema();
    assert_eq!(schema.fields()[0].name, "sum");
    assert_eq!(schema.fields()[1].name, "product");
    assert_eq!(schema.fields()[2].name, "diff");

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "7");
    assert_eq!(rows[0][1].to_string(), "12");
    assert_eq!(rows[0][2].to_string(), "-1");
}

#[test]
fn test_select_expression_without_alias() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE test (a INT64, b INT64)")
        .expect("CREATE failed");

    executor
        .execute_sql("INSERT INTO test VALUES (10, 20)")
        .expect("INSERT failed");

    let result = executor.execute_sql("SELECT a + b FROM test");
    assert!(result.is_ok(), "SELECT without alias failed: {:?}", result);
    let batch = result.unwrap();
    assert_eq!(batch.num_rows(), 1);

    let rows = batch.rows().unwrap();
    assert_eq!(rows[0][0].to_string(), "30");
}
