-- Array Aggregates - SQL:2023
-- Description: Array aggregate functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES (1, 'A', 10);
INSERT INTO items VALUES (2, 'A', 20);
INSERT INTO items VALUES (3, 'A', 30);
INSERT INTO items VALUES (4, 'B', 40);
INSERT INTO items VALUES (5, 'B', 50);

-- Tag: arrays_array_aggregates_test_select_001
SELECT ARRAY_AGG(value) as all_values FROM items;

-- ---------------------------------------------------------------------------
-- ARRAY_AGG with GROUP BY
-- ---------------------------------------------------------------------------

-- Group and aggregate
-- Tag: arrays_array_aggregates_test_select_002
SELECT category, ARRAY_AGG(value) as values
FROM items
GROUP BY category
ORDER BY category;
-- A -> [10,20,30]
-- B -> [40,50]

-- Multiple groups
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Jan', 100);
INSERT INTO sales VALUES ('North', 'Feb', 150);
INSERT INTO sales VALUES ('North', 'Mar', 120);
INSERT INTO sales VALUES ('South', 'Jan', 200);
INSERT INTO sales VALUES ('South', 'Feb', 180);

-- Tag: arrays_array_aggregates_test_select_003
SELECT region, ARRAY_AGG(amount) as monthly_sales
FROM sales
GROUP BY region
ORDER BY region;
-- North -> [100,150,120]
-- South -> [200,180]

-- ---------------------------------------------------------------------------
-- ARRAY_AGG with ORDER BY
-- ---------------------------------------------------------------------------

-- Ordered aggregation
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, test INT64, score INT64);
INSERT INTO scores VALUES ('Alice', 1, 85);
INSERT INTO scores VALUES ('Alice', 2, 92);
INSERT INTO scores VALUES ('Alice', 3, 78);
INSERT INTO scores VALUES ('Bob', 1, 88);
INSERT INTO scores VALUES ('Bob', 2, 84);

-- Tag: arrays_array_aggregates_test_select_004
SELECT student, ARRAY_AGG(score ORDER BY test) as scores_ordered
FROM scores
GROUP BY student
ORDER BY student;
-- Alice -> [85,92,78]
-- Bob -> [88,84]

-- Order by multiple columns
DROP TABLE IF EXISTS events;
CREATE TABLE events (category STRING, ts TIMESTAMP, value INT64);
INSERT INTO events VALUES ('A', TIMESTAMP '2024-01-01 10:00:00', 10);
INSERT INTO events VALUES ('A', TIMESTAMP '2024-01-01 09:00:00', 20);
INSERT INTO events VALUES ('A', TIMESTAMP '2024-01-01 11:00:00', 30);

-- Tag: arrays_array_aggregates_test_select_005
SELECT category, ARRAY_AGG(value ORDER BY ts) as chronological
FROM events
GROUP BY category;

-- Descending order
-- Tag: arrays_array_aggregates_test_select_006
SELECT category, ARRAY_AGG(value ORDER BY value DESC) as descending
FROM items
GROUP BY category
ORDER BY category;
-- A -> [30,20,10]
-- B -> [50,40]

-- ---------------------------------------------------------------------------
-- ARRAY_AGG with DISTINCT
-- ---------------------------------------------------------------------------

-- Remove duplicates during aggregation
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (item_id INT64, tag STRING);
INSERT INTO tags VALUES (1, 'red');
INSERT INTO tags VALUES (1, 'small');
INSERT INTO tags VALUES (1, 'red');  -- duplicate
INSERT INTO tags VALUES (2, 'blue');
INSERT INTO tags VALUES (2, 'large');
INSERT INTO tags VALUES (2, 'blue');  -- duplicate

-- Tag: arrays_array_aggregates_test_select_007
SELECT item_id, ARRAY_AGG(DISTINCT tag) as unique_tags
FROM tags
GROUP BY item_id
ORDER BY item_id;
-- 1 -> ['red','small']
-- 2 -> ['blue','large']

-- DISTINCT with ORDER BY
-- Tag: arrays_array_aggregates_test_select_008
SELECT item_id, ARRAY_AGG(DISTINCT tag ORDER BY tag) as sorted_unique_tags
FROM tags
GROUP BY item_id
ORDER BY item_id;
-- 1 -> ['red','small'] (alphabetically sorted)
-- 2 -> ['blue','large'] (alphabetically sorted)

-- ---------------------------------------------------------------------------
-- ARRAY_AGG with NULL handling
-- ---------------------------------------------------------------------------

-- Include NULL values
DROP TABLE IF EXISTS values_with_nulls;
CREATE TABLE values_with_nulls (category STRING, val INT64);
INSERT INTO values_with_nulls VALUES ('A', 1);
INSERT INTO values_with_nulls VALUES ('A', NULL);
INSERT INTO values_with_nulls VALUES ('A', 3);
INSERT INTO values_with_nulls VALUES ('B', NULL);
INSERT INTO values_with_nulls VALUES ('B', 5);

