#![allow(dead_code)]
#![allow(unused_variables)]

mod common;
use common::*;

fn setup_crew_members(executor: &mut yachtsql::QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS crew_members")
        .unwrap();
    executor
        .execute_sql(
            "CREATE TABLE crew_members (id INT64, name STRING, fleet STRING, salary INT64)",
        )
        .unwrap();
}

fn setup_scores(executor: &mut yachtsql::QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS scores").unwrap();
    executor
        .execute_sql("CREATE TABLE scores (id INT64, student STRING, subject STRING, score INT64)")
        .unwrap();
}

#[test]
fn test_row_number_basic() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 60000),
            (3, 'Charlie', 'Sales', 55000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                ROW_NUMBER() OVER (ORDER BY salary DESC) as rank
            FROM crew_members
            ORDER BY rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_string(&result, 0, 0), "Bob");
    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_string(&result, 0, 1), "Charlie");
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_string(&result, 0, 2), "Alice");
    assert_eq!(get_i64(&result, 2, 2), 3);
}

#[test]
fn test_row_number_with_partition_by() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 60000),
            (3, 'Charlie', 'Engineering', 70000),
            (4, 'David', 'Engineering', 65000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                fleet,
                salary,
                ROW_NUMBER() OVER (PARTITION BY fleet ORDER BY salary DESC) as dept_rank
            FROM crew_members
            ORDER BY fleet, dept_rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Charlie");
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_string(&result, 0, 1), "David");
    assert_eq!(get_i64(&result, 3, 1), 2);
    assert_eq!(get_string(&result, 0, 2), "Bob");
    assert_eq!(get_i64(&result, 3, 2), 1);
    assert_eq!(get_string(&result, 0, 3), "Alice");
    assert_eq!(get_i64(&result, 3, 3), 2);
}

#[test]
fn test_row_number_with_ties() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 50000),
            (3, 'Charlie', 'Sales', 50000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                ROW_NUMBER() OVER (ORDER BY salary) as row_num
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let row_nums: Vec<i64> = (0..3).map(|i| get_i64(&result, 2, i)).collect();
    assert!(row_nums.contains(&1));
    assert!(row_nums.contains(&2));
    assert!(row_nums.contains(&3));
}

#[test]
fn test_row_number_without_order_by() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 60000),
            (3, 'Charlie', 'Sales', 55000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                ROW_NUMBER() OVER () as row_num
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let row_nums: Vec<i64> = (0..3).map(|i| get_i64(&result, 2, i)).collect();
    assert!(row_nums.contains(&1));
    assert!(row_nums.contains(&2));
    assert!(row_nums.contains(&3));
}

#[test]
fn test_row_number_complex_order_by() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 60000),
            (3, 'Charlie', 'Sales', 55000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                fleet,
                salary,
                ROW_NUMBER() OVER (ORDER BY fleet, salary DESC) as row_num
            FROM crew_members
            ORDER BY row_num",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_string(&result, 0, 0), "Bob");
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_string(&result, 0, 1), "Charlie");
    assert_eq!(get_i64(&result, 3, 1), 2);
    assert_eq!(get_string(&result, 0, 2), "Alice");
    assert_eq!(get_i64(&result, 3, 2), 3);
}

#[test]
fn test_rank_basic() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC) as rank
            FROM scores
            ORDER BY rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Alice");
    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_eq!(get_i64(&result, 2, 3), 4);
}

#[test]
fn test_rank_vs_row_number() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
                RANK() OVER (ORDER BY score DESC) as rank
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 3, 1), 2);
    assert_eq!(get_i64(&result, 3, 2), 2);
    assert_eq!(get_i64(&result, 3, 3), 4);
}

#[test]
fn test_rank_with_partition_by() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 90),
            (2, 'Bob', 'Math', 85),
            (3, 'Charlie', 'Science', 95),
            (4, 'David', 'Science', 95)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                subject,
                score,
                RANK() OVER (PARTITION BY subject ORDER BY score DESC) as rank
            FROM scores
            ORDER BY subject, rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_string(&result, 0, 0), "Alice");
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_string(&result, 0, 1), "Bob");
    assert_eq!(get_i64(&result, 3, 1), 2);

    assert_eq!(get_i64(&result, 3, 2), 1);
    assert_eq!(get_i64(&result, 3, 3), 1);
}

#[test]
fn test_rank_all_tied() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 100),
            (3, 'Charlie', 'Math', 100)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC) as rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 1);
    assert_eq!(get_i64(&result, 2, 2), 1);
}

