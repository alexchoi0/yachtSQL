-- Basic Views - SQL:2023
-- Description: Basic VIEW creation and usage
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64,
    name STRING,
    age INT64
);

INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35);

-- Create a simple view
DROP VIEW IF EXISTS adult_users;
CREATE VIEW adult_users AS
-- Tag: views_basic_views_test_select_001
SELECT * FROM users WHERE age >= 18;

-- Query the view
-- Tag: views_basic_views_test_select_002
SELECT * FROM adult_users ORDER BY id;

-- CREATE VIEW - With Computed Columns

-- Setup
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    name STRING,
    price FLOAT64,
    quantity INT64
);

INSERT INTO equipment VALUES
    (1, 'Widget', 10.50, 100),
    (2, 'Gadget', 25.00, 50);

-- Create view with computed column
DROP VIEW IF EXISTS product_inventory;
CREATE VIEW product_inventory AS
-- Tag: views_basic_views_test_select_001
SELECT
    id,
    name,
    price,
    quantity,
    price * quantity AS total_value
FROM equipment;

-- Query view
-- Tag: views_basic_views_test_select_003
SELECT * FROM product_inventory ORDER BY id;
-- (1, 'Widget', 10.50, 100, 1050.0)
-- (2, 'Gadget', 25.00, 50, 1250.0)

-- CREATE VIEW - With JOINs

-- Setup
DROP TABLE IF EXISTS fleets;
CREATE TABLE fleets (
    id INT64,
    name STRING
);

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64,
    name STRING,
    dept_id INT64,
    salary INT64
);

INSERT INTO fleets VALUES (1, 'Engineering'), (2, 'Sales');

INSERT INTO crew_members VALUES
    (1, 'Alice', 1, 80000),
    (2, 'Bob', 2, 60000),
    (3, 'Charlie', 1, 90000);

-- Create view with JOIN
DROP VIEW IF EXISTS crew_member_details;
CREATE VIEW crew_member_details AS
-- Tag: views_basic_views_test_select_002
SELECT
    e.id,
    e.name,
    d.name AS fleet,
    e.salary
FROM crew_members e
JOIN fleets d ON e.dept_id = d.id;

-- Query view
-- Tag: views_basic_views_test_select_004
SELECT * FROM crew_member_details ORDER BY id;

-- CREATE VIEW - With Aggregations

-- Setup
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT64,
    product STRING,
    amount FLOAT64,
    region STRING
);

INSERT INTO sales VALUES
    (1, 'Widget', 100, 'North'),
    (2, 'Widget', 150, 'South'),
    (3, 'Gadget', 200, 'North');

-- Create view with GROUP BY
DROP VIEW IF EXISTS sales_by_region;
CREATE VIEW sales_by_region AS
-- Tag: views_basic_views_test_select_003
SELECT
    region,
    SUM(amount) AS total_sales,
    COUNT(*) AS sale_count
FROM sales
GROUP BY region;

-- Query view
-- Tag: views_basic_views_test_select_005
SELECT * FROM sales_by_region ORDER BY region;
-- ('North', 300, 2)
-- ('South', 150, 1)

-- CREATE VIEW - With Subquery

-- Setup
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT64,
    owner_id INT64,
    total FLOAT64
);

INSERT INTO orders VALUES
    (1, 1, 100),
    (2, 1, 200),
    (3, 2, 150),
    (4, 2, 175);

-- View with correlated subquery
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: views_basic_views_test_select_006
SELECT DISTINCT
    owner_id,
    (SELECT COUNT(*) FROM orders o2 WHERE o2.owner_id = o1.owner_id) AS order_count,
    (SELECT SUM(total) FROM orders o2 WHERE o2.owner_id = o1.owner_id) AS total_spent
FROM orders o1;

-- Query view
-- Tag: views_basic_views_test_select_007
SELECT * FROM customer_order_stats ORDER BY owner_id;
-- (1, 2, 300)
-- (2, 2, 325)

-- CREATE VIEW - With WHERE Clause

DROP TABLE IF EXISTS items;
CREATE TABLE items (
    id INT64,
    name STRING,
    category STRING,
    price FLOAT64
);

INSERT INTO items VALUES
    (1, 'Item A', 'Electronics', 100.0),
    (2, 'Item B', 'Books', 20.0),
    (3, 'Item C', 'Electronics', 150.0);