-- Tag: arrays_array_aggregates_test_select_009
SELECT category, ARRAY_AGG(val) as with_nulls
FROM values_with_nulls
GROUP BY category
ORDER BY category;
-- A -> [1,null,3]
-- B -> [null,5]

-- Filter out NULLs (if supported)
-- Tag: arrays_array_aggregates_test_select_010
SELECT category, ARRAY_AGG(val) FILTER (WHERE val IS NOT NULL) as without_nulls
FROM values_with_nulls
GROUP BY category
ORDER BY category;
-- A -> [1,3]
-- B -> [5]

-- ---------------------------------------------------------------------------
-- ARRAY_AGG on empty groups
-- ---------------------------------------------------------------------------

-- Empty group
DROP TABLE IF EXISTS empty_group;
CREATE TABLE empty_group (category STRING, value INT64);
INSERT INTO empty_group VALUES ('A', 1);

-- Tag: arrays_array_aggregates_test_select_011
SELECT category, ARRAY_AGG(value) as values
FROM empty_group
WHERE category = 'B'
GROUP BY category;

-- All NULL values
DROP TABLE IF EXISTS all_nulls;
CREATE TABLE all_nulls (category STRING, value INT64);
INSERT INTO all_nulls VALUES ('A', NULL);
INSERT INTO all_nulls VALUES ('A', NULL);

-- Tag: arrays_array_aggregates_test_select_012
SELECT ARRAY_AGG(value) as all_null FROM all_nulls;

-- ---------------------------------------------------------------------------
-- ARRAY_AGG with FILTER clause
-- ---------------------------------------------------------------------------

-- Conditional aggregation
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (sensor STRING, reading INT64);
INSERT INTO measurements VALUES ('A', 10);
INSERT INTO measurements VALUES ('A', 150);  -- outlier
INSERT INTO measurements VALUES ('A', 12);
INSERT INTO measurements VALUES ('B', 20);
INSERT INTO measurements VALUES ('B', 200);  -- outlier
INSERT INTO measurements VALUES ('B', 22);

-- Tag: arrays_array_aggregates_test_select_013
SELECT sensor, ARRAY_AGG(reading) FILTER (WHERE reading < 100) as normal_readings
FROM measurements
GROUP BY sensor
ORDER BY sensor;
-- A -> [10,12]
-- B -> [20,22]

-- Multiple filters
-- Tag: arrays_array_aggregates_test_select_001
SELECT
  sensor,
  ARRAY_AGG(reading) FILTER (WHERE reading < 50) as low,
  ARRAY_AGG(reading) FILTER (WHERE reading >= 50) as high
FROM measurements
GROUP BY sensor
ORDER BY sensor;
-- A -> low: [10,12], high: [150]
-- B -> low: [20,22], high: [200]

-- ---------------------------------------------------------------------------
-- UNNEST with aggregates
-- ---------------------------------------------------------------------------

-- Flatten arrays and aggregate
DROP TABLE IF EXISTS array_data;
CREATE TABLE array_data (id INT64, nums ARRAY<INT64>);
INSERT INTO array_data VALUES (1, ARRAY[1, 2, 3]);
INSERT INTO array_data VALUES (2, ARRAY[4, 5, 6]);
INSERT INTO array_data VALUES (3, ARRAY[7, 8, 9]);

-- Tag: arrays_array_aggregates_test_select_014
SELECT SUM(num) as total
FROM array_data, UNNEST(nums) as num;

-- Average of all array elements
-- Tag: arrays_array_aggregates_test_select_015
SELECT AVG(num) as average
FROM array_data, UNNEST(nums) as num;

-- Count of all array elements
-- Tag: arrays_array_aggregates_test_select_016
SELECT COUNT(num) as count
FROM array_data, UNNEST(nums) as num;

-- Max across all arrays
-- Tag: arrays_array_aggregates_test_select_017
SELECT MAX(num) as maximum
FROM array_data, UNNEST(nums) as num;

-- Min across all arrays
-- Tag: arrays_array_aggregates_test_select_018
SELECT MIN(num) as minimum
FROM array_data, UNNEST(nums) as num;

-- ---------------------------------------------------------------------------
-- UNNEST with GROUP BY
-- ---------------------------------------------------------------------------

-- Group by original row, aggregate unnested values
-- Tag: arrays_array_aggregates_test_select_019
SELECT id, SUM(num) as row_sum
FROM array_data, UNNEST(nums) as num
GROUP BY id
ORDER BY id;
-- 1 -> 6 (1+2+3)
-- 2 -> 15 (4+5+6)
-- 3 -> 24 (7+8+9)

-- Count elements per array
-- Tag: arrays_array_aggregates_test_select_020
SELECT id, COUNT(num) as element_count
FROM array_data, UNNEST(nums) as num
GROUP BY id
ORDER BY id;
-- 1 -> 3
-- 2 -> 3
-- 3 -> 3

-- ---------------------------------------------------------------------------
-- ARRAY_AGG from UNNEST (round-trip)
-- ---------------------------------------------------------------------------

