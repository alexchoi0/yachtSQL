-- Window Frames - SQL:2023
-- Description: Window frame specifications
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT64,
    day INT64,
    amount INT64,
    region STRING
);

DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (
    ts TIMESTAMP,
    value FLOAT64,
    sensor STRING
);

DROP TABLE IF EXISTS events;
CREATE TABLE events (
    event_id INT64,
    event_date DATE,
    score INT64
);

-- ----------------------------------------------------------------------------
-- ROWS Frame Specification
-- ----------------------------------------------------------------------------

-- ROWS BETWEEN - Physical row-based window
-- SQL:2023 Part 2, Section 7.14
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 2, 150, 'East'),
    (3, 3, 200, 'East'),
    (4, 4, 180, 'East'),
    (5, 5, 220, 'East');

-- Fixed window: 2 rows before to 2 rows after (5 total)
-- Tag: window_functions_window_frames_test_select_001
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) as rolling_sum_5
FROM sales
ORDER BY day;
-- Day 1: sum of days 1-3 (3 rows)
-- Day 2: sum of days 1-4 (4 rows)
-- Day 3: sum of days 1-5 (5 rows) - full window
-- Day 4: sum of days 2-5 (4 rows)
-- Day 5: sum of days 3-5 (3 rows)

-- Fixed window: 2 rows before to current (3 total)
-- Tag: window_functions_window_frames_test_select_002
SELECT
    day,
    amount,
    AVG(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as rolling_avg_3
FROM sales
ORDER BY day;
-- Day 1: avg of day 1 (1 row)
-- Day 2: avg of days 1-2 (2 rows)
-- Day 3: avg of days 1-3 (3 rows) - full window
-- Day 4: avg of days 2-4 (3 rows)
-- Day 5: avg of days 3-5 (3 rows)

-- ROWS UNBOUNDED PRECEDING - from start to current
-- Tag: window_functions_window_frames_test_select_003
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_sum
FROM sales
ORDER BY day;
-- Running total from beginning

-- ROWS UNBOUNDED FOLLOWING - current to end
-- Tag: window_functions_window_frames_test_select_004
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) as remaining_sum
FROM sales
ORDER BY day;
-- Sum from current row to end

-- ROWS full frame - all rows in partition
-- Tag: window_functions_window_frames_test_select_005
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as total_sum
FROM sales
ORDER BY day;
-- All rows show same total (sum of all rows)

-- ROWS with offset values
-- Tag: window_functions_window_frames_test_select_006
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as rolling_sum_3,
    MIN(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ) as min_last_4,
    MAX(amount) OVER (
        ORDER BY day
        ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING
    ) as max_next_4
FROM sales
ORDER BY day;

-- ----------------------------------------------------------------------------
-- RANGE Frame Specification
-- ----------------------------------------------------------------------------

-- RANGE BETWEEN - Logical value-based window
-- SQL:2023 Part 2, Section 7.14
-- All rows with ORDER BY values in specified range

DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 1, 150, 'East'),  -- Same day as row 1
    (3, 2, 200, 'East'),
    (4, 3, 180, 'East'),
    (5, 3, 220, 'East');  -- Same day as row 4

-- RANGE with numeric offset
-- Tag: window_functions_window_frames_test_select_007
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as range_sum
FROM sales
ORDER BY id;
-- Includes all rows where day is within ±1 of current row's day
-- Rows with same day value are all included together

-- RANGE UNBOUNDED PRECEDING - all rows with value <= current
-- Tag: window_functions_window_frames_test_select_008
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_by_value
FROM sales
ORDER BY id;
-- All rows with same ORDER BY value get same cumulative sum

