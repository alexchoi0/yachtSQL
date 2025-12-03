-- Window GROUPS Frame - SQL:2023 Compliance Suite
-- Description: Extracted SQL for Feature F443 covering GROUPS frame semantics
-- PostgreSQL: Pending window GROUPS support
-- BigQuery: Pending window GROUPS support
-- SQL Standard: SQL:2023 Feature F443
-- Notes: SQL:2023 core (normalize output for PostgreSQL / BigQuery)

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_basic_peer_detection
-- **Baseline Case:** GROUPS frame with simple peer groups
-- **Scenario:** Values 1, 1, 2, 2, 3 → 3 peer groups

CREATE TABLE sales (id INT64, amount INT64);

INSERT INTO sales VALUES
        (1, 100),
        (2, 100),  -- Peer with row 1
        (3, 200),
        (4, 200),  -- Peer with row 3
        (5, 300);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_001
SELECT
            id,
            amount,
            SUM(amount) OVER (
                ORDER BY amount
                GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW
            ) AS sum_current_and_prev_group
         FROM sales
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_vs_rows_frame_difference
-- **Comparison Case:** Same query with GROUPS vs ROWS to show difference
-- **Important:** Demonstrates why GROUPS exists (handles peer groups atomically)

CREATE TABLE data (id INT64, val INT64);

INSERT INTO data VALUES
        (1, 10),
        (2, 10),  -- Peer
        (3, 20),
        (4, 30);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_002
