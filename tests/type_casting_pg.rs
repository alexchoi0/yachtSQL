use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

#[test]
fn test_pg_cast_int_to_varchar() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor.execute_sql("SELECT CAST(123 AS VARCHAR)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "123");
}

#[test]
fn test_pg_cast_string_to_integer() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST('456' AS INTEGER)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 456);
}

#[test]
fn test_pg_cast_string_to_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST('2024-01-15' AS DATE)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let date = col.get(0).unwrap().as_date().unwrap();
    assert_eq!(date.to_string(), "2024-01-15");
}

#[test]
fn test_pg_cast_column_to_decimal() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE products (price FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (19.99), (29.50), (99.00)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(price AS DECIMAL(10,2)) FROM products ORDER BY price")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_pg_double_colon_string_to_integer() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor.execute_sql("SELECT '123'::integer").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 123);
}

#[test]
fn test_pg_double_colon_column_to_text() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (num_col INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (100), (200), (300)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT num_col::text FROM data ORDER BY num_col")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "100");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "200");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "300");
}

#[test]
fn test_pg_try_cast_valid_succeeds() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT TRY_CAST('123' AS INTEGER)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 123);
}

#[test]
fn test_pg_cast_float_to_integer_truncates() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST(3.14159 AS INTEGER)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 3);
}

#[test]
fn test_pg_cast_to_bigint() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (big_number FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (9223372036854775000.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(big_number AS BIGINT) FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_pg_cast_to_double_precision() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE orders (amount INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (100), (250), (500)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(amount AS DOUBLE PRECISION) FROM orders ORDER BY amount")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_f64().unwrap(), 100.0);
}

#[test]
fn test_pg_cast_string_to_timestamp() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST('2024-01-15 10:30:00' AS TIMESTAMP)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_pg_cast_integer_to_boolean() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor.execute_sql("SELECT CAST(1 AS BOOLEAN)").unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().as_bool().unwrap());
}

#[test]
fn test_pg_cast_string_to_boolean() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST('true' AS BOOLEAN)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().as_bool().unwrap());
}

#[test]
fn test_pg_cast_boolean_to_integer() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE users (active BOOLEAN)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (true), (false), (true)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(active AS INTEGER) FROM users")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_pg_cast_json_to_text() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE data (json_col JSON)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('{\"a\":1}')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CAST(json_col AS TEXT) FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_pg_cast_null_preserves_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT CAST(NULL AS INTEGER)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
}

#[test]
fn test_pg_try_cast_null_returns_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql("SELECT TRY_CAST(NULL AS VARCHAR)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
}
