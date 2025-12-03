use yachtsql_executor::QueryExecutor;

#[test]
fn test_explain_basic_select() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25)")
        .unwrap();

    let result = executor
        .execute_sql("EXPLAIN SELECT * FROM users WHERE age > 25")
        .unwrap();

    assert!(result.num_rows() > 0, "EXPLAIN should return plan rows");

    assert_eq!(result.num_columns(), 1, "EXPLAIN should return one column");

    if let Ok(rows) = result.rows() {
        println!("\nQuery Plan:");
        for row in rows {
            for value in row.values() {
                println!("{}", value);
            }
        }
    }
}

#[test]
fn test_explain_verbose() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE test (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("EXPLAIN VERBOSE SELECT id FROM test WHERE value > 100")
        .unwrap();

    assert!(result.num_rows() > 0);
}

#[test]
fn test_explain_analyze() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64)")
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35)",
        )
        .unwrap();

    let result = executor
        .execute_sql("EXPLAIN ANALYZE SELECT * FROM users WHERE age > 25")
        .unwrap();

    assert!(
        result.num_rows() > 0,
        "EXPLAIN ANALYZE should return plan rows"
    );

    if let Ok(rows) = result.rows() {
        println!("\nEXPLAIN ANALYZE output:");
        for row in rows {
            for value in row.values() {
                println!("{}", value);
            }
        }
    }
}
