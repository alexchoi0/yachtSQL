-- Window Functions Grouping - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES
('A', 12), ('A', 10), ('A', 14),
('B', 7), ('B', 3), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 1), (2, 2), (3, 4), (4, 8);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'hello');

-- Tag: window_functions_window_functions_grouping_test_select_001
SELECT category,
BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_grouping_test_select_002
SELECT BOOL_AND(flag) as bool_and,
BOOL_OR(NOT flag) as or_not
FROM test;
-- Tag: window_functions_window_functions_grouping_test_select_003
SELECT BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test;
-- Tag: window_functions_window_functions_grouping_test_select_004
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_grouping_test_select_005
SELECT BIT_AND(value) FROM test;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('Electronics', 'Phone', 100.0),
('Electronics', 'Laptop', 200.0),
('Clothing', 'Shirt', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (year INT64, quarter INT64, region STRING, amount FLOAT64);
INSERT INTO sales VALUES
(2023, 1, 'North', 100.0),
(2023, 1, 'South', 150.0),
(2023, 2, 'North', 120.0),
(2024, 1, 'North', 130.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('A', 20),
('B', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('North', 'Widget', 2023, 100.0),
('North', 'Widget', 2024, 150.0),
('North', 'Gadget', 2023, 200.0),
('South', 'Widget', 2023, 120.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value INT64);
INSERT INTO data VALUES
(3, 'C', 30),
(1, 'A', 10),
(2, 'B', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, name STRING);
INSERT INTO data VALUES (10, 'A'), (30, 'C'), (20, 'B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, subcategory STRING, value INT64);
INSERT INTO data VALUES
('B', 'Y', 1),
('A', 'Z', 2),
('A', 'X', 3),
('B', 'X', 4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (player STRING, score INT64);
INSERT INTO scores VALUES
('Alice', 100),
('Bob', 100),
('Charlie', 50),
('David', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b STRING, c INT64);
INSERT INTO data VALUES
(1, 'Z', 10),
(1, 'A', 20),
(2, 'Z', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (price FLOAT64, quantity INT64);
INSERT INTO data VALUES
(10.0, 5),
(20.0, 2),
(5.0, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, value INT64);
INSERT INTO data VALUES
('Alice', 10),
('alice', 20),
('Bob', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0),
('C', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (3, 30), (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, score INT64);
INSERT INTO data VALUES
('Alice', 90),
('Bob', 85),
('Charlie', 95);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, subcategory STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'X', 100.0),
('A', 'Y', 150.0),
('B', 'X', 200.0);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0), (2, 200.0), (1, 150.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_grouping_test_select_006
SELECT category, SUM(amount) as total
FROM sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_007
SELECT year, quarter, SUM(amount) as total
FROM sales
GROUP BY 1, 2
ORDER BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_008
SELECT UPPER(category) as cat_upper, SUM(value) as total
FROM data
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_009
SELECT region, product, year, SUM(amount) as total
FROM sales
GROUP BY 1, product, 3
ORDER BY 1, 2, 3;
-- Tag: window_functions_window_functions_grouping_test_select_010
SELECT id, name, value
FROM data
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_011
SELECT value, name
FROM data
ORDER BY 1 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_012
SELECT category, subcategory, value
FROM data
ORDER BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_013
SELECT player, score
FROM scores
ORDER BY 2 DESC, 1 ASC;
-- Tag: window_functions_window_functions_grouping_test_select_014
SELECT a, b, c
FROM data
ORDER BY 1, b DESC, 3;
-- Tag: window_functions_window_functions_grouping_test_select_015
SELECT price, quantity, price * quantity as total
FROM data
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_016
SELECT UPPER(name) as name_upper, SUM(value) as total
FROM data
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_017
SELECT a, b FROM data ORDER BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_018
SELECT a, b FROM data ORDER BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_019
SELECT category, SUM(value) FROM data GROUP BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_020
SELECT category, SUM(value) FROM data GROUP BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_021
SELECT a FROM data ORDER BY -1;
-- Tag: window_functions_window_functions_grouping_test_select_022
SELECT product, SUM(amount) as total
FROM sales
GROUP BY product
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_023
SELECT category, SUM(amount) as total
FROM sales
GROUP BY 1
HAVING SUM(amount) > 100
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_024
SELECT *
FROM (SELECT id, value FROM data ORDER BY 1) as sorted
LIMIT 2;
-- Tag: window_functions_window_functions_grouping_test_select_025
SELECT category, total
FROM (SELECT category, SUM(amount) as total FROM sales GROUP BY 1) as grouped
ORDER BY total DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_grouping_test_select_026
SELECT name, score FROM data
)
-- Tag: window_functions_window_functions_grouping_test_select_027
SELECT name, score
FROM ranked
ORDER BY 2 DESC;
WITH category_sales AS (
-- Tag: window_functions_window_functions_grouping_test_select_028
SELECT category, subcategory, amount FROM sales
)
-- Tag: window_functions_window_functions_grouping_test_select_029
SELECT category, SUM(amount) as total
FROM category_sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_030
SELECT c.name, SUM(o.amount) as total
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_031
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_032
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_033
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_034
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_035
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (year INT64, quarter INT64, region STRING, amount FLOAT64);
INSERT INTO sales VALUES
(2023, 1, 'North', 100.0),
(2023, 1, 'South', 150.0),
(2023, 2, 'North', 120.0),
(2024, 1, 'North', 130.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('A', 20),
('B', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('North', 'Widget', 2023, 100.0),
('North', 'Widget', 2024, 150.0),
('North', 'Gadget', 2023, 200.0),
('South', 'Widget', 2023, 120.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value INT64);
INSERT INTO data VALUES
(3, 'C', 30),
(1, 'A', 10),
(2, 'B', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, name STRING);
INSERT INTO data VALUES (10, 'A'), (30, 'C'), (20, 'B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, subcategory STRING, value INT64);
INSERT INTO data VALUES
('B', 'Y', 1),
('A', 'Z', 2),
('A', 'X', 3),
('B', 'X', 4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (player STRING, score INT64);
INSERT INTO scores VALUES
('Alice', 100),
('Bob', 100),
('Charlie', 50),
('David', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b STRING, c INT64);
INSERT INTO data VALUES
(1, 'Z', 10),
(1, 'A', 20),
(2, 'Z', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (price FLOAT64, quantity INT64);
INSERT INTO data VALUES
(10.0, 5),
(20.0, 2),
(5.0, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, value INT64);
INSERT INTO data VALUES
('Alice', 10),
('alice', 20),
('Bob', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0),
('C', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (3, 30), (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, score INT64);
INSERT INTO data VALUES
('Alice', 90),
('Bob', 85),
('Charlie', 95);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, subcategory STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'X', 100.0),
('A', 'Y', 150.0),
('B', 'X', 200.0);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0), (2, 200.0), (1, 150.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_grouping_test_select_036
SELECT year, quarter, SUM(amount) as total
FROM sales
GROUP BY 1, 2
ORDER BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_037
SELECT UPPER(category) as cat_upper, SUM(value) as total
FROM data
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_038
SELECT region, product, year, SUM(amount) as total
FROM sales
GROUP BY 1, product, 3
ORDER BY 1, 2, 3;
-- Tag: window_functions_window_functions_grouping_test_select_039
SELECT id, name, value
FROM data
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_040
SELECT value, name
FROM data
ORDER BY 1 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_041
SELECT category, subcategory, value
FROM data
ORDER BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_042
SELECT player, score
FROM scores
ORDER BY 2 DESC, 1 ASC;
-- Tag: window_functions_window_functions_grouping_test_select_043
SELECT a, b, c
FROM data
ORDER BY 1, b DESC, 3;
-- Tag: window_functions_window_functions_grouping_test_select_044
SELECT price, quantity, price * quantity as total
FROM data
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_045
SELECT UPPER(name) as name_upper, SUM(value) as total
FROM data
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_046
SELECT a, b FROM data ORDER BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_047
SELECT a, b FROM data ORDER BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_048
SELECT category, SUM(value) FROM data GROUP BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_049
SELECT category, SUM(value) FROM data GROUP BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_050
SELECT a FROM data ORDER BY -1;
-- Tag: window_functions_window_functions_grouping_test_select_051
SELECT product, SUM(amount) as total
FROM sales
GROUP BY product
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_052
SELECT category, SUM(amount) as total
FROM sales
GROUP BY 1
HAVING SUM(amount) > 100
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_053
SELECT *
FROM (SELECT id, value FROM data ORDER BY 1) as sorted
LIMIT 2;
-- Tag: window_functions_window_functions_grouping_test_select_054
SELECT category, total
FROM (SELECT category, SUM(amount) as total FROM sales GROUP BY 1) as grouped
ORDER BY total DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_grouping_test_select_055
SELECT name, score FROM data
)
-- Tag: window_functions_window_functions_grouping_test_select_056
SELECT name, score
FROM ranked
ORDER BY 2 DESC;
WITH category_sales AS (
-- Tag: window_functions_window_functions_grouping_test_select_057
SELECT category, subcategory, amount FROM sales
)
-- Tag: window_functions_window_functions_grouping_test_select_058
SELECT category, SUM(amount) as total
FROM category_sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_059
SELECT c.name, SUM(o.amount) as total
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_060
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_061
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_062
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_063
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_064
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, value INT64);
INSERT INTO data VALUES
('Alice', 10),
('alice', 20),
('Bob', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0),
('C', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (3, 30), (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, score INT64);
INSERT INTO data VALUES
('Alice', 90),
('Bob', 85),
('Charlie', 95);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, subcategory STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'X', 100.0),
('A', 'Y', 150.0),
('B', 'X', 200.0);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0), (2, 200.0), (1, 150.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_grouping_test_select_065
SELECT UPPER(name) as name_upper, SUM(value) as total
FROM data
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_066
SELECT a, b FROM data ORDER BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_067
SELECT a, b FROM data ORDER BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_068
SELECT category, SUM(value) FROM data GROUP BY 0;
-- Tag: window_functions_window_functions_grouping_test_select_069
SELECT category, SUM(value) FROM data GROUP BY 3;
-- Tag: window_functions_window_functions_grouping_test_select_070
SELECT a FROM data ORDER BY -1;
-- Tag: window_functions_window_functions_grouping_test_select_071
SELECT product, SUM(amount) as total
FROM sales
GROUP BY product
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_072
SELECT category, SUM(amount) as total
FROM sales
GROUP BY 1
HAVING SUM(amount) > 100
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_073
SELECT *
FROM (SELECT id, value FROM data ORDER BY 1) as sorted
LIMIT 2;
-- Tag: window_functions_window_functions_grouping_test_select_074
SELECT category, total
FROM (SELECT category, SUM(amount) as total FROM sales GROUP BY 1) as grouped
ORDER BY total DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_grouping_test_select_075
SELECT name, score FROM data
)
-- Tag: window_functions_window_functions_grouping_test_select_076
SELECT name, score
FROM ranked
ORDER BY 2 DESC;
WITH category_sales AS (
-- Tag: window_functions_window_functions_grouping_test_select_077
SELECT category, subcategory, amount FROM sales
)
-- Tag: window_functions_window_functions_grouping_test_select_078
SELECT category, SUM(amount) as total
FROM category_sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_079
SELECT c.name, SUM(o.amount) as total
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_080
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_081
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_082
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_083
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_084
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (3, 30), (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING, score INT64);
INSERT INTO data VALUES
('Alice', 90),
('Bob', 85),
('Charlie', 95);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, subcategory STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'X', 100.0),
('A', 'Y', 150.0),
('B', 'X', 200.0);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0), (2, 200.0), (1, 150.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_grouping_test_select_085
SELECT category, SUM(amount) as total
FROM sales
GROUP BY 1
HAVING SUM(amount) > 100
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_086
SELECT *
FROM (SELECT id, value FROM data ORDER BY 1) as sorted
LIMIT 2;
-- Tag: window_functions_window_functions_grouping_test_select_087
SELECT category, total
FROM (SELECT category, SUM(amount) as total FROM sales GROUP BY 1) as grouped
ORDER BY total DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_grouping_test_select_088
SELECT name, score FROM data
)
-- Tag: window_functions_window_functions_grouping_test_select_089
SELECT name, score
FROM ranked
ORDER BY 2 DESC;
WITH category_sales AS (
-- Tag: window_functions_window_functions_grouping_test_select_090
SELECT category, subcategory, amount FROM sales
)
-- Tag: window_functions_window_functions_grouping_test_select_091
SELECT category, SUM(amount) as total
FROM category_sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_092
SELECT c.name, SUM(o.amount) as total
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_093
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_094
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_095
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_096
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_097
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, subcategory STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'X', 100.0),
('A', 'Y', 150.0),
('B', 'X', 200.0);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0), (2, 200.0), (1, 150.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

WITH category_sales AS (
-- Tag: window_functions_window_functions_grouping_test_select_098
SELECT category, subcategory, amount FROM sales
)
-- Tag: window_functions_window_functions_grouping_test_select_099
SELECT category, SUM(amount) as total
FROM category_sales
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_100
SELECT c.name, SUM(o.amount) as total
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_101
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_102
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_103
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_104
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_105
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO products VALUES (1, 'Electronics'), (2, 'Electronics'), (3, 'Clothing');
INSERT INTO sales VALUES (1, 100.0), (2, 200.0), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING, value INT64);
INSERT INTO data VALUES
('X', 'Y', 10),
('X', 'Z', 20),
('Y', 'Y', 30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_grouping_test_select_106
SELECT p.category, SUM(s.amount) as total
FROM products p
JOIN sales s ON p.id = s.product_id
GROUP BY 1
ORDER BY 1;
-- Tag: window_functions_window_functions_grouping_test_select_107
SELECT a, b, SUM(value) as total
FROM data
GROUP BY 1, 2
ORDER BY 3 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_108
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_grouping_test_select_109
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_grouping_test_select_110
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

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

-- Tag: window_functions_window_functions_grouping_test_select_111
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_grouping_test_select_112
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_grouping_test_select_113
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_114
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_115
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_grouping_test_select_116
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_grouping_test_select_117
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_118
SELECT *;
-- Tag: window_functions_window_functions_grouping_test_select_119
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_grouping_test_select_120
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_grouping_test_select_121
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_grouping_test_select_122
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_grouping_test_select_123
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_124
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_125
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_126
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_grouping_test_select_127
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_grouping_test_select_128
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_129
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_130
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_grouping_test_select_131
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_grouping_test_select_132
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_grouping_test_select_133
SELECT *;
-- Tag: window_functions_window_functions_grouping_test_select_134
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_grouping_test_select_135
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_grouping_test_select_136
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_grouping_test_select_137
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_grouping_test_select_138
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_139
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_140
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_141
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_grouping_test_select_142
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_grouping_test_select_143
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_144
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_grouping_test_select_145
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_grouping_test_select_146
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_grouping_test_select_147
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_grouping_test_select_148
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_001
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_grouping_test_select_149
SELECT userid FROM users;
-- Tag: window_functions_window_functions_grouping_test_select_150
SELECT * FROM user;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( year INT64, quarter INT64, month INT64, revenue FLOAT64 );
INSERT INTO sales VALUES (2024, 1, 1, 100.0);
INSERT INTO sales VALUES (2024, 1, 2, 150.0);
INSERT INTO sales VALUES (2024, 2, 4, 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
INSERT INTO sales VALUES ('North', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_151
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_152
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_153
SELECT year, quarter, month, SUM(revenue) as total
FROM sales
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_154
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING SUM(amount) >= 100;
-- Tag: window_functions_window_functions_grouping_test_select_155
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_156
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_157
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_158
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_159
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_160
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_161
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_162
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_163
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_164
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_002
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_003
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_004
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_165
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_166
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_167
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_168
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_005
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_169
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_170
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_171
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_172
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_173
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_174
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_006
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_175
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( year INT64, quarter INT64, month INT64, revenue FLOAT64 );
INSERT INTO sales VALUES (2024, 1, 1, 100.0);
INSERT INTO sales VALUES (2024, 1, 2, 150.0);
INSERT INTO sales VALUES (2024, 2, 4, 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
INSERT INTO sales VALUES ('North', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_176
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_177
SELECT year, quarter, month, SUM(revenue) as total
FROM sales
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_178
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING SUM(amount) >= 100;
-- Tag: window_functions_window_functions_grouping_test_select_179
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_180
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_181
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_182
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_183
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_184
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_185
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_186
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_187
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_188
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_007
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_008
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_009
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_189
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_190
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_191
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_192
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_010
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_193
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_194
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_195
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_196
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_197
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_198
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_011
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_199
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( year INT64, quarter INT64, month INT64, revenue FLOAT64 );
INSERT INTO sales VALUES (2024, 1, 1, 100.0);
INSERT INTO sales VALUES (2024, 1, 2, 150.0);
INSERT INTO sales VALUES (2024, 2, 4, 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
INSERT INTO sales VALUES ('North', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_200
SELECT year, quarter, month, SUM(revenue) as total
FROM sales
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_201
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING SUM(amount) >= 100;
-- Tag: window_functions_window_functions_grouping_test_select_202
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_203
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_204
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_205
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_206
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_207
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_208
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_209
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_210
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_211
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_012
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_013
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_014
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_212
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_213
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_214
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_215
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_015
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_216
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_217
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_218
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_219
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_220
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_221
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_016
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_222
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
INSERT INTO sales VALUES ('North', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_223
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING SUM(amount) >= 100;
-- Tag: window_functions_window_functions_grouping_test_select_224
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_225
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_226
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_227
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_228
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_229
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_230
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_231
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_232
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_233
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_017
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_018
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_019
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_234
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_235
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_236
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_237
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_020
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_238
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_239
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_240
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_241
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_242
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_243
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_021
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_244
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_245
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_246
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_247
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_248
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_249
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_250
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_251
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_252
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_253
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_254
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_022
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_023
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_024
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_255
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_256
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_257
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_258
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_025
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_259
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_260
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_261
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_262
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_263
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_264
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_026
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_265
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, channel STRING, amount INT64 );
INSERT INTO sales VALUES ('East', 'Widget', 'Online', 100);
INSERT INTO sales VALUES ('West', 'Gadget', 'Store', 50);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_266
SELECT region, product, channel, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product, channel);
-- Tag: window_functions_window_functions_grouping_test_select_267
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_268
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_269
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_270
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_271
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_272
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_273
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_274
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_027
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_028
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_029
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_275
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_276
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_277
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_278
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_030
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_279
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_280
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_281
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_282
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_283
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_284
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_031
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_285
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES ('A', 10);
INSERT INTO test VALUES ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_286
SELECT category, SUM(value) as total FROM test GROUP BY CUBE(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_287
SELECT category, SUM(value) as total FROM test GROUP BY ROLLUP(category) ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_288
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_289
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_290
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_291
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_292
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_293
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_032
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_033
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_034
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_294
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_295
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_296
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_297
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_035
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_298
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_299
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_300
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_301
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_302
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_303
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_036
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_304
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('East', 'Gadget', 50);
INSERT INTO sales VALUES ('West', 'Widget', 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_305
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_306
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_307
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_308
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_309
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_310
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_037
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_038
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_039
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_311
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_312
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_313
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_314
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_040
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_315
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_316
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_317
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_318
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_319
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_320
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_041
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_321
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, quarter INT64, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 1, 100);
INSERT INTO sales VALUES ('East', 'Widget', 2, 150);
INSERT INTO sales VALUES ('West', 'Gadget', 1, 75);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_322
SELECT region, product, quarter, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (quarter), ());
-- Tag: window_functions_window_functions_grouping_test_select_323
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_324
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_325
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_326
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_042
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_043
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_044
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_327
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_328
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_329
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_330
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_045
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_331
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_332
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_333
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_334
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_335
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_336
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_046
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_337
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_338
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ())
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_339
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_340
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_341
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_047
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_048
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_049
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_342
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_343
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_344
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_345
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_050
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_346
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_347
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_348
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_349
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_350
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_351
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_051
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_352
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_353
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), (product), ());
-- Tag: window_functions_window_functions_grouping_test_select_354
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_052
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_053
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_054
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_355
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_356
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_357
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_358
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_055
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_359
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_360
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_361
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_362
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_363
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_364
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_056
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_365
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_057
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_058
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_059
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_366
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_367
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_368
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_369
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_060
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_370
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_371
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_372
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_373
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_374
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_375
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_061
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_376
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_062
SELECT
region,
product,
SUM(amount) as total,
GROUPING(region) as grp_region,
GROUPING(product) as grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_063
SELECT
region,
SUM(amount) as total,
GROUPING(region) as is_aggregated
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_377
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
HAVING GROUPING(region) = 1;
-- Tag: window_functions_window_functions_grouping_test_select_378
SELECT region, SUM(amount) as total, GROUPING(region) as grp
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region) DESC, region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_379
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_380
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_064
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_381
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_382
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_383
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_384
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_385
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_386
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_065
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_387
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64);
INSERT INTO products VALUES ('widget', 10.0);
INSERT INTO products VALUES ('Widget', 15.0);
INSERT INTO products VALUES ('GADGET', 20.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_388
SELECT UPPER(name) as name_upper, SUM(price) as total
FROM products
GROUP BY UPPER(name)
ORDER BY name_upper;
-- Tag: window_functions_window_functions_grouping_test_select_389
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_066
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_390
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_391
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_392
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_393
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_394
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_395
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_067
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_396
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, total FLOAT64, tax_rate FLOAT64);
INSERT INTO orders VALUES (1, 100.0, 0.1);
INSERT INTO orders VALUES (2, 200.0, 0.1);
INSERT INTO orders VALUES (3, 150.0, 0.2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 5.0);
INSERT INTO products VALUES (2, 15.0);
INSERT INTO products VALUES (3, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_397
SELECT tax_rate, COUNT(*) as cnt
FROM orders
GROUP BY tax_rate
ORDER BY tax_rate;
-- Tag: window_functions_window_functions_grouping_test_select_068
SELECT
CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END as price_range,
COUNT(*) as cnt
FROM products
GROUP BY CASE
WHEN price < 10 THEN 'Cheap'
WHEN price < 30 THEN 'Medium'
ELSE 'Expensive'
END;
-- Tag: window_functions_window_functions_grouping_test_select_398
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_399
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_400
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_401
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_402
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_403
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_069
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_404
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_405
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY 1, 2;
-- Tag: window_functions_window_functions_grouping_test_select_406
SELECT region, SUM(amount) as total
FROM sales
GROUP BY ROLLUP(region)
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_407
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_408
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_409
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_410
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_070
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_411
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_412
SELECT region, product, SUM(amount) as total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_413
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_414
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_415
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_071
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_416
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10);
INSERT INTO test VALUES (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_417
SELECT COUNT(*) as cnt, SUM(value) as total
FROM test
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_418
SELECT col1, SUM(col1) FROM test GROUP BY ROLLUP(nonexistent);
-- Tag: window_functions_window_functions_grouping_test_select_419
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_072
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_420
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_421
SELECT col1, SUM(col2) as total
FROM test
GROUP BY GROUPING SETS ((col1), (col1));
-- Tag: window_functions_window_functions_grouping_test_select_073
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_422
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('West', 50);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region_id INT64, amount INT64);
INSERT INTO regions VALUES (1, 'East');
INSERT INTO sales VALUES (1, 100);

-- Tag: window_functions_window_functions_grouping_test_select_074
SELECT
region,
SUM(amount) as total,
SUM(SUM(amount)) OVER () as grand_total
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_423
SELECT r.name, SUM(s.amount) as total
FROM regions r
JOIN sales s ON r.id = s.region_id
GROUP BY CUBE(r.name);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200),
('West', 'B', 120);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (category STRING, amount INT64);
INSERT INTO orders VALUES
('Books', 50), ('Books', 75), ('Electronics', 200);
DROP TABLE IF EXISTS sales_detail;
CREATE TABLE sales_detail ( year INT64, quarter INT64, month INT64, revenue INT64 );
INSERT INTO sales_detail VALUES
(2024, 1, 1, 1000),
(2024, 1, 2, 1200),
(2024, 2, 4, 1500);
DROP TABLE IF EXISTS products;
CREATE TABLE products (category STRING, sales INT64);
INSERT INTO products VALUES
('A', 100), ('A', 200), ('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, amount INT64);
INSERT INTO data VALUES
('East', 100),
(NULL, 50),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'X', 100),
('East', 'Y', 150),
('West', 'X', 200),
('West', 'Y', 120);
DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_424
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_425
SELECT category, SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(category)
ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_426
SELECT year, quarter, month, SUM(revenue) AS total
FROM sales_detail
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_427
SELECT category, SUM(sales) AS total
FROM products
GROUP BY ROLLUP(category)
HAVING SUM(sales) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_428
SELECT region, SUM(amount) AS total
FROM data
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_429
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_430
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_431
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_432
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_433
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_434
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_075
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_076
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_077
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_078
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_079
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_435
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_436
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_437
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_438
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_439
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_440
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (category STRING, amount INT64);
INSERT INTO orders VALUES
('Books', 50), ('Books', 75), ('Electronics', 200);
DROP TABLE IF EXISTS sales_detail;
CREATE TABLE sales_detail ( year INT64, quarter INT64, month INT64, revenue INT64 );
INSERT INTO sales_detail VALUES
(2024, 1, 1, 1000),
(2024, 1, 2, 1200),
(2024, 2, 4, 1500);
DROP TABLE IF EXISTS products;
CREATE TABLE products (category STRING, sales INT64);
INSERT INTO products VALUES
('A', 100), ('A', 200), ('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, amount INT64);
INSERT INTO data VALUES
('East', 100),
(NULL, 50),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'X', 100),
('East', 'Y', 150),
('West', 'X', 200),
('West', 'Y', 120);
DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_441
SELECT category, SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(category)
ORDER BY category NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_442
SELECT year, quarter, month, SUM(revenue) AS total
FROM sales_detail
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_443
SELECT category, SUM(sales) AS total
FROM products
GROUP BY ROLLUP(category)
HAVING SUM(sales) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_444
SELECT region, SUM(amount) AS total
FROM data
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_445
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_446
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_447
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_448
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_449
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_450
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_080
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_081
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_082
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_083
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_084
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_451
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_452
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_453
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_454
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_455
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_456
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales_detail;
CREATE TABLE sales_detail ( year INT64, quarter INT64, month INT64, revenue INT64 );
INSERT INTO sales_detail VALUES
(2024, 1, 1, 1000),
(2024, 1, 2, 1200),
(2024, 2, 4, 1500);
DROP TABLE IF EXISTS products;
CREATE TABLE products (category STRING, sales INT64);
INSERT INTO products VALUES
('A', 100), ('A', 200), ('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, amount INT64);
INSERT INTO data VALUES
('East', 100),
(NULL, 50),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'X', 100),
('East', 'Y', 150),
('West', 'X', 200),
('West', 'Y', 120);
DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_457
SELECT year, quarter, month, SUM(revenue) AS total
FROM sales_detail
GROUP BY ROLLUP(year, quarter, month);
-- Tag: window_functions_window_functions_grouping_test_select_458
SELECT category, SUM(sales) AS total
FROM products
GROUP BY ROLLUP(category)
HAVING SUM(sales) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_459
SELECT region, SUM(amount) AS total
FROM data
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_460
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_461
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_462
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_463
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_464
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_465
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_085
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_086
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_087
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_088
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_089
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_466
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_467
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_468
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_469
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_470
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_471
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS products;
CREATE TABLE products (category STRING, sales INT64);
INSERT INTO products VALUES
('A', 100), ('A', 200), ('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, amount INT64);
INSERT INTO data VALUES
('East', 100),
(NULL, 50),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'X', 100),
('East', 'Y', 150),
('West', 'X', 200),
('West', 'Y', 120);
DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_472
SELECT category, SUM(sales) AS total
FROM products
GROUP BY ROLLUP(category)
HAVING SUM(sales) > 100;
-- Tag: window_functions_window_functions_grouping_test_select_473
SELECT region, SUM(amount) AS total
FROM data
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_474
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_475
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_476
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_477
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_478
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_479
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_090
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_091
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_092
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_093
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_094
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_480
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_481
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_482
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_483
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_484
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_485
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'X', 100),
('East', 'Y', 150),
('West', 'X', 200),
('West', 'Y', 120);
DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_486
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY CUBE(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_487
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_488
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_489
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_490
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_491
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_095
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_096
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_097
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_098
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_099
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_492
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_493
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_494
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_495
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_496
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_497
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim ( region STRING, category STRING, year INT64, revenue INT64 );
INSERT INTO multi_dim VALUES
('East', 'A', 2024, 1000),
('West', 'B', 2024, 2000);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_498
SELECT region, category, year, SUM(revenue) AS total
FROM multi_dim
GROUP BY CUBE(region, category, year);
-- Tag: window_functions_window_functions_grouping_test_select_499
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_500
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_501
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_502
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_100
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_101
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_102
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_103
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_104
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_503
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_504
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_505
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_506
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_507
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_508
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING, count INT64);
INSERT INTO items VALUES ('A', 10), ('B', 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_509
SELECT category, SUM(count) AS total
FROM items
GROUP BY CUBE(category);
-- Tag: window_functions_window_functions_grouping_test_select_510
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_511
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_512
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_105
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_106
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_107
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_108
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_109
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_513
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_514
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_515
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_516
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_517
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_518
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, quarter INT64, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 1, 100),
('West', 'B', 2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_519
SELECT region, product, quarter, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS (
(region, product),
(quarter),
()
);
-- Tag: window_functions_window_functions_grouping_test_select_520
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_521
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_110
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_111
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_112
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_113
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_114
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_522
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_523
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_524
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_525
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_526
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_527
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_528
SELECT SUM(value) AS total
FROM data
GROUP BY GROUPING SETS (());
-- Tag: window_functions_window_functions_grouping_test_select_529
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_115
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_116
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_117
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_118
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_119
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_530
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_531
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_532
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_533
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_534
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_535
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('East', 'B', 150),
('West', 'A', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_536
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), (product));
-- Tag: window_functions_window_functions_grouping_test_select_120
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_121
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_122
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_123
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_124
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_537
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_538
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_539
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_540
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_541
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_542
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_125
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS is_total_row
FROM sales
GROUP BY ROLLUP(region)
ORDER BY GROUPING(region), region;
-- Tag: window_functions_window_functions_grouping_test_select_126
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_127
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_128
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_129
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_543
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_544
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_545
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_546
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_547
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_548
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, amount INT64 );
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES
('East', 100),
(NULL, 50);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_130
SELECT
region,
product,
SUM(amount) AS total,
GROUPING(region) AS grp_region,
GROUPING(product) AS grp_product
FROM sales
GROUP BY ROLLUP(region, product);
-- Tag: window_functions_window_functions_grouping_test_select_131
SELECT
region,
SUM(amount) AS total,
GROUPING(region) AS grp
FROM sales
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_132
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_133
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_549
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_550
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_551
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_552
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_553
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_554
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (region STRING, customer STRING, amount INT64);
INSERT INTO orders VALUES
('East', 'Alice', 100),
('East', 'Alice', 150),
('East', 'Bob', 200),
('West', 'Alice', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_134
SELECT
region,
COUNT(DISTINCT customer) AS unique_customers,
SUM(amount) AS total
FROM orders
GROUP BY ROLLUP(region);
-- Tag: window_functions_window_functions_grouping_test_select_135
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_555
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_556
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_557
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_558
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_559
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_560
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'A', 100),
('West', 'B', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('West', 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( a STRING, b STRING, c STRING, d STRING, value INT64 );
INSERT INTO data VALUES
('a1', 'b1', 'c1', 'd1', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);

-- Tag: window_functions_window_functions_grouping_test_select_136
SELECT
region,
product,
SUM(amount) AS total,
ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY CUBE(region, product);
WITH regional_summary AS (
-- Tag: window_functions_window_functions_grouping_test_select_561
SELECT region, SUM(amount) AS total
FROM sales
GROUP BY GROUPING SETS ((region), ())
)
-- Tag: window_functions_window_functions_grouping_test_select_562
SELECT * FROM regional_summary
ORDER BY region NULLS LAST;
-- Tag: window_functions_window_functions_grouping_test_select_563
SELECT region, SUM(amount), GROUPING(product)
FROM sales
GROUP BY region;
-- Tag: window_functions_window_functions_grouping_test_select_564
SELECT SUM(value) FROM data GROUP BY GROUPING SETS ();
-- Tag: window_functions_window_functions_grouping_test_select_565
SELECT a, b, c, d, SUM(value)
FROM data
GROUP BY CUBE(a, b, c, d);
-- Tag: window_functions_window_functions_grouping_test_select_566
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product);

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_grouping_test_select_567
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_grouping_test_select_568
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_grouping_test_select_569
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_grouping_test_select_570
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_grouping_test_select_571
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_grouping_test_select_572
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_grouping_test_select_573
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_grouping_test_select_574
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_grouping_test_select_575
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_grouping_test_select_576
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_grouping_test_select_577
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_grouping_test_select_578
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_grouping_test_select_579
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_grouping_test_select_580
SELECT * FROM test;

