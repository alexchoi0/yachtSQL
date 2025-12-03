-- Window Functions Json - SQL:2023
-- Description: JSON data type and JSON manipulation functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES ('Alice'), ('Bob'), ('Charlie');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_001
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_002
SELECT JSON_AGG(name) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_003
SELECT JSON_AGG(name) as names, JSON_AGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_004
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_005
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_006
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_007
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_008
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_009
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_010
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_011
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_012
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_013
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_014
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_015
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_016
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_017
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_018
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES ('Alice'), ('Bob'), ('Charlie');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_019
SELECT JSON_AGG(name) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_020
SELECT JSON_AGG(name) as names, JSON_AGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_021
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_022
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_023
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_024
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_025
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_026
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_027
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_028
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_029
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_030
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_031
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_032
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_033
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_034
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_035
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_036
SELECT JSON_AGG(name) as names, JSON_AGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_037
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_038
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_039
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_040
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_041
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_042
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_043
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_044
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_045
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_046
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_047
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_048
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_049
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_050
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_051
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_052
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_053
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_054
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_055
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_056
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_057
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_058
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_059
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_060
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_061
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_062
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_063
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_064
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_065
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_066
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_067
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_068
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_069
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_070
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_071
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_072
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_073
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_074
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_075
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_076
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_077
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_078
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_079
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', 2), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value STRING);
INSERT INTO test VALUES ('name', 'Alice'), ('city', 'NYC');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('a', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, key STRING, value INT64);
INSERT INTO test VALUES ('X', 'a', 1), ('X', 'b', 2), ('Y', 'c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: window_functions_window_functions_json_test_select_080
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_081
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_json_test_select_082
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_083
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_084
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_085
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_086
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_087
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_088
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_089
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_json_test_select_090
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_091
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

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

-- Tag: window_functions_window_functions_json_test_select_092
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_json_test_select_093
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_json_test_select_094
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_json_test_select_095
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

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

-- Tag: window_functions_window_functions_json_test_select_096
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_json_test_select_097
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_json_test_select_098
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (20), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOL);
INSERT INTO test VALUES (true), (false), (true), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (3.14159), (2.71828), (-0.0), (1e10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150), ('West', 250), ('West', 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5), (2, 'Bob', 87.3), (3, 'Charlie', 92.1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('answer', 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('x', 1), ('y', 2), ('x', 3), ('x', 4);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2), ('b', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k INT64, v STRING);
INSERT INTO test VALUES (1, 'one'), (2, 'two'), (42, 'answer');
DROP TABLE IF EXISTS test;
CREATE TABLE test (k BOOL, v INT64);
INSERT INTO test VALUES (true, 1), (false, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v_int INT64, v_str STRING, v_bool BOOL);
INSERT INTO test VALUES ('row1', 42, 'text', true);
DROP TABLE IF EXISTS config;
CREATE TABLE config (env STRING, key STRING, value STRING);
INSERT INTO config VALUES ('dev', 'host', 'localhost'), ('dev', 'port', '8080'), ('prod', 'host', 'example.com'), ('prod', 'port', '443');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, key STRING, value INT64);
INSERT INTO data VALUES ('A', 'x', 10), ('A', 'y', 20), ('B', 'z', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: window_functions_window_functions_json_test_select_099
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_100
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_101
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_102
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_103
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_104
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_105
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_106
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_107
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_json_test_select_108
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_109
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_110
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_json_test_select_111
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_json_test_select_112
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_113
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_114
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_115
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_116
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_117
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_118
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_119
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_120
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_121
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_json_test_select_122
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_json_test_select_123
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_json_test_select_124
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_json_test_select_125
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_json_test_select_126
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_127
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_json_test_select_128
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_json_test_select_129
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_130
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (20), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOL);
INSERT INTO test VALUES (true), (false), (true), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (3.14159), (2.71828), (-0.0), (1e10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150), ('West', 250), ('West', 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5), (2, 'Bob', 87.3), (3, 'Charlie', 92.1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('answer', 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('x', 1), ('y', 2), ('x', 3), ('x', 4);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2), ('b', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k INT64, v STRING);
INSERT INTO test VALUES (1, 'one'), (2, 'two'), (42, 'answer');
DROP TABLE IF EXISTS test;
CREATE TABLE test (k BOOL, v INT64);
INSERT INTO test VALUES (true, 1), (false, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v_int INT64, v_str STRING, v_bool BOOL);
INSERT INTO test VALUES ('row1', 42, 'text', true);
DROP TABLE IF EXISTS config;
CREATE TABLE config (env STRING, key STRING, value STRING);
INSERT INTO config VALUES ('dev', 'host', 'localhost'), ('dev', 'port', '8080'), ('prod', 'host', 'example.com'), ('prod', 'port', '443');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, key STRING, value INT64);
INSERT INTO data VALUES ('A', 'x', 10), ('A', 'y', 20), ('B', 'z', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: window_functions_window_functions_json_test_select_131
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_132
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_133
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_134
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_135
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_136
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_137
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_138
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_json_test_select_139
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_140
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_141
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_json_test_select_142
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_json_test_select_143
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_144
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_145
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_146
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_147
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_148
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_149
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_150
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_151
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_152
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_json_test_select_153
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_json_test_select_154
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_json_test_select_155
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_json_test_select_156
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_json_test_select_157
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_158
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_json_test_select_159
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_json_test_select_160
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_161
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (NULL), (20), (NULL), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOL);
INSERT INTO test VALUES (true), (false), (true), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (3.14159), (2.71828), (-0.0), (1e10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150), ('West', 250), ('West', 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5), (2, 'Bob', 87.3), (3, 'Charlie', 92.1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('answer', 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('x', 1), ('y', 2), ('x', 3), ('x', 4);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2), ('b', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k INT64, v STRING);
INSERT INTO test VALUES (1, 'one'), (2, 'two'), (42, 'answer');
DROP TABLE IF EXISTS test;
CREATE TABLE test (k BOOL, v INT64);
INSERT INTO test VALUES (true, 1), (false, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v_int INT64, v_str STRING, v_bool BOOL);
INSERT INTO test VALUES ('row1', 42, 'text', true);
DROP TABLE IF EXISTS config;
CREATE TABLE config (env STRING, key STRING, value STRING);
INSERT INTO config VALUES ('dev', 'host', 'localhost'), ('dev', 'port', '8080'), ('prod', 'host', 'example.com'), ('prod', 'port', '443');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, key STRING, value INT64);
INSERT INTO data VALUES ('A', 'x', 10), ('A', 'y', 20), ('B', 'z', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: window_functions_window_functions_json_test_select_162
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_163
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_164
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_165
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_166
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_167
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_168
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_json_test_select_169
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_170
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_171
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_json_test_select_172
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_json_test_select_173
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_174
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_175
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_176
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_177
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_178
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_179
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_180
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_181
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_182
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_json_test_select_183
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_json_test_select_184
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_json_test_select_185
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_json_test_select_186
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_json_test_select_187
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_188
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_json_test_select_189
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_json_test_select_190
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_191
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOL);
INSERT INTO test VALUES (true), (false), (true), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (3.14159), (2.71828), (-0.0), (1e10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150), ('West', 250), ('West', 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5), (2, 'Bob', 87.3), (3, 'Charlie', 92.1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('answer', 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('x', 1), ('y', 2), ('x', 3), ('x', 4);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2), ('b', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k INT64, v STRING);
INSERT INTO test VALUES (1, 'one'), (2, 'two'), (42, 'answer');
DROP TABLE IF EXISTS test;
CREATE TABLE test (k BOOL, v INT64);
INSERT INTO test VALUES (true, 1), (false, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v_int INT64, v_str STRING, v_bool BOOL);
INSERT INTO test VALUES ('row1', 42, 'text', true);
DROP TABLE IF EXISTS config;
CREATE TABLE config (env STRING, key STRING, value STRING);
INSERT INTO config VALUES ('dev', 'host', 'localhost'), ('dev', 'port', '8080'), ('prod', 'host', 'example.com'), ('prod', 'port', '443');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, key STRING, value INT64);
INSERT INTO data VALUES ('A', 'x', 10), ('A', 'y', 20), ('B', 'z', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: window_functions_window_functions_json_test_select_192
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_193
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_194
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_195
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_196
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_197
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_json_test_select_198
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_199
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_200
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_json_test_select_201
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_json_test_select_202
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_203
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_204
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_205
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_206
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_207
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_208
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_209
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_210
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_211
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_json_test_select_212
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_json_test_select_213
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_json_test_select_214
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_json_test_select_215
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_json_test_select_216
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_217
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_json_test_select_218
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_json_test_select_219
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_220
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOL);
INSERT INTO test VALUES (true), (false), (true), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (3.14159), (2.71828), (-0.0), (1e10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (d DATE);
INSERT INTO test VALUES (DATE '2024-01-01'), (DATE '2024-12-31');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150), ('West', 250), ('West', 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10), ('A', 20), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, score FLOAT64);
INSERT INTO test VALUES (1, 'Alice', 95.5), (2, 'Bob', 87.3), (3, 'Charlie', 92.1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('answer', 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('x', 1), ('y', 2), ('x', 3), ('x', 4);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), (NULL, 2), ('b', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1), ('b', NULL), ('c', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES (NULL, 1), (NULL, 2), (NULL, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k INT64, v STRING);
INSERT INTO test VALUES (1, 'one'), (2, 'two'), (42, 'answer');
DROP TABLE IF EXISTS test;
CREATE TABLE test (k BOOL, v INT64);
INSERT INTO test VALUES (true, 1), (false, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v_int INT64, v_str STRING, v_bool BOOL);
INSERT INTO test VALUES ('row1', 42, 'text', true);
DROP TABLE IF EXISTS config;
CREATE TABLE config (env STRING, key STRING, value STRING);
INSERT INTO config VALUES ('dev', 'host', 'localhost'), ('dev', 'port', '8080'), ('prod', 'host', 'example.com'), ('prod', 'port', '443');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, key STRING, value INT64);
INSERT INTO data VALUES ('A', 'x', 10), ('A', 'y', 20), ('B', 'z', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: window_functions_window_functions_json_test_select_221
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_222
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_223
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_224
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_225
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_json_test_select_226
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_227
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_json_test_select_228
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_json_test_select_229
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_json_test_select_230
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_231
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_232
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_233
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_234
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_235
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_236
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_237
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_238
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_json_test_select_239
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_json_test_select_240
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_json_test_select_241
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_json_test_select_242
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_json_test_select_243
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_json_test_select_244
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_json_test_select_245
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_json_test_select_246
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_json_test_select_247
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_json_test_select_248
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_249
SELECT JSON_VALUE(data, '$.num') FROM tiny;
-- Tag: window_functions_window_functions_json_test_select_250
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
-- Tag: window_functions_window_functions_json_test_select_251
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_252
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_253
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_001
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_254
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_255
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_256
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_257
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_258
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_259
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_260
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
-- Tag: window_functions_window_functions_json_test_select_261
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_262
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_263
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_002
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_264
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_265
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_266
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_267
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_268
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_269
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_270
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
-- Tag: window_functions_window_functions_json_test_select_271
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_272
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_273
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_003
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_274
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_275
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_276
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_277
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_278
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_279
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_280
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
-- Tag: window_functions_window_functions_json_test_select_281
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_282
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_283
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_004
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_284
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_285
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_286
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_287
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_288
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_289
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_290
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_291
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_292
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_005
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_293
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_294
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_295
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_296
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_297
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_298
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_299
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_300
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_301
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_006
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_302
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_303
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_304
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_305
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_306
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_307
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_308
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_309
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_310
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_007
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_311
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_312
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_313
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_314
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_315
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_316
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_317
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_318
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_319
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_008
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_320
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_321
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_322
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_323
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_324
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_325
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_json_test_select_326
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_json_test_select_327
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_328
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_009
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_329
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_330
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_331
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_332
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_333
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_334
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);

-- Tag: window_functions_window_functions_json_test_select_335
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_json_test_select_336
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_010
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_337
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_338
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_339
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_340
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_341
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_342
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);

