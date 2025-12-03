-- Window Functions Recursive - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, manager_id INT64, salary INT64);
INSERT INTO employees VALUES (1, NULL, 100000);
INSERT INTO employees VALUES (2, 1, 80000), (3, 1, 90000);
INSERT INTO employees VALUES (4, 2, 60000), (5, 2, 70000);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data STRING);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Apple', 1.5), (2, 'Banana', 0.5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('West', 'A', 100), ('West', 'B', 200);
INSERT INTO sales VALUES ('East', 'A', 150), ('East', 'B', 250);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date DATE, price FLOAT64);
INSERT INTO prices VALUES (DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES (DATE '2024-01-02', 11.0);
INSERT INTO prices VALUES (DATE '2024-01-03', NULL);
INSERT INTO prices VALUES (DATE '2024-01-04', 12.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, user_id INT64, date DATE, amount FLOAT64, category STRING);
INSERT INTO transactions VALUES (1, 1, DATE '2024-01-05', 100.0, 'Food');
INSERT INTO transactions VALUES (2, 1, DATE '2024-01-15', 50.0, 'Transport');
INSERT INTO transactions VALUES (3, 2, DATE '2024-01-10', 200.0, 'Food');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, product STRING, quantity INT64, price FLOAT64);
INSERT INTO orders VALUES (1, 'A', 5, 10.0), (1, 'B', 3, 20.0);
INSERT INTO orders VALUES (2, 'A', 10, 10.0), (2, 'B', 1, 20.0);
DROP TABLE IF EXISTS sales_2023;
CREATE TABLE sales_2023 (product STRING, amount INT64);
DROP TABLE IF EXISTS sales_2024;
CREATE TABLE sales_2024 (product STRING, amount INT64);
INSERT INTO sales_2023 VALUES ('A', 100), ('B', 200);
INSERT INTO sales_2024 VALUES ('A', 150), ('B', 250);

