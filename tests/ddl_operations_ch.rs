use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::BigQuery)
}

#[test]
fn test_create_table_basic() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE users (
            id Int64,
            name String,
            email String
        )",
    );
    assert!(result.is_ok(), "CREATE TABLE failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM users");
    assert!(result.is_ok());
}

#[test]
fn test_create_table_if_not_exists() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_test (id Int64)")
        .unwrap();

    let result = executor.execute_sql("CREATE TABLE IF NOT EXISTS ch_test (id Int64)");
    assert!(result.is_ok());
}

#[test]
fn test_create_table_with_nullable() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE nullable_test (
            id Int64,
            optional_field String
        )",
    );
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_add_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_alter (id Int64, name String)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE ch_alter ADD COLUMN email String");
    assert!(
        result.is_ok(),
        "ALTER TABLE ADD COLUMN failed: {:?}",
        result
    );

    executor
        .execute_sql("INSERT INTO ch_alter (id, name, email) VALUES (1, 'Alice', 'alice@test.com')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT email FROM ch_alter WHERE id = 1")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_alter_table_drop_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_drop (id Int64, name String, temp String)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE ch_drop DROP COLUMN temp");
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_rename_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_rename (id Int64, old_col String)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE ch_rename RENAME COLUMN old_col TO new_col");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT new_col FROM ch_rename");
    assert!(result.is_ok());
}

#[test]
fn test_drop_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_to_drop (id Int64)")
        .unwrap();

    let result = executor.execute_sql("DROP TABLE ch_to_drop");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT * FROM ch_to_drop");
    assert!(result.is_err());
}

#[test]
fn test_drop_table_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP TABLE IF EXISTS ch_nonexistent");
    assert!(result.is_ok());
}

#[test]
fn test_create_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_base (id INT64, name STRING, active BOOL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO ch_base VALUES (1, 'Alice', TRUE), (2, 'Bob', FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("CREATE VIEW ch_active AS SELECT id, name FROM ch_base WHERE active = TRUE");
    assert!(result.is_ok(), "CREATE VIEW failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM ch_active").unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_drop_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_view_base (id Int64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW ch_view_drop AS SELECT * FROM ch_view_base")
        .unwrap();

    let result = executor.execute_sql("DROP VIEW ch_view_drop");
    assert!(result.is_ok());
}

#[test]
fn test_truncate_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE ch_truncate (id Int64, name String)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO ch_truncate VALUES (1, 'A'), (2, 'B'), (3, 'C')")
        .unwrap();

    let result = executor.execute_sql("TRUNCATE TABLE ch_truncate");
    assert!(result.is_ok(), "TRUNCATE failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM ch_truncate").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_workflow_clickhouse() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE ch_workflow (
                id Int64,
                name String,
                status String
            )",
        )
        .unwrap();

    executor
        .execute_sql("ALTER TABLE ch_workflow ADD COLUMN created_at TIMESTAMP")
        .unwrap();

    executor
        .execute_sql(
            "CREATE VIEW ch_workflow_active AS SELECT id, name FROM ch_workflow WHERE status = 'active'",
        )
        .unwrap();

    executor
        .execute_sql("INSERT INTO ch_workflow (id, name, status) VALUES (1, 'Test', 'active')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM ch_workflow_active")
        .unwrap();
    assert_eq!(result.num_rows(), 1);

    executor
        .execute_sql("DROP VIEW ch_workflow_active")
        .unwrap();

    executor.execute_sql("DROP TABLE ch_workflow").unwrap();
}