-- Tag: window_functions_window_functions_json_test_select_343
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_json_test_select_011
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_344
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_345
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_346
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_347
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_348
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_349
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);

-- Tag: window_functions_window_functions_json_test_select_012
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_json_test_select_350
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_json_test_select_351
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_json_test_select_352
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_json_test_select_353
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_json_test_select_354
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_json_test_select_355
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS events;
CREATE TABLE events ( category STRING, event_name STRING, severity INT64 );
INSERT INTO events VALUES
('security', 'login_attempt', 1),
('security', 'permission_denied', 2),
('security', 'data_breach', 5),
('performance', 'slow_query', 2),
('performance', 'timeout', 3),
('error', 'null_pointer', 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( id INT64, flag1 BOOL, flag2 BOOL, flag3 BOOL );
INSERT INTO test VALUES
(1, true, NULL, false),   -- TRUE AND NULL = NULL
(2, false, NULL, true),   -- FALSE AND NULL = FALSE (short-circuit)
(3, true, NULL, true),    -- TRUE OR NULL = TRUE (short-circuit)
(4, NULL, false, true),   -- NULL OR FALSE = NULL
(5, NULL, true, false)    -- NULL OR TRUE = TRUE (short-circuit);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( group_id INT64, value INT64 );
INSERT INTO test VALUES (1, 7), (1, 3), (3, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( category STRING, flag BOOL );
INSERT INTO test VALUES
('A', NULL),
('A', NULL),
('B', true),
('B', NULL);
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, name STRING, manager_id INT64 );
INSERT INTO users VALUES
(1, 'Alice', NULL),   -- Top-level manager
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, revenue INT64 );
INSERT INTO sales VALUES
('North', 'Widget', 1000),
('North', 'Gadget', 500),
('South', 'Widget', 2000),
('South', 'Gadget', 3000);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( group_id INT64, permissions INT64, is_active BOOL );
INSERT INTO test VALUES
(1, 15, true),
(1, 7, true),
(1, 3, false),
(2, 1, true),
(2, 1, true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (42), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( val1 INT64, val2 INT64, val3 INT64 );
INSERT INTO test VALUES
(NULL, NULL, 100),
(NULL, 200, 100),
(300, 200, 100);

-- Tag: window_functions_window_functions_json_test_select_013
SELECT
TRANSLATE(category, '_', ' ') as clean_category,
JSON_AGG(event_name) as events,
AVG(severity) as avg_severity
FROM events
GROUP BY category
HAVING AVG(severity) >= 2
ORDER BY avg_severity DESC;
-- Tag: window_functions_window_functions_json_test_select_356
SELECT id FROM test WHERE flag1 AND flag2 ORDER BY id;
-- Tag: window_functions_window_functions_json_test_select_357
SELECT id FROM test WHERE flag1 OR flag3 ORDER BY id;
-- Tag: window_functions_window_functions_json_test_select_358
SELECT group_id, BIT_AND(value) as bit_and_result
FROM test
WHERE group_id <= 5
GROUP BY group_id
ORDER BY group_id;
-- Tag: window_functions_window_functions_json_test_select_359
SELECT category, BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true
FROM test
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_json_test_select_014
SELECT
u1.name as employee,
(SELECT name FROM users WHERE id = u1.manager_id),
'CEO') as reports_to
FROM users u1
ORDER BY u1.id;
-- Tag: window_functions_window_functions_json_test_select_360
SELECT BIT_AND(value) FROM test;
-- Tag: window_functions_window_functions_json_test_select_361
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_json_test_select_362
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_json_test_select_363
SELECT region, product
FROM sales
GROUP BY region, product
HAVING SUM(revenue) > 1000
ORDER BY region, product;
-- Tag: window_functions_window_functions_json_test_select_364
SELECT group_id, COUNT(*) as member_count
FROM test
GROUP BY group_id
HAVING (BIT_AND(permissions) & 1) = 1
AND BOOL_OR(is_active) = true
AND BOOL_AND(is_active) = false
ORDER BY group_id;
-- Tag: window_functions_window_functions_json_test_select_365
SELECT value, NVL(value, value) as nvl_result FROM test ORDER BY value;
-- Tag: window_functions_window_functions_json_test_select_366
SELECT NVL(val1, NVL(val2, val3)) as result FROM test ORDER BY result;

