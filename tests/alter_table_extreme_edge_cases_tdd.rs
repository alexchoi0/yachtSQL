#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

mod common;

#[test]
fn test_add_column_to_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING");

    assert!(result.is_ok(), "Should add column to empty table");

    executor
        .execute_sql("INSERT INTO users (id, name, email) VALUES (1, 'Alice', 'alice@example.com')")
        .unwrap();
}

#[test]
fn test_add_column_to_table_with_data() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (2, 'Bob')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, email FROM users ORDER BY id")
        .unwrap();
    assert_eq!(result.num_rows(), 2);

    let col = result.column(1).unwrap();
    assert!(
        col.get(0).unwrap().is_null(),
        "Existing row should have NULL for new column"
    );
    assert!(
        col.get(1).unwrap().is_null(),
        "Existing row should have NULL for new column"
    );
}

#[test]
fn test_add_column_with_default_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (2, 'Bob')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active'")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, status FROM users ORDER BY id")
        .unwrap();
    assert_eq!(result.num_rows(), 2);

    let col = result.column(1).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "active");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "active");
}

#[test]
fn test_add_column_not_null_to_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING NOT NULL");
}

#[test]
fn test_add_column_not_null_to_table_with_data_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING NOT NULL");

    assert!(
        result.is_err(),
        "Cannot add NOT NULL column without DEFAULT to table with data"
    );
    let err_msg = result.unwrap_err().to_string();
    assert!(
        err_msg.contains("NOT NULL")
            || err_msg.contains("default")
            || err_msg.contains("constraint"),
        "Error should mention NOT NULL constraint issue: {}",
        err_msg
    );
}

#[test]
fn test_add_column_not_null_with_default() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    let result = executor
        .execute_sql("ALTER TABLE users ADD COLUMN status STRING NOT NULL DEFAULT 'active'");

    assert!(
        result.is_ok(),
        "Should add NOT NULL column with DEFAULT to table with data"
    );

    let query_result = executor
        .execute_sql("SELECT status FROM users WHERE id = 1")
        .unwrap();
    let col = query_result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "active");
}

#[test]
fn test_add_multiple_columns_in_sequence() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN name STRING")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN age INT64")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, email, age FROM users")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_add_column_with_same_name_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN name STRING");

    assert!(result.is_err(), "Cannot add column with duplicate name");
    let err_msg = result.unwrap_err().to_string();
    assert!(
        err_msg.contains("already exists")
            || err_msg.contains("duplicate")
            || err_msg.contains("name"),
        "Error should mention duplicate column name: {}",
        err_msg
    );
}

#[test]
fn test_drop_column_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, email STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice', 'alice@example.com')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users DROP COLUMN email")
        .unwrap();

    let result = executor.execute_sql("SELECT id, name FROM users").unwrap();
    assert_eq!(result.num_rows(), 1);

    let err_result = executor.execute_sql("SELECT email FROM users");
    assert!(
        err_result.is_err(),
        "Dropped column should not be accessible"
    );
}

#[test]
fn test_drop_column_from_middle() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, email STRING, age INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', 30)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users DROP COLUMN email")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, age FROM users")
        .unwrap();
    assert_eq!(result.num_rows(), 1);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let age_col = result.column(2).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(name_col.get(0).unwrap().as_str().unwrap(), "Alice");
    assert_eq!(age_col.get(0).unwrap().as_i64().unwrap(), 30);
}

#[test]
fn test_drop_column_that_does_not_exist_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users DROP COLUMN nonexistent");

    assert!(result.is_err(), "Cannot drop non-existent column");
}

#[test]
fn test_drop_last_column_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE single_col (id INT64)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE single_col DROP COLUMN id");

    assert!(
        result.is_err(),
        "Cannot drop last column - table must have at least one column"
    );
}

#[test]
fn test_drop_column_referenced_by_foreign_key() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64 PRIMARY KEY, name STRING)")
        .unwrap();
    executor.execute_sql(
        "CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id))"
    ).unwrap();

    let result = executor.execute_sql("ALTER TABLE users DROP COLUMN id");

    assert!(
        result.is_err(),
        "Cannot drop column referenced by FOREIGN KEY"
    );
}

#[test]
fn test_rename_column_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, old_name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users RENAME COLUMN old_name TO new_name")
        .unwrap();

    let err_result = executor.execute_sql("SELECT old_name FROM users");
    assert!(err_result.is_err(), "Old column name should not work");

    let result = executor.execute_sql("SELECT new_name FROM users").unwrap();
    assert_eq!(result.num_rows(), 1);

    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Alice");
}

#[test]
fn test_rename_column_to_existing_name_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, email STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users RENAME COLUMN name TO email");

    assert!(result.is_err(), "Cannot rename to existing column name");
}

#[test]
fn test_rename_nonexistent_column_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users RENAME COLUMN nonexistent TO new_name");

    assert!(result.is_err(), "Cannot rename non-existent column");
}