-- Unnest then re-aggregate
DROP TABLE IF EXISTS multi_arrays;
CREATE TABLE multi_arrays (group_id INT64, data ARRAY<INT64>);
INSERT INTO multi_arrays VALUES (1, ARRAY[1, 2, 3]);
INSERT INTO multi_arrays VALUES (1, ARRAY[4, 5, 6]);
INSERT INTO multi_arrays VALUES (2, ARRAY[7, 8, 9]);

-- Tag: arrays_array_aggregates_test_select_021
SELECT group_id, ARRAY_AGG(num ORDER BY num) as all_nums
FROM multi_arrays, UNNEST(data) as num
GROUP BY group_id
ORDER BY group_id;
-- 1 -> [1,2,3,4,5,6]
-- 2 -> [7,8,9]

-- ---------------------------------------------------------------------------
-- Complex aggregations
-- ---------------------------------------------------------------------------

-- Aggregate objects from arrays
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, items ARRAY<STRUCT<item STRING, qty INT64>>);
-- (Assuming STRUCT support in arrays)
-- INSERT INTO orders VALUES (1, [STRUCT('A', 2), STRUCT('B', 3)]);

-- Aggregate arrays across multiple dimensions
DROP TABLE IF EXISTS matrix;
CREATE TABLE matrix (row_id INT64, col_id INT64, value INT64);
INSERT INTO matrix VALUES (1, 1, 10);
INSERT INTO matrix VALUES (1, 2, 20);
INSERT INTO matrix VALUES (1, 3, 30);
INSERT INTO matrix VALUES (2, 1, 40);
INSERT INTO matrix VALUES (2, 2, 50);
INSERT INTO matrix VALUES (2, 3, 60);

-- Aggregate by row
-- Tag: arrays_array_aggregates_test_select_022
SELECT row_id, ARRAY_AGG(value ORDER BY col_id) as row_values
FROM matrix
GROUP BY row_id
ORDER BY row_id;
-- 1 -> [10,20,30]
-- 2 -> [40,50,60]

-- Aggregate by column
-- Tag: arrays_array_aggregates_test_select_023
SELECT col_id, ARRAY_AGG(value ORDER BY row_id) as col_values
FROM matrix
GROUP BY col_id
ORDER BY col_id;
-- 1 -> [10,40]
-- 2 -> [20,50]
-- 3 -> [30,60]

-- ---------------------------------------------------------------------------
-- Window functions with ARRAY_AGG
-- ---------------------------------------------------------------------------

-- Cumulative array aggregation (if window functions support ARRAY_AGG)
-- SELECT
--   id,
--   value,
--   ARRAY_AGG(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative
-- FROM items
-- ORDER BY id;

-- ---------------------------------------------------------------------------
-- Statistical operations on arrays
-- ---------------------------------------------------------------------------

-- Median from array (using UNNEST + PERCENTILE_CONT)
DROP TABLE IF EXISTS distributions;
CREATE TABLE distributions (id INT64, values ARRAY<FLOAT64>);
INSERT INTO distributions VALUES (1, ARRAY[1.0, 2.0, 3.0, 4.0, 5.0]);

-- Tag: arrays_array_aggregates_test_select_024
SELECT id, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY val) as median
FROM distributions, UNNEST(values) as val
GROUP BY id;

-- Standard deviation of array elements
-- Tag: arrays_array_aggregates_test_select_025
SELECT id, STDDEV(val) as std_dev
FROM distributions, UNNEST(values) as val
GROUP BY id;

-- Variance of array elements
-- Tag: arrays_array_aggregates_test_select_026
SELECT id, VARIANCE(val) as var
FROM distributions, UNNEST(values) as val
GROUP BY id;

-- ---------------------------------------------------------------------------
-- Performance considerations
-- ---------------------------------------------------------------------------

-- Large aggregation (1000 elements)
-- CREATE TABLE large_agg AS
-- SELECT ARRAY_AGG(id) as all_ids
-- FROM (SELECT * FROM GENERATE_SERIES(1, 1000) as id);

-- Many groups (1000 groups, 10 elements each)
-- CREATE TABLE many_groups AS
-- SELECT group_id, ARRAY_AGG(value) as values
-- FROM (SELECT MOD(id, 1000) as group_id, id as value FROM GENERATE_SERIES(1, 10000) as id)
-- GROUP BY group_id;

-- Error Conditions

-- ARRAY_AGG on incompatible types
-- SELECT ARRAY_AGG(col1 || col2) as combined
-- FROM (SELECT 1 as col1, 'a' as col2);

-- Summary
-- This file covers array aggregation operations:
-- - ARRAY_AGG: Basic aggregation into arrays
-- - ARRAY_AGG with ORDER BY: Ordered aggregation
-- - ARRAY_AGG with DISTINCT: Deduplicated aggregation
-- - ARRAY_AGG with FILTER: Conditional aggregation
-- - UNNEST with aggregates: Flatten and aggregate
-- - Window functions with arrays
-- - Statistical operations on array elements