#[test]
fn test_rank_no_ties() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC) as rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_i64(&result, 2, 2), 3);
}

#[test]
fn test_dense_rank_basic() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
            FROM scores
            ORDER BY dense_rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_eq!(get_i64(&result, 2, 3), 3);
}

#[test]
fn test_comparison_row_number_rank_dense_rank() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
                RANK() OVER (ORDER BY score DESC) as rank,
                DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 4, 0), 1);

    assert_eq!(get_i64(&result, 2, 3), 4);
    assert_eq!(get_i64(&result, 3, 3), 4);
    assert_eq!(get_i64(&result, 4, 3), 3);
}

#[test]
fn test_dense_rank_with_partition_by() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Science', 95),
            (5, 'Eve', 'Science', 85)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                subject,
                score,
                DENSE_RANK() OVER (PARTITION BY subject ORDER BY score DESC) as rank
            FROM scores
            ORDER BY subject, rank",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert_eq!(get_string(&result, 0, 0), "Alice");
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 3, 1), 2);
    assert_eq!(get_i64(&result, 3, 2), 2);
    assert_eq!(get_i64(&result, 3, 3), 1);
    assert_eq!(get_i64(&result, 3, 4), 2);
}

#[test]
fn test_dense_rank_multiple_ties() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'A', 'Math', 100),
            (2, 'B', 'Math', 100),
            (3, 'C', 'Math', 90),
            (4, 'D', 'Math', 90),
            (5, 'E', 'Math', 90),
            (6, 'F', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    let dense_ranks: Vec<i64> = (0..6).map(|i| get_i64(&result, 2, i)).collect();
    assert_eq!(dense_ranks.iter().filter(|&&x| x == 1).count(), 2);
    assert_eq!(dense_ranks.iter().filter(|&&x| x == 2).count(), 3);
    assert_eq!(dense_ranks.iter().filter(|&&x| x == 3).count(), 1);
}

#[test]
fn test_percent_rank_basic() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 80),
            (4, 'David', 'Math', 70)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 2, 0), 0.0, 0.0001);
    assert_float_eq(get_f64(&result, 2, 1), 1.0 / 3.0, 0.0001);
    assert_float_eq(get_f64(&result, 2, 2), 2.0 / 3.0, 0.0001);
    assert_float_eq(get_f64(&result, 2, 3), 1.0, 0.0001);
}

#[test]
fn test_percent_rank_with_ties() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC) as rank,
                PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_float_eq(get_f64(&result, 3, 0), 0.0, 0.0001);
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_float_eq(get_f64(&result, 3, 1), 1.0 / 3.0, 0.0001);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_float_eq(get_f64(&result, 3, 2), 1.0 / 3.0, 0.0001);
    assert_eq!(get_i64(&result, 2, 3), 4);
    assert_float_eq(get_f64(&result, 3, 3), 1.0, 0.0001);
}

#[test]
fn test_percent_rank_with_partition_by() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                subject,
                score,
                PERCENT_RANK() OVER (PARTITION BY subject ORDER BY score DESC) as percent_rank
            FROM scores
            ORDER BY subject, score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 3, 0), 0.0, 0.0001);
    assert_float_eq(get_f64(&result, 3, 1), 1.0 / 3.0, 0.0001);
    assert_float_eq(get_f64(&result, 3, 2), 1.0 / 3.0, 0.0001);
    assert_float_eq(get_f64(&result, 3, 3), 1.0, 0.0001);
}

#[test]
fn test_percent_rank_single_row() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql("INSERT INTO scores VALUES (1, 'Alice', 'Math', 100)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                PERCENT_RANK() OVER (ORDER BY score) as percent_rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert_float_eq(get_f64(&result, 2, 0), 0.0, 0.0001);
}

#[test]
fn test_cume_dist_basic() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 80),
            (4, 'David', 'Math', 70)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 2, 0), 0.25, 0.0001);
    assert_float_eq(get_f64(&result, 2, 1), 0.5, 0.0001);
    assert_float_eq(get_f64(&result, 2, 2), 0.75, 0.0001);
    assert_float_eq(get_f64(&result, 2, 3), 1.0, 0.0001);
}

#[test]
fn test_cume_dist_with_ties() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 2, 0), 0.25, 0.0001);
    assert_float_eq(get_f64(&result, 2, 1), 0.75, 0.0001);
    assert_float_eq(get_f64(&result, 2, 2), 0.75, 0.0001);
    assert_float_eq(get_f64(&result, 2, 3), 1.0, 0.0001);
}

