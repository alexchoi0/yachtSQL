use yachtsql::QueryExecutor;

#[test]
fn test_basic_select() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64, name STRING)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO test VALUES (1, 'Alice'), (2, 'Bob')")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();

    println!("Rows without WHERE: {}", result.num_rows());
    assert_eq!(result.num_rows(), 2);

    let result2 = executor
        .execute_sql("SELECT * FROM test WHERE id = 1")
        .unwrap();

    println!("Rows with WHERE: {}", result2.num_rows());
    assert_eq!(result2.num_rows(), 1);
}
