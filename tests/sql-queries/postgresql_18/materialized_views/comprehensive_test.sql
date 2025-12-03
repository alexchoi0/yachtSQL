-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/materialized_views_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: CREATE MATERIALIZED VIEW basic
-- Expected: Creates physical copy of query results
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, date DATE);
INSERT INTO sales VALUES
    (1, 'Widget', 100.0, DATE '2024-01-01'),
    (2, 'Gadget', 200.0, DATE '2024-01-02'),
    (3, 'Widget', 150.0, DATE '2024-01-03');

DROP MATERIALIZED VIEW IF EXISTS sales_summary;
CREATE MATERIALIZED VIEW sales_summary AS
SELECT product, SUM(amount) as total_sales, COUNT(*) as num_sales
FROM sales
GROUP BY product;

SELECT * FROM sales_summary ORDER BY product;
-- Result: Gadget (200, 1), Widget (250, 2)

-- Test: Query MATERIALIZED VIEW like table
-- Expected: Can SELECT, filter, and join like regular table
SELECT product FROM sales_summary WHERE total_sales > 200;
-- Result: Widget

-- Test: REFRESH MATERIALIZED VIEW
-- Expected: Update materialized view with current data
INSERT INTO sales VALUES (4, 'Gadget', 150.0, DATE '2024-01-04');

-- Before refresh
SELECT total_sales FROM sales_summary WHERE product = 'Gadget';
-- Result: 200 (stale)

REFRESH MATERIALIZED VIEW sales_summary;

-- After refresh
SELECT total_sales FROM sales_summary WHERE product = 'Gadget';
-- Result: 350 (updated)

-- Test: REFRESH MATERIALIZED VIEW CONCURRENTLY
-- Expected: Refresh without locking for reads
CREATE UNIQUE INDEX sales_summary_idx ON sales_summary(product);

REFRESH MATERIALIZED VIEW CONCURRENTLY sales_summary;
-- View refreshed while remaining queryable

-- Test: DROP MATERIALIZED VIEW
-- Expected: Remove materialized view
DROP MATERIALIZED VIEW IF EXISTS temp_view;
CREATE MATERIALIZED VIEW temp_view AS SELECT 1 as value;

DROP MATERIALIZED VIEW temp_view;

SELECT * FROM temp_view;
-- ERROR: relation "temp_view" does not exist

-- Test: DROP MATERIALIZED VIEW IF EXISTS
-- Expected: No error if doesn't exist
DROP MATERIALIZED VIEW nonexistent_view;  -- ERROR

-- Test: Materialized view with complex query
-- Expected: Supports JOINs, subqueries, aggregations
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (id INT64, name STRING, region STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, owner_id INT64, amount FLOAT64);
INSERT INTO yacht_owners VALUES (1, 'Alice', 'North'), (2, 'Bob', 'South');
INSERT INTO orders VALUES (1, 1, 100.0), (2, 1, 200.0), (3, 2, 150.0);

DROP MATERIALIZED VIEW IF EXISTS customer_totals;
CREATE MATERIALIZED VIEW customer_totals AS
SELECT c.id, c.name, c.region, SUM(o.amount) as total_orders
FROM yacht_owners c
JOIN orders o ON c.id = o.owner_id
GROUP BY c.id, c.name, c.region;

SELECT * FROM customer_totals ORDER BY id;
-- Result: Alice (North, 300), Bob (South, 150)

-- Test: Materialized view with WHERE clause
-- Expected: Filters applied during materialization
DROP MATERIALIZED VIEW IF EXISTS high_value_sales;
CREATE MATERIALIZED VIEW high_value_sales AS
SELECT * FROM sales WHERE amount > 150.0;

SELECT COUNT(*) FROM high_value_sales;
-- Result: Count of sales over 150

-- Test: Materialized view with ORDER BY
-- Expected: Results materialized in sorted order (optimization)
DROP MATERIALIZED VIEW IF EXISTS sorted_sales;
CREATE MATERIALIZED VIEW sorted_sales AS
SELECT * FROM sales ORDER BY amount DESC;

SELECT * FROM sorted_sales LIMIT 3;
-- Result: Top 3 sales by amount

-- Test: Index on materialized view
-- Expected: Can create indexes for query performance
DROP MATERIALIZED VIEW IF EXISTS product_stats;
CREATE MATERIALIZED VIEW product_stats AS
SELECT product, AVG(amount) as avg_amount
FROM sales
GROUP BY product;

