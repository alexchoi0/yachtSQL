use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_simple_multi_column() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    let result = executor
        .execute_sql(
            "WITH RECURSIVE nums AS (
                SELECT 1 AS a, 2 AS b
                UNION ALL
                SELECT a + 1, b + 1
                FROM nums
                WHERE a < 5
            )
            SELECT * FROM nums ORDER BY a",
        )
        .expect("recursive CTE");

    println!("Rows returned: {}", result.num_rows());
    for i in 0..result.num_rows() {
        let col_a = result.column(0).unwrap().get(i).unwrap();
        let col_b = result.column(1).unwrap().get(i).unwrap();
        println!("Row {}: a={:?}, b={:?}", i, col_a, col_b);
    }

    assert_eq!(result.num_rows(), 5, "Expected 5 rows");
}