-- View filtering by category
DROP VIEW IF EXISTS electronics;
CREATE VIEW electronics AS
-- Tag: views_basic_views_test_select_008
SELECT * FROM items WHERE category = 'Electronics';

-- Tag: views_basic_views_test_select_009
SELECT * FROM electronics ORDER BY id;

-- CREATE VIEW - With ORDER BY

-- Note: ORDER BY in view definition may not be guaranteed
-- unless used in query on the view

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (
    id INT64,
    name STRING,
    score INT64
);

INSERT INTO scores VALUES (1, 'Alice', 85), (2, 'Bob', 92), (3, 'Charlie', 78);

-- View with implicit ordering (may not be preserved)
DROP VIEW IF EXISTS top_scores;
CREATE VIEW top_scores AS
-- Tag: views_basic_views_test_select_010
SELECT * FROM scores WHERE score >= 80;

-- Query with explicit ORDER BY
-- Tag: views_basic_views_test_select_011
SELECT * FROM top_scores ORDER BY score DESC;

-- CREATE OR REPLACE VIEW

-- Setup
DROP TABLE IF EXISTS data;
CREATE TABLE data (
    id INT64,
    value INT64
);

INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);

-- Create initial view
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS
-- Tag: views_basic_views_test_select_012
SELECT * FROM data WHERE value > 10;

-- Tag: views_basic_views_test_select_013
SELECT COUNT(*) FROM data_view;

-- Replace the view with different definition
CREATE OR REPLACE VIEW data_view AS
-- Tag: views_basic_views_test_select_014
SELECT * FROM data WHERE value > 20;

-- Tag: views_basic_views_test_select_015
SELECT COUNT(*) FROM data_view;

-- CREATE OR REPLACE VIEW - Change Columns

DROP TABLE IF EXISTS items_replace;
CREATE TABLE items_replace (
    id INT64,
    name STRING,
    price FLOAT64
);

INSERT INTO items_replace VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);

-- Create view with 2 columns
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS
-- Tag: views_basic_views_test_select_016
SELECT id, name FROM items_replace;

-- Tag: views_basic_views_test_select_017
SELECT * FROM item_view;

-- Replace with different columns
CREATE OR REPLACE VIEW item_view AS
-- Tag: views_basic_views_test_select_018
SELECT id, price FROM items_replace;

-- Tag: views_basic_views_test_select_019
SELECT * FROM item_view;

-- CREATE VIEW - Multiple Levels (View on View)

DROP TABLE IF EXISTS base_data;
CREATE TABLE base_data (
    id INT64,
    category STRING,
    value INT64
);

INSERT INTO base_data VALUES
    (1, 'A', 100),
    (2, 'A', 150),
    (3, 'B', 200);

-- First level view
DROP VIEW IF EXISTS category_a;
CREATE VIEW category_a AS
-- Tag: views_basic_views_test_select_020
SELECT * FROM base_data WHERE category = 'A';

-- Second level view (view on view)
DROP VIEW IF EXISTS high_value_a;
CREATE VIEW high_value_a AS
-- Tag: views_basic_views_test_select_021
SELECT * FROM category_a WHERE value > 120;

-- Tag: views_basic_views_test_select_022
SELECT * FROM high_value_a;

-- DROP VIEW

-- Create a view
DROP TABLE IF EXISTS temp_table;
CREATE TABLE temp_table (id INT64);
DROP VIEW IF EXISTS temp_view;
CREATE VIEW temp_view AS SELECT * FROM temp_table;

-- Verify view exists
-- Tag: views_basic_views_test_select_023
SELECT * FROM temp_view;

-- Drop the view
DROP VIEW temp_view;

-- Attempting to query dropped view should fail
-- SELECT * FROM temp_view;

-- DROP VIEW IF EXISTS

-- Drop view that doesn't exist (should not error)

-- Create and drop with IF EXISTS
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test_table;


-- VIEW - Column Aliases

DROP TABLE IF EXISTS source_data;
CREATE TABLE source_data (
    col1 INT64,
    col2 STRING
);

INSERT INTO source_data VALUES (1, 'A'), (2, 'B');

-- View with explicit column aliases
DROP VIEW IF EXISTS aliased_view;
CREATE VIEW aliased_view (id, label) AS
-- Tag: views_basic_views_test_select_024
SELECT col1, col2 FROM source_data;