#[test]
fn test_cume_dist_vs_percent_rank() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank,
                CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 2, 0), 0.0, 0.0001);
    assert_float_eq(get_f64(&result, 3, 0), 0.25, 0.0001);
    assert_float_eq(get_f64(&result, 2, 1), 1.0 / 3.0, 0.0001);
    assert_float_eq(get_f64(&result, 3, 1), 0.75, 0.0001);
}

#[test]
fn test_cume_dist_with_partition_by() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                subject,
                score,
                CUME_DIST() OVER (PARTITION BY subject ORDER BY score DESC) as cume_dist
            FROM scores
            ORDER BY subject, score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    assert_float_eq(get_f64(&result, 3, 0), 0.25, 0.0001);
    assert_float_eq(get_f64(&result, 3, 1), 0.75, 0.0001);
    assert_float_eq(get_f64(&result, 3, 2), 0.75, 0.0001);
    assert_float_eq(get_f64(&result, 3, 3), 1.0, 0.0001);
}

#[test]
fn test_ntile_quartiles() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 55000),
            (3, 'C', 'Sales', 60000),
            (4, 'D', 'Sales', 65000),
            (5, 'E', 'Sales', 70000),
            (6, 'F', 'Sales', 75000),
            (7, 'G', 'Sales', 80000),
            (8, 'H', 'Sales', 85000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                NTILE(4) OVER (ORDER BY salary) as quartile
            FROM crew_members
            ORDER BY salary",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 8);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 1);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_eq!(get_i64(&result, 2, 3), 2);
    assert_eq!(get_i64(&result, 2, 4), 3);
    assert_eq!(get_i64(&result, 2, 5), 3);
    assert_eq!(get_i64(&result, 2, 6), 4);
    assert_eq!(get_i64(&result, 2, 7), 4);
}

#[test]
fn test_ntile_uneven_distribution() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000),
            (3, 'C', 'Sales', 70000),
            (4, 'D', 'Sales', 80000),
            (5, 'E', 'Sales', 90000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                NTILE(3) OVER (ORDER BY salary) as tercile
            FROM crew_members
            ORDER BY salary",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 1);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_eq!(get_i64(&result, 2, 3), 2);
    assert_eq!(get_i64(&result, 2, 4), 3);
}

#[test]
fn test_ntile_more_buckets_than_rows() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                NTILE(5) OVER (ORDER BY salary) as bucket
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 2);
}

#[test]
fn test_ntile_with_partition_by() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000),
            (3, 'C', 'Sales', 70000),
            (4, 'D', 'Engineering', 80000),
            (5, 'E', 'Engineering', 90000),
            (6, 'F', 'Engineering', 100000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                fleet,
                salary,
                NTILE(2) OVER (PARTITION BY fleet ORDER BY salary) as half
            FROM crew_members
            ORDER BY fleet, salary",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 3, 1), 1);
    assert_eq!(get_i64(&result, 3, 2), 2);

    assert_eq!(get_i64(&result, 3, 3), 1);
    assert_eq!(get_i64(&result, 3, 4), 1);
    assert_eq!(get_i64(&result, 3, 5), 2);
}

#[test]
fn test_ntile_percentile_groups() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000),
            (3, 'C', 'Sales', 70000),
            (4, 'D', 'Engineering', 80000),
            (5, 'E', 'Engineering', 90000),
            (6, 'F', 'Engineering', 100000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                NTILE(100) OVER (ORDER BY salary) as percentile
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_i64(&result, 2, 2), 3);
    assert_eq!(get_i64(&result, 2, 3), 4);
    assert_eq!(get_i64(&result, 2, 4), 5);
    assert_eq!(get_i64(&result, 2, 5), 6);
}

#[test]
fn test_ntile_single_bucket() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000),
            (3, 'C', 'Sales', 70000),
            (4, 'D', 'Engineering', 80000),
            (5, 'E', 'Engineering', 90000),
            (6, 'F', 'Engineering', 100000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                NTILE(1) OVER (ORDER BY salary) as single_bucket
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    for i in 0..6 {
        assert_eq!(get_i64(&result, 2, i), 1);
    }
}

#[test]
fn test_multiple_ranking_functions_together() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80),
            (5, 'Eve', 'Math', 80),
            (6, 'Frank', 'Math', 70)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
                RANK() OVER (ORDER BY score DESC) as rank,
                DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank,
                PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank,
                CUME_DIST() OVER (ORDER BY score DESC) as cume_dist,
                NTILE(3) OVER (ORDER BY score DESC) as tercile
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 4, 0), 1);
    assert_float_eq(get_f64(&result, 5, 0), 0.0, 0.0001);
    assert_float_eq(get_f64(&result, 6, 0), 1.0 / 6.0, 0.0001);

    assert_eq!(get_i64(&result, 2, 5), 6);
    assert_eq!(get_i64(&result, 3, 5), 6);
    assert_eq!(get_i64(&result, 4, 5), 4);
    assert_float_eq(get_f64(&result, 5, 5), 1.0, 0.0001);
    assert_float_eq(get_f64(&result, 6, 5), 1.0, 0.0001);
}

