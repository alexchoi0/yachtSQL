use yachtsql_executor::QueryExecutor;
use yachtsql_storage::table::indexes::TableIndexOps;

fn create_test_executor() -> QueryExecutor {
    let executor = QueryExecutor::new();
    {
        let mut storage = executor.storage.borrow_mut();
        let _ = storage.create_dataset("default".to_string());
    }
    executor
}

#[test]
fn test_index_with_null_values() {
    let mut executor = create_test_executor();

    executor
        .execute_sql(
            "CREATE TABLE default.test (
            id INT64,
            name STRING,
            age INT64
        )",
        )
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 'Alice', 30)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (2, NULL, 25)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (3, 'Charlie', NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (4, NULL, NULL)")
        .unwrap();

    let result = executor.execute_sql("CREATE INDEX idx_name ON default.test(name)");
    assert!(
        result.is_ok(),
        "Should allow index on column with NULLs: {:?}",
        result.err()
    );

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE name = 'Alice'")
        .unwrap();
    assert_eq!(
        result.num_rows(),
        1,
        "Should find 1 row with name = 'Alice'"
    );
}

#[test]
fn test_index_lookup_null_value() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 'A')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (2, NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (3, 'C')")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_value ON default.test(value)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE value IS NULL")
        .unwrap();
    assert_eq!(result.num_rows(), 1, "Should find 1 NULL row");
}

#[test]
fn test_unique_index_prevents_duplicates() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, email STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE UNIQUE INDEX idx_email ON default.test(email)")
        .unwrap();

    let result1 = executor.execute_sql("INSERT INTO default.test VALUES (1, 'alice@example.com')");
    assert!(result1.is_ok(), "First insert should succeed");

    let result2 = executor.execute_sql("INSERT INTO default.test VALUES (2, 'alice@example.com')");
    assert!(
        result2.is_err(),
        "Duplicate insert should fail with unique constraint violation"
    );
}

#[test]
fn test_unique_index_allows_multiple_nulls() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, email STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE UNIQUE INDEX idx_email ON default.test(email)")
        .unwrap();

    let result1 = executor.execute_sql("INSERT INTO default.test VALUES (1, NULL)");
    assert!(result1.is_ok(), "First NULL insert should succeed");

    let result2 = executor.execute_sql("INSERT INTO default.test VALUES (2, NULL)");
    assert!(
        result2.is_ok(),
        "Second NULL insert should succeed (NULLs are not equal)"
    );
}

#[test]
fn test_composite_index_with_nulls() {
    let mut executor = create_test_executor();

    executor
        .execute_sql(
            "CREATE TABLE default.test (
            id INT64,
            first_name STRING,
            last_name STRING
        )",
        )
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_name ON default.test(first_name, last_name)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 'Alice', 'Smith')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (2, 'Bob', NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (3, NULL, 'Johnson')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (4, NULL, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE first_name = 'Alice'")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_large_composite_key() {
    let mut executor = create_test_executor();

    executor
        .execute_sql(
            "CREATE TABLE default.test (
            col1 STRING,
            col2 STRING,
            col3 STRING,
            col4 STRING,
            col5 STRING
        )",
        )
        .unwrap();

    let result = executor
        .execute_sql("CREATE INDEX idx_composite ON default.test(col1, col2, col3, col4, col5)");
    assert!(
        result.is_ok(),
        "Should allow large composite index: {:?}",
        result.err()
    );

    executor
        .execute_sql("INSERT INTO default.test VALUES ('A', 'B', 'C', 'D', 'E')")
        .unwrap();
    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE col1 = 'A'")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_many_indexes_on_single_table() {
    let mut executor = create_test_executor();

    executor
        .execute_sql(
            "CREATE TABLE default.test (
            id INT64,
            col1 STRING,
            col2 STRING,
            col3 STRING,
            col4 STRING,
            col5 STRING
        )",
        )
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx1 ON default.test(id)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx2 ON default.test(col1)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx3 ON default.test(col2)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx4 ON default.test(col3)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx5 ON default.test(col4)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx6 ON default.test(col5)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 'A', 'B', 'C', 'D', 'E')")
        .unwrap();

    let storage = executor.storage.borrow_mut();
    let dataset = storage.get_dataset("default").unwrap();
    let table = dataset.get_table("test").unwrap();

    assert_eq!(table.index_metadata().len(), 6, "Should have 6 indexes");
}

