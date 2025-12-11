use crate::assert_table_eq;
use crate::common::create_executor;

#[test]
fn test_aggregating_basic() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_source (
                id INT64,
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_basic
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                sumState(value) AS total
            FROM amt_source
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_source VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT category, sumMerge(total) FROM amt_basic GROUP BY category ORDER BY category",
        )
        .unwrap();
    assert_table_eq!(result, [["A", 30], ["B", 30]]);
}

#[test]
fn test_aggregating_count_state() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_count_src (
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_count
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                countState() AS cnt
            FROM amt_count_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_count_src VALUES ('A', 1), ('A', 2), ('B', 3)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT category, countMerge(cnt) FROM amt_count GROUP BY category ORDER BY category",
        )
        .unwrap();
    assert_table_eq!(result, [["A", 2], ["B", 1]]);
}

#[test]
fn test_aggregating_avg_state() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_avg_src (
                category String,
                score INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_avg
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                avgState(score) AS avg_score
            FROM amt_avg_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_avg_src VALUES ('A', 80), ('A', 90), ('B', 70)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT category, avgMerge(avg_score) FROM amt_avg GROUP BY category ORDER BY category",
        )
        .unwrap();
    assert_table_eq!(result, [["A", 85.0], ["B", 70.0]]);
}

#[test]
fn test_aggregating_multiple_states() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_multi_src (
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_multi
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                sumState(value) AS total,
                countState() AS cnt,
                avgState(value) AS avg_val
            FROM amt_multi_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_multi_src VALUES ('A', 10), ('A', 20), ('B', 30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT category, sumMerge(total), countMerge(cnt), avgMerge(avg_val) FROM amt_multi GROUP BY category ORDER BY category")
        .unwrap();
    assert!(result.num_rows() == 2); // TODO: use table![[expected_values]]
}

#[test]
fn test_aggregating_with_partition() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_part_src (
                region String,
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_part
            ENGINE = AggregatingMergeTree
            ORDER BY (region, category)
            AS SELECT
                region,
                category,
                sumState(value) AS total
            FROM amt_part_src
            GROUP BY region, category",
        )
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO amt_part_src VALUES ('US', 'A', 100), ('US', 'A', 50), ('EU', 'B', 200)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT region, category, sumMerge(total) FROM amt_part GROUP BY region, category ORDER BY region, category")
        .unwrap();
    assert_table_eq!(result, [["EU", "B", 200.0], ["US", "A", 150.0]]);
}

#[test]
fn test_aggregating_uniq_state() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_uniq_src (
                category String,
                user_id INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_uniq
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                uniqState(user_id) AS unique_users
            FROM amt_uniq_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_uniq_src VALUES ('A', 1), ('A', 2), ('A', 1), ('B', 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT category, uniqMerge(unique_users) FROM amt_uniq GROUP BY category ORDER BY category")
        .unwrap();
    assert!(result.num_rows() == 2); // TODO: use table![[expected_values]]
}

#[test]
fn test_aggregating_min_max_state() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_minmax_src (
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_minmax
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                minState(value) AS min_val,
                maxState(value) AS max_val
            FROM amt_minmax_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_minmax_src VALUES ('A', 10), ('A', 50), ('A', 30)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT category, minMerge(min_val), maxMerge(max_val) FROM amt_minmax GROUP BY category")
        .unwrap();
    assert_table_eq!(result, [["A", 10, 50]]);
}

#[test]
fn test_aggregating_direct_table() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_direct_src (
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_direct
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                sumState(value) AS total,
                countState() AS cnt
            FROM amt_direct_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_direct_src VALUES ('A', 0), ('A', 1), ('A', 2), ('A', 3), ('A', 4), ('A', 5), ('A', 6), ('A', 7), ('A', 8), ('A', 9)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT category, sumMerge(total), countMerge(cnt) FROM amt_direct GROUP BY category",
        )
        .unwrap();
    assert_table_eq!(result, [["A", 45.0, 10]]);
}

#[test]
fn test_aggregating_batch_insert() {
    let mut executor = create_executor();
    executor
        .execute_sql(
            "CREATE TABLE amt_batch_src (
                category String,
                value INT64
            )",
        )
        .unwrap();
    executor
        .execute_sql(
            "CREATE MATERIALIZED VIEW amt_batch
            ENGINE = AggregatingMergeTree
            ORDER BY category
            AS SELECT
                category,
                sumState(value) AS total
            FROM amt_batch_src
            GROUP BY category",
        )
        .unwrap();
    executor
        .execute_sql("INSERT INTO amt_batch_src VALUES ('A', 10), ('A', 20), ('B', 15)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT category, sumMerge(total) FROM amt_batch GROUP BY category ORDER BY category",
        )
        .unwrap();
    assert_table_eq!(result, [["A", 30.0], ["B", 15.0]]);
}