#[test]
fn test_modify_column_compatible_type() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 100)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2, 200)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE data MODIFY COLUMN value FLOAT64")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data WHERE id = 1")
        .unwrap();
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_f64().unwrap(), 100.0);
}

#[test]
fn test_modify_column_incompatible_type_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 'Alice')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE data MODIFY COLUMN name INT64");

    assert!(
        result.is_err(),
        "Cannot convert non-numeric string to INT64"
    );
}

#[test]
fn test_modify_column_string_to_int64_with_numeric_data() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, '100')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2, '200')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE data MODIFY COLUMN value INT64")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data WHERE id = 1")
        .unwrap();
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 100);
}

#[test]
fn test_modify_column_precision_loss() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 123.456)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE data MODIFY COLUMN value INT64")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data WHERE id = 1")
        .unwrap();
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 123);
}

#[test]
fn test_modify_column_increase_string_length() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 'Alice')")
        .unwrap();
}

#[test]
fn test_modify_column_with_null_values() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 100)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2, NULL)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE data MODIFY COLUMN value FLOAT64")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data WHERE id = 2")
        .unwrap();
    let col = result.column(0).unwrap();

    assert!(
        col.get(0).unwrap().is_null(),
        "NULL should remain NULL after type change"
    );
}

#[test]
fn test_add_primary_key_to_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD PRIMARY KEY (id)");

    assert!(result.is_ok(), "Should add PRIMARY KEY to empty table");
}

#[test]
fn test_add_primary_key_to_table_with_unique_data() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (2, 'Bob')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD PRIMARY KEY (id)");

    assert!(
        result.is_ok(),
        "Should add PRIMARY KEY when existing data is unique and non-NULL"
    );
}

#[test]
fn test_add_primary_key_with_duplicate_data_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Bob')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD PRIMARY KEY (id)");

    assert!(
        result.is_err(),
        "Cannot add PRIMARY KEY when existing data has duplicates"
    );
}

#[test]
fn test_add_primary_key_with_null_data_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (NULL, 'Alice')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD PRIMARY KEY (id)");

    assert!(
        result.is_err(),
        "Cannot add PRIMARY KEY when column contains NULL"
    );
}

#[test]
fn test_add_unique_constraint_with_duplicate_data_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, email STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'alice@example.com')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (2, 'alice@example.com')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD UNIQUE (email)");

    assert!(
        result.is_err(),
        "Cannot add UNIQUE constraint when existing data has duplicates"
    );
}

#[test]
fn test_add_not_null_constraint_to_column_with_nulls_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, NULL)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users MODIFY COLUMN name STRING NOT NULL");

    assert!(
        result.is_err(),
        "Cannot add NOT NULL constraint when column contains NULL"
    );
}

#[test]
fn test_add_check_constraint_with_violating_data_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE products (id INT64, price FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (1, -10.00)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE products ADD CHECK (price > 0)");

    assert!(
        result.is_err(),
        "Cannot add CHECK constraint when existing data violates it"
    );
}

#[test]
fn test_rename_table_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE old_name (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO old_name VALUES (1, 'test')")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE old_name RENAME TO new_name")
        .unwrap();

    let err_result = executor.execute_sql("SELECT * FROM old_name");
    assert!(err_result.is_err(), "Old table name should not work");

    let result = executor
        .execute_sql("SELECT value FROM new_name WHERE id = 1")
        .unwrap();
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "test");
}

#[test]
fn test_rename_table_to_existing_name_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE table1 (id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE table2 (id INT64)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE table1 RENAME TO table2");

    assert!(result.is_err(), "Cannot rename to existing table name");
}

#[test]
fn test_rename_table_with_foreign_key_references() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64 PRIMARY KEY)")
        .unwrap();
    executor.execute_sql(
        "CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id))"
    ).unwrap();

    let result = executor.execute_sql("ALTER TABLE users RENAME TO customers");
}

#[test]
fn test_alter_table_on_nonexistent_table_fails() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor.execute_sql("ALTER TABLE nonexistent ADD COLUMN new_col STRING");

    assert!(
        result.is_err(),
        "ALTER TABLE should fail on non-existent table"
    );
}

#[test]
fn test_multiple_alter_operations_in_sequence() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN name STRING")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD PRIMARY KEY (id)")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD UNIQUE (email)")
        .unwrap();

    let result = executor.execute_sql("SELECT id, name, email FROM users");
    assert!(result.is_ok());
}

#[test]
fn test_alter_table_preserves_indexes() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64 PRIMARY KEY, name STRING)")
        .unwrap();

    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();
}

#[test]
fn test_failed_alter_table_preserves_original_schema() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64 PRIMARY KEY, name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN name STRING");
    assert!(result.is_err());

    let query_result = executor.execute_sql("SELECT id, name FROM users").unwrap();
    assert_eq!(query_result.num_rows(), 1);
}

#[test]
fn test_alter_table_operation() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING UNIQUE");
}
