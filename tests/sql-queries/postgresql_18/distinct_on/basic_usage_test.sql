-- ============================================================================
-- Basic Usage - PostgreSQL 18
-- ============================================================================
-- Source: tests/distinct_on_comprehensive_tdd.rs
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Single Column DISTINCT ON
-- Expected: Returns most recent action per user
-- ============================================================================
-- Get most recent action per user
-- Expected result: 2 rows
-- user_id=1, action='click', timestamp=200
-- user_id=2, action='logout', timestamp=300
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, user_id INT64, action STRING, timestamp INT64);
INSERT INTO events VALUES (1, 1, 'login', 100), (2, 1, 'click', 200), (3, 2, 'login', 150), (4, 2, 'logout', 300);

SELECT DISTINCT ON (user_id) user_id, action, timestamp FROM events ORDER BY user_id, timestamp DESC;

-- ============================================================================
-- Test: DISTINCT ON Returns First Row Per Group
-- Expected: Returns earliest price for each product
-- ============================================================================
-- Get earliest price for each product
-- Expected result: 2 rows
-- product='gadget', price=20.0, date=1
-- product='widget', price=10.0, date=1
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (id INT64, product STRING, date INT64, price FLOAT64);
INSERT INTO prices VALUES (1, 'widget', 1, 10.0), (2, 'widget', 2, 12.0), (3, 'widget', 3, 11.0), (4, 'gadget', 1, 20.0), (5, 'gadget', 2, 18.0);

SELECT DISTINCT ON (product) product, price, date FROM prices ORDER BY product, date ASC;

-- ============================================================================
-- Test: Multiple DISTINCT ON Columns
-- Expected: Returns latest sale per region AND product combination
-- ============================================================================
-- Get latest sale per region AND product
-- Expected result: 3 rows
-- region='North', product='gadget', amount=200.0, date=1
-- region='North', product='widget', amount=150.0, date=2
-- region='South', product='widget', amount=110.0, date=2
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, product STRING, amount FLOAT64, date INT64);
INSERT INTO sales VALUES (1, 'North', 'widget', 100.0, 1), (2, 'North', 'widget', 150.0, 2), (3, 'North', 'gadget', 200.0, 1), (4, 'South', 'widget', 120.0, 1), (5, 'South', 'widget', 110.0, 2);

SELECT DISTINCT ON (region, product) region, product, amount, date FROM sales ORDER BY region, product, date DESC;

-- ============================================================================
-- Test: DISTINCT ON with Expression
-- Expected: Deduplicates by case-insensitive email, keeps most recent
-- ============================================================================
-- Deduplicate by case-insensitive email
-- Expected result: 2 rows
-- id=2, email='ALICE@EXAMPLE.COM', created_at=200
-- id=3, email='bob@example.com', created_at=150
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, email STRING, created_at INT64);
INSERT INTO users VALUES (1, 'alice@example.com', 100), (2, 'ALICE@EXAMPLE.COM', 200), (3, 'bob@example.com', 150);

SELECT DISTINCT ON (LOWER(email)) id, email, created_at FROM users ORDER BY LOWER(email), created_at DESC;