-- Query using new column names
-- Tag: views_basic_views_test_select_025
SELECT id, label FROM aliased_view;

-- VIEW - SELECT DISTINCT

DROP TABLE IF EXISTS duplicates;
CREATE TABLE duplicates (
    category STRING,
    value INT64
);

INSERT INTO duplicates VALUES
    ('A', 1),
    ('A', 1),
    ('B', 2),
    ('B', 2);

-- View with DISTINCT
DROP VIEW IF EXISTS unique_combinations;
CREATE VIEW unique_combinations AS
-- Tag: views_basic_views_test_select_026
SELECT DISTINCT category, value FROM duplicates;

-- Tag: views_basic_views_test_select_027
SELECT * FROM unique_combinations ORDER BY category;

-- VIEW - Complex Query

DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
    owner_id INT64,
    name STRING
);

DROP TABLE IF EXISTS orders_complex;
CREATE TABLE orders_complex (
    order_id INT64,
    owner_id INT64,
    amount INT64
);

INSERT INTO yacht_owners VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders_complex VALUES
    (1, 1, 100),
    (2, 1, 200),
    (3, 2, 150);

-- Complex view with JOIN, aggregation, and HAVING
DROP VIEW IF EXISTS high_value_yacht_owners;
CREATE VIEW high_value_yacht_owners AS
-- Tag: views_basic_views_test_select_004
SELECT
    c.owner_id,
    c.name,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount) AS total_spent
FROM yacht_owners c
JOIN orders_complex o ON c.owner_id = o.owner_id
GROUP BY c.owner_id, c.name
HAVING SUM(o.amount) > 200;

-- Tag: views_basic_views_test_select_028
SELECT * FROM high_value_yacht_owners;

-- VIEW - WITH CTE

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    id INT64,
    amount INT64
);

INSERT INTO transactions VALUES (1, 100), (2, 200), (3, 300);

-- View using CTE
DROP VIEW IF EXISTS transaction_summary;
CREATE VIEW transaction_summary AS
WITH high_value AS (
-- Tag: views_basic_views_test_select_029
    SELECT * FROM transactions WHERE amount > 150
)
-- Tag: views_basic_views_test_select_030
SELECT COUNT(*) AS count, SUM(amount) AS total
FROM high_value;

-- Tag: views_basic_views_test_select_031
SELECT * FROM transaction_summary;

-- VIEW - NULL Handling

DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (
    id INT64,
    value STRING
);

INSERT INTO nullable_data VALUES (1, 'A'), (2, NULL), (3, 'C');

-- View with NULL filtering
DROP VIEW IF EXISTS non_null_values;
CREATE VIEW non_null_values AS
-- Tag: views_basic_views_test_select_032
SELECT * FROM nullable_data WHERE value IS NOT NULL;

-- Tag: views_basic_views_test_select_033
SELECT COUNT(*) FROM non_null_values;

-- VIEW - Dependent Views

-- When base table changes, views should reflect changes
DROP TABLE IF EXISTS dynamic_table;
CREATE TABLE dynamic_table (
    id INT64,
    value INT64
);

INSERT INTO dynamic_table VALUES (1, 10), (2, 20);

DROP VIEW IF EXISTS dynamic_view;
CREATE VIEW dynamic_view AS
-- Tag: views_basic_views_test_select_034
SELECT * FROM dynamic_table WHERE value > 10;

-- Tag: views_basic_views_test_select_035
SELECT COUNT(*) FROM dynamic_view;

-- Insert more data
INSERT INTO dynamic_table VALUES (3, 30);

-- Tag: views_basic_views_test_select_036
SELECT COUNT(*) FROM dynamic_view;

-- VIEW - Security/Encapsulation

-- Views can hide sensitive columns
DROP TABLE IF EXISTS user_accounts;
CREATE TABLE user_accounts (
    user_id INT64,
    username STRING,
    password_hash STRING,
    email STRING
);

INSERT INTO user_accounts VALUES
    (1, 'alice', 'hash1', 'alice@example.com');

-- Public view without sensitive data
DROP VIEW IF EXISTS public_users;
CREATE VIEW public_users AS
-- Tag: views_basic_views_test_select_037
SELECT user_id, username, email FROM user_accounts;

-- Query view (password_hash hidden)
-- Tag: views_basic_views_test_select_038
SELECT * FROM public_users;

-- End of File