-- Tag: window_functions_window_functions_recursive_test_select_001
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_recursive_test_select_002
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_recursive_test_select_003
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_recursive_test_select_004
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS tree_nodes;
CREATE TABLE tree_nodes ( id INT64, parent_id INT64, level INT64 );
INSERT INTO tree_nodes VALUES
(1, NULL, 0),
(2, 1, 1), (3, 1, 1),
(4, 2, 2), (5, 2, 2), (6, 3, 2), (7, 3, 2),
(8, 4, 3), (9, 4, 3), (10, 5, 3), (11, 5, 3);
DROP TABLE IF EXISTS nullable_hierarchy;
CREATE TABLE nullable_hierarchy ( id INT64, parent_id INT64 );
INSERT INTO nullable_hierarchy VALUES
(1, NULL),
(2, 1),
(3, NULL),  -- Another root
(4, 3);
DROP TABLE IF EXISTS edges;
CREATE TABLE edges ( from_node INT64, to_node INT64 );
INSERT INTO edges VALUES
(1, 2), (1, 3),
(2, 4), (3, 4),  -- Two paths to node 4
(4, 5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( day INT64, amount INT64 );
INSERT INTO sales VALUES
(1, 100), (2, 150), (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_recursive_test_select_005
SELECT id, parent_id, level, 1 AS iteration
FROM tree_nodes
WHERE parent_id IS NULL
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_006
SELECT tn.id, tn.parent_id, tn.level, t.iteration + 1
FROM tree_nodes tn
JOIN tree t ON tn.parent_id = t.id
WHERE t.iteration < 4  -- Limit iterations
)
-- Tag: window_functions_window_functions_recursive_test_select_007
SELECT COUNT(*), MAX(level) FROM tree;
WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_recursive_test_select_008
SELECT id, parent_id, 0 AS level
FROM nullable_hierarchy
WHERE id = 1
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_009
SELECT nh.id, nh.parent_id, t.level + 1
FROM nullable_hierarchy nh
JOIN tree t ON nh.parent_id = t.id
)
-- Tag: window_functions_window_functions_recursive_test_select_010
SELECT COUNT(*) FROM tree;
WITH RECURSIVE
numbers AS (
-- Tag: window_functions_window_functions_recursive_test_select_011
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_012
SELECT n + 1 FROM numbers WHERE n < 3
),
letters AS (
-- Tag: window_functions_window_functions_recursive_test_select_013
SELECT 'A' AS letter, 1 AS ord
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_001
SELECT
CASE ord
WHEN 1 THEN 'B'
WHEN 2 THEN 'C'
END,
ord + 1
FROM letters
WHERE ord < 3
)
-- Tag: window_functions_window_functions_recursive_test_select_014
SELECT n, letter FROM numbers CROSS JOIN letters ORDER BY n, ord;
WITH RECURSIVE paths AS (
-- Tag: window_functions_window_functions_recursive_test_select_015
SELECT DISTINCT from_node AS node, 0 AS hops
FROM edges
WHERE from_node = 1
UNION DISTINCT
-- Tag: window_functions_window_functions_recursive_test_select_016
SELECT DISTINCT e.to_node, p.hops + 1
FROM edges e
JOIN paths p ON e.from_node = p.node
WHERE p.hops < 3
)
-- Tag: window_functions_window_functions_recursive_test_select_017
SELECT * FROM paths ORDER BY node;
WITH RECURSIVE running_total AS (
-- Tag: window_functions_window_functions_recursive_test_select_018
SELECT day, amount, amount AS total
FROM sales
WHERE day = 1
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_019
SELECT s.day, s.amount, rt.total + s.amount
FROM sales s
JOIN running_total rt ON s.day = rt.day + 1
)
-- Tag: window_functions_window_functions_recursive_test_select_020
SELECT * FROM running_total ORDER BY day;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_021
SELECT 1 AS n, 'A' AS letter
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_022
SELECT n + 1 FROM broken WHERE n < 5  -- Missing 'letter' column!
)
-- Tag: window_functions_window_functions_recursive_test_select_023
SELECT * FROM broken;
WITH RECURSIVE type_broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_024
SELECT 1 AS value
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_025
SELECT 'not a number' FROM type_broken WHERE value < 5  -- Type mismatch!
)
-- Tag: window_functions_window_functions_recursive_test_select_026
SELECT * FROM type_broken;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_027
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_028
SELECT n + 1
FROM non_existent_table  -- Table doesn't exist!
WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_029
SELECT * FROM broken;
WITH numbers AS (  -- Missing RECURSIVE!
-- Tag: window_functions_window_functions_recursive_test_select_030
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_031
SELECT n + 1 FROM numbers WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_032
SELECT * FROM numbers;
WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_recursive_test_select_033
SELECT id FROM data WHERE id = 999  -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_034
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_035
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_036
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_037
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_recursive_test_select_038
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_039
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_040
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_recursive_test_select_041
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_recursive_test_select_042
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_043
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_044
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_045
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_046
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_047
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_002
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

DROP TABLE IF EXISTS edges;
CREATE TABLE edges ( from_node INT64, to_node INT64 );
INSERT INTO edges VALUES
(1, 2), (1, 3),
(2, 4), (3, 4),  -- Two paths to node 4
(4, 5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( day INT64, amount INT64 );
INSERT INTO sales VALUES
(1, 100), (2, 150), (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

WITH RECURSIVE paths AS (
-- Tag: window_functions_window_functions_recursive_test_select_048
SELECT DISTINCT from_node AS node, 0 AS hops
FROM edges
WHERE from_node = 1
UNION DISTINCT
-- Tag: window_functions_window_functions_recursive_test_select_049
SELECT DISTINCT e.to_node, p.hops + 1
FROM edges e
JOIN paths p ON e.from_node = p.node
WHERE p.hops < 3
)
-- Tag: window_functions_window_functions_recursive_test_select_050
SELECT * FROM paths ORDER BY node;
WITH RECURSIVE running_total AS (
-- Tag: window_functions_window_functions_recursive_test_select_051
SELECT day, amount, amount AS total
FROM sales
WHERE day = 1
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_052
SELECT s.day, s.amount, rt.total + s.amount
FROM sales s
JOIN running_total rt ON s.day = rt.day + 1
)
-- Tag: window_functions_window_functions_recursive_test_select_053
SELECT * FROM running_total ORDER BY day;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_054
SELECT 1 AS n, 'A' AS letter
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_055
SELECT n + 1 FROM broken WHERE n < 5  -- Missing 'letter' column!
)
-- Tag: window_functions_window_functions_recursive_test_select_056
SELECT * FROM broken;
WITH RECURSIVE type_broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_057
SELECT 1 AS value
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_058
SELECT 'not a number' FROM type_broken WHERE value < 5  -- Type mismatch!
)
-- Tag: window_functions_window_functions_recursive_test_select_059
SELECT * FROM type_broken;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_recursive_test_select_060
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_061
SELECT n + 1
FROM non_existent_table  -- Table doesn't exist!
WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_062
SELECT * FROM broken;
WITH numbers AS (  -- Missing RECURSIVE!
-- Tag: window_functions_window_functions_recursive_test_select_063
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_064
SELECT n + 1 FROM numbers WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_065
SELECT * FROM numbers;
WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_recursive_test_select_066
SELECT id FROM data WHERE id = 999  -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_067
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_068
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_069
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_070
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_recursive_test_select_071
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_072
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_073
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_recursive_test_select_074
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_recursive_test_select_075
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_076
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_077
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_078
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_079
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_080
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_003
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_recursive_test_select_081
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_recursive_test_select_082
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_recursive_test_select_004
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