#[test]
fn test_ranking_multiple_order_by_columns() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'A', 'Sales', 50000),
            (2, 'B', 'Sales', 60000),
            (3, 'C', 'Sales', 70000),
            (4, 'D', 'Engineering', 80000),
            (5, 'E', 'Engineering', 90000),
            (6, 'F', 'Engineering', 100000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                fleet,
                salary,
                RANK() OVER (ORDER BY fleet, salary DESC) as rank
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);
}

#[test]
fn test_ranking_desc_and_asc_mixed() {
    let mut executor = setup_executor();
    setup_crew_members(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 'Sales', 50000),
            (2, 'Bob', 'Sales', 50000),
            (3, 'Charlie', 'Sales', 60000)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                name,
                salary,
                RANK() OVER (ORDER BY salary DESC, name ASC) as rank
            FROM crew_members",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_ranking_gaps_analysis() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', 90),
            (3, 'Charlie', 'Math', 90),
            (4, 'David', 'Math', 80),
            (5, 'Eve', 'Math', 80),
            (6, 'Frank', 'Math', 70)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC) as rank,
                DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
            FROM scores
            ORDER BY score DESC",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 6);

    assert_eq!(get_string(&result, 0, 0), "Alice");
    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 3, 0), 1);

    assert_eq!(get_i64(&result, 2, 1), 2);
    assert_eq!(get_i64(&result, 3, 1), 2);
    assert_eq!(get_i64(&result, 2, 2), 2);
    assert_eq!(get_i64(&result, 3, 2), 2);

    assert_eq!(get_i64(&result, 2, 3), 4);
    assert_eq!(get_i64(&result, 3, 3), 3);
    assert_eq!(get_i64(&result, 2, 4), 4);
    assert_eq!(get_i64(&result, 3, 4), 3);

    assert_eq!(get_string(&result, 0, 5), "Frank");
    assert_eq!(get_i64(&result, 2, 5), 6);
    assert_eq!(get_i64(&result, 3, 5), 4);
}

#[test]
fn test_ranking_empty_table() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score) as rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ranking_single_row() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql("INSERT INTO scores VALUES (1, 'Alice', 'Math', 100)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                ROW_NUMBER() OVER (ORDER BY score) as row_num,
                RANK() OVER (ORDER BY score) as rank,
                DENSE_RANK() OVER (ORDER BY score) as dense_rank,
                PERCENT_RANK() OVER (ORDER BY score) as percent_rank,
                CUME_DIST() OVER (ORDER BY score) as cume_dist
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(get_i64(&result, 2, 0), 1);
    assert_eq!(get_i64(&result, 3, 0), 1);
    assert_eq!(get_i64(&result, 4, 0), 1);
    assert_float_eq(get_f64(&result, 5, 0), 0.0, 0.0001);
    assert_float_eq(get_f64(&result, 6, 0), 1.0, 0.0001);
}

#[test]
fn test_ranking_all_rows_identical() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'A', 'Math', 100),
            (2, 'B', 'Math', 100),
            (3, 'C', 'Math', 100)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score) as rank,
                DENSE_RANK() OVER (ORDER BY score) as dense_rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        assert_eq!(get_i64(&result, 2, i), 1);
        assert_eq!(get_i64(&result, 3, i), 1);
    }
}

#[test]
fn test_ranking_null_values_in_order_by() {
    let mut executor = setup_executor();
    setup_scores(&mut executor);

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            (1, 'Alice', 'Math', 100),
            (2, 'Bob', 'Math', NULL),
            (3, 'Charlie', 'Math', 90)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT
                student,
                score,
                RANK() OVER (ORDER BY score DESC NULLS LAST) as rank
            FROM scores",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    for i in 0..3 {
        let student = get_string(&result, 0, i);
        let rank = get_i64(&result, 2, i);
        match student.as_str() {
            "Alice" => assert_eq!(rank, 1),
            "Charlie" => assert_eq!(rank, 2),
            "Bob" => assert_eq!(rank, 3),
            _ => panic!("Unexpected student: {}", student),
        }
    }
}
