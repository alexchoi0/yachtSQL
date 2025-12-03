-- Window Functions Subqueries - SQL:2023
-- Description: Subqueries in SELECT, WHERE, and FROM clauses
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (20), (NULL), (30);
DROP TABLE IF EXISTS indexed_data;
CREATE TABLE indexed_data (id INT64, value INT64);
CREATE INDEX idx_value ON indexed_data(value);
INSERT INTO indexed_data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
CREATE INDEX idx_value ON data(value);
DROP INDEX idx_value;
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
INSERT INTO evolving VALUES (1);
ALTER TABLE evolving ADD COLUMN value INT64 DEFAULT 100;
INSERT INTO evolving VALUES (2, 200);
ALTER TABLE evolving ADD COLUMN name STRING DEFAULT 'test';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (session_id INT64, status STRING);
INSERT INTO sessions VALUES (1, 'active');
INSERT INTO sessions VALUES (1, 'new');
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
INSERT INTO outer_table VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS recovery_test;
CREATE TABLE recovery_test (id INT64);
INSERT INTO recovery_test VALUES (1);

-- Tag: window_functions_window_functions_subqueries_test_select_001
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_002
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_subqueries_test_select_003
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_subqueries_test_select_004
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_005
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_subqueries_test_select_006
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_subqueries_test_select_007
SELECT * FROM large;
-- Tag: window_functions_window_functions_subqueries_test_select_008
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_009
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_subqueries_test_select_010
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_011
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_012
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_subqueries_test_select_013
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_subqueries_test_select_014
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_015
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);

-- Tag: window_functions_window_functions_subqueries_test_select_016
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_subqueries_test_select_017
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_subqueries_test_select_018
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_subqueries_test_select_019
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_subqueries_test_select_020
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: window_functions_window_functions_subqueries_test_select_021
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_subqueries_test_select_022
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_subqueries_test_select_023
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_subqueries_test_select_024
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_001
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_subqueries_test_select_025
SELECT userid FROM users;
-- Tag: window_functions_window_functions_subqueries_test_select_026
SELECT * FROM user;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value STRING);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, related STRING);
INSERT INTO t1 VALUES (1, 'test');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (a INT64, b INT64, c INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 10), (2, 20);
INSERT INTO t3 VALUES (1, 10, 100), (2, 20, 200);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, ref_id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (ref_id INT64, data STRING);
INSERT INTO outer_table VALUES (1, 100), (2, NULL), (3, 200);
INSERT INTO inner_table VALUES (100, 'A'), (200, 'B');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_subqueries_test_select_027
SELECT t1.value, t2.related
FROM t1
CROSS JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2;
-- Tag: window_functions_window_functions_subqueries_test_select_028
SELECT t1.value, t2.related
FROM t1
LEFT JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2 ON true;
-- Tag: window_functions_window_functions_subqueries_test_select_029
SELECT t1.a, x.b, y.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_030
SELECT b FROM t2 WHERE t2.a = t1.a
) x
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_031
SELECT c FROM t3 WHERE t3.a = t1.a AND t3.b = x.b
) y
ORDER BY t1.a;
-- Tag: window_functions_window_functions_subqueries_test_select_032
SELECT o.id, i.data
FROM outer_table o
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_033
SELECT data FROM inner_table WHERE ref_id = o.ref_id
) i
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_034
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_035
SELECT * FROM t2 WHERE id = t1.nonexistent_col
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_036
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_037
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_038
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_039
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_subqueries_test_select_040
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_subqueries_test_select_041
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_042
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_subqueries_test_select_043
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_002
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_044
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_045
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_046
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_047
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_048
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (a INT64, b INT64, c INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 10), (2, 20);
INSERT INTO t3 VALUES (1, 10, 100), (2, 20, 200);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, ref_id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (ref_id INT64, data STRING);
INSERT INTO outer_table VALUES (1, 100), (2, NULL), (3, 200);
INSERT INTO inner_table VALUES (100, 'A'), (200, 'B');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_subqueries_test_select_049
SELECT t1.a, x.b, y.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_050
SELECT b FROM t2 WHERE t2.a = t1.a
) x
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_051
SELECT c FROM t3 WHERE t3.a = t1.a AND t3.b = x.b
) y
ORDER BY t1.a;
-- Tag: window_functions_window_functions_subqueries_test_select_052
SELECT o.id, i.data
FROM outer_table o
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_053
SELECT data FROM inner_table WHERE ref_id = o.ref_id
) i
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_054
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_055
SELECT * FROM t2 WHERE id = t1.nonexistent_col
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_056
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_057
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_058
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_059
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_subqueries_test_select_060
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_subqueries_test_select_061
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_062
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_subqueries_test_select_063
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_003
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_064
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_065
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_066
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_067
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_068
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_subqueries_test_select_069
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_070
SELECT * FROM t2 WHERE id = t1.nonexistent_col
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_071
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_072
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_073
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_074
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_subqueries_test_select_075
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_subqueries_test_select_076
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_077
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_subqueries_test_select_078
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_004
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_079
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_080
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_081
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_082
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_083
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_subqueries_test_select_084
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_085
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_086
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_087
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_subqueries_test_select_088
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_subqueries_test_select_089
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_090
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_subqueries_test_select_091
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_005
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_092
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_093
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_094
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_095
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_096
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