#[test]
fn test_index_on_int64() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_value ON default.test(value)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 1000)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (2, 2000)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE value = 1000")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_index_on_string() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_name ON default.test(name)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 'Alice')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO default.test VALUES (2, 'Bob')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE name = 'Alice'")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_index_on_long_strings() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, data STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_data ON default.test(data)")
        .unwrap();

    let long_string = "A".repeat(1000);
    let sql = format!("INSERT INTO default.test VALUES (1, '{}')", long_string);
    executor.execute_sql(&sql).unwrap();

    let sql = format!("SELECT * FROM default.test WHERE data = '{}'", long_string);
    let result = executor.execute_sql(&sql).unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_drop_index_with_pending_queries() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_id ON default.test(id)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 100)")
        .unwrap();

    let result1 = executor
        .execute_sql("SELECT * FROM default.test WHERE id = 1")
        .unwrap();
    assert_eq!(result1.num_rows(), 1);

    executor.execute_sql("DROP INDEX idx_id").unwrap();

    let result2 = executor
        .execute_sql("SELECT * FROM default.test WHERE id = 1")
        .unwrap();
    assert_eq!(result2.num_rows(), 1);
}

#[test]
fn test_recreate_index_same_name() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE INDEX idx_test ON default.test(id)")
        .unwrap();

    executor.execute_sql("DROP INDEX idx_test").unwrap();

    let result = executor.execute_sql("CREATE INDEX idx_test ON default.test(value)");
    assert!(
        result.is_ok(),
        "Should allow recreating index with same name after drop"
    );
}

#[test]
fn test_index_on_empty_table() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value INT64)")
        .unwrap();

    let result = executor.execute_sql("CREATE INDEX idx_id ON default.test(id)");
    assert!(result.is_ok(), "Should allow index creation on empty table");

    executor
        .execute_sql("INSERT INTO default.test VALUES (1, 100)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE id = 1")
        .unwrap();
    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_index_with_many_duplicates() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, category STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_category ON default.test(category)")
        .unwrap();

    for i in 0..100 {
        let category = format!("cat_{}", i % 5);
        executor
            .execute_sql(&format!(
                "INSERT INTO default.test VALUES ({}, '{}')",
                i, category
            ))
            .unwrap();
    }

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE category = 'cat_0'")
        .unwrap();
    assert_eq!(result.num_rows(), 20, "Should find all 20 rows with cat_0");
}

#[test]
fn test_index_all_duplicate_values() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx_value ON default.test(value)")
        .unwrap();

    for i in 0..50 {
        executor
            .execute_sql(&format!("INSERT INTO default.test VALUES ({}, 'SAME')", i))
            .unwrap();
    }

    let result = executor
        .execute_sql("SELECT * FROM default.test WHERE value = 'SAME'")
        .unwrap();
    assert_eq!(result.num_rows(), 50, "Should find all 50 duplicate rows");
}

#[test]
fn test_if_exists_on_missing_index() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64)")
        .unwrap();

    let result = executor.execute_sql("DROP INDEX IF EXISTS idx_nonexistent");
    assert!(
        result.is_ok(),
        "DROP IF EXISTS should succeed on missing index"
    );
}

#[test]
fn test_index_metadata_persistence() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx1 ON default.test(id)")
        .unwrap();
    executor
        .execute_sql("CREATE INDEX idx2 ON default.test(value)")
        .unwrap();

    let storage = executor.storage.borrow_mut();
    let dataset = storage.get_dataset("default").unwrap();
    let table = dataset.get_table("test").unwrap();

    assert_eq!(table.index_metadata().len(), 2, "Should have 2 indexes");

    let index_names: Vec<&str> = table
        .index_metadata()
        .iter()
        .map(|idx| idx.index_name.as_str())
        .collect();

    assert!(index_names.contains(&"idx1"), "Should have idx1");
    assert!(index_names.contains(&"idx2"), "Should have idx2");
}

#[test]
fn test_case_sensitive_index_names() {
    let mut executor = create_test_executor();

    executor
        .execute_sql("CREATE TABLE default.test (id INT64)")
        .unwrap();

    let result1 = executor.execute_sql("CREATE INDEX idx_test ON default.test(id)");
    assert!(result1.is_ok());

    let _result2 = executor.execute_sql("CREATE INDEX IDX_TEST ON default.test(id)");
}
