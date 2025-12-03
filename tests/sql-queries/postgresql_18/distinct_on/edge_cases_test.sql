-- ============================================================================
-- Edge Cases - PostgreSQL 18
-- ============================================================================
-- Source: tests/distinct_on_comprehensive_tdd.rs
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Single column DISTINCT ON
-- Expected: Returns most recent action per user
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, user_id INT64, action STRING, timestamp INT64);
INSERT INTO events VALUES
    (1, 1, 'login', 100),
    (2, 1, 'click', 200),
    (3, 2, 'login', 150),
    (4, 2, 'logout', 300);

SELECT DISTINCT ON (user_id) user_id, action, timestamp
FROM events
ORDER BY user_id, timestamp DESC;
-- Result: user 1 = 'click' (200), user 2 = 'logout' (300)

-- Test: Returns first row per group (earliest price per product)
-- Expected: Earliest price for each product
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (id INT64, product STRING, date INT64, price FLOAT64);
INSERT INTO prices VALUES
    (1, 'widget', 1, 10.0),
    (2, 'widget', 2, 12.0),
    (3, 'widget', 3, 11.0),
    (4, 'gadget', 1, 20.0),
    (5, 'gadget', 2, 18.0);

SELECT DISTINCT ON (product) product, price, date
FROM prices
ORDER BY product, date ASC;
-- Result: gadget earliest = 20.0, widget earliest = 10.0

-- Test: Multiple DISTINCT ON columns
-- Expected: Latest sale per region AND product
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, product STRING, amount FLOAT64, date INT64);
INSERT INTO sales VALUES
    (1, 'North', 'widget', 100.0, 1),
    (2, 'North', 'widget', 150.0, 2),
    (3, 'North', 'gadget', 200.0, 1),
    (4, 'South', 'widget', 120.0, 1),
    (5, 'South', 'widget', 110.0, 2);

SELECT DISTINCT ON (region, product) region, product, amount, date
FROM sales
ORDER BY region, product, date DESC;
-- Result: 3 rows - one for each (region, product) combination

-- Test: DISTINCT ON with expression
-- Expected: Deduplicate by case-insensitive email
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, email STRING, created_at INT64);
INSERT INTO users VALUES
    (1, 'alice@example.com', 100),
    (2, 'ALICE@EXAMPLE.COM', 200),
    (3, 'bob@example.com', 150);

SELECT DISTINCT ON (LOWER(email)) id, email, created_at
FROM users
ORDER BY LOWER(email), created_at DESC;
-- Result: 2 rows - latest for each unique lowercase email

-- ============================================================================
-- Edge Cases
-- ============================================================================

-- Test: Empty result set
-- Expected: Zero rows returned
DROP TABLE IF EXISTS data_empty;
CREATE TABLE data_empty (id INT64, category STRING);

SELECT DISTINCT ON (category) category, id
FROM data_empty
ORDER BY category, id;
-- Result: 0 rows

-- Test: Single row
-- Expected: One row returned
DROP TABLE IF EXISTS data_single;
CREATE TABLE data_single (id INT64, category STRING);
INSERT INTO data_single VALUES (1, 'A');

SELECT DISTINCT ON (category) category, id
FROM data_single
ORDER BY category;
-- Result: 1 row

-- Test: All unique values
-- Expected: All rows returned
DROP TABLE IF EXISTS data_unique;
CREATE TABLE data_unique (id INT64, value STRING);
INSERT INTO data_unique VALUES (1, 'A'), (2, 'B'), (3, 'C');

SELECT DISTINCT ON (value) value, id
FROM data_unique
ORDER BY value;
-- Result: 3 rows

-- Test: All same value
-- Expected: Only first row returned
DROP TABLE IF EXISTS data_same;
CREATE TABLE data_same (id INT64, category STRING, value STRING);
INSERT INTO data_same VALUES
    (1, 'A', 'first'),
    (2, 'A', 'second'),
    (3, 'A', 'third');

