use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

#[test]
fn test_bq_cast_int_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor.execute_sql("SELECT CAST(123 AS STRING)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "123");
}

#[test]
fn test_bq_cast_string_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor.execute_sql("SELECT CAST('456' AS INT64)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 456);
}

#[test]
fn test_bq_cast_string_to_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT CAST('2024-01-15' AS DATE)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let date = col.get(0).unwrap().as_date().unwrap();
    assert_eq!(date.to_string(), "2024-01-15");
}

#[test]
fn test_bq_cast_column_to_numeric() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);
    executor
        .execute_sql("CREATE TABLE products (price FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (19.99), (29.50), (99.00)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(price AS NUMERIC) FROM products ORDER BY price")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_bq_safe_cast_valid_succeeds() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT SAFE_CAST('123' AS INT64)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 123);
}

#[test]
fn test_bq_safe_cast_valid_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT SAFE_CAST('2024-01-15' AS DATE)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let date = col.get(0).unwrap().as_date().unwrap();
    assert_eq!(date.to_string(), "2024-01-15");
}

#[test]
fn test_bq_cast_float_to_int_truncates() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT CAST(3.14159 AS INT64)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 3);
}

#[test]
fn test_bq_cast_to_float64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);
    executor
        .execute_sql("CREATE TABLE orders (amount INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (100), (250), (500)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(amount AS FLOAT64) FROM orders ORDER BY amount")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_f64().unwrap(), 100.0);
}

#[test]
fn test_bq_cast_string_to_timestamp() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT CAST('2024-01-15 10:30:00' AS TIMESTAMP)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_bq_cast_integer_to_bool() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor.execute_sql("SELECT CAST(1 AS BOOL)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().as_bool().unwrap());
}

#[test]
fn test_bq_cast_string_to_bool() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor.execute_sql("SELECT CAST('true' AS BOOL)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().as_bool().unwrap());
}

#[test]
fn test_bq_cast_bool_to_int64() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);
    executor
        .execute_sql("CREATE TABLE users (active BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (true), (false), (true)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(active AS INT64) FROM users")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_bq_cast_json_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);
    executor
        .execute_sql("CREATE TABLE data (json_col JSON)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('{\"a\":1}')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(json_col AS STRING) FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_bq_cast_null_preserves_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor.execute_sql("SELECT CAST(NULL AS INT64)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
}

#[test]
fn test_bq_safe_cast_null_returns_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

    let result = executor
        .execute_sql("SELECT SAFE_CAST(NULL AS STRING)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
}

#[test]
fn test_bq_cast_bytes_to_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);
    executor
        .execute_sql("CREATE TABLE data (bytes_col BYTES)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (b'hello')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(bytes_col AS STRING) FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "hello");
}
