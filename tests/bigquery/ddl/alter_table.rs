use crate::assert_table_eq;
use crate::common::create_executor;

#[test]
fn test_alter_table_add_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN age INT64")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (2, 'Bob', 30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM users ORDER BY id")
        .unwrap();

    assert_table_eq!(result, [[1, "Alice", null], [2, "Bob", 30],]);
}

#[test]
fn test_alter_table_drop_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice', 30)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users DROP COLUMN age")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM users").unwrap();

    assert_table_eq!(result, [[1, "Alice"]]);
}

#[test]
fn test_alter_table_rename_column() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users RENAME COLUMN name TO full_name")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, full_name FROM users")
        .unwrap();

    assert_table_eq!(result, [[1, "Alice"]]);
}

#[test]
fn test_alter_table_rename_table() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE old_name (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO old_name VALUES (1, 'Alice')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE old_name RENAME TO new_name")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM new_name").unwrap();

    assert_table_eq!(result, [[1, "Alice"]]);
}

#[test]
fn test_alter_table_add_column_with_default() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active'")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM users").unwrap();

    assert_table_eq!(result, [[1, "Alice", "active"]]);
}

#[test]
fn test_alter_table_add_constraint() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, email STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'test@example.com')")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM users").unwrap();

    assert_table_eq!(result, [[1, "test@example.com"]]);
}

#[test]
fn test_alter_table_set_not_null() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ALTER COLUMN name SET NOT NULL")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM users").unwrap();
    assert_table_eq!(result, [[1, "Alice"]]);
}

#[test]
fn test_alter_table_drop_not_null() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING NOT NULL)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ALTER COLUMN name DROP NOT NULL")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, NULL)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM users").unwrap();
    assert_table_eq!(result, [[1, null]]);
}

#[test]
#[ignore]
fn test_alter_table_set_options() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE options_table (id INT64)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE options_table SET OPTIONS (description = 'Updated description')")
        .unwrap();

    executor
        .execute_sql("INSERT INTO options_table VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM options_table")
        .unwrap();
    assert_table_eq!(result, [[1]]);
}

#[test]
fn test_alter_table_add_multiple_columns() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE multi_add (id INT64)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE multi_add ADD COLUMN name STRING, ADD COLUMN age INT64")
        .unwrap();

    executor
        .execute_sql("INSERT INTO multi_add VALUES (1, 'Alice', 30)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM multi_add").unwrap();
    assert_table_eq!(result, [[1, "Alice", 30]]);
}

#[test]
#[ignore]
fn test_alter_table_alter_column_set_default() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE default_test (id INT64, status STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE default_test ALTER COLUMN status SET DEFAULT 'pending'")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default_test (id) VALUES (1)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM default_test").unwrap();
    assert_table_eq!(result, [[1, "pending"]]);
}

#[test]
#[ignore]
fn test_alter_table_alter_column_drop_default() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE drop_default (id INT64, status STRING DEFAULT 'active')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE drop_default ALTER COLUMN status DROP DEFAULT")
        .unwrap();

    executor
        .execute_sql("INSERT INTO drop_default (id) VALUES (1)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM drop_default").unwrap();
    assert_table_eq!(result, [[1, null]]);
}

#[test]
#[ignore]
fn test_alter_table_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("ALTER TABLE IF EXISTS nonexistent ADD COLUMN x INT64");
    assert!(result.is_ok());
}

#[test]
#[ignore]
fn test_alter_table_drop_constraint() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE constraint_drop (id INT64, email STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE constraint_drop ADD CONSTRAINT unique_email UNIQUE (email)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE constraint_drop DROP CONSTRAINT unique_email")
        .unwrap();

    executor
        .execute_sql("INSERT INTO constraint_drop VALUES (1, 'a@b.com'), (2, 'a@b.com')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COUNT(*) FROM constraint_drop")
        .unwrap();
    assert_table_eq!(result, [[2]]);
}

#[test]
#[ignore]
fn test_alter_table_alter_column_set_data_type() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE type_change (id INT64, value STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE type_change ALTER COLUMN value SET DATA TYPE STRING(100)")
        .unwrap();
}

#[test]
#[ignore]
fn test_alter_table_add_primary_key() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE add_pk (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE add_pk ADD PRIMARY KEY (id) NOT ENFORCED")
        .unwrap();
}

#[test]
#[ignore]
fn test_alter_table_drop_primary_key() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE drop_pk (id INT64 PRIMARY KEY NOT ENFORCED, name STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE drop_pk DROP PRIMARY KEY")
        .unwrap();
}

#[test]
#[ignore]
fn test_alter_view_set_options() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE base_view_table (id INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE VIEW my_view AS SELECT * FROM base_view_table")
        .unwrap();

    executor
        .execute_sql("ALTER VIEW my_view SET OPTIONS (description = 'Updated view')")
        .unwrap();
}

#[test]
#[ignore]
fn test_alter_materialized_view_set_options() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE mv_base (id INT64, value INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE MATERIALIZED VIEW my_mv AS SELECT id, SUM(value) as total FROM mv_base GROUP BY id")
        .unwrap();

    executor
        .execute_sql("ALTER MATERIALIZED VIEW my_mv SET OPTIONS (enable_refresh = true)")
        .unwrap();
}