CREATE INDEX product_stats_idx ON product_stats(product);

-- Queries on product_stats can use index

-- Test: Multiple indexes on materialized view
-- Expected: Support multiple indexes
DROP MATERIALIZED VIEW IF EXISTS sales_details;
CREATE MATERIALIZED VIEW sales_details AS
SELECT id, product, amount, date FROM sales;

CREATE INDEX sales_details_equipment_idx ON sales_details(product);
CREATE INDEX sales_details_date_idx ON sales_details(date);
CREATE INDEX sales_details_amount_idx ON sales_details(amount);

-- Test: Materialized view with DISTINCT
-- Expected: Eliminates duplicates in materialized data
DROP MATERIALIZED VIEW IF EXISTS distinct_equipment;
CREATE MATERIALIZED VIEW distinct_equipment AS
SELECT DISTINCT product FROM sales;

SELECT * FROM distinct_equipment ORDER BY product;
-- Result: Gadget, Widget (no duplicates)

-- Test: Materialized view with CTEs
-- Expected: Can use WITH clauses in definition
DROP MATERIALIZED VIEW IF EXISTS monthly_summary;
CREATE MATERIALIZED VIEW monthly_summary AS
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', date) as month, SUM(amount) as total
    FROM sales
    GROUP BY DATE_TRUNC('month', date)
)
SELECT month, total FROM monthly_sales;

-- Test: Materialized view with window functions
-- Expected: Window functions work in materialization
DROP MATERIALIZED VIEW IF EXISTS sales_with_rank;
CREATE MATERIALIZED VIEW sales_with_rank AS
SELECT id, product, amount,
       ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount DESC) as rank
FROM sales;

SELECT * FROM sales_with_rank WHERE rank = 1;
-- Result: Top sale per product

-- Test: Materialized view with UNION
-- Expected: Combine multiple queries
DROP TABLE IF EXISTS archived_sales;
CREATE TABLE archived_sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO archived_sales VALUES (100, 'Widget', 50.0);

DROP MATERIALIZED VIEW IF EXISTS all_sales;
CREATE MATERIALIZED VIEW all_sales AS
SELECT id, product, amount FROM sales
UNION ALL
SELECT id, product, amount FROM archived_sales;

SELECT COUNT(*) FROM all_sales;
-- Result: Count includes both tables

-- Test: Materialized view referencing another view
-- Expected: Can stack materialized views
DROP MATERIALIZED VIEW IF EXISTS base_summary;
CREATE MATERIALIZED VIEW base_summary AS
SELECT product, SUM(amount) as total FROM sales GROUP BY product;

DROP MATERIALIZED VIEW IF EXISTS top_equipment;
CREATE MATERIALIZED VIEW top_equipment AS
SELECT * FROM base_summary WHERE total > 200;

-- Test: Materialized view with NULL values
-- Expected: Handles NULLs correctly
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, category STRING, value INT64);
INSERT INTO nullable_data VALUES (1, 'A', 10), (2, NULL, 20), (3, 'A', NULL);

DROP MATERIALIZED VIEW IF EXISTS nullable_summary;
CREATE MATERIALIZED VIEW nullable_summary AS
SELECT category, COUNT(*) as count, SUM(value) as total
FROM nullable_data
GROUP BY category;

SELECT * FROM nullable_summary;
-- Result: Handles NULL category and values

-- Test: Materialized view empty result
-- Expected: Creates empty materialized view
DROP MATERIALIZED VIEW IF EXISTS empty_view;
CREATE MATERIALIZED VIEW empty_view AS
SELECT * FROM sales WHERE amount < 0;

SELECT COUNT(*) FROM empty_view;
-- Result: 0

-- Test: REFRESH on empty view
-- Expected: Can refresh even if no data
REFRESH MATERIALIZED VIEW empty_view;

-- Test: Materialized view with computed columns
-- Expected: Expressions evaluated during materialization
DROP MATERIALIZED VIEW IF EXISTS sales_computed;
CREATE MATERIALIZED VIEW sales_computed AS
SELECT id,
       product,
       amount,
       amount * 0.1 as tax,
       amount * 1.1 as total_with_tax
FROM sales;

SELECT * FROM sales_computed;

-- Test: Materialized view size/storage
-- Expected: Physical storage used
DROP MATERIALIZED VIEW IF EXISTS large_summary;
CREATE MATERIALIZED VIEW large_summary AS
SELECT product, date, SUM(amount) as total
FROM sales
GROUP BY product, date;

