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
            id INT64,
            name STRING,
            email STRING
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
        .execute_sql("CREATE TABLE bq_test (id INT64)")
        .unwrap();

    let result = executor.execute_sql("CREATE TABLE IF NOT EXISTS bq_test (id INT64)");
    assert!(result.is_ok());
}

#[test]
fn test_create_table_with_struct() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE bq_struct_test (
            id INT64,
            name STRING,
            metadata STRING
        )",
    );
    assert!(result.is_ok());
}

#[test]
fn test_create_table_with_array() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE bq_array_test (
            id INT64,
            tags STRING
        )",
    );
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_add_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_alter (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE bq_alter ADD COLUMN email STRING");
    assert!(
        result.is_ok(),
        "ALTER TABLE ADD COLUMN failed: {:?}",
        result
    );

    executor
        .execute_sql("INSERT INTO bq_alter (id, name, email) VALUES (1, 'Alice', 'alice@test.com')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT email FROM bq_alter WHERE id = 1")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_alter_table_drop_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_drop (id INT64, name STRING, temp STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE bq_drop DROP COLUMN temp");
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_rename_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_rename (id INT64, old_col STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE bq_rename RENAME COLUMN old_col TO new_col");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT new_col FROM bq_rename");
    assert!(result.is_ok());
}

#[test]
fn test_drop_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_to_drop (id INT64)")
        .unwrap();

    let result = executor.execute_sql("DROP TABLE bq_to_drop");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT * FROM bq_to_drop");
    assert!(result.is_err());
}

#[test]
fn test_drop_table_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP TABLE IF EXISTS bq_nonexistent");
    assert!(result.is_ok());
}

#[test]
fn test_create_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_base (id INT64, name STRING, active BOOL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO bq_base VALUES (1, 'Alice', TRUE), (2, 'Bob', FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("CREATE VIEW bq_active AS SELECT id, name FROM bq_base WHERE active = TRUE");
    assert!(result.is_ok(), "CREATE VIEW failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM bq_active").unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_create_or_replace_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_view_base (id INT64, value INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW bq_test_view AS SELECT id FROM bq_view_base")
        .unwrap();

    let result = executor
        .execute_sql("CREATE OR REPLACE VIEW bq_test_view AS SELECT id, value FROM bq_view_base");
    assert!(result.is_ok());
}

#[test]
fn test_drop_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_view_drop_base (id INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW bq_view_to_drop AS SELECT * FROM bq_view_drop_base")
        .unwrap();

    let result = executor.execute_sql("DROP VIEW bq_view_to_drop");
    assert!(result.is_ok());
}

#[test]
fn test_drop_view_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP VIEW IF EXISTS bq_nonexistent_view");
    assert!(result.is_ok());
}

#[test]
fn test_truncate_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE bq_truncate (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO bq_truncate VALUES (1, 'A'), (2, 'B'), (3, 'C')")
        .unwrap();

    let result = executor.execute_sql("TRUNCATE TABLE bq_truncate");
    assert!(result.is_ok(), "TRUNCATE failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM bq_truncate").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_workflow_bigquery() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE bq_workflow (
                id INT64,
                name STRING,
                status STRING
            )",
        )
        .unwrap();

    executor
        .execute_sql("ALTER TABLE bq_workflow ADD COLUMN created_at TIMESTAMP")
        .unwrap();

    executor
        .execute_sql(
            "CREATE VIEW bq_workflow_active AS SELECT id, name FROM bq_workflow WHERE status = 'active'",
        )
        .unwrap();

    executor
        .execute_sql("INSERT INTO bq_workflow (id, name, status) VALUES (1, 'Test', 'active')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM bq_workflow_active")
        .unwrap();
    assert_eq!(result.num_rows(), 1);

    executor
        .execute_sql("DROP VIEW bq_workflow_active")
        .unwrap();

    executor.execute_sql("DROP TABLE bq_workflow").unwrap();
}