WITH customer_totals AS (
-- Tag: window_functions_window_functions_subqueries_test_select_097
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_subqueries_test_select_098
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_099
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_subqueries_test_select_100
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_006
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_101
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_102
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_103
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_104
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_105
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_subqueries_test_select_106
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_007
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_subqueries_test_select_107
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_108
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_109
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_subqueries_test_select_110
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_subqueries_test_select_111
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS duplicates;
CREATE TABLE duplicates (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO duplicates VALUES (42), (42), (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS multi;
CREATE TABLE multi (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO multi VALUES (10), (20), (10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64);
INSERT INTO orders VALUES
(1, 100),
(2, 100),
(3, 200),
(4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (value STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES ('123');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (discount_pct INT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS config;
CREATE TABLE config (prefix STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO config VALUES ('User: ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (text STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO messages VALUES ('Hello World');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64, in_stock BOOL);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (min_price FLOAT64);
INSERT INTO products VALUES
(1, 50.0, true),
(2, 150.0, true),
(3, 75.0, false);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (special_value INT64);
INSERT INTO items VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO config VALUES (20);
DROP TABLE IF EXISTS values;
CREATE TABLE values (id INT64, num INT64);
DROP TABLE IF EXISTS range;
CREATE TABLE range (min INT64, max INT64);
INSERT INTO values VALUES (1, 5), (2, 15), (3, 25);
INSERT INTO range VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (id INT64, name STRING);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, cat_id INT64, price FLOAT64);
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Clothing');
INSERT INTO items VALUES
(1, 1, 100.0),
(2, 1, 200.0),
(3, 2, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_subqueries_test_select_112
SELECT id, (SELECT DISTINCT value FROM duplicates) as unique_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_113
SELECT id, (SELECT DISTINCT value FROM multi) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_114
SELECT (SELECT COUNT(DISTINCT customer_id) FROM orders) as unique_customers;
-- Tag: window_functions_window_functions_subqueries_test_select_115
SELECT id, (SELECT CAST(value AS INT64) FROM config) as int_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_116
SELECT id, price, price * (SELECT discount_pct FROM config) / 100.0 as discount
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_117
SELECT id, CONCAT((SELECT prefix FROM config), name) as formatted_name
FROM users
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_118
SELECT id,
(SELECT UPPER(text) FROM messages) as upper_msg,
(SELECT LOWER(text) FROM messages) as lower_msg
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_119
SELECT id, price
FROM products
WHERE in_stock = true AND price > (SELECT min_price FROM thresholds)
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_120
SELECT id
FROM items
WHERE value < 15 OR value = (SELECT special_value FROM config)
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_121
SELECT id
FROM values
WHERE num BETWEEN (SELECT min FROM range) AND (SELECT max FROM range)
ORDER BY id;
WITH stats AS (
-- Tag: window_functions_window_functions_subqueries_test_select_122
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_subqueries_test_select_123
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_subqueries_test_select_124
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_subqueries_test_select_125
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_subqueries_test_select_126
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_subqueries_test_select_127
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_128
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_subqueries_test_select_129
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_130
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_131
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_132
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_133
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_134
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_135
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_136
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (text STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO messages VALUES ('Hello World');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64, in_stock BOOL);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (min_price FLOAT64);
INSERT INTO products VALUES
(1, 50.0, true),
(2, 150.0, true),
(3, 75.0, false);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (special_value INT64);
INSERT INTO items VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO config VALUES (20);
DROP TABLE IF EXISTS values;
CREATE TABLE values (id INT64, num INT64);
DROP TABLE IF EXISTS range;
CREATE TABLE range (min INT64, max INT64);
INSERT INTO values VALUES (1, 5), (2, 15), (3, 25);
INSERT INTO range VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (id INT64, name STRING);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, cat_id INT64, price FLOAT64);
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Clothing');
INSERT INTO items VALUES
(1, 1, 100.0),
(2, 1, 200.0),
(3, 2, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_subqueries_test_select_137
SELECT id,
(SELECT UPPER(text) FROM messages) as upper_msg,
(SELECT LOWER(text) FROM messages) as lower_msg
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_138
SELECT id, price
FROM products
WHERE in_stock = true AND price > (SELECT min_price FROM thresholds)
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_139
SELECT id
FROM items
WHERE value < 15 OR value = (SELECT special_value FROM config)
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_140
SELECT id
FROM values
WHERE num BETWEEN (SELECT min FROM range) AND (SELECT max FROM range)
ORDER BY id;
WITH stats AS (
-- Tag: window_functions_window_functions_subqueries_test_select_141
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_subqueries_test_select_142
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_subqueries_test_select_143
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_subqueries_test_select_144
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_subqueries_test_select_145
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_subqueries_test_select_146
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_147
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_subqueries_test_select_148
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_149
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_150
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_151
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_152
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_153
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_154
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_155
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (id INT64, name STRING);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, cat_id INT64, price FLOAT64);
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Clothing');
INSERT INTO items VALUES
(1, 1, 100.0),
(2, 1, 200.0),
(3, 2, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

WITH stats AS (
-- Tag: window_functions_window_functions_subqueries_test_select_156
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_subqueries_test_select_157
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_subqueries_test_select_158
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_subqueries_test_select_159
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_subqueries_test_select_160
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_subqueries_test_select_161
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_162
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_subqueries_test_select_163
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_164
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_165
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_166
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_167
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_168
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_169
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_170
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_subqueries_test_select_171
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_subqueries_test_select_172
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_173
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_subqueries_test_select_174
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_175
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_176
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_177
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_178
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_179
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_180
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_181
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_subqueries_test_select_182
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_183
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_184
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_185
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_186
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING, value FLOAT64);
INSERT INTO products VALUES
(1, 'Widget', 10.0),
(2, 'Gadget', 20.0);
INSERT INTO settings VALUES ('discount', 0.1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min_val INT64, max_val INT64);
INSERT INTO data VALUES (5);
INSERT INTO stats VALUES (1, 10);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 1, 50000.0),
(2, 'Bob', 1, 60000.0),
(3, 'Charlie', 2, 55000.0),
(4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 'Alice'),
(2, 1, 'Bob'),
(3, 2, 'Charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_187
SELECT id, (SELECT 42) as constant FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_188
SELECT name, salary, (SELECT AVG(salary) FROM employees) as avg_salary
FROM employees
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_189
SELECT name, price,
price * (SELECT value FROM settings WHERE key = 'discount') as discount
FROM products
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_190
SELECT id,
(SELECT min_val FROM stats) as min_value,
(SELECT max_val FROM stats) as max_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_191
SELECT e1.name, e1.salary,
(SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.dept_id = e1.dept_id) as dept_avg
FROM employees e1
ORDER BY e1.name;
-- Tag: window_functions_window_functions_subqueries_test_select_192
SELECT d.name,
(SELECT COUNT(*) FROM employees e WHERE e.dept_id = d.id) as emp_count
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_193
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_194
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_195
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_196
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_197
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_198
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_199
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_200
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_201
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_202
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_203
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_204
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_205
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_206
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_207
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_208
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_209
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_210
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_211
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_212
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_213
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_214
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_215
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING, value FLOAT64);
INSERT INTO products VALUES
(1, 'Widget', 10.0),
(2, 'Gadget', 20.0);
INSERT INTO settings VALUES ('discount', 0.1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min_val INT64, max_val INT64);
INSERT INTO data VALUES (5);
INSERT INTO stats VALUES (1, 10);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 1, 50000.0),
(2, 'Bob', 1, 60000.0),
(3, 'Charlie', 2, 55000.0),
(4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 'Alice'),
(2, 1, 'Bob'),
(3, 2, 'Charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_216
SELECT name, salary, (SELECT AVG(salary) FROM employees) as avg_salary
FROM employees
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_217
SELECT name, price,
price * (SELECT value FROM settings WHERE key = 'discount') as discount
FROM products
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_218
SELECT id,
(SELECT min_val FROM stats) as min_value,
(SELECT max_val FROM stats) as max_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_219
SELECT e1.name, e1.salary,
(SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.dept_id = e1.dept_id) as dept_avg
FROM employees e1
ORDER BY e1.name;
-- Tag: window_functions_window_functions_subqueries_test_select_220
SELECT d.name,
(SELECT COUNT(*) FROM employees e WHERE e.dept_id = d.id) as emp_count
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_221
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_222
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_223
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_224
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_225
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_226
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_227
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_228
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_229
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_230
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_231
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_232
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_233
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_234
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_235
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_236
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_237
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_238
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_239
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_240
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_241
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_242
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_243
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING, value FLOAT64);
INSERT INTO products VALUES
(1, 'Widget', 10.0),
(2, 'Gadget', 20.0);
INSERT INTO settings VALUES ('discount', 0.1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min_val INT64, max_val INT64);
INSERT INTO data VALUES (5);
INSERT INTO stats VALUES (1, 10);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 1, 50000.0),
(2, 'Bob', 1, 60000.0),
(3, 'Charlie', 2, 55000.0),
(4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 'Alice'),
(2, 1, 'Bob'),
(3, 2, 'Charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_244
SELECT name, price,
price * (SELECT value FROM settings WHERE key = 'discount') as discount
FROM products
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_245
SELECT id,
(SELECT min_val FROM stats) as min_value,
(SELECT max_val FROM stats) as max_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_246
SELECT e1.name, e1.salary,
(SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.dept_id = e1.dept_id) as dept_avg
FROM employees e1
ORDER BY e1.name;
-- Tag: window_functions_window_functions_subqueries_test_select_247
SELECT d.name,
(SELECT COUNT(*) FROM employees e WHERE e.dept_id = d.id) as emp_count
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_248
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_249
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_250
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_251
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_252
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_253
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_254
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_255
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_256
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_257
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_258
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_259
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_260
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_261
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_262
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_263
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_264
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_265
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_266
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_267
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_268
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_269
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_270
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min_val INT64, max_val INT64);
INSERT INTO data VALUES (5);
INSERT INTO stats VALUES (1, 10);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 1, 50000.0),
(2, 'Bob', 1, 60000.0),
(3, 'Charlie', 2, 55000.0),
(4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 'Alice'),
(2, 1, 'Bob'),
(3, 2, 'Charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_271
SELECT id,
(SELECT min_val FROM stats) as min_value,
(SELECT max_val FROM stats) as max_value
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_272
SELECT e1.name, e1.salary,
(SELECT AVG(e2.salary)
FROM employees e2
WHERE e2.dept_id = e1.dept_id) as dept_avg
FROM employees e1
ORDER BY e1.name;
-- Tag: window_functions_window_functions_subqueries_test_select_273
SELECT d.name,
(SELECT COUNT(*) FROM employees e WHERE e.dept_id = d.id) as emp_count
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_274
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_275
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_276
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_subqueries_test_select_277
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_278
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_279
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_280
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_281
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_282
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_283
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_284
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_285
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_286
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_287
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_288
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_289
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_290
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_291
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_292
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_293
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_294
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_295
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_296
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_297
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_298
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_subqueries_test_select_299
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_300
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_301
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_302
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_303
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_304
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_305
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_306
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_307
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_308
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_309
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_310
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_311
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_312
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_313
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_314
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_315
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_316
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_subqueries_test_select_317
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_subqueries_test_select_318
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_319
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_320
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_321
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_322
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_323
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_324
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_325
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_326
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_327
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_328
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_329
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_330
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_331
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_subqueries_test_select_332
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_333
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_334
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_335
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_336
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_337
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_338
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_339
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_340
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_341
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_342
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_343
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_344
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_subqueries_test_select_345
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_subqueries_test_select_346
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_347
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_subqueries_test_select_348
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_349
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_350
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_351
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_352
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_353
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_354
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_355
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_356
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_357
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_358
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_359
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_360
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_361
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_362
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_363
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_364
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_365
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_subqueries_test_select_366
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_367
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_368
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_369
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_subqueries_test_select_370
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_subqueries_test_select_371
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_subqueries_test_select_372
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_subqueries_test_select_373
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