-- Storage space allocated for materialized data

-- Test: Materialized view with aggregates
-- Expected: All aggregate functions work
DROP MATERIALIZED VIEW IF EXISTS product_aggregates;
CREATE MATERIALIZED VIEW product_aggregates AS
SELECT product,
       COUNT(*) as count,
       SUM(amount) as total,
       AVG(amount) as average,
       MIN(amount) as minimum,
       MAX(amount) as maximum
FROM sales
GROUP BY product;

SELECT * FROM product_aggregates;

-- Test: DROP CASCADE removes dependent objects
-- Expected: Drops views that depend on this view
DROP MATERIALIZED VIEW IF EXISTS base;
CREATE MATERIALIZED VIEW base AS SELECT * FROM sales;
DROP MATERIALIZED VIEW IF EXISTS dependent;
CREATE MATERIALIZED VIEW dependent AS SELECT * FROM base;

DROP MATERIALIZED VIEW base CASCADE;
-- Also drops dependent view

-- Test: Materialized view with LIMIT
-- Expected: Only materializes limited rows
DROP MATERIALIZED VIEW IF EXISTS top_10_sales;
CREATE MATERIALIZED VIEW top_10_sales AS
SELECT * FROM sales ORDER BY amount DESC LIMIT 10;

-- Test: IF NOT EXISTS in CREATE
-- Expected: No error if already exists
DROP MATERIALIZED VIEW IF EXISTS test_view;
CREATE MATERIALIZED VIEW test_view AS SELECT 1 as value;
DROP MATERIALIZED VIEW IF EXISTS IF;
CREATE MATERIALIZED VIEW IF NOT EXISTS test_view AS SELECT 2 as value;
-- Second CREATE does nothing

-- Test: Refresh timing
-- Expected: Manual refresh required, not automatic
INSERT INTO sales VALUES (5, 'Widget', 500.0, DATE '2024-01-05');

-- sales_summary won't automatically update
SELECT total_sales FROM sales_summary WHERE product = 'Widget';
-- Result: Stale data until manual REFRESH

-- Test: Materialized view with transaction
-- Expected: Refresh is transactional
BEGIN;
INSERT INTO sales VALUES (6, 'Gadget', 100.0, DATE '2024-01-06');
REFRESH MATERIALIZED VIEW sales_summary;
ROLLBACK;

-- Refresh rolled back, summary reverts

-- Test: Concurrent access during refresh
-- Expected: REFRESH locks view, CONCURRENTLY allows reads
-- Standard REFRESH blocks readers
REFRESH MATERIALIZED VIEW sales_summary;

-- Concurrent refresh with unique index
CREATE UNIQUE INDEX sales_summary_product_key ON sales_summary(product);
REFRESH MATERIALIZED VIEW CONCURRENTLY sales_summary;
-- Readers can still query during refresh

-- Test: Materialized view with HAVING
-- Expected: Post-aggregation filter
DROP MATERIALIZED VIEW IF EXISTS high_volume_equipment;
CREATE MATERIALIZED VIEW high_volume_equipment AS
SELECT product, COUNT(*) as sale_count
FROM sales
GROUP BY product
HAVING COUNT(*) > 1;

SELECT * FROM high_volume_equipment;

-- Test: Rename materialized view
-- Expected: Can rename like table
DROP MATERIALIZED VIEW IF EXISTS old_name;
CREATE MATERIALIZED VIEW old_name AS SELECT 1 as value;

ALTER MATERIALIZED VIEW old_name RENAME TO new_name;

SELECT * FROM new_name;

-- Test: Change owner of materialized view
-- Expected: Can change ownership
-- ALTER MATERIALIZED VIEW sales_summary OWNER TO new_owner;

-- Test: Comments on materialized view
-- Expected: Can document view purpose
COMMENT ON MATERIALIZED VIEW sales_summary IS 'Summary of sales by product';

-- Test: Materialized view with NO DATA
-- Expected: Create structure without initial data
DROP MATERIALIZED VIEW IF EXISTS no_data_view;
CREATE MATERIALIZED VIEW no_data_view AS
SELECT * FROM sales
WITH NO DATA;

SELECT * FROM no_data_view;
-- ERROR: materialized view has not been populated

REFRESH MATERIALIZED VIEW no_data_view;
-- Now queryable