SELECT
            id, val,
            SUM(val) OVER (ORDER BY val ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS sum_rows
         FROM data ORDER BY id;

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_003
SELECT
            id, val,
            SUM(val) OVER (ORDER BY val GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW) AS sum_groups
         FROM data ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_nulls_first
-- **Edge Case:** NULL values form their own peer group with NULLS FIRST
-- **SQL:2023:** NULLs are peers with each other, ordered first

CREATE TABLE nullable (id INT64, val INT64);

INSERT INTO nullable VALUES
        (1, NULL),
        (2, NULL),  -- Peer with row 1 (both NULL)
        (3, 10),
        (4, 20);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_004
SELECT
            id,
            val,
            COUNT(*) OVER (
                ORDER BY val NULLS FIRST
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS count_up_to_current_group
         FROM nullable
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_nulls_last
-- **Edge Case:** NULL values form peer group at end with NULLS LAST

CREATE TABLE nullable (id INT64, val INT64);

INSERT INTO nullable VALUES
        (1, 10),
        (2, 20),
        (3, NULL),
        (4, NULL)  -- Peer with row 3;

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_005
SELECT
            id,
            val,
            COUNT(*) OVER (
                ORDER BY val NULLS LAST
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS count_up_to_current_group
         FROM nullable
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_nulls_and_duplicate_values
-- **Complex Case:** NULLs + duplicate values → multiple peer groups
-- **Challenge:** Peer group boundaries must be precise

CREATE TABLE mixed (id INT64, score INT64);

INSERT INTO mixed VALUES
        (1, NULL),
        (2, 10),
        (3, 10),   -- Peer with row 2
        (4, NULL), -- Peer with row 1 (if NULLS FIRST)
        (5, 20);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_006
SELECT
            id,
            score,
            SUM(id) OVER (
                ORDER BY score NULLS FIRST
                GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING
            ) AS sum_current_and_next_group
         FROM mixed
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_unbounded_preceding
-- **Baseline Case:** UNBOUNDED PRECEDING for GROUPS frame

CREATE TABLE amounts (id INT64, val INT64);

INSERT INTO amounts VALUES
        (1, 5),
        (2, 5),
        (3, 10),
        (4, 20),
        (5, 20);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_007
SELECT
            id, val,
            SUM(val) OVER (
                ORDER BY val
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS sum_all_previous_groups
         FROM amounts
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_unbounded_following
-- **Baseline Case:** UNBOUNDED FOLLOWING for GROUPS frame

CREATE TABLE amounts (id INT64, val INT64);

INSERT INTO amounts VALUES
        (1, 10),
        (2, 10),
        (3, 20),
        (4, 30);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_008
SELECT
            id, val,
            SUM(val) OVER (
                ORDER BY val
                GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
            ) AS sum_current_and_future_groups
         FROM amounts
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_n_preceding_offset
-- **Edge Case:** Offset with GROUPS PRECEDING

CREATE TABLE offsets (id INT64, val INT64);

INSERT INTO offsets VALUES
        (1, 100),
        (2, 200),
        (3, 200),
        (4, 300),
        (5, 400);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_009
SELECT
            id, val,
            SUM(val) OVER (
                ORDER BY val
                GROUPS BETWEEN 2 PRECEDING AND CURRENT ROW
            ) AS sum_two_groups_back
         FROM offsets
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_n_following_offset
-- **Edge Case:** Offset with GROUPS FOLLOWING

CREATE TABLE offsets (id INT64, val INT64);

INSERT INTO offsets VALUES
        (1, 10),
        (2, 20),
        (3, 30),
        (4, 30),
        (5, 40);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_010
SELECT
            id, val,
            SUM(val) OVER (
                ORDER BY val
                GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING
            ) AS sum_next_group
         FROM offsets
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_exclude_current_row
-- **Integration:** GROUPS frame with EXCLUDE CURRENT ROW

CREATE TABLE sales (id INT64, amount INT64);

INSERT INTO sales VALUES
        (1, 100),
        (2, 100),
        (3, 200),
        (4, 200);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_011
SELECT
            id, amount,
            SUM(amount) OVER (
                ORDER BY amount
                GROUPS BETWEEN CURRENT ROW AND CURRENT ROW
                EXCLUDE CURRENT ROW
            ) AS sum_peers_excluding_self
         FROM sales
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_exclude_group
-- **Integration:** GROUPS frame with EXCLUDE GROUP

CREATE TABLE sales (id INT64, amount INT64);

INSERT INTO sales VALUES
        (1, 50),
        (2, 50),
        (3, 100),
        (4, 100),
        (5, 150);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_012
SELECT
            id, amount,
            SUM(amount) OVER (
                ORDER BY amount
                GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                EXCLUDE GROUP
            ) AS sum_all_other_groups
         FROM sales
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_exclude_ties
-- **Integration:** GROUPS frame with EXCLUDE TIES

CREATE TABLE sales (id INT64, amount INT64);

INSERT INTO sales VALUES
        (1, 5),
        (2, 5),
        (3, 10),
        (4, 10),
        (5, 15);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_013
SELECT
            id, amount,
            SUM(amount) OVER (
                ORDER BY amount
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                EXCLUDE TIES
            ) AS sum_excluding_peers
         FROM sales
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_single_peer_group
-- **Boundary Case:** All rows belong to one peer group

CREATE TABLE same_values (id INT64, val INT64);

INSERT INTO same_values VALUES
        (1, 100),
        (2, 100),
        (3, 100);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_014
SELECT
            id, val,
            COUNT(*) OVER (
                ORDER BY val
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS count_all_rows
         FROM same_values
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_all_distinct_groups
-- **Boundary Case:** Every row is its own peer group

CREATE TABLE distinct_vals (id INT64, val INT64);

INSERT INTO distinct_vals VALUES
        (1, 5),
        (2, 10),
        (3, 15),
        (4, 20);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_015
SELECT
            id, val,
            SUM(val) OVER (
                ORDER BY val
                GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING
            ) AS sum_3_groups
         FROM distinct_vals
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_empty_partition
-- **Boundary Case:** Partition with no rows (after PARTITION BY filtering)

CREATE TABLE partitioned (dept STRING, id INT64, val INT64);

INSERT INTO partitioned VALUES
        ('Sales', 1, 100),
        ('Sales', 2, 200)
        -- Engineering dept has no rows;

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_016
SELECT
            dept, id,
            SUM(val) OVER (
                PARTITION BY dept
                ORDER BY val
                GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS dept_sum
         FROM partitioned
         WHERE dept = 'Engineering'  -- Filters to empty set
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_multi_column_order
-- **Complex Case:** ORDER BY with 2+ columns affects peer group definition
-- **Peer Rule:** Rows are peers only if ALL ORDER BY columns match

CREATE TABLE multi_order (id INT64, col1 INT64, col2 INT64);

INSERT INTO multi_order VALUES
        (1, 10, 100),
        (2, 10, 100),  -- Peer with row 1 (both columns match)
        (3, 10, 200),  -- Not peer (col2 differs)
        (4, 20, 100)   -- Not peer (col1 differs);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_017
SELECT
            id, col1, col2,
            COUNT(*) OVER (
                ORDER BY col1, col2
                GROUPS BETWEEN CURRENT ROW AND CURRENT ROW
            ) AS peer_count
         FROM multi_order
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_with_row_number
-- **Integration:** GROUPS frame with ROW_NUMBER() function
-- **Note:** Ranking functions don't use frames, but can coexist

CREATE TABLE ranked (id INT64, score INT64);

INSERT INTO ranked VALUES
        (1, 100),
        (2, 100),
        (3, 200);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_018
SELECT
            id, score,
            ROW_NUMBER() OVER (ORDER BY score) AS row_num,
            SUM(id) OVER (ORDER BY score GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_groups
         FROM ranked
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_requires_order_by
-- **Error Condition:** GROUPS frame requires ORDER BY (like RANGE)
-- NOTE: Expected to fail because GROUPS frame without ORDER BY is invalid.

CREATE TABLE data (val INT64);

INSERT INTO data VALUES (1), (2);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_001
SELECT val, SUM(val) OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM data;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_negative_offset_error
-- **Error Condition:** Negative offset in GROUPS frame
-- NOTE: Expected to raise error for negative GROUPS offset.

CREATE TABLE data (val INT64);

INSERT INTO data VALUES (1);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_002
SELECT val, SUM(val) OVER (ORDER BY val GROUPS BETWEEN -1 PRECEDING AND CURRENT ROW) FROM data;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_large_peer_group_performance
-- **Performance Case:** Single peer group with 10,000 rows
-- **Challenge:** Frame calculation must handle large groups efficiently
-- NOTE: Data inserted via Rust loop (10k rows) to stress peer group handling.

CREATE TABLE large_group (id INT64, val INT64);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_019
SELECT
            SUM(id) OVER (ORDER BY val GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_group
         FROM large_group
         LIMIT 1;

-- ---------------------------------------------------------------------------
-- Source ID: test_groups_frame_many_small_groups_performance
-- **Performance Case:** 10,000 distinct values → 10,000 peer groups
-- **Challenge:** Peer group boundary calculation must be efficient
-- NOTE: Data inserted via Rust loop (10k peer groups) to stress planner.

CREATE TABLE many_groups (id INT64, val INT64);

-- Tag: window_functions_window_groups_frame_comprehensive_test_select_020
SELECT
            COUNT(*) OVER (ORDER BY val GROUPS BETWEEN 10 PRECEDING AND 10 FOLLOWING) AS window_count
         FROM many_groups
         LIMIT 1;
