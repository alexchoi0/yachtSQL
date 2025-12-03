-- Window Functions Dml - SQL:2023
-- Description: Data Manipulation Language: INSERT, UPDATE, DELETE, MERGE
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_dml_test_select_001
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_dml_test_select_002
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_dml_test_select_003
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_004
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_005
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_dml_test_select_006
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_dml_test_select_007
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales (date DATE, product STRING, amount INT64);
DROP TABLE IF EXISTS monthly_summary;
CREATE TABLE monthly_summary (month INT64, product STRING, total INT64);
INSERT INTO daily_sales VALUES (DATE '2024-01-05', 'A', 100);
INSERT INTO daily_sales VALUES (DATE '2024-01-15', 'A', 150);
INSERT INTO daily_sales VALUES (DATE '2024-02-10', 'A', 200);
INSERT INTO monthly_summary SELECT EXTRACT(MONTH FROM date), product, SUM(amount) FROM daily_sales GROUP BY EXTRACT(MONTH FROM date), product;
DROP TABLE IF EXISTS computed;
CREATE TABLE computed (id INT64, value INT64, squared INT64);
INSERT INTO computed VALUES (1, 5, 5 * 5), (2, 10, 10 * 10), (3, 15, 15 * 15);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
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

-- Tag: window_functions_window_functions_dml_test_select_008
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_dml_test_select_009
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_010
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_011
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_dml_test_select_012
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_dml_test_select_013
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_dml_test_select_014
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_dml_test_select_015
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS computed;
CREATE TABLE computed (id INT64, value INT64, squared INT64);
INSERT INTO computed VALUES (1, 5, 5 * 5), (2, 10, 10 * 10), (3, 15, 15 * 15);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
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

-- Tag: window_functions_window_functions_dml_test_select_016
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_017
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_018
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_dml_test_select_019
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_dml_test_select_020
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_dml_test_select_021
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_dml_test_select_022
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
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

-- Tag: window_functions_window_functions_dml_test_select_023
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_024
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_dml_test_select_025
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_dml_test_select_026
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_dml_test_select_027
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_dml_test_select_028
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);
INSERT INTO logs VALUES (1, 'first');
INSERT INTO logs VALUES (2, 'second');
INSERT INTO logs VALUES (3, 'third');
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, count INT64);
INSERT INTO counters VALUES (1, 0), (2, 0), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
ALTER TABLE data ADD COLUMN new_col STRING DEFAULT 'test';
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

-- Tag: window_functions_window_functions_dml_test_select_029
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_dml_test_select_030
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_dml_test_select_031
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_032
SELECT * FROM data;
-- Tag: window_functions_window_functions_dml_test_select_033
SELECT * FROM data;
-- Tag: window_functions_window_functions_dml_test_select_034
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_035
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_036
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_dml_test_select_037
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_038
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_039
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_040
SELECT * FROM large;
-- Tag: window_functions_window_functions_dml_test_select_041
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_042
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_dml_test_select_043
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_044
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_045
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_046
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_047
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_048
SELECT * FROM recovery_test;

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

UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_049
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_050
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_dml_test_select_051
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_052
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_053
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_054
SELECT * FROM large;
-- Tag: window_functions_window_functions_dml_test_select_055
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_056
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_dml_test_select_057
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_058
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_059
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_060
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_061
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_062
SELECT * FROM recovery_test;

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

-- Tag: window_functions_window_functions_dml_test_select_063
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_064
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_065
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_066
SELECT * FROM large;
-- Tag: window_functions_window_functions_dml_test_select_067
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_068
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_dml_test_select_069
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_070
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_071
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_072
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_073
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_074
SELECT * FROM recovery_test;

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

-- Tag: window_functions_window_functions_dml_test_select_075
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_076
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_dml_test_select_077
SELECT * FROM large;
-- Tag: window_functions_window_functions_dml_test_select_078
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_079
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_dml_test_select_080
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_081
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_082
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_083
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_084
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_085
SELECT * FROM recovery_test;

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

UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_dml_test_select_086
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_087
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_088
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_089
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_090
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_091
SELECT * FROM recovery_test;

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

DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_092
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_dml_test_select_093
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_dml_test_select_094
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_095
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_dml_test_select_096
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING);
INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob');
CREATE TABLE target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
CREATE TABLE empty_target AS SELECT * FROM source WHERE id > 1000;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING);
INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
CREATE TABLE single AS SELECT * FROM source WHERE id = 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING, age INT64);
INSERT INTO source VALUES (1, 'Alice', 30), (2, 'Bob', 25);
CREATE TABLE names_only AS SELECT name FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE target AS SELECT id AS user_id, value AS amount FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_097
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_098
SELECT * FROM empty_target;
-- Tag: window_functions_window_functions_dml_test_select_099
SELECT * FROM single;
-- Tag: window_functions_window_functions_dml_test_select_100
SELECT * FROM names_only;
-- Tag: window_functions_window_functions_dml_test_select_101
SELECT user_id, amount FROM target ORDER BY user_id;
-- Tag: window_functions_window_functions_dml_test_select_102
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_103
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_104
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_105
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_106
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_107
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_108
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_109
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_110
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_111
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_112
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_113
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_114
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_115
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_116
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_117
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_118
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_119
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_120
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_121
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_122
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_123
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_124
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_125
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_126
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_127
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_128
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
CREATE TABLE empty_target AS SELECT * FROM source WHERE id > 1000;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING);
INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
CREATE TABLE single AS SELECT * FROM source WHERE id = 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING, age INT64);
INSERT INTO source VALUES (1, 'Alice', 30), (2, 'Bob', 25);
CREATE TABLE names_only AS SELECT name FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE target AS SELECT id AS user_id, value AS amount FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_129
SELECT * FROM empty_target;
-- Tag: window_functions_window_functions_dml_test_select_130
SELECT * FROM single;
-- Tag: window_functions_window_functions_dml_test_select_131
SELECT * FROM names_only;
-- Tag: window_functions_window_functions_dml_test_select_132
SELECT user_id, amount FROM target ORDER BY user_id;
-- Tag: window_functions_window_functions_dml_test_select_133
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_134
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_135
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_136
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_137
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_138
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_139
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_140
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_141
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_142
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_143
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_144
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_145
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_146
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_147
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_148
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_149
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_150
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_151
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_152
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_153
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_154
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_155
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_156
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_157
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_158
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_159
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING);
INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
CREATE TABLE single AS SELECT * FROM source WHERE id = 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING, age INT64);
INSERT INTO source VALUES (1, 'Alice', 30), (2, 'Bob', 25);
CREATE TABLE names_only AS SELECT name FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE target AS SELECT id AS user_id, value AS amount FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_160
SELECT * FROM single;
-- Tag: window_functions_window_functions_dml_test_select_161
SELECT * FROM names_only;
-- Tag: window_functions_window_functions_dml_test_select_162
SELECT user_id, amount FROM target ORDER BY user_id;
-- Tag: window_functions_window_functions_dml_test_select_163
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_164
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_165
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_166
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_167
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_168
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_169
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_170
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_171
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_172
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_173
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_174
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_175
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_176
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_177
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_178
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_179
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_180
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_181
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_182
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_183
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_184
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_185
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_186
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_187
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_188
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_189
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING, age INT64);
INSERT INTO source VALUES (1, 'Alice', 30), (2, 'Bob', 25);
CREATE TABLE names_only AS SELECT name FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE target AS SELECT id AS user_id, value AS amount FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_190
SELECT * FROM names_only;
-- Tag: window_functions_window_functions_dml_test_select_191
SELECT user_id, amount FROM target ORDER BY user_id;
-- Tag: window_functions_window_functions_dml_test_select_192
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_193
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_194
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_195
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_196
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_197
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_198
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_199
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_200
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_201
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_202
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_203
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_204
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_205
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_206
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_207
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_208
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_209
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_210
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_211
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_212
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_213
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_214
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_215
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_216
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_217
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_218
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE target AS SELECT id AS user_id, value AS amount FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_219
SELECT user_id, amount FROM target ORDER BY user_id;
-- Tag: window_functions_window_functions_dml_test_select_220
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_221
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_222
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_223
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_224
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_225
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_226
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_227
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_228
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_229
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_230
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_231
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_232
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_233
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_234
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_235
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_236
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_237
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_238
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_239
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_240
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_241
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_242
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_243
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_244
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_245
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_246
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (price INT64, quantity INT64);
INSERT INTO source VALUES (10, 5), (20, 3);
CREATE TABLE derived AS SELECT price, quantity, price * quantity AS total FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_247
SELECT total FROM derived ORDER BY total;
-- Tag: window_functions_window_functions_dml_test_select_248
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_249
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_250
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_251
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_252
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_253
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_254
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_255
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_256
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_257
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_258
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_259
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_260
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_261
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_262
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_263
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_264
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_265
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_266
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_267
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_268
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_269
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_270
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_271
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_272
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_273
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
CREATE TABLE summary AS SELECT product, SUM(amount) AS total, COUNT(*) AS count FROM sales GROUP BY product;
CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_274
SELECT * FROM summary ORDER BY product;
-- Tag: window_functions_window_functions_dml_test_select_275
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_276
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_277
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_278
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_279
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_280
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_281
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_282
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_283
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_284
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_285
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_286
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_287
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_288
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_289
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_290
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_291
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_292
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_293
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_294
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_295
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_296
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_297
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_298
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_299
SELECT * FROM second_ctas;

