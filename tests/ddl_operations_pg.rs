use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

#[test]
fn test_create_table_basic() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(255)
        )",
    );
    assert!(result.is_ok(), "CREATE TABLE failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM users");
    assert!(result.is_ok());
    assert_eq!(result.unwrap().num_rows(), 0);
}

#[test]
fn test_create_table_if_not_exists() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE test_table (id INT64)")
        .unwrap();

    let result = executor.execute_sql("CREATE TABLE IF NOT EXISTS test_table (id INT64)");
    assert!(result.is_ok());
}

#[test]
fn test_create_table_with_constraints() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE orders (
            id INTEGER PRIMARY KEY,
            user_id INTEGER,
            total DECIMAL(10,2),
            status VARCHAR(20)
        )",
    );
    assert!(result.is_ok());
}

#[test]
fn test_create_table_with_default_values() {
    let mut executor = create_executor();

    let result = executor.execute_sql(
        "CREATE TABLE events (
            id INTEGER PRIMARY KEY,
            name VARCHAR(100),
            active BOOLEAN DEFAULT TRUE
        )",
    );
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_add_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING");
    assert!(
        result.is_ok(),
        "ALTER TABLE ADD COLUMN failed: {:?}",
        result
    );

    executor
        .execute_sql("INSERT INTO users (id, name, email) VALUES (1, 'Alice', 'alice@test.com')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT email FROM users WHERE id = 1")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_alter_table_drop_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE test_drop (id INT64, name STRING, temp STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE test_drop DROP COLUMN temp");
    assert!(
        result.is_ok(),
        "ALTER TABLE DROP COLUMN failed: {:?}",
        result
    );

    let result = executor.execute_sql("SELECT temp FROM test_drop");
    assert!(result.is_err());
}

#[test]
fn test_alter_table_rename_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE test_rename (id INT64, old_name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE test_rename RENAME COLUMN old_name TO new_name");
    assert!(
        result.is_ok(),
        "ALTER TABLE RENAME COLUMN failed: {:?}",
        result
    );

    let result = executor.execute_sql("SELECT new_name FROM test_rename");
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_add_column_with_default() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE test_default (id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test_default VALUES (1)")
        .unwrap();

    let result =
        executor.execute_sql("ALTER TABLE test_default ADD COLUMN status STRING DEFAULT 'active'");
    assert!(result.is_ok());

    let result = executor
        .execute_sql("SELECT status FROM test_default WHERE id = 1")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_drop_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE to_drop (id INT64)")
        .unwrap();

    let result = executor.execute_sql("DROP TABLE to_drop");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT * FROM to_drop");
    assert!(result.is_err());
}

#[test]
fn test_drop_table_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP TABLE IF EXISTS nonexistent_table");
    assert!(result.is_ok());
}

#[test]
fn test_create_index_basic() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE indexed_table (id INT64, email STRING)")
        .unwrap();

    let result = executor.execute_sql("CREATE INDEX idx_email ON indexed_table(email)");
    assert!(result.is_ok(), "CREATE INDEX failed: {:?}", result);
}

#[test]
fn test_create_unique_index() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE unique_idx_table (id INT64, code STRING)")
        .unwrap();

    let result =
        executor.execute_sql("CREATE UNIQUE INDEX idx_unique_code ON unique_idx_table(code)");
    assert!(result.is_ok());
}

#[test]
fn test_drop_index() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE idx_drop_table (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_to_drop ON idx_drop_table(name)")
        .unwrap();

    let result = executor.execute_sql("DROP INDEX idx_to_drop");
    assert!(result.is_ok());
}

#[test]
fn test_drop_index_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP INDEX IF EXISTS nonexistent_index");
    assert!(result.is_ok());
}

#[test]
fn test_create_view_basic() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE base_table (id INT64, name STRING, active BOOL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO base_table VALUES (1, 'Alice', TRUE), (2, 'Bob', FALSE)")
        .unwrap();

    let result = executor.execute_sql(
        "CREATE VIEW active_users AS SELECT id, name FROM base_table WHERE active = TRUE",
    );
    assert!(result.is_ok(), "CREATE VIEW failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM active_users").unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_create_or_replace_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE view_base (id INT64, value INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW test_view AS SELECT id FROM view_base")
        .unwrap();

    let result =
        executor.execute_sql("CREATE OR REPLACE VIEW test_view AS SELECT id, value FROM view_base");
    assert!(result.is_ok());
}

#[test]
fn test_drop_view() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE drop_view_base (id INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW view_to_drop AS SELECT * FROM drop_view_base")
        .unwrap();

    let result = executor.execute_sql("DROP VIEW view_to_drop");
    assert!(result.is_ok());

    let result = executor.execute_sql("SELECT * FROM view_to_drop");
    assert!(result.is_err());
}

#[test]
fn test_drop_view_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP VIEW IF EXISTS nonexistent_view");
    assert!(result.is_ok());
}

#[test]
fn test_truncate_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE truncate_test (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO truncate_test VALUES (1, 'A'), (2, 'B'), (3, 'C')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COUNT(*) FROM truncate_test")
        .unwrap();
    assert_eq!(result.num_rows(), 1);

    let result = executor.execute_sql("TRUNCATE TABLE truncate_test");
    assert!(result.is_ok(), "TRUNCATE failed: {:?}", result);

    let result = executor.execute_sql("SELECT * FROM truncate_test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_workflow() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE workflow_test (
            id INTEGER PRIMARY KEY,
            name VARCHAR(100),
            status VARCHAR(20)
        )",
        )
        .unwrap();

    executor
        .execute_sql("ALTER TABLE workflow_test ADD COLUMN created_at TIMESTAMP")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_workflow_status ON workflow_test(status)")
        .unwrap();

    executor
        .execute_sql(
            "CREATE VIEW workflow_active AS SELECT id, name FROM workflow_test WHERE status = 'active'",
        )
        .unwrap();

    executor
        .execute_sql("INSERT INTO workflow_test (id, name, status) VALUES (1, 'Test', 'active')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM workflow_active")
        .unwrap();
    assert_eq!(result.num_rows(), 1);

    executor.execute_sql("DROP VIEW workflow_active").unwrap();

    executor
        .execute_sql("DROP INDEX idx_workflow_status")
        .unwrap();

    executor.execute_sql("DROP TABLE workflow_test").unwrap();
}