SELECT DISTINCT ON (category) category, value
FROM data_same
ORDER BY category, id ASC;
-- Result: 1 row with 'first'

-- Test: NULL values in DISTINCT ON column
-- Expected: NULLs are considered equal, returns first NULL
DROP TABLE IF EXISTS data_null;
CREATE TABLE data_null (id INT64, category STRING, value INT64);
INSERT INTO data_null VALUES
    (1, NULL, 10),
    (2, NULL, 20),
    (3, 'A', 30),
    (4, 'A', 40);

SELECT DISTINCT ON (category) category, value
FROM data_null
ORDER BY category, value ASC;
-- Result: 2 rows - one for NULL (value 10), one for 'A' (value 30)

-- Test: NULL ordering with NULLS FIRST
-- Expected: NULL group appears first
SELECT DISTINCT ON (category) category, id
FROM data_null
ORDER BY category NULLS FIRST, id ASC;
-- Result: 3 rows - NULL, 'A', 'B'

-- ============================================================================
-- ORDER BY Interaction Tests
-- ============================================================================

-- Test: ORDER BY same column as DISTINCT ON
-- Expected: DISTINCT ON column must be first in ORDER BY
DROP TABLE IF EXISTS data_order;
CREATE TABLE data_order (id INT64, category STRING, value INT64);
INSERT INTO data_order VALUES
    (1, 'A', 100),
    (2, 'A', 200),
    (3, 'B', 150);

SELECT DISTINCT ON (category) category, value
FROM data_order
ORDER BY category, value DESC;
-- Result: Category A gets highest value (200)

-- Test: ORDER BY with additional columns after DISTINCT ON
-- Expected: Secondary sort affects which row is selected
DROP TABLE IF EXISTS events_complex;
CREATE TABLE events_complex (id INT64, user_id INT64, type STRING, priority INT64, timestamp INT64);
INSERT INTO events_complex VALUES
    (1, 1, 'alert', 1, 100),
    (2, 1, 'info', 3, 200),
    (3, 1, 'alert', 2, 150);

SELECT DISTINCT ON (user_id) user_id, type, priority, timestamp
FROM events_complex
ORDER BY user_id, priority ASC, timestamp DESC;
-- Result: Returns alert with priority 1

-- Test: ORDER BY DESC on DISTINCT ON column
-- Expected: Category ordering affects result order
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, player STRING, score INT64);
INSERT INTO scores VALUES
    (1, 'Alice', 100),
    (2, 'Alice', 150),
    (3, 'Bob', 200);

SELECT DISTINCT ON (player) player, score
FROM scores
ORDER BY player ASC, score DESC;
-- Result: Alice highest score = 150

-- ============================================================================
-- Integration with Other Features
-- ============================================================================

-- Test: DISTINCT ON with WHERE clause
-- Expected: Filter applied before DISTINCT ON
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING, user_id INT64, message STRING);
INSERT INTO logs VALUES
    (1, 'ERROR', 1, 'msg1'),
    (2, 'INFO', 1, 'msg2'),
    (3, 'ERROR', 2, 'msg3'),
    (4, 'WARN', 2, 'msg4');

SELECT DISTINCT ON (user_id) user_id, message
FROM logs
WHERE level = 'ERROR'
ORDER BY user_id, id ASC;
-- Result: First ERROR log per user

-- Test: DISTINCT ON with JOIN
-- Expected: Get latest order per user with user name
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, total FLOAT64, date INT64);
DROP TABLE IF EXISTS users_join;
CREATE TABLE users_join (id INT64, name STRING);
INSERT INTO orders VALUES
    (1, 1, 100.0, 1),
    (2, 1, 200.0, 2),
    (3, 2, 150.0, 1);
INSERT INTO users_join VALUES (1, 'Alice'), (2, 'Bob');

SELECT DISTINCT ON (users_join.id) users_join.name, orders.total, orders.date
FROM orders
JOIN users_join ON orders.user_id = users_join.id
ORDER BY users_join.id, orders.date DESC;
-- Result: Alice's latest order = 200.0