-- RANGE vs ROWS comparison with ties
-- Tag: window_functions_window_frames_test_select_009
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as rows_cumsum,
    SUM(amount) OVER (
        ORDER BY day
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as range_cumsum
FROM sales
ORDER BY id;
-- ROWS: each row gets different sum based on position
-- RANGE: rows with same day get same sum (includes all ties)

-- RANGE with interval (for DATE/TIMESTAMP)
DELETE FROM events;
INSERT INTO events VALUES
    (1, DATE '2024-01-01', 100),
    (2, DATE '2024-01-02', 150),
    (3, DATE '2024-01-03', 200),
    (4, DATE '2024-01-05', 180),
    (5, DATE '2024-01-06', 220);

-- Tag: window_functions_window_frames_test_select_010
SELECT
    event_date,
    score,
    SUM(score) OVER (
        ORDER BY event_date
        RANGE BETWEEN INTERVAL '2' DAY PRECEDING AND CURRENT ROW
    ) as sum_last_3_days
FROM events
ORDER BY event_date;
-- Includes all rows within 2 days before current row's date

-- ----------------------------------------------------------------------------
-- GROUPS Frame Specification (SQL:2016)
-- ----------------------------------------------------------------------------

-- GROUPS BETWEEN - Peer group-based window
-- SQL:2023 Part 2, Section 7.14 - Feature T618
-- Groups rows with same ORDER BY value as single unit

DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 1, 150, 'East'),  -- Group 1 (day=1): 2 rows
    (3, 2, 200, 'East'),  -- Group 2 (day=2): 1 row
    (4, 3, 180, 'East'),
    (5, 3, 220, 'East'),
    (6, 3, 250, 'East');  -- Group 3 (day=3): 3 rows

-- GROUPS: 1 group before to 1 group after
-- Tag: window_functions_window_frames_test_select_011
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as group_sum
FROM sales
ORDER BY id;
-- Day 1 rows: sum of groups for day 1 and day 2
-- Day 2 row: sum of groups for day 1, 2, and 3
-- Day 3 rows: sum of groups for day 2 and day 3

-- GROUPS vs ROWS vs RANGE
-- Tag: window_functions_window_frames_test_select_012
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as rows_sum,
    SUM(amount) OVER (
        ORDER BY day
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as range_sum,
    SUM(amount) OVER (
        ORDER BY day
        GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) as groups_sum
FROM sales
ORDER BY id;
-- ROWS: physical rows (±1 row)
-- RANGE: all rows with day <= current day
-- GROUPS: previous peer group + current peer group

-- ----------------------------------------------------------------------------
-- Frame Boundaries and Special Cases
-- ----------------------------------------------------------------------------

-- CURRENT ROW only
-- Tag: window_functions_window_frames_test_select_013
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN CURRENT ROW AND CURRENT ROW
    ) as just_current
FROM sales
ORDER BY day;
-- Each row sums only itself (same as amount column)

-- N PRECEDING only (from N rows back to current)
-- Tag: window_functions_window_frames_test_select_014
SELECT
    day,
    amount,
    AVG(amount) OVER (
        ORDER BY day
        ROWS 3 PRECEDING  -- Shorthand for BETWEEN 3 PRECEDING AND CURRENT ROW
    ) as ma_4
FROM sales
ORDER BY day;
-- 4-period moving average

-- N FOLLOWING only (from current to N rows ahead)
-- Tag: window_functions_window_frames_test_select_015
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING
    ) as sum_next_4
FROM sales
ORDER BY day;

-- Asymmetric windows
-- Tag: window_functions_window_frames_test_select_016
SELECT
    day,
    amount,
    AVG(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 3 PRECEDING AND 1 FOLLOWING
    ) as asymmetric_avg
FROM sales
ORDER BY day;
-- 5-row window: 3 before, current, 1 after

-- ----------------------------------------------------------------------------
-- Frame Exclusions (SQL:2016)
-- ----------------------------------------------------------------------------

-- EXCLUDE CURRENT ROW - exclude current row from frame
-- SQL:2023 Part 2, Section 7.14
-- Tag: window_functions_window_frames_test_select_017
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
        EXCLUDE CURRENT ROW
    ) as sum_excluding_current
FROM sales
ORDER BY day;
-- 5-row window minus current row = sum of 4 surrounding rows

-- EXCLUDE GROUP - exclude entire peer group (rows with same ORDER BY value)
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 1, 150, 'East'),
    (3, 2, 200, 'East'),
    (4, 3, 180, 'East'),
    (5, 3, 220, 'East');

-- Tag: window_functions_window_frames_test_select_018
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        EXCLUDE GROUP
    ) as sum_excluding_peers
FROM sales
ORDER BY id;
-- For day=1 rows: sum excludes both rows with day=1
-- For day=2 row: sum excludes the row with day=2
-- For day=3 rows: sum excludes both rows with day=3

-- EXCLUDE TIES - exclude peers but keep current row
-- Tag: window_functions_window_frames_test_select_019
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        EXCLUDE TIES
    ) as sum_excluding_ties