CREATE TABLE int_table AS SELECT 1 AS a, 2 AS b, 3 AS c;
CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_300
SELECT * FROM int_table;
-- Tag: window_functions_window_functions_dml_test_select_301
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_302
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_303
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_304
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_305
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_306
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_307
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_308
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_309
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_310
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_311
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_312
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_313
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_314
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_315
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_316
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_317
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_318
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_319
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_320
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_321
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_322
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_323
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_324
SELECT * FROM second_ctas;

CREATE TABLE str_table AS SELECT 'hello' AS greeting, 'world' AS target;
CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_325
SELECT * FROM str_table;
-- Tag: window_functions_window_functions_dml_test_select_326
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_327
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_328
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_329
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_330
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_331
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_332
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_333
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_334
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_335
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_336
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_337
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_338
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_339
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_340
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_341
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_342
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_343
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_344
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_345
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_346
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_347
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_348
SELECT * FROM second_ctas;

CREATE TABLE mixed AS SELECT 1 AS num, 'text' AS str, TRUE AS bool;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_349
SELECT * FROM mixed;
-- Tag: window_functions_window_functions_dml_test_select_350
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_351
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_352
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_353
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_354
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_355
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_356
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_357
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_358
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_359
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_360
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_361
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_362
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_363
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_364
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_365
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_366
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_367
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_368
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_369
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_370
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_371
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL), (2, 100);
CREATE TABLE with_nulls AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_372
SELECT * FROM with_nulls ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_373
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_374
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_375
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_376
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_377
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_378
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_379
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_380
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_381
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_382
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_383
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_384
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_385
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_386
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_387
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_388
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_389
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_390
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_391
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_392
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_393
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3);
CREATE TABLE nulls AS SELECT id, CAST(NULL AS INT64) AS null_col FROM source;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_394
SELECT * FROM nulls;
-- Tag: window_functions_window_functions_dml_test_select_395
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_396
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_397
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_398
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_399
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_400
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_401
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_402
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_403
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_404
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_405
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_406
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_407
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_408
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_409
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_410
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_411
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_412
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_413
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_414
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100), (1, 150), (2, 200);
CREATE TABLE user_orders AS SELECT u.name, o.amount FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_415
SELECT * FROM user_orders;
-- Tag: window_functions_window_functions_dml_test_select_416
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_417
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_418
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_419
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_420
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_421
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_422
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_423
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_424
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_425
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_426
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_427
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_428
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_429
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_430
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_431
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_432
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_433
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_434
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, amount INT64);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
CREATE TABLE all_users AS SELECT u.name, o.amount FROM users u LEFT JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_435
SELECT * FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_436
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_437
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_438
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_439
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_440
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_441
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_442
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_443
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_444
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_445
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_446
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_447
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_448
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_449
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_450
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_451
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_452
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_453
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE doubled AS SELECT * FROM (SELECT id, value * 2 AS doubled_value FROM source) AS subq;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_454
SELECT * FROM doubled;
-- Tag: window_functions_window_functions_dml_test_select_455
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_456
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_457
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_458
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_459
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_460
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_461
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_462
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_463
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_464
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_465
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_466
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_467
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_468
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_469
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_470
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_471
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
CREATE TABLE from_cte AS WITH filtered AS (SELECT * FROM source WHERE value > 15) SELECT * FROM filtered;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_472
SELECT * FROM from_cte ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_473
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_474
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_475
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_476
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_477
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_478
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_479
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_480
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_481
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_482
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_483
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_484
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_485
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_486
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_487
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_488
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 200), ('A', 150);
CREATE TABLE ranked AS SELECT product, amount, ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) AS rank FROM sales;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
CREATE TABLE existing AS SELECT 1 AS id;
DROP TABLE IF EXISTS existing;
CREATE TABLE existing (id INT64);
INSERT INTO existing VALUES (1);
CREATE TABLE IF NOT EXISTS existing AS SELECT 2 AS id;
DROP TABLE IF EXISTS dummy;
CREATE TABLE dummy (id INT64);
CREATE TABLE target AS SELECT * FROM non_existent;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE target AS SELECT invalid_column FROM source;
CREATE TABLE broken AS SELECT * FROM;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
DROP VIEW IF EXISTS source_view;
CREATE VIEW source_view AS SELECT * FROM source WHERE value > 100;
CREATE TABLE from_view AS SELECT * FROM source_view;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200);
CREATE TABLE ctas_table AS SELECT * FROM source;
DROP VIEW IF EXISTS ctas_view;
CREATE VIEW ctas_view AS SELECT * FROM ctas_table WHERE id = 2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (3), (4);
CREATE TABLE combined AS SELECT * FROM table1 UNION SELECT * FROM table2;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1), (2);
INSERT INTO table2 VALUES (2), (3);
CREATE TABLE with_dups AS SELECT * FROM table1 UNION ALL SELECT * FROM table2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (3, 300), (1, 100), (2, 200);
CREATE TABLE sorted AS SELECT * FROM source ORDER BY id;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE limited AS SELECT * FROM source LIMIT 3;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 500), (3, 300), (4, 400);
CREATE TABLE top_two AS SELECT * FROM source ORDER BY value DESC LIMIT 2;
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
CREATE TABLE unique_values AS SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 50), (3, 100);
CREATE TABLE categorized AS SELECT id, value, CASE WHEN value < 25 THEN 'low' WHEN value < 75 THEN 'medium' ELSE 'high' END AS category FROM source;
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (color STRING);
DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes (size STRING);
INSERT INTO colors VALUES ('red'), ('blue');
INSERT INTO sizes VALUES ('S'), ('M'), ('L');
CREATE TABLE product_variants AS SELECT c.color, s.size FROM colors c CROSS JOIN sizes s;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
CREATE TABLE large_target AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (c1 INT64, c2 INT64, c3 INT64, c4 INT64, c5 INT64, c6 INT64, c7 INT64, c8 INT64, c9 INT64, c10 INT64);
INSERT INTO source VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
CREATE TABLE wide AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100);
CREATE TABLE target AS SELECT * FROM source;
INSERT INTO target VALUES (2, 200);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: window_functions_window_functions_dml_test_select_489
SELECT * FROM ranked;
-- Tag: window_functions_window_functions_dml_test_select_490
SELECT * FROM existing;
-- Tag: window_functions_window_functions_dml_test_select_491
SELECT * FROM from_view;
-- Tag: window_functions_window_functions_dml_test_select_492
SELECT * FROM ctas_view;
-- Tag: window_functions_window_functions_dml_test_select_493
SELECT * FROM combined ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_494
SELECT * FROM with_dups;
-- Tag: window_functions_window_functions_dml_test_select_495
SELECT * FROM sorted;
-- Tag: window_functions_window_functions_dml_test_select_496
SELECT * FROM limited;
-- Tag: window_functions_window_functions_dml_test_select_497
SELECT * FROM top_two;
-- Tag: window_functions_window_functions_dml_test_select_498
SELECT * FROM unique_values ORDER BY value;
-- Tag: window_functions_window_functions_dml_test_select_499
SELECT * FROM categorized;
-- Tag: window_functions_window_functions_dml_test_select_500
SELECT * FROM product_variants;
-- Tag: window_functions_window_functions_dml_test_select_501
SELECT COUNT(*) FROM large_target;
-- Tag: window_functions_window_functions_dml_test_select_502
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_503
SELECT * FROM target ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_504
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
INSERT INTO strings VALUES (2, 'non-empty');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (value STRING);
INSERT INTO strings VALUES ('');
INSERT INTO strings VALUES ('test');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (9223372036854775807);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (0, 0);
INSERT INTO numbers VALUES (1, 0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-100);
INSERT INTO numbers VALUES (-1);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (id INT64, text STRING);
INSERT INTO unicode VALUES (1, 'Hello 世界');
INSERT INTO unicode VALUES (2, 'Привет мир');
INSERT INTO unicode VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS special;
CREATE TABLE special (id INT64, text STRING);
INSERT INTO special VALUES (1, 'Line1
Line2');
INSERT INTO special VALUES (2, 'Tab\there');
INSERT INTO special VALUES (3, 'Quote''s');
DROP TABLE IF EXISTS spaces;
CREATE TABLE spaces (id INT64, text STRING);
INSERT INTO spaces VALUES (1, ' leading');
INSERT INTO spaces VALUES (2, 'trailing ');
INSERT INTO spaces VALUES (3, ' both ');
DROP TABLE IF EXISTS duplicates;
CREATE TABLE duplicates (value INT64);
INSERT INTO duplicates VALUES (42);
DROP TABLE IF EXISTS single;
CREATE TABLE single (id INT64, value STRING);
INSERT INTO single VALUES (1, 'only');
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 0.0);
INSERT INTO floats VALUES (2, -0.0);
INSERT INTO floats VALUES (3, 1.7976931348623157E308);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (value FLOAT64);
INSERT INTO floats VALUES (2.2250738585072014E-308);
INSERT INTO floats VALUES (1e-300);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (category STRING, value INT64);
DROP TABLE IF EXISTS distinct_vals;
CREATE TABLE distinct_vals (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (id INT64, text STRING);
INSERT INTO whitespace VALUES (1, '  ');
INSERT INTO whitespace VALUES (2, '\t\t');
INSERT INTO whitespace VALUES (3, '
');

-- Tag: window_functions_window_functions_dml_test_select_505
SELECT * FROM strings WHERE value = '';
-- Tag: window_functions_window_functions_dml_test_select_506
SELECT * FROM strings WHERE value = '';
-- Tag: window_functions_window_functions_dml_test_select_507
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_dml_test_select_508
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_dml_test_select_509
SELECT * FROM numbers WHERE id = 0;
-- Tag: window_functions_window_functions_dml_test_select_510
SELECT * FROM numbers WHERE value = 0;
-- Tag: window_functions_window_functions_dml_test_select_511
SELECT SUM(value) FROM numbers;
-- Tag: window_functions_window_functions_dml_test_select_512
SELECT * FROM numbers WHERE value < 0;
-- Tag: window_functions_window_functions_dml_test_select_513
SELECT * FROM texts;
-- Tag: window_functions_window_functions_dml_test_select_514
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_dml_test_select_515
SELECT * FROM special;
-- Tag: window_functions_window_functions_dml_test_select_516
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_dml_test_select_517
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_dml_test_select_518
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_dml_test_select_519
SELECT * FROM single;
-- Tag: window_functions_window_functions_dml_test_select_520
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_dml_test_select_521
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_dml_test_select_522
SELECT * FROM empty;
-- Tag: window_functions_window_functions_dml_test_select_523
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_dml_test_select_524
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_dml_test_select_525
SELECT * FROM floats;
-- Tag: window_functions_window_functions_dml_test_select_526
SELECT * FROM floats;
-- Tag: window_functions_window_functions_dml_test_select_527
SELECT * FROM wide;
-- Tag: window_functions_window_functions_dml_test_select_528
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_dml_test_select_529
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_dml_test_select_530
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_dml_test_select_531
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_dml_test_select_532
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_dml_test_select_533
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_dml_test_select_534
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_dml_test_select_535
SELECT * FROM whitespace;

DROP TABLE IF EXISTS typed;
CREATE TABLE typed (id INT64, value INT64);
INSERT INTO typed VALUES (1, 'string');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 'North', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (amount INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64, value STRING);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64, value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
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

-- Tag: window_functions_window_functions_dml_test_select_536
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_dml_test_select_537
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_dml_test_select_538
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_539
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_dml_test_select_540
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_dml_test_select_541
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_dml_test_select_542
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_dml_test_select_543
SELECT *;
-- Tag: window_functions_window_functions_dml_test_select_544
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_dml_test_select_545
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_dml_test_select_546
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_dml_test_select_547
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_dml_test_select_548
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_dml_test_select_549
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_dml_test_select_550
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_dml_test_select_551
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ('not a number', 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_dml_test_select_552
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_553
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_dml_test_select_554
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_dml_test_select_555
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_dml_test_select_556
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_dml_test_select_557
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_dml_test_select_558
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_dml_test_select_559
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_560
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_dml_test_select_561
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_dml_test_select_562
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_dml_test_select_563
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_dml_test_select_564
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_dml_test_select_565
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_dml_test_select_566
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_567
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_dml_test_select_568
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_dml_test_select_569
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_dml_test_select_570
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_dml_test_select_571
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_dml_test_select_572
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS typed;
CREATE TABLE typed (id INT64, value INT64);
INSERT INTO typed VALUES (1, 'string');
DROP TABLE IF EXISTS data;
CREATE TABLE data (int_val INT64, str_val STRING);
INSERT INTO data VALUES (42, 'test');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (str_val STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (amount INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_dml_test_select_573
SELECT * FROM data WHERE int_val = str_val;
-- Tag: window_functions_window_functions_dml_test_select_574
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_dml_test_select_575
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_dml_test_select_576
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_dml_test_select_577
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_578
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_dml_test_select_579
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_580
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_dml_test_select_581
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_dml_test_select_582
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_dml_test_select_583
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_dml_test_select_584
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_dml_test_select_585
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_dml_test_select_586
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_dml_test_select_587
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_dml_test_select_588
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_dml_test_select_001
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_dml_test_select_589
SELECT userid FROM users;
-- Tag: window_functions_window_functions_dml_test_select_590
SELECT * FROM user;

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES ('not_an_int', 'Alice');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
INSERT INTO t VALUES (1), (2), (3);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id STRING);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES ('1');
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (column_name INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);

UPDATE nonexistent SET col = 1;
-- Tag: window_functions_window_functions_dml_test_select_591
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_dml_test_select_592
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_dml_test_select_593
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_dml_test_select_594
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_dml_test_select_595
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_dml_test_select_596
SELECT * FROM cte;
-- Tag: window_functions_window_functions_dml_test_select_597
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_dml_test_select_598
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_dml_test_select_599
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_dml_test_select_600
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_dml_test_select_601
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS source;
CREATE TABLE source (name STRING, age_str STRING, score_str STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (name STRING, age INT64, score FLOAT64, grade STRING);
INSERT INTO source VALUES
('Alice', '25', '85.5'),
('Bob', '30', '92.0'),
('Charlie', '22', '78.5');
INSERT INTO target (name, age, score, grade)
-- Tag: window_functions_window_functions_dml_test_select_602
SELECT name,
CAST(age_str AS INT64),
CAST(score_str AS FLOAT64),
CASE
WHEN CAST(score_str AS FLOAT64) >= 90 THEN 'A'
WHEN CAST(score_str AS FLOAT64) >= 80 THEN 'B'
ELSE 'C'
END
FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, year_str STRING, amount FLOAT64);
INSERT INTO sales VALUES
(1, '2023', 100.0), (2, '2023', 200.0),
(3, '2024', 150.0), (4, '2024', 250.0), (5, '2024', 300.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Alice', 'Eng', 80000),
(2, 'Bob', 'Sales', 70000),
(3, 'Charlie', 'Eng', 90000),
(4, 'David', 'Sales', 75000);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_dml_test_select_603
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_dml_test_select_604
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_dml_test_select_605
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_dml_test_select_606
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_dml_test_select_607
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
INSERT INTO products VALUES (4, 'Doohickey', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, status STRING);
INSERT INTO employees VALUES (1, 'Alice', 'active');
INSERT INTO employees VALUES (2, 'Bob', 'active');
INSERT INTO employees VALUES (3, 'Charlie', 'active');
DROP TABLE IF EXISTS resignations;
CREATE TABLE resignations (emp_id INT64);
INSERT INTO resignations VALUES (2);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, value INT64);
INSERT INTO temp_data VALUES (1, 10);
INSERT INTO temp_data VALUES (2, 20);
INSERT INTO temp_data VALUES (3, 30);
INSERT INTO temp_data VALUES (4, 40);
DROP TABLE IF EXISTS delete_list;
CREATE TABLE delete_list (value INT64);
INSERT INTO delete_list VALUES (20);
INSERT INTO delete_list VALUES (40);
DROP TABLE IF EXISTS all_records;
CREATE TABLE all_records (id INT64, value INT64);
INSERT INTO all_records VALUES (1, 10);
INSERT INTO all_records VALUES (2, 20);
INSERT INTO all_records VALUES (3, 30);
INSERT INTO all_records VALUES (4, 40);
DROP TABLE IF EXISTS keep_list;
CREATE TABLE keep_list (value INT64);
INSERT INTO keep_list VALUES (10);
INSERT INTO keep_list VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'deleted');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
INSERT INTO data VALUES (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (id INT64, value INT64);
INSERT INTO level1 VALUES (1, 100);
INSERT INTO level1 VALUES (2, 200);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (id INT64, l1_value INT64);
INSERT INTO level2 VALUES (1, 100);
DROP TABLE IF EXISTS level3;
CREATE TABLE level3 (id INT64, l2_id INT64);
INSERT INTO level3 VALUES (1, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS multi;
CREATE TABLE multi (col1 INT64, col2 INT64);
INSERT INTO multi VALUES (10, 20);
DROP TABLE IF EXISTS empty_data;
CREATE TABLE empty_data (id INT64, value INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (30);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, status STRING);
INSERT INTO data VALUES (1, 10, 'active');
INSERT INTO data VALUES (2, 20, 'inactive');
INSERT INTO data VALUES (3, 30, 'active');
INSERT INTO data VALUES (4, 40, 'inactive');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, flag BOOL);
INSERT INTO data VALUES (1, 10, true);
INSERT INTO data VALUES (2, 20, false);
INSERT INTO data VALUES (3, 30, true);
INSERT INTO data VALUES (4, 40, false);

UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_dml_test_select_608
SELECT id FROM products WHERE active = true ORDER BY id;
UPDATE employees SET status = 'inactive' WHERE id NOT IN (SELECT emp_id FROM resignations WHERE emp_id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_609
SELECT name FROM employees WHERE status = 'inactive' ORDER BY name;
DELETE FROM temp_data WHERE value IN (SELECT value FROM delete_list);
-- Tag: window_functions_window_functions_dml_test_select_610
SELECT id FROM temp_data ORDER BY id;
DELETE FROM all_records WHERE value NOT IN (SELECT value FROM keep_list WHERE value IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_611
SELECT id FROM all_records ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_612
SELECT id, CASE WHEN status IN ('active', 'pending') THEN 'good' ELSE 'bad' END as health FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_613
SELECT id, CASE WHEN value NOT IN (10, 30) THEN 'excluded' ELSE 'included' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_614
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_615
SELECT COUNT(*) FROM data WHERE id NOT IN (SELECT id FROM filter WHERE id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_616
SELECT id FROM level1 WHERE value IN (SELECT l1_value FROM level2 WHERE id IN (SELECT l2_id FROM level3));
-- Tag: window_functions_window_functions_dml_test_select_617
SELECT id FROM data WHERE value IN ('foo', 'bar');
-- Tag: window_functions_window_functions_dml_test_select_618
SELECT id FROM data WHERE value IN (SELECT col1, col2 FROM multi);
-- Tag: window_functions_window_functions_dml_test_select_619
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_620
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_dml_test_select_621
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_622
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_623
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_624
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_625
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, status STRING);
INSERT INTO employees VALUES (1, 'Alice', 'active');
INSERT INTO employees VALUES (2, 'Bob', 'active');
INSERT INTO employees VALUES (3, 'Charlie', 'active');
DROP TABLE IF EXISTS resignations;
CREATE TABLE resignations (emp_id INT64);
INSERT INTO resignations VALUES (2);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, value INT64);
INSERT INTO temp_data VALUES (1, 10);
INSERT INTO temp_data VALUES (2, 20);
INSERT INTO temp_data VALUES (3, 30);
INSERT INTO temp_data VALUES (4, 40);
DROP TABLE IF EXISTS delete_list;
CREATE TABLE delete_list (value INT64);
INSERT INTO delete_list VALUES (20);
INSERT INTO delete_list VALUES (40);
DROP TABLE IF EXISTS all_records;
CREATE TABLE all_records (id INT64, value INT64);
INSERT INTO all_records VALUES (1, 10);
INSERT INTO all_records VALUES (2, 20);
INSERT INTO all_records VALUES (3, 30);
INSERT INTO all_records VALUES (4, 40);
DROP TABLE IF EXISTS keep_list;
CREATE TABLE keep_list (value INT64);
INSERT INTO keep_list VALUES (10);
INSERT INTO keep_list VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'deleted');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
INSERT INTO data VALUES (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (id INT64, value INT64);
INSERT INTO level1 VALUES (1, 100);
INSERT INTO level1 VALUES (2, 200);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (id INT64, l1_value INT64);
INSERT INTO level2 VALUES (1, 100);
DROP TABLE IF EXISTS level3;
CREATE TABLE level3 (id INT64, l2_id INT64);
INSERT INTO level3 VALUES (1, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS multi;
CREATE TABLE multi (col1 INT64, col2 INT64);
INSERT INTO multi VALUES (10, 20);
DROP TABLE IF EXISTS empty_data;
CREATE TABLE empty_data (id INT64, value INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (30);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, status STRING);
INSERT INTO data VALUES (1, 10, 'active');
INSERT INTO data VALUES (2, 20, 'inactive');
INSERT INTO data VALUES (3, 30, 'active');
INSERT INTO data VALUES (4, 40, 'inactive');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, flag BOOL);
INSERT INTO data VALUES (1, 10, true);
INSERT INTO data VALUES (2, 20, false);
INSERT INTO data VALUES (3, 30, true);
INSERT INTO data VALUES (4, 40, false);

UPDATE employees SET status = 'inactive' WHERE id NOT IN (SELECT emp_id FROM resignations WHERE emp_id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_626
SELECT name FROM employees WHERE status = 'inactive' ORDER BY name;
DELETE FROM temp_data WHERE value IN (SELECT value FROM delete_list);
-- Tag: window_functions_window_functions_dml_test_select_627
SELECT id FROM temp_data ORDER BY id;
DELETE FROM all_records WHERE value NOT IN (SELECT value FROM keep_list WHERE value IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_628
SELECT id FROM all_records ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_629
SELECT id, CASE WHEN status IN ('active', 'pending') THEN 'good' ELSE 'bad' END as health FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_630
SELECT id, CASE WHEN value NOT IN (10, 30) THEN 'excluded' ELSE 'included' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_631
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_632
SELECT COUNT(*) FROM data WHERE id NOT IN (SELECT id FROM filter WHERE id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_633
SELECT id FROM level1 WHERE value IN (SELECT l1_value FROM level2 WHERE id IN (SELECT l2_id FROM level3));
-- Tag: window_functions_window_functions_dml_test_select_634
SELECT id FROM data WHERE value IN ('foo', 'bar');
-- Tag: window_functions_window_functions_dml_test_select_635
SELECT id FROM data WHERE value IN (SELECT col1, col2 FROM multi);
-- Tag: window_functions_window_functions_dml_test_select_636
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_637
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_dml_test_select_638
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_639
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_640
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_641
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_642
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, value INT64);
INSERT INTO temp_data VALUES (1, 10);
INSERT INTO temp_data VALUES (2, 20);
INSERT INTO temp_data VALUES (3, 30);
INSERT INTO temp_data VALUES (4, 40);
DROP TABLE IF EXISTS delete_list;
CREATE TABLE delete_list (value INT64);
INSERT INTO delete_list VALUES (20);
INSERT INTO delete_list VALUES (40);
DROP TABLE IF EXISTS all_records;
CREATE TABLE all_records (id INT64, value INT64);
INSERT INTO all_records VALUES (1, 10);
INSERT INTO all_records VALUES (2, 20);
INSERT INTO all_records VALUES (3, 30);
INSERT INTO all_records VALUES (4, 40);
DROP TABLE IF EXISTS keep_list;
CREATE TABLE keep_list (value INT64);
INSERT INTO keep_list VALUES (10);
INSERT INTO keep_list VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'deleted');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
INSERT INTO data VALUES (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (id INT64, value INT64);
INSERT INTO level1 VALUES (1, 100);
INSERT INTO level1 VALUES (2, 200);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (id INT64, l1_value INT64);
INSERT INTO level2 VALUES (1, 100);
DROP TABLE IF EXISTS level3;
CREATE TABLE level3 (id INT64, l2_id INT64);
INSERT INTO level3 VALUES (1, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS multi;
CREATE TABLE multi (col1 INT64, col2 INT64);
INSERT INTO multi VALUES (10, 20);
DROP TABLE IF EXISTS empty_data;
CREATE TABLE empty_data (id INT64, value INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (30);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, status STRING);
INSERT INTO data VALUES (1, 10, 'active');
INSERT INTO data VALUES (2, 20, 'inactive');
INSERT INTO data VALUES (3, 30, 'active');
INSERT INTO data VALUES (4, 40, 'inactive');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, flag BOOL);
INSERT INTO data VALUES (1, 10, true);
INSERT INTO data VALUES (2, 20, false);
INSERT INTO data VALUES (3, 30, true);
INSERT INTO data VALUES (4, 40, false);

DELETE FROM temp_data WHERE value IN (SELECT value FROM delete_list);
-- Tag: window_functions_window_functions_dml_test_select_643
SELECT id FROM temp_data ORDER BY id;
DELETE FROM all_records WHERE value NOT IN (SELECT value FROM keep_list WHERE value IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_644
SELECT id FROM all_records ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_645
SELECT id, CASE WHEN status IN ('active', 'pending') THEN 'good' ELSE 'bad' END as health FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_646
SELECT id, CASE WHEN value NOT IN (10, 30) THEN 'excluded' ELSE 'included' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_647
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_648
SELECT COUNT(*) FROM data WHERE id NOT IN (SELECT id FROM filter WHERE id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_649
SELECT id FROM level1 WHERE value IN (SELECT l1_value FROM level2 WHERE id IN (SELECT l2_id FROM level3));
-- Tag: window_functions_window_functions_dml_test_select_650
SELECT id FROM data WHERE value IN ('foo', 'bar');
-- Tag: window_functions_window_functions_dml_test_select_651
SELECT id FROM data WHERE value IN (SELECT col1, col2 FROM multi);
-- Tag: window_functions_window_functions_dml_test_select_652
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_653
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_dml_test_select_654
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_655
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_656
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_657
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_658
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

DROP TABLE IF EXISTS all_records;
CREATE TABLE all_records (id INT64, value INT64);
INSERT INTO all_records VALUES (1, 10);
INSERT INTO all_records VALUES (2, 20);
INSERT INTO all_records VALUES (3, 30);
INSERT INTO all_records VALUES (4, 40);
DROP TABLE IF EXISTS keep_list;
CREATE TABLE keep_list (value INT64);
INSERT INTO keep_list VALUES (10);
INSERT INTO keep_list VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'deleted');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
INSERT INTO data VALUES (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (id INT64, value INT64);
INSERT INTO level1 VALUES (1, 100);
INSERT INTO level1 VALUES (2, 200);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (id INT64, l1_value INT64);
INSERT INTO level2 VALUES (1, 100);
DROP TABLE IF EXISTS level3;
CREATE TABLE level3 (id INT64, l2_id INT64);
INSERT INTO level3 VALUES (1, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS multi;
CREATE TABLE multi (col1 INT64, col2 INT64);
INSERT INTO multi VALUES (10, 20);
DROP TABLE IF EXISTS empty_data;
CREATE TABLE empty_data (id INT64, value INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (30);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, status STRING);
INSERT INTO data VALUES (1, 10, 'active');
INSERT INTO data VALUES (2, 20, 'inactive');
INSERT INTO data VALUES (3, 30, 'active');
INSERT INTO data VALUES (4, 40, 'inactive');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64, flag BOOL);
INSERT INTO data VALUES (1, 10, true);
INSERT INTO data VALUES (2, 20, false);
INSERT INTO data VALUES (3, 30, true);
INSERT INTO data VALUES (4, 40, false);

DELETE FROM all_records WHERE value NOT IN (SELECT value FROM keep_list WHERE value IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_659
SELECT id FROM all_records ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_660
SELECT id, CASE WHEN status IN ('active', 'pending') THEN 'good' ELSE 'bad' END as health FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_661
SELECT id, CASE WHEN value NOT IN (10, 30) THEN 'excluded' ELSE 'included' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_662
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_663
SELECT COUNT(*) FROM data WHERE id NOT IN (SELECT id FROM filter WHERE id IS NOT NULL);
-- Tag: window_functions_window_functions_dml_test_select_664
SELECT id FROM level1 WHERE value IN (SELECT l1_value FROM level2 WHERE id IN (SELECT l2_id FROM level3));
-- Tag: window_functions_window_functions_dml_test_select_665
SELECT id FROM data WHERE value IN ('foo', 'bar');
-- Tag: window_functions_window_functions_dml_test_select_666
SELECT id FROM data WHERE value IN (SELECT col1, col2 FROM multi);
-- Tag: window_functions_window_functions_dml_test_select_667
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_668
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_dml_test_select_669
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_670
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_dml_test_select_671
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_672
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_673
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING);
INSERT INTO source VALUES (1, 'Alice');
INSERT INTO source VALUES (2, 'Bob');
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, name STRING);
INSERT INTO dest SELECT * FROM source WHERE id > 100;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'A');
INSERT INTO data VALUES (2, 'B');
INSERT INTO data SELECT * FROM data;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, product STRING);
INSERT INTO orders VALUES (1, 'Laptop');
INSERT INTO orders VALUES (1, 'Mouse');
INSERT INTO orders VALUES (2, 'Keyboard');
DROP TABLE IF EXISTS report;
CREATE TABLE report (user_name STRING, product STRING);
INSERT INTO report SELECT u.name, o.product FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (date DATE, amount FLOAT64);
INSERT INTO sales VALUES (DATE '2024-01-01', 100.0);
INSERT INTO sales VALUES (DATE '2024-01-02', 200.0);
INSERT INTO sales VALUES (DATE '2024-01-03', 150.0);
DROP TABLE IF EXISTS summary;
CREATE TABLE summary (total_sales FLOAT64);
INSERT INTO summary \
WITH totals AS (SELECT SUM(amount) as total FROM sales) \
-- Tag: window_functions_window_functions_dml_test_select_674
SELECT total FROM totals;
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64, name STRING);
INSERT INTO active_users VALUES (1, 'Alice');
INSERT INTO active_users VALUES (2, 'Bob');
DROP TABLE IF EXISTS inactive_users;
CREATE TABLE inactive_users (id INT64, name STRING);
INSERT INTO inactive_users VALUES (3, 'Charlie');
INSERT INTO inactive_users VALUES (4, 'David');
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users \
-- Tag: window_functions_window_functions_dml_test_select_675
SELECT * FROM active_users \
UNION ALL \
-- Tag: window_functions_window_functions_dml_test_select_676
SELECT * FROM inactive_users;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_677
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_678
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_679
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_680
SELECT COUNT(*) FROM report;
-- Tag: window_functions_window_functions_dml_test_select_681
SELECT * FROM summary;
-- Tag: window_functions_window_functions_dml_test_select_682
SELECT COUNT(*) FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_683
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_684
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_685
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_686
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_687
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_688
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_689
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_690
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_691
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_692
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_693
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_694
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_695
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_696
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_697
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_698
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_699
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_700
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_701
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_702
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_703
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_704
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_705
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_706
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_707
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_708
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'A');
INSERT INTO data VALUES (2, 'B');
INSERT INTO data SELECT * FROM data;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, product STRING);
INSERT INTO orders VALUES (1, 'Laptop');
INSERT INTO orders VALUES (1, 'Mouse');
INSERT INTO orders VALUES (2, 'Keyboard');
DROP TABLE IF EXISTS report;
CREATE TABLE report (user_name STRING, product STRING);
INSERT INTO report SELECT u.name, o.product FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (date DATE, amount FLOAT64);
INSERT INTO sales VALUES (DATE '2024-01-01', 100.0);
INSERT INTO sales VALUES (DATE '2024-01-02', 200.0);
INSERT INTO sales VALUES (DATE '2024-01-03', 150.0);
DROP TABLE IF EXISTS summary;
CREATE TABLE summary (total_sales FLOAT64);
INSERT INTO summary \
WITH totals AS (SELECT SUM(amount) as total FROM sales) \
-- Tag: window_functions_window_functions_dml_test_select_709
SELECT total FROM totals;
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64, name STRING);
INSERT INTO active_users VALUES (1, 'Alice');
INSERT INTO active_users VALUES (2, 'Bob');
DROP TABLE IF EXISTS inactive_users;
CREATE TABLE inactive_users (id INT64, name STRING);
INSERT INTO inactive_users VALUES (3, 'Charlie');
INSERT INTO inactive_users VALUES (4, 'David');
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users \
-- Tag: window_functions_window_functions_dml_test_select_710
SELECT * FROM active_users \
UNION ALL \
-- Tag: window_functions_window_functions_dml_test_select_711
SELECT * FROM inactive_users;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_712
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_713
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_714
SELECT COUNT(*) FROM report;
-- Tag: window_functions_window_functions_dml_test_select_715
SELECT * FROM summary;
-- Tag: window_functions_window_functions_dml_test_select_716
SELECT COUNT(*) FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_717
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_718
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_719
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_720
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_721
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_722
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_723
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_724
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_725
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_726
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_727
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_728
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_729
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_730
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_731
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_732
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_733
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_734
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_735
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_736
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_737
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_738
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_739
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_740
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_741
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_742
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (user_id INT64, product STRING);
INSERT INTO orders VALUES (1, 'Laptop');
INSERT INTO orders VALUES (1, 'Mouse');
INSERT INTO orders VALUES (2, 'Keyboard');
DROP TABLE IF EXISTS report;
CREATE TABLE report (user_name STRING, product STRING);
INSERT INTO report SELECT u.name, o.product FROM users u JOIN orders o ON u.id = o.user_id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (date DATE, amount FLOAT64);
INSERT INTO sales VALUES (DATE '2024-01-01', 100.0);
INSERT INTO sales VALUES (DATE '2024-01-02', 200.0);
INSERT INTO sales VALUES (DATE '2024-01-03', 150.0);
DROP TABLE IF EXISTS summary;
CREATE TABLE summary (total_sales FLOAT64);
INSERT INTO summary \
WITH totals AS (SELECT SUM(amount) as total FROM sales) \
-- Tag: window_functions_window_functions_dml_test_select_743
SELECT total FROM totals;
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64, name STRING);
INSERT INTO active_users VALUES (1, 'Alice');
INSERT INTO active_users VALUES (2, 'Bob');
DROP TABLE IF EXISTS inactive_users;
CREATE TABLE inactive_users (id INT64, name STRING);
INSERT INTO inactive_users VALUES (3, 'Charlie');
INSERT INTO inactive_users VALUES (4, 'David');
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users \
-- Tag: window_functions_window_functions_dml_test_select_744
SELECT * FROM active_users \
UNION ALL \
-- Tag: window_functions_window_functions_dml_test_select_745
SELECT * FROM inactive_users;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_746
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_747
SELECT COUNT(*) FROM report;
-- Tag: window_functions_window_functions_dml_test_select_748
SELECT * FROM summary;
-- Tag: window_functions_window_functions_dml_test_select_749
SELECT COUNT(*) FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_750
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_751
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_752
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_753
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_754
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_755
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_756
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_757
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_758
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_759
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_760
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_761
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_762
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_763
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_764
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_765
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_766
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_767
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_768
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_769
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_770
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_771
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_772
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_773
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_774
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_775
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (date DATE, amount FLOAT64);
INSERT INTO sales VALUES (DATE '2024-01-01', 100.0);
INSERT INTO sales VALUES (DATE '2024-01-02', 200.0);
INSERT INTO sales VALUES (DATE '2024-01-03', 150.0);
DROP TABLE IF EXISTS summary;
CREATE TABLE summary (total_sales FLOAT64);
INSERT INTO summary \
WITH totals AS (SELECT SUM(amount) as total FROM sales) \
-- Tag: window_functions_window_functions_dml_test_select_776
SELECT total FROM totals;
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64, name STRING);
INSERT INTO active_users VALUES (1, 'Alice');
INSERT INTO active_users VALUES (2, 'Bob');
DROP TABLE IF EXISTS inactive_users;
CREATE TABLE inactive_users (id INT64, name STRING);
INSERT INTO inactive_users VALUES (3, 'Charlie');
INSERT INTO inactive_users VALUES (4, 'David');
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users \
-- Tag: window_functions_window_functions_dml_test_select_777
SELECT * FROM active_users \
UNION ALL \
-- Tag: window_functions_window_functions_dml_test_select_778
SELECT * FROM inactive_users;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_779
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_780
SELECT * FROM summary;
-- Tag: window_functions_window_functions_dml_test_select_781
SELECT COUNT(*) FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_782
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_783
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_784
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_785
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_786
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_787
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_788
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_789
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_790
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_791
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_792
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_793
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_794
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_795
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_796
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_797
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_798
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_799
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_800
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_801
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_802
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_803
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_804
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_805
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_806
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_807
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64, name STRING);
INSERT INTO active_users VALUES (1, 'Alice');
INSERT INTO active_users VALUES (2, 'Bob');
DROP TABLE IF EXISTS inactive_users;
CREATE TABLE inactive_users (id INT64, name STRING);
INSERT INTO inactive_users VALUES (3, 'Charlie');
INSERT INTO inactive_users VALUES (4, 'David');
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users \
-- Tag: window_functions_window_functions_dml_test_select_808
SELECT * FROM active_users \
UNION ALL \
-- Tag: window_functions_window_functions_dml_test_select_809
SELECT * FROM inactive_users;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_810
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_811
SELECT COUNT(*) FROM all_users;
-- Tag: window_functions_window_functions_dml_test_select_812
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_813
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_814
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_815
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_816
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_817
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_818
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_819
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_820
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_821
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_822
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_823
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_824
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_825
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_826
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_827
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_828
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_829
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_830
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_831
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_832
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_833
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_834
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_835
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_836
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_837
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b STRING, c FLOAT64);
INSERT INTO source VALUES (1, 'X', 10.0);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (a INT64, b STRING, c FLOAT64);
INSERT INTO dest (c, a, b) SELECT c, a, b FROM source;
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_838
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_839
SELECT a, b, c FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_840
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_841
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_842
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_843
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_844
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_845
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_846
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_847
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_848
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_849
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_850
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_851
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_852
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_853
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_854
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_855
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_856
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_857
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_858
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_859
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_860
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_861
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_862
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_863
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_864
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (id INT64, value INT64);
INSERT INTO int_data VALUES (1, 100);
INSERT INTO int_data VALUES (2, 200);
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (id INT64, value FLOAT64);
INSERT INTO float_data SELECT id, value FROM int_data;
DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_865
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_866
SELECT COUNT(*) FROM float_data;
-- Tag: window_functions_window_functions_dml_test_select_867
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_868
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_869
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_870
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_871
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_872
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_873
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_874
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_875
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_876
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_877
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_878
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_879
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_880
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_881
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_882
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_883
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_884
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_885
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_886
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_887
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_888
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_889
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_890
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS float_data;
CREATE TABLE float_data (value FLOAT64);
INSERT INTO float_data VALUES (10.5);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (value INT64);
INSERT INTO int_data SELECT value FROM float_data;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_891
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_892
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_893
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_894
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_895
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_896
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_897
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_898
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_899
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_900
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_901
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_902
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_903
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_904
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_905
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_906
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_907
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_908
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_909
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_910
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_911
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_912
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_913
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_914
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_915
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64);
INSERT INTO dest SELECT id FROM source ORDER BY id LIMIT 10;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_916
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_917
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_918
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_919
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_920
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_921
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_922
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_923
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_924
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_925
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_926
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_927
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_928
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_929
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_930
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_931
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_932
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_933
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_934
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_935
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_936
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_937
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_938
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_939
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_940
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_941
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_942
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_943
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_944
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_945
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_946
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_947
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_948
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_949
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_950
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_951
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_952
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_953
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_954
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_955
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_956
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_957
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_958
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_959
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_960
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_961
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_962
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_963
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_964
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob'), (1, 'DUPLICATE'), (3, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_965
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_966
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_967
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_968
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_969
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_970
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_971
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_972
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_973
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_974
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_975
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_976
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_977
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_978
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_979
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_980
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_981
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_982
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_983
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_984
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_985
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_986
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES \
(1, 'Alice', 30), \
(2, NULL, 25), \
(3, 'Charlie', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_987
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_988
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_989
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_990
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_991
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_992
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_993
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_994
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_995
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_996
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_997
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_998
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_999
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1000
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1001
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1002
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1003
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1004
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1005
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1006
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 20.5), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1007
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1008
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1009
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1010
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1011
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1012
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1013
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1014
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1015
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1016
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1017
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1018
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1019
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1020
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1021
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1022
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1023
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1024
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1025
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1026
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1027
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1028
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1029
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1030
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1031
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1032
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1033
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1034
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1035
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1036
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1037
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1038
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1039
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1040
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1041
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1042
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1043
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1044
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1045
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1046
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1047
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1048
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1049
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1050
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1051
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1052
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1053
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1054
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1055
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1056
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1057
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1058
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1059
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1060
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1061
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1062
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1063
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1064
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1065
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1066
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1067
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1068
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1069
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1070
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1071
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1072
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1073
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1074
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1075
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1076
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1077
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1078
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1079
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1080
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1081
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1082
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1083
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1084
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1085
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1086
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1087
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1088
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1089
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1090
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1091
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1092
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1093
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1094
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1095
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1096
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1097
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1098
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1099
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1100
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1101
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1102
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1103
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1104
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1105
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1106
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1107
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1108
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1109
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1110
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1111
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1112
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1113
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1114
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1115
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1116
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1117
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1118
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1119
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1120
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1121
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1122
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1123
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1124
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1125
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1126
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1127
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1128
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1129
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1130
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1131
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1132
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1133
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1134
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1135
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1136
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1137
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1138
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1139
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1140
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1141
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1142
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1143
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1144
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1145
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1146
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1147
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1148
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1149
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1150
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1151
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1152
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1153
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1154
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1155
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1156
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1157
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1158
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1159
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1160
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1161
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1162
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1163
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1164
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1165
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1166
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1167
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1168
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1169
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1170
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1171
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1172
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_dml_test_select_1173
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1174
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1175
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1176
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1177
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1178
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1179
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1180
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1181
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1182
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1183
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1184
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1185
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1186
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1187
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1188
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1189
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1190
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1191
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1192
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1193
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1194
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1195
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1196
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1197
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1198
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1199
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1200
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1201
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1202
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_dml_test_select_1203
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1204
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1205
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1206
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1207
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1208
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1209
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1210
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_dml_test_select_1211
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1212
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_dml_test_select_1213
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1214
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1215
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_dml_test_select_1216
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_dml_test_select_1217
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_dml_test_select_1218
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_dml_test_select_1219
SELECT id FROM data WHERE name = 'Alice';

