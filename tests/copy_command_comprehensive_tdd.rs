#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use std::fs;
use std::path::PathBuf;

use yachtsql::{DialectType, QueryExecutor};

fn assert_error_contains(
    result: yachtsql::Result<yachtsql::RecordBatch>,
    keywords: &[&str],
    context: &str,
) {
    assert!(result.is_err(), "{}", context);
    let err_msg = result.unwrap_err().to_string();
    let found = keywords.iter().any(|kw| err_msg.contains(kw));
    assert!(
        found,
        "Error message '{}' should contain one of {:?} (context: {})",
        err_msg, keywords, context
    );
}

#[inline]
fn new_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

#[inline]
fn get_row_count(executor: &mut QueryExecutor, table: &str) -> i64 {
    let result = executor
        .execute_sql(&format!("SELECT COUNT(*) FROM {}", table))
        .unwrap();
    result.column(0).unwrap().get(0).unwrap().as_i64().unwrap()
}

fn get_temp_file_path(name: &str) -> PathBuf {
    let mut path = std::env::temp_dir();
    path.push(format!("yachtsql_test_{}.csv", name));
    path
}

fn cleanup_test_file(path: &PathBuf) {
    let _ = fs::remove_file(path);
}

#[test]
fn test_copy_from_basic() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, email STRING)")
        .unwrap();

    let file_path = get_temp_file_path("basic_import");
    fs::write(
        &file_path,
        "1,Alice,alice@example.com\n\
         2,Bob,bob@example.com\n\
         3,Charlie,charlie@example.com\n",
    )
    .unwrap();

    executor
        .execute_sql(&format!(
            "COPY users FROM '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    assert_eq!(get_row_count(&mut executor, "users"), 3);

    let result = executor
        .execute_sql("SELECT * FROM users ORDER BY id")
        .unwrap();

    let col_name = result.column(1).unwrap();
    assert_eq!(col_name.get(0).unwrap().as_str().unwrap(), "Alice");
    assert_eq!(col_name.get(1).unwrap().as_str().unwrap(), "Bob");
    assert_eq!(col_name.get(2).unwrap().as_str().unwrap(), "Charlie");

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_from_with_header() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE products (id INT64, name STRING, price INT64)")
        .unwrap();

    let file_path = get_temp_file_path("with_header");
    fs::write(
        &file_path,
        "id,name,price\n\
         1,Widget,100\n\
         2,Gadget,200\n",
    )
    .unwrap();

    executor
        .execute_sql(&format!(
            "COPY products FROM '{}' WITH (HEADER)",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    assert_eq!(get_row_count(&mut executor, "products"), 2);

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_from_custom_delimiter() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE data (id INT64, value STRING)")
        .unwrap();

    let file_path = get_temp_file_path("custom_delimiter");
    fs::write(&file_path, "1|first\n2|second\n3|third\n").unwrap();

    executor
        .execute_sql(&format!(
            "COPY data FROM '{}' WITH (DELIMITER '|')",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    assert_eq!(get_row_count(&mut executor, "data"), 3);

    let result = executor
        .execute_sql("SELECT value FROM data WHERE id = 2")
        .unwrap();
    let value = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(value.as_str().unwrap(), "second");

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_from_null_values() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE nullable (id INT64, value INT64)")
        .unwrap();

    let file_path = get_temp_file_path("null_values");
    fs::write(&file_path, "1,100\n2,\n3,300\n").unwrap();

    executor
        .execute_sql(&format!(
            "COPY nullable FROM '{}' WITH (NULL '')",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM nullable ORDER BY id")
        .unwrap();

    let col_value = result.column(1).unwrap();
    assert_eq!(col_value.get(0).unwrap().as_i64().unwrap(), 100);
    assert!(col_value.get(1).unwrap().is_null());
    assert_eq!(col_value.get(2).unwrap().as_i64().unwrap(), 300);

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_from_column_list() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE partial (id INT64, name STRING, email STRING)")
        .unwrap();

    let file_path = get_temp_file_path("column_list");
    fs::write(&file_path, "1,Alice\n2,Bob\n").unwrap();

    executor
        .execute_sql(&format!(
            "COPY partial (id, name) FROM '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM partial ORDER BY id")
        .unwrap();

    let col_email = result.column(2).unwrap();
    assert!(col_email.get(0).unwrap().is_null());
    assert!(col_email.get(1).unwrap().is_null());

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_to_basic() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE export_test (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO export_test VALUES (1, 'first'), (2, 'second')")
        .unwrap();

    let file_path = get_temp_file_path("basic_export");

    executor
        .execute_sql(&format!(
            "COPY export_test TO '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();
    assert!(contents.contains("1,first"));
    assert!(contents.contains("2,second"));

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_to_with_header() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE with_header (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO with_header VALUES (1, 'test')")
        .unwrap();

    let file_path = get_temp_file_path("export_header");

    executor
        .execute_sql(&format!(
            "COPY with_header TO '{}' WITH (HEADER)",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();
    let lines: Vec<&str> = contents.lines().collect();

    assert_eq!(lines[0], "id,name", "First line should be header");
    assert_eq!(lines[1], "1,test", "Second line should be data");

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_query_to_file() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE source (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO source VALUES (1, 10), (2, 20), (3, 30)")
        .unwrap();

    let file_path = get_temp_file_path("query_export");

    executor
        .execute_sql(&format!(
            "COPY (SELECT id, value * 2 AS doubled FROM source WHERE id > 1)
             TO '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();
    assert!(contents.contains("2,40"));
    assert!(contents.contains("3,60"));
    assert!(!contents.contains("1,20"), "id=1 should be filtered out");

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_with_quote_option() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE quoted (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple')")
        .unwrap();

    let file_path = get_temp_file_path("quoted");

    executor
        .execute_sql(&format!(
            "COPY quoted TO '{}' WITH (QUOTE '\"')",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();
    assert!(
        contents.contains("\"Hello, World\""),
        "Comma should be quoted"
    );

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_with_escape_option() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE escaped (id INT64, text STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO escaped VALUES (1, 'It''s working')")
        .unwrap();

    let file_path = get_temp_file_path("escaped");

    executor
        .execute_sql(&format!(
            "COPY escaped TO '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();

    assert!(
        contents.contains("It's working"),
        "Apostrophe should be in output"
    );

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_binary_format() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE binary_test (id INT64, value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828)")
        .unwrap();

    let file_path = get_temp_file_path("binary");

    assert_error_contains(
        executor.execute_sql(&format!(
            "COPY binary_test TO '{}' WITH (FORMAT BINARY)",
            file_path.to_str().unwrap()
        )),
        &["BINARY", "not", "supported"],
        "BINARY format should return unsupported error",
    );
}

#[test]
fn test_copy_from_empty_file() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE empty_import (id INT64)")
        .unwrap();

    let file_path = get_temp_file_path("empty");
    fs::write(&file_path, "").unwrap();

    executor
        .execute_sql(&format!(
            "COPY empty_import FROM '{}'",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    assert_eq!(get_row_count(&mut executor, "empty_import"), 0);

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_to_empty_table() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE empty_export (id INT64)")
        .unwrap();

    let file_path = get_temp_file_path("empty_export");

    executor
        .execute_sql(&format!(
            "COPY empty_export TO '{}' WITH (HEADER)",
            file_path.to_str().unwrap()
        ))
        .unwrap();

    let contents = fs::read_to_string(&file_path).unwrap();
    let lines: Vec<&str> = contents.lines().collect();

    assert_eq!(lines.len(), 1, "Should only have header line");
    assert_eq!(lines[0], "id");

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_from_file_not_found() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();

    let result = executor.execute_sql("COPY test FROM '/nonexistent/file.csv'");

    assert_error_contains(
        result,
        &["file", "not found", "nonexistent"],
        "Should error when file doesn't exist",
    );
}

#[test]
fn test_copy_from_format_error() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, value INT64)")
        .unwrap();

    let file_path = get_temp_file_path("malformed");
    fs::write(&file_path, "1,100\n2,not_a_number\n3,300\n").unwrap();

    let result = executor.execute_sql(&format!("COPY test FROM '{}'", file_path.to_str().unwrap()));

    assert_error_contains(
        result,
        &["parse", "error", "type", "INT64"],
        "Should error on type mismatch",
    );

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_to_permission_error() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO test VALUES (1)").unwrap();

    let result = executor.execute_sql("COPY test TO '/root/forbidden.csv'");

    assert_error_contains(
        result,
        &[
            "permission",
            "denied",
            "access",
            "No such file",
            "Could not write",
        ],
        "Should error on permission denied or file not found",
    );
}

#[test]
fn test_copy_column_count_mismatch() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, name STRING)")
        .unwrap();

    let file_path = get_temp_file_path("column_mismatch");
    fs::write(&file_path, "1,Alice,extra_column\n2,Bob,another\n").unwrap();

    let result = executor.execute_sql(&format!("COPY test FROM '{}'", file_path.to_str().unwrap()));

    assert_error_contains(
        result,
        &["column", "count", "mismatch", "expected 2"],
        "Should error on column count mismatch",
    );

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_with_primary_key_violation() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64 PRIMARY KEY, value STRING)")
        .unwrap();

    let file_path = get_temp_file_path("pk_violation");
    fs::write(&file_path, "1,first\n1,duplicate\n").unwrap();

    let result = executor.execute_sql(&format!("COPY test FROM '{}'", file_path.to_str().unwrap()));

    assert_error_contains(
        result,
        &["primary key", "violation", "duplicate"],
        "Should error on PK violation",
    );

    cleanup_test_file(&file_path);
}

#[test]
fn test_copy_with_not_null_violation() {
    let mut executor = new_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64 NOT NULL, value STRING)")
        .unwrap();

    let file_path = get_temp_file_path("not_null_violation");
    fs::write(&file_path, "1,first\n,second\n").unwrap();

    let result = executor.execute_sql(&format!(
        "COPY test FROM '{}' WITH (NULL '')",
        file_path.to_str().unwrap()
    ));

    assert_error_contains(
        result,
        &["not null", "constraint", "violation"],
        "Should error on NOT NULL violation",
    );

    cleanup_test_file(&file_path);
}