-- Test: DISTINCT ON in subquery
-- Expected: Use DISTINCT ON results in outer query
SELECT user_id, timestamp
FROM (
    SELECT DISTINCT ON (user_id) user_id, timestamp
    FROM events
    ORDER BY user_id, timestamp DESC
) AS latest;
-- Result: All latest events per user

-- Test: DISTINCT ON with CTE
-- Expected: CTE can contain DISTINCT ON query
WITH latest_sales AS (
    SELECT DISTINCT ON (product) product, amount, date
    FROM sales
    ORDER BY product, date DESC
)
SELECT * FROM latest_sales ORDER BY product;
-- Result: Latest sale for each product

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: ORDER BY mismatch error
-- Expected: Error - DISTINCT ON must match leftmost ORDER BY
DROP TABLE IF EXISTS data_error;
CREATE TABLE data_error (id INT64, a STRING, b STRING);

SELECT DISTINCT ON (a) a, b
FROM data_error
ORDER BY b;
-- ERROR: DISTINCT ON expressions must match initial ORDER BY expressions

-- Test: Missing ORDER BY error
-- Expected: Error - ORDER BY required with DISTINCT ON
SELECT DISTINCT ON (category) category, id
FROM data_error;
-- ERROR: SELECT DISTINCT ON requires ORDER BY clause

-- Test: Invalid column error
-- Expected: Error - column not found
SELECT DISTINCT ON (nonexistent) category, id
FROM data_error
ORDER BY nonexistent;
-- ERROR: column "nonexistent" does not exist

-- Test: DISTINCT and DISTINCT ON together
-- Expected: Error - cannot use both
SELECT DISTINCT DISTINCT ON (category) category, id
FROM data_error
ORDER BY category;
-- ERROR: syntax error

-- ============================================================================
-- Complex / Real-World Scenarios
-- ============================================================================

-- Test: Deduplication - keep latest record
-- Expected: Latest user snapshot per email
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES
    (1, 'alice@example.com', 'Alice A', 1),
    (2, 'alice@example.com', 'Alice B', 2),
    (3, 'bob@example.com', 'Bob', 1),
    (4, 'alice@example.com', 'Alice C', 3);

SELECT DISTINCT ON (email) email, name, updated_at
FROM user_snapshots
ORDER BY email, updated_at DESC;
-- Result: Alice C for alice@example.com

-- Test: Top N per group (N=1 for DISTINCT ON)
-- Expected: Top selling product per category
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64, category STRING, sales INT64);
INSERT INTO equipment VALUES
    (1, 'electronics', 1000),
    (2, 'electronics', 1500),
    (3, 'books', 500),
    (4, 'books', 800);

SELECT DISTINCT ON (category) category, id, sales
FROM equipment
ORDER BY category, sales DESC;
-- Result: electronics top = 1500, books top = 800

-- Test: DISTINCT ON with LIMIT
-- Expected: Limit applied after DISTINCT ON
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES
    (1, 'A', 10),
    (2, 'A', 20),
    (3, 'B', 30),
    (4, 'C', 40);

SELECT DISTINCT ON (category) category, value
FROM items
ORDER BY category, value DESC
LIMIT 2;
-- Result: Only 2 categories returned

-- Test: DISTINCT ON with OFFSET
-- Expected: Skip first category after DISTINCT ON
SELECT DISTINCT ON (category) category, value
FROM items
ORDER BY category
OFFSET 1;
-- Result: Skip first distinct category

-- ============================================================================
-- GROUP BY Error Test
-- ============================================================================

-- Test: DISTINCT ON with GROUP BY
-- Expected: Error - cannot use together
DROP TABLE IF EXISTS data_group;
CREATE TABLE data_group (id INT64, category STRING, value INT64);

SELECT DISTINCT ON (category) category, SUM(value)
FROM data_group
GROUP BY category
ORDER BY category;
-- ERROR: DISTINCT ON cannot be used with GROUP BY
