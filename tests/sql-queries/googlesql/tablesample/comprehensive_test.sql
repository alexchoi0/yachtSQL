-- ============================================================================
-- Comprehensive - GoogleSQL/BigQuery
-- ============================================================================
-- Source: tests/tablesample_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

-- Test: TABLESAMPLE SYSTEM returns approximately correct percentage
-- Expected: Sample size roughly 10% of 1000 rows (50-150 rows)
DROP TABLE IF EXISTS large_table;
CREATE TABLE large_table (id INT64, value STRING);
-- Insert 1000 rows (0-999)

SELECT * FROM large_table TABLESAMPLE SYSTEM (10);

-- Test: TABLESAMPLE SYSTEM (0) returns no rows
-- Expected: Empty result set
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);

SELECT * FROM data TABLESAMPLE SYSTEM (0);

-- Test: TABLESAMPLE SYSTEM (100) returns all rows
-- Expected: All 5 rows returned
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);

SELECT * FROM data TABLESAMPLE SYSTEM (100);

-- ============================================================================
-- TABLESAMPLE BERNOULLI - Row-Level Sampling
-- ============================================================================

-- Test: TABLESAMPLE BERNOULLI returns approximately correct percentage
-- Expected: Sample size roughly 10% of 1000 rows (70-130 rows, more accurate than SYSTEM)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
-- Insert 1000 rows

SELECT * FROM data TABLESAMPLE BERNOULLI (10);

-- Test: TABLESAMPLE BERNOULLI works with small tables
-- Expected: Probabilistic sampling even with few rows (3-7 rows expected)
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64);
INSERT INTO small VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

SELECT * FROM small TABLESAMPLE BERNOULLI (50);

-- ============================================================================
-- REPEATABLE Clause - Deterministic Sampling
-- ============================================================================

-- Test: TABLESAMPLE REPEATABLE produces same results with same seed
-- Expected: Identical samples with same seed (42)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
-- Insert 100 rows

SELECT id FROM data TABLESAMPLE SYSTEM (20) REPEATABLE (42) ORDER BY id;
-- Run twice with same seed - results should be identical

-- Test: TABLESAMPLE REPEATABLE produces different results with different seeds
-- Expected: Different samples with different seeds (42 vs 123)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
-- Insert 100 rows

SELECT id FROM data TABLESAMPLE SYSTEM (20) REPEATABLE (42) ORDER BY id;
SELECT id FROM data TABLESAMPLE SYSTEM (20) REPEATABLE (123) ORDER BY id;
-- Results should differ

-- ============================================================================
-- Integration with WHERE Clause
-- ============================================================================

-- Test: TABLESAMPLE with WHERE clause
-- Expected: Sample is filtered after sampling (all results are "even")
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
-- Insert 1000 rows: category = "even" for even ids, "odd" for odd ids

SELECT * FROM data
TABLESAMPLE SYSTEM (10)
WHERE category = 'even';

-- ============================================================================
-- Integration with JOIN
-- ============================================================================

-- Test: TABLESAMPLE in JOIN
-- Expected: Sampling applied before join
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, owner_id INT64);
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (owner_id INT64, name STRING);
-- Insert 1000 orders, 100 yacht_owners

SELECT c.name, COUNT(*) as order_count
FROM orders TABLESAMPLE SYSTEM (10) o
JOIN yacht_owners c ON o.owner_id = c.owner_id
GROUP BY c.name;

-- ============================================================================
-- Integration with Aggregations
-- ============================================================================

-- Test: TABLESAMPLE with aggregation
-- Expected: Aggregation on sampled data (counts should reflect 60/40 distribution)
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
-- Insert 600 rows with product='A', 400 rows with product='B'

SELECT product, COUNT(*) as sample_count
FROM sales TABLESAMPLE BERNOULLI (10)
GROUP BY product
ORDER BY product;

-- ============================================================================
-- Integration with ORDER BY and LIMIT
-- ============================================================================

-- Test: TABLESAMPLE with ORDER BY and LIMIT
-- Expected: Sample first, then order, then limit (5 rows in DESC order)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
-- Insert 100 rows with value = id * 10

SELECT * FROM data
TABLESAMPLE SYSTEM (20)
ORDER BY value DESC
LIMIT 5;

-- ============================================================================
-- Edge Cases
-- ============================================================================

-- Test: TABLESAMPLE on empty table
-- Expected: Returns empty result
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);

SELECT * FROM empty_table TABLESAMPLE SYSTEM (50);

-- Test: TABLESAMPLE on table with single row
-- Expected: Probabilistic inclusion of the row (100% sample returns 1 row)
DROP TABLE IF EXISTS single;
CREATE TABLE single (id INT64);
INSERT INTO single VALUES (1);

SELECT * FROM single TABLESAMPLE BERNOULLI (100) REPEATABLE (42);

-- ============================================================================
-- Error Handling
-- ============================================================================

-- Test: TABLESAMPLE with negative percentage
-- Expected: Error indicating invalid percentage
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

SELECT * FROM data TABLESAMPLE SYSTEM (-10);
-- Expected error: percentage must be between 0 and 100

-- Test: TABLESAMPLE with percentage > 100
-- Expected: Error indicating invalid percentage
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

SELECT * FROM data TABLESAMPLE SYSTEM (150);
-- Expected error: percentage must be between 0 and 100

-- Test: TABLESAMPLE with invalid sampling method
-- Expected: Error indicating invalid method
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

SELECT * FROM data TABLESAMPLE INVALID (10);
-- Expected error: method must be SYSTEM or BERNOULLI

-- ============================================================================
-- Advanced Use Cases
-- ============================================================================

-- Test: TABLESAMPLE in CTE
-- Expected: CTE contains sampled data (roughly 10% of 1000 rows)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
-- Insert 1000 rows

WITH sample AS (
    SELECT * FROM data TABLESAMPLE SYSTEM (10) REPEATABLE (42)
)
SELECT COUNT(*) FROM sample;

-- Test: TABLESAMPLE on multiple tables in same query
-- Expected: Independent sampling on each table
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
-- Insert 100 rows into each

SELECT id FROM table1 TABLESAMPLE SYSTEM (20) REPEATABLE (1)
UNION ALL
SELECT id FROM table2 TABLESAMPLE SYSTEM (20) REPEATABLE (2);

-- ============================================================================
-- Performance Tests
-- ============================================================================

-- Test: TABLESAMPLE is faster than full scan
-- Expected: Sampling completes quickly even on large table (1% of 10,000 rows)
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, data STRING);
-- Insert 10,000 rows

SELECT COUNT(*) FROM large TABLESAMPLE SYSTEM (1);

-- ============================================================================
-- Real-World Use Cases
-- ============================================================================

-- Use Case 1: Quick data preview
-- Get a random sample to preview table structure and values
SELECT * FROM large_table TABLESAMPLE SYSTEM (1) LIMIT 100;

-- Use Case 2: Statistical analysis on sample
-- Estimate average without scanning full table
SELECT AVG(value) as estimated_avg
FROM sales_data TABLESAMPLE BERNOULLI (5);

-- Use Case 3: Query optimization testing
-- Test query performance on sample before running on full table
SELECT product, COUNT(*) as count
FROM sales TABLESAMPLE SYSTEM (10)
WHERE region = 'US'
GROUP BY product;

-- Use Case 4: Reproducible sampling for testing
-- Create consistent test dataset from production data
CREATE TABLE test_data AS
SELECT * FROM production_table TABLESAMPLE BERNOULLI (1) REPEATABLE (12345);
