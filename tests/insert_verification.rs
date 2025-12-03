use yachtsql_executor::QueryExecutor;

#[test]
fn test_insert_single_row() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .expect("Failed to create table");

    let result = executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
        .expect("INSERT failed");

    println!("INSERT result: {:?}", result);

    let select_result = executor
        .execute_sql("SELECT * FROM users")
        .expect("SELECT failed");

    assert_eq!(select_result.num_rows(), 1, "Expected 1 row");
    println!("SELECT result: {:?}", select_result);
}

#[test]
fn test_insert_multi_row() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .expect("Failed to create table");

    let result = executor
        .execute_sql("INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie')")
        .expect("INSERT failed");

    println!("INSERT result: {:?}", result);

    let select_result = executor
        .execute_sql("SELECT * FROM users")
        .expect("SELECT failed");

    assert_eq!(select_result.num_rows(), 3, "Expected 3 rows");
    println!("SELECT result: {:?}", select_result);
}

#[test]
fn test_insert_select() {
    let mut executor = QueryExecutor::new();

    executor
        .execute_sql("CREATE TABLE source (id INT64, name STRING)")
        .expect("Failed to create source table");

    executor
        .execute_sql("INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob')")
        .expect("Failed to insert into source");

    executor
        .execute_sql("CREATE TABLE target (id INT64, name STRING)")
        .expect("Failed to create target table");

    let result = executor
        .execute_sql("INSERT INTO target SELECT * FROM source")
        .expect("INSERT SELECT failed");

    println!("INSERT SELECT result: {:?}", result);

    let select_result = executor
        .execute_sql("SELECT * FROM target")
        .expect("SELECT failed");

    assert_eq!(select_result.num_rows(), 2, "Expected 2 rows");
    println!("SELECT result: {:?}", select_result);
}
