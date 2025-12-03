use yachtsql_executor::QueryExecutor;

#[test]
fn test_insert_with_column_list() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .expect("Failed to create table");

    executor
        .execute_sql("INSERT INTO users (name, id) VALUES ('Alice', 1)")
        .expect("INSERT failed");

    let result = executor
        .execute_sql("SELECT id, name FROM users")
        .expect("SELECT failed");

    assert_eq!(result.num_rows(), 1);

    let id_col = result.column(0).expect("id column not found");
    let name_col = result.column(1).expect("name column not found");

    let id = id_col.get(0).expect("Failed to get id");
    let name = name_col.get(0).expect("Failed to get name");

    assert_eq!(id.as_i64(), Some(1), "id should be 1");
    assert_eq!(name.as_str(), Some("Alice"), "name should be Alice");
}

#[test]
fn test_insert_select_with_where() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE source (id INT64, value INT64)")
        .expect("Failed to create source");

    executor
        .execute_sql("INSERT INTO source VALUES (1, 10), (2, 20), (3, 30)")
        .expect("Failed to populate source");

    executor
        .execute_sql("CREATE TABLE target (id INT64, value INT64)")
        .expect("Failed to create target");

    executor
        .execute_sql("INSERT INTO target SELECT id, value FROM source WHERE value >= 20")
        .expect("INSERT SELECT failed");

    let result = executor
        .execute_sql("SELECT COUNT(*) as cnt FROM target")
        .expect("SELECT failed");

    let cnt_col = result.column(0).expect("count column");
    let cnt = cnt_col.get(0).expect("count value");
    assert_eq!(
        cnt.as_i64(),
        Some(2),
        "Should have 2 rows (values 20 and 30)"
    );
}

#[test]
fn test_insert_select_with_expressions() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE numbers (x INT64)")
        .expect("Failed to create table");

    executor
        .execute_sql("INSERT INTO numbers VALUES (5), (10), (15)")
        .expect("Failed to insert");

    executor
        .execute_sql("CREATE TABLE doubled (original INT64, doubled INT64)")
        .expect("Failed to create target");

    executor
        .execute_sql("INSERT INTO doubled SELECT x, x * 2 FROM numbers")
        .expect("INSERT SELECT with expression failed");

    let result = executor
        .execute_sql("SELECT doubled FROM doubled ORDER BY original")
        .expect("SELECT failed");

    assert_eq!(result.num_rows(), 3);

    let doubled_col = result.column(0).expect("doubled column");
    assert_eq!(doubled_col.get(0).unwrap().as_i64(), Some(10));
    assert_eq!(doubled_col.get(1).unwrap().as_i64(), Some(20));
    assert_eq!(doubled_col.get(2).unwrap().as_i64(), Some(30));
}

#[test]
fn test_insert_with_null_values() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE nullable_table (id INT64, optional_name STRING)")
        .expect("Failed to create table");

    executor
        .execute_sql("INSERT INTO nullable_table VALUES (1, NULL)")
        .expect("INSERT with NULL failed");

    executor
        .execute_sql("INSERT INTO nullable_table VALUES (2, 'Bob')")
        .expect("INSERT without NULL failed");

    let result = executor
        .execute_sql("SELECT id, optional_name FROM nullable_table ORDER BY id")
        .expect("SELECT failed");

    assert_eq!(result.num_rows(), 2);

    let name_col = result.column(1).expect("name column");

    let name1 = name_col.get(0).expect("get name1");
    assert!(name1.is_null(), "First row name should be NULL");

    let name2 = name_col.get(1).expect("get name2");
    assert_eq!(name2.as_str(), Some("Bob"), "Second row name should be Bob");
}

#[test]
fn test_insert_multiple_batches() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE batch_test (id INT64, batch_num INT64)")
        .expect("Failed to create table");

    executor
        .execute_sql("INSERT INTO batch_test VALUES (1, 1), (2, 1), (3, 1)")
        .expect("Batch 1 failed");

    executor
        .execute_sql("INSERT INTO batch_test VALUES (4, 2), (5, 2)")
        .expect("Batch 2 failed");

    executor
        .execute_sql("INSERT INTO batch_test VALUES (6, 3)")
        .expect("Batch 3 failed");

    let result = executor
        .execute_sql("SELECT COUNT(*) as total FROM batch_test")
        .expect("SELECT failed");

    let total_col = result.column(0).expect("total column");
    let total = total_col.get(0).expect("total value");
    assert_eq!(total.as_i64(), Some(6), "Should have 6 total rows");

    let batch_result = executor
        .execute_sql("SELECT batch_num, COUNT(*) as cnt FROM batch_test GROUP BY batch_num ORDER BY batch_num")
        .expect("GROUP BY failed");

    assert_eq!(batch_result.num_rows(), 3, "Should have 3 batches");

    let cnt_col = batch_result.column(1).expect("count column");
    assert_eq!(cnt_col.get(0).unwrap().as_i64(), Some(3), "Batch 1: 3 rows");
    assert_eq!(cnt_col.get(1).unwrap().as_i64(), Some(2), "Batch 2: 2 rows");
    assert_eq!(cnt_col.get(2).unwrap().as_i64(), Some(1), "Batch 3: 1 row");
}

#[test]
fn test_insert_with_string_escaping() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE strings (id INT64, text STRING)")
        .expect("Failed to create table");

    executor
        .execute_sql("INSERT INTO strings VALUES (1, 'It''s a test')")
        .expect("INSERT with escaped quote failed");

    executor
        .execute_sql("INSERT INTO strings VALUES (2, 'Normal string')")
        .expect("INSERT normal string failed");

    let result = executor
        .execute_sql("SELECT text FROM strings ORDER BY id")
        .expect("SELECT failed");

    let text_col = result.column(0).expect("text column");

    let text1 = text_col.get(0).expect("text1");
    assert_eq!(
        text1.as_str(),
        Some("It's a test"),
        "Escaped quote should work"
    );

    let text2 = text_col.get(1).expect("text2");
    assert_eq!(
        text2.as_str(),
        Some("Normal string"),
        "Normal string should work"
    );
}

#[test]
fn test_insert_select_from_cte() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE cte_target (num INT64)")
        .expect("Failed to create table");

    executor
        .execute_sql(
            "INSERT INTO cte_target
             WITH numbers AS (
                 SELECT 1 as n UNION ALL SELECT 2 UNION ALL SELECT 3
             )
             SELECT n FROM numbers",
        )
        .expect("INSERT from CTE failed");

    let result = executor
        .execute_sql("SELECT COUNT(*) as cnt FROM cte_target")
        .expect("SELECT failed");

    let cnt = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(cnt.as_i64(), Some(3), "Should insert 3 rows from CTE");
}