CREATE SEQUENCE seq_insert;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item2');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item3');
CREATE SEQUENCE seq_curr;
CREATE SEQUENCE seq_curr_err;
CREATE SEQUENCE seq_noadvance;
CREATE SEQUENCE seq_set;
CREATE SEQUENCE seq_setcall;
CREATE SEQUENCE seq_setmax MAXVALUE 100 NO CYCLE;
CREATE SEQUENCE seq_last;
CREATE SEQUENCE seq1;
CREATE SEQUENCE seq2 START WITH 100;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
INSERT INTO items (name) VALUES ('Item3');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (id, name) VALUES (10, 'Item10');
INSERT INTO items (name) VALUES ('Item11');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id BIGSERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(1, 1), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(100, 5), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (10, 'Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_dml_test_select_1220
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1221
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_dml_test_select_1222
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_dml_test_select_1223
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_dml_test_select_1224
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_dml_test_select_1225
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_dml_test_select_1226
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_dml_test_select_1227
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_dml_test_select_1228
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_dml_test_select_1229
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_dml_test_select_1230
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_dml_test_select_1231
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_dml_test_select_1232
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_dml_test_select_1233
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_dml_test_select_1234
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_dml_test_select_1235
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_dml_test_select_1236
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_dml_test_select_1237
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_dml_test_select_1238
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_dml_test_select_1239
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_dml_test_select_1240
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_dml_test_select_1241
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_dml_test_select_1242
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_dml_test_select_1243
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_dml_test_select_1244
SELECT LASTVAL();
-- Tag: window_functions_window_functions_dml_test_select_1245
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1246
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1247
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1248
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1249
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_dml_test_select_1250
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_dml_test_select_1251
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1252
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1253
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1254
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1255
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_dml_test_select_1256
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1257
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_dml_test_select_1258
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1259
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1260
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1261
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id BIGSERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(1, 1), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(100, 5), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (10, 'Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_dml_test_select_1262
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1263
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1264
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_dml_test_select_1265
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_dml_test_select_1266
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1267
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1268
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1269
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_dml_test_select_1270
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_dml_test_select_1271
SELECT id FROM items;
-- Tag: window_functions_window_functions_dml_test_select_1272
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_dml_test_select_1273
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1274
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1275
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_dml_test_select_1276
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL);
INSERT INTO users VALUES (1, 'alice@example.com');
INSERT INTO users VALUES (2, 'bob@example.com');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com'), (2, 'bob@example.com'), (3, 'charlie@example.com');
INSERT INTO users VALUES (10, 'dave@example.com'), (10, 'eve@example.com');
INSERT INTO users VALUES (20, 'frank@example.com'), (21, 'frank@example.com');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING UNIQUE);
INSERT INTO items VALUES (1, 'test@#$%^&*()');
INSERT INTO items VALUES (2, '中文字符');
INSERT INTO items VALUES (3, '🚀🎉');
INSERT INTO items VALUES (4, 'test@#$%^&*()');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING NOT NULL UNIQUE);
INSERT INTO test VALUES (1, 'first');
INSERT INTO test VALUES (1, 'second');
INSERT INTO test VALUES (2, 'first');
INSERT INTO test VALUES (3, NULL);

UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_dml_test_select_1277
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com'), (2, 'bob@example.com'), (3, 'charlie@example.com');
INSERT INTO users VALUES (10, 'dave@example.com'), (10, 'eve@example.com');
INSERT INTO users VALUES (20, 'frank@example.com'), (21, 'frank@example.com');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING UNIQUE);
INSERT INTO items VALUES (1, 'test@#$%^&*()');
INSERT INTO items VALUES (2, '中文字符');
INSERT INTO items VALUES (3, '🚀🎉');
INSERT INTO items VALUES (4, 'test@#$%^&*()');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING NOT NULL UNIQUE);
INSERT INTO test VALUES (1, 'first');
INSERT INTO test VALUES (1, 'second');
INSERT INTO test VALUES (2, 'first');
INSERT INTO test VALUES (3, NULL);

-- Tag: window_functions_window_functions_dml_test_select_1278
SELECT COUNT(*) FROM numbers;

