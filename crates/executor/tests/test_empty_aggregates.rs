use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_count_on_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE empty_table (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COUNT(*) FROM empty_table")
        .unwrap();

    assert_eq!(result.num_rows(), 1, "Should return one row with count");

    let rows = result.rows().unwrap();
    let count_value = &rows[0].values()[0];

    if let Some(count) = count_value.as_i64() {
        assert_eq!(count, 0, "COUNT(*) on empty table should be 0");
    } else {
        panic!("COUNT should return an integer, got: {:?}", count_value);
    }
}

#[test]
fn test_sum_on_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE empty_table (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SUM(value) FROM empty_table")
        .unwrap();

    assert_eq!(result.num_rows(), 1, "Should return one row");

    let rows = result.rows().unwrap();
    let sum_value = &rows[0].values()[0];

    assert!(
        sum_value.is_null(),
        "SUM on empty table should be NULL, got: {:?}",
        sum_value
    );
}

#[test]
fn test_avg_on_empty_table() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE empty_table (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT AVG(value) FROM empty_table")
        .unwrap();

    assert_eq!(result.num_rows(), 1, "Should return one row");

    let rows = result.rows().unwrap();
    let avg_value = &rows[0].values()[0];

    assert!(
        avg_value.is_null(),
        "AVG on empty table should be NULL, got: {:?}",
        avg_value
    );
}

#[test]
fn test_empty_result_set() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE empty (id INT64, value STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM empty").unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_empty_result_with_where() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (2, 20)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE value > 1000")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_all_rows_match_filter() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (20)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE value > 0")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_single_row_operations() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE single (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO single VALUES (1, 'only')")
        .unwrap();

    let select = executor.execute_sql("SELECT * FROM single").unwrap();
    assert_eq!(select.num_rows(), 1);

    let count = executor.execute_sql("SELECT COUNT(*) FROM single").unwrap();
    assert_eq!(count.num_rows(), 1);

    let group_by = executor
        .execute_sql("SELECT value, COUNT(*) FROM single GROUP BY value")
        .unwrap();
    assert_eq!(group_by.num_rows(), 1);
}
