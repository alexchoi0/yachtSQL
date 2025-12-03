#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_not_equal_operator() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE t (id INT64, a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (1, 10, 20)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (2, 30, 30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM t WHERE a <> b ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 1, "Should find 1 row where a <> b");
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    assert_eq!(
        val.as_i64().unwrap(),
        1,
        "Row with id=1 should match where 10 <> 20"
    );
}

#[test]
fn test_not_equal_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE t (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (1, 10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t VALUES (2, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM t WHERE val <> 10 ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 0, "NULL <> value should not match");
}