FROM sales
ORDER BY id;
-- Keeps current row, excludes other rows with same ORDER BY value

-- EXCLUDE NO OTHERS - explicit default (include all)
-- Tag: window_functions_window_frames_test_select_020
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
        EXCLUDE NO OTHERS
    ) as normal_sum
FROM sales
ORDER BY day;

-- ----------------------------------------------------------------------------
-- PARTITION BY with Frames
-- ----------------------------------------------------------------------------

-- Frames within partitions
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 2, 150, 'East'),
    (3, 3, 200, 'East'),
    (4, 1, 80, 'West'),
    (5, 2, 120, 'West'),
    (6, 3, 160, 'West');

-- Tag: window_functions_window_frames_test_select_021
SELECT
    region,
    day,
    amount,
    SUM(amount) OVER (
        PARTITION BY region
        ORDER BY day
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as regional_rolling_sum
FROM sales
ORDER BY region, day;
-- Each region has independent 3-row rolling sum

-- Cumulative sum per partition
-- Tag: window_functions_window_frames_test_select_022
SELECT
    region,
    day,
    amount,
    SUM(amount) OVER (
        PARTITION BY region
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as regional_cumsum
FROM sales
ORDER BY region, day;
-- Running total resets for each region

-- Multiple aggregate functions over same frame
-- Tag: window_functions_window_frames_test_select_023
SELECT
    region,
    day,
    amount,
    SUM(amount) OVER w as sum,
    AVG(amount) OVER w as avg,
    MIN(amount) OVER w as min,
    MAX(amount) OVER w as max,
    COUNT(*) OVER w as count
FROM sales
WINDOW w AS (
    PARTITION BY region
    ORDER BY day
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
ORDER BY region, day;

-- ----------------------------------------------------------------------------
-- Window Clause and Named Windows
-- ----------------------------------------------------------------------------

-- WINDOW clause for reusable window definitions
-- Tag: window_functions_window_frames_test_select_024
SELECT
    day,
    amount,
    SUM(amount) OVER w as sum,
    AVG(amount) OVER w as avg,
    MIN(amount) OVER w as min,
    MAX(amount) OVER w as max
FROM sales
WINDOW w AS (ORDER BY day ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
ORDER BY day;

-- Multiple named windows
-- Tag: window_functions_window_frames_test_select_025
SELECT
    day,
    amount,
    SUM(amount) OVER short_term as sum_3,
    SUM(amount) OVER long_term as sum_5,
    AVG(amount) OVER cumulative as avg_cumulative
FROM sales
WINDOW
    short_term AS (ORDER BY day ROWS 2 PRECEDING),
    long_term AS (ORDER BY day ROWS 4 PRECEDING),
    cumulative AS (ORDER BY day ROWS UNBOUNDED PRECEDING)
ORDER BY day;

-- Inheriting and extending window definitions
-- Tag: window_functions_window_frames_test_select_026
SELECT
    day,
    amount,
    SUM(amount) OVER base as base_sum,
    SUM(amount) OVER extended as extended_sum
FROM sales
WINDOW
    base AS (ORDER BY day),
    extended AS (base ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
ORDER BY day;

-- ----------------------------------------------------------------------------
-- Common Analytical Patterns
-- ----------------------------------------------------------------------------

-- Moving averages
-- Tag: window_functions_window_frames_test_select_027
SELECT
    day,
    amount,
    AVG(amount) OVER (ORDER BY day ROWS 2 PRECEDING) as ma_3,
    AVG(amount) OVER (ORDER BY day ROWS 4 PRECEDING) as ma_5,
    AVG(amount) OVER (ORDER BY day ROWS 6 PRECEDING) as ma_7
FROM sales
ORDER BY day;

-- Running min/max
-- Tag: window_functions_window_frames_test_select_028
SELECT
    day,
    amount,
    MIN(amount) OVER (ORDER BY day ROWS UNBOUNDED PRECEDING) as running_min,
    MAX(amount) OVER (ORDER BY day ROWS UNBOUNDED PRECEDING) as running_max
FROM sales
ORDER BY day;

-- Centered moving average (symmetric window)
-- Tag: window_functions_window_frames_test_select_029
SELECT
    day,
    amount,
    AVG(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) as centered_ma_5
FROM sales
ORDER BY day;

-- Standard deviation over window
-- Tag: window_functions_window_frames_test_select_030
SELECT
    day,
    amount,
    STDDEV(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) as rolling_stddev_5
FROM sales
ORDER BY day;

-- Ratio to total
-- Tag: window_functions_window_frames_test_select_031
SELECT
    day,
    amount,
    amount * 100.0 / SUM(amount) OVER () as pct_of_total,
    amount * 100.0 / SUM(amount) OVER (
        ORDER BY day
        ROWS UNBOUNDED PRECEDING
    ) as pct_of_cumulative
FROM sales
ORDER BY day;

-- Change from previous
-- Tag: window_functions_window_frames_test_select_032
SELECT
    day,
    amount,
    amount - LAG(amount) OVER (ORDER BY day) as change,
    (amount - LAG(amount) OVER (ORDER BY day)) * 100.0 /
        LAG(amount) OVER (ORDER BY day) as pct_change
FROM sales
ORDER BY day;

-- Comparing to window aggregates
-- Tag: window_functions_window_frames_test_select_033
SELECT
    day,
    amount,
    AVG(amount) OVER (ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) as local_avg,
    amount - AVG(amount) OVER (ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) as deviation,
    CASE
        WHEN amount > AVG(amount) OVER (ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING)
        THEN 'above'
        ELSE 'below'
    END as compared_to_local_avg
FROM sales
ORDER BY day;

-- ----------------------------------------------------------------------------
-- Edge Cases and Special Scenarios
-- ----------------------------------------------------------------------------

-- Empty partition
DELETE FROM sales;
INSERT INTO sales VALUES (1, 1, 100, 'East');
-- Tag: window_functions_window_frames_test_select_034
SELECT
    region,
    day,
    amount,
    SUM(amount) OVER (
        PARTITION BY region
        ORDER BY day
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as sum
FROM sales
WHERE region = 'West';  -- No rows match

-- Single row in partition
-- Tag: window_functions_window_frames_test_select_035
SELECT
    region,
    day,
    amount,
    SUM(amount) OVER (
        PARTITION BY region
        ORDER BY day
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as sum
FROM sales;
-- Sum equals amount (only 1 row in partition)

-- Frame larger than partition
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, 2, 150, 'East');

-- Tag: window_functions_window_frames_test_select_036
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN 10 PRECEDING AND 10 FOLLOWING
    ) as sum
FROM sales;
-- Frame extends beyond available rows: uses all available

-- NULL values in ORDER BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'East'),
    (2, NULL, 150, 'East'),
    (3, 3, 200, 'East');

-- Tag: window_functions_window_frames_test_select_037
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day NULLS LAST
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) as sum
FROM sales;
-- NULLs handled according to NULLS FIRST/LAST

-- All NULL values
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, NULL, 100, 'East'),
    (2, NULL, 150, 'East'),
    (3, NULL, 200, 'East');

-- Tag: window_functions_window_frames_test_select_038
SELECT
    day,
    amount,
    SUM(amount) OVER (
        ORDER BY day
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as sum
FROM sales;
-- All rows treated as same ORDER BY group

-- ----------------------------------------------------------------------------
-- Performance Considerations
-- ----------------------------------------------------------------------------

-- Efficient window reuse
-- Tag: window_functions_window_frames_test_select_039
SELECT
    day,
    amount,
    SUM(amount) OVER w,
    AVG(amount) OVER w,
    COUNT(*) OVER w,
    MIN(amount) OVER w,
    MAX(amount) OVER w
FROM sales
WINDOW w AS (ORDER BY day ROWS 4 PRECEDING);
-- Single window definition computed once, reused for multiple aggregates

-- Avoid redundant window specifications
-- Good: use WINDOW clause
-- Tag: window_functions_window_frames_test_select_001
SELECT day, SUM(amount) OVER w, AVG(amount) OVER w
FROM sales
WINDOW w AS (ORDER BY day);

-- Less efficient: duplicate specifications
-- Tag: window_functions_window_frames_test_select_040
SELECT
    day,
    SUM(amount) OVER (ORDER BY day),
    AVG(amount) OVER (ORDER BY day)
FROM sales;

-- ----------------------------------------------------------------------------
-- Cleanup
-- ----------------------------------------------------------------------------

