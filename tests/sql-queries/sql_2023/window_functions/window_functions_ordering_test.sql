-- Window Functions Ordering - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_ordering_test_select_001
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_002
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ordering_test_select_003
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ordering_test_select_001
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_002
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_003
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_004
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_004
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_005
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_006
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_007
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ordering_test_select_008
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_009
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department STRING, salary INT64);
INSERT INTO employees VALUES (1, 'Alice', 'Engineering', 80000);
INSERT INTO employees VALUES (2, 'Bob', 'Sales', 60000);
INSERT INTO employees VALUES (3, 'Charlie', 'Engineering', 90000);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS customers_us;
CREATE TABLE customers_us (name STRING);
DROP TABLE IF EXISTS customers_eu;
CREATE TABLE customers_eu (name STRING);
INSERT INTO customers_us VALUES ('Alice');
INSERT INTO customers_us VALUES ('Bob');
INSERT INTO customers_eu VALUES ('Charlie');
INSERT INTO customers_eu VALUES ('Alice');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

WITH
eng_emps AS (SELECT * FROM employees WHERE department = 'Engineering'),
high_earners AS (SELECT * FROM eng_emps WHERE salary > 75000)
-- Tag: window_functions_window_functions_ordering_test_select_010
SELECT * FROM high_earners;
-- Tag: window_functions_window_functions_ordering_test_select_011
SELECT DISTINCT customer FROM orders;
-- Tag: window_functions_window_functions_ordering_test_select_012
SELECT DISTINCT customer, product FROM orders;
-- Tag: window_functions_window_functions_ordering_test_select_013
SELECT name FROM customers_us UNION SELECT name FROM customers_eu;
-- Tag: window_functions_window_functions_ordering_test_select_014
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_ordering_test_select_015
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_ordering_test_select_016
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_ordering_test_select_017
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_ordering_test_select_018
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_019
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_020
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_ordering_test_select_021
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_ordering_test_select_022
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_ordering_test_select_023
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_ordering_test_select_024
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_ordering_test_select_025
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_ordering_test_select_026
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_ordering_test_select_027
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS customers_us;
CREATE TABLE customers_us (name STRING);
DROP TABLE IF EXISTS customers_eu;
CREATE TABLE customers_eu (name STRING);
INSERT INTO customers_us VALUES ('Alice');
INSERT INTO customers_us VALUES ('Bob');
INSERT INTO customers_eu VALUES ('Charlie');
INSERT INTO customers_eu VALUES ('Alice');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_ordering_test_select_028
SELECT DISTINCT customer, product FROM orders;
-- Tag: window_functions_window_functions_ordering_test_select_029
SELECT name FROM customers_us UNION SELECT name FROM customers_eu;
-- Tag: window_functions_window_functions_ordering_test_select_030
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_ordering_test_select_031
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_ordering_test_select_032
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_ordering_test_select_033
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_ordering_test_select_034
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_035
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_036
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_ordering_test_select_037
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_ordering_test_select_038
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_ordering_test_select_039
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_ordering_test_select_040
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_ordering_test_select_041
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_ordering_test_select_042
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_ordering_test_select_043
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_ordering_test_select_044
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_ordering_test_select_045
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_ordering_test_select_046
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_047
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_ordering_test_select_048
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_ordering_test_select_049
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_ordering_test_select_050
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_ordering_test_select_051
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, amount FLOAT64, type STRING);
INSERT INTO transactions VALUES
(1, 100.0, 'credit'), (2, 50.0, 'debit'),
(3, 200.0, 'credit'), (4, 75.0, 'debit'),
(5, 150.0, 'credit');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, status STRING, amount FLOAT64);
INSERT INTO orders VALUES
('Alice', 'completed', 100.0),
('Alice', 'cancelled', 50.0),
('Alice', 'completed', 200.0),
('Bob', 'completed', 150.0),
('Bob', 'cancelled', 200.0),
('Charlie', 'completed', 300.0);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, subject STRING, score INT64);
INSERT INTO scores VALUES
('Alice', 'Math', 90), ('Alice', 'English', 85),
('Bob', 'Math', 75), ('Bob', 'English', 95),
('Charlie', 'Math', 60), ('Charlie', 'English', 70);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b INT64, c STRING);
INSERT INTO data VALUES
(1, 10, 20, '5'),
(2, NULL, 30, '10'),
(3, 40, NULL, '15'),
(4, 50, 60, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10), ('A', 20),
(NULL, 30), (NULL, 40),
('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, int_val INT64, float_val FLOAT64, str_val STRING);
INSERT INTO data VALUES (1, 10, 2.5, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL, int_val INT64, float_val FLOAT64);
INSERT INTO data VALUES (1, true, 10, 3.5), (2, false, 20, 4.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES
(1, 'A', 100), (2, 'A', 200), (3, 'B', 150),
(4, 'B', 250), (5, 'C', 300);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (user_id INT64, amount_str STRING);
INSERT INTO transactions VALUES
(1, '100'), (1, '200'), (2, '150'), (2, '250'), (2, '100');
DROP TABLE IF EXISTS source;
CREATE TABLE source (name STRING, age_str STRING, score_str STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (name STRING, age INT64, score FLOAT64, grade STRING);
INSERT INTO source VALUES
('Alice', '25', '85.5'),
('Bob', '30', '92.0'),
('Charlie', '22', '78.5');
INSERT INTO target (name, age, score, grade)
-- Tag: window_functions_window_functions_ordering_test_select_052
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

WITH credits AS (
-- Tag: window_functions_window_functions_ordering_test_select_053
SELECT SUM(amount) as total_credits
FROM transactions
WHERE type = 'credit'
),
debits AS (
-- Tag: window_functions_window_functions_ordering_test_select_054
SELECT SUM(amount) as total_debits
FROM transactions
WHERE type = 'debit'
),
summary AS (
-- Tag: window_functions_window_functions_ordering_test_select_005
SELECT
(SELECT total_credits FROM credits) as credits,
(SELECT total_debits FROM debits) as debits
)
-- Tag: window_functions_window_functions_ordering_test_select_055
SELECT credits, debits, credits - debits as net
FROM summary;
-- Tag: window_functions_window_functions_ordering_test_select_056
SELECT customer,
SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total,
SUM(CASE WHEN status = 'cancelled' THEN amount ELSE 0 END) as cancelled_total,
COUNT(*) as order_count
FROM orders
GROUP BY customer
HAVING SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) > 100
ORDER BY completed_total DESC;
-- Tag: window_functions_window_functions_ordering_test_select_057
SELECT student,
AVG(score) as avg_score,
CASE
WHEN AVG(score) >= 85 THEN 'A'
WHEN AVG(score) >= 75 THEN 'B'
WHEN AVG(score) >= 65 THEN 'C'
ELSE 'F'
END as grade
FROM scores
GROUP BY student
ORDER BY avg_score DESC;
-- Tag: window_functions_window_functions_ordering_test_select_058
SELECT id,
a + b as sum,
a * b as product,
CAST(c AS INT64) as c_int,
COALESCE(a, 0) + COALESCE(b, 0) as coalesced_sum
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_059
SELECT category, COUNT(*) as count, SUM(value) as total
FROM data
GROUP BY category
ORDER BY category NULLS FIRST;
-- Tag: window_functions_window_functions_ordering_test_select_060
SELECT (int_val + float_val) * CAST(str_val AS FLOAT64) as complex_result
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_061
SELECT id,
CASE WHEN flag THEN int_val ELSE float_val END as mixed_result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_062
SELECT category, avg_value
FROM (
-- Tag: window_functions_window_functions_ordering_test_select_063
SELECT category, AVG(value) as avg_value
FROM (
-- Tag: window_functions_window_functions_ordering_test_select_064
SELECT category, value
FROM data
WHERE value > 100
) as filtered
GROUP BY category
) as averaged
WHERE avg_value > 150
ORDER BY avg_value DESC;
-- Tag: window_functions_window_functions_ordering_test_select_065
SELECT user_id, total_amount
FROM (
-- Tag: window_functions_window_functions_ordering_test_select_066
SELECT user_id, SUM(CAST(amount_str AS INT64)) as total_amount
FROM transactions
GROUP BY user_id
) as user_totals
WHERE total_amount > 300
ORDER BY total_amount DESC;
-- Tag: window_functions_window_functions_ordering_test_select_067
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_ordering_test_select_068
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_ordering_test_select_069
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_ordering_test_select_070
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_ordering_test_select_071
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

CREATE SEQUENCE seq_multi;
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

-- Tag: window_functions_window_functions_ordering_test_select_072
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ordering_test_select_073
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_074
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ordering_test_select_075
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ordering_test_select_076
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ordering_test_select_077
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ordering_test_select_078
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ordering_test_select_079
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ordering_test_select_080
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ordering_test_select_081
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ordering_test_select_082
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ordering_test_select_083
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ordering_test_select_084
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ordering_test_select_085
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ordering_test_select_086
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ordering_test_select_087
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ordering_test_select_088
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ordering_test_select_089
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ordering_test_select_090
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ordering_test_select_091
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ordering_test_select_092
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ordering_test_select_093
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ordering_test_select_094
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ordering_test_select_095
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ordering_test_select_096
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ordering_test_select_097
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ordering_test_select_098
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_099
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_100
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_101
SELECT id FROM items;
-- Tag: window_functions_window_functions_ordering_test_select_102
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ordering_test_select_103
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ordering_test_select_104
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_105
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_106
SELECT id FROM items;
-- Tag: window_functions_window_functions_ordering_test_select_107
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_108
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ordering_test_select_109
SELECT id FROM items;
-- Tag: window_functions_window_functions_ordering_test_select_110
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ordering_test_select_111
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_112
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_113
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_114
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_ordering_test_select_115
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ordering_test_select_116
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_117
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_118
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ordering_test_select_119
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64 PRIMARY KEY, status STRING DEFAULT 'pending', priority INT64 DEFAULT 1, archived BOOL DEFAULT false);
INSERT INTO records (id) VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64 PRIMARY KEY, name STRING, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
INSERT INTO events (id, name) VALUES (1, 'Event A');
DROP TABLE IF EXISTS daily_logs;
CREATE TABLE daily_logs (id INT64 PRIMARY KEY, message STRING, log_date DATE DEFAULT CURRENT_DATE);
INSERT INTO daily_logs (id, message) VALUES (1, 'Log entry');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE, name STRING);
INSERT INTO users VALUES (1, 'alice@example.com', 'Alice');
INSERT INTO users VALUES (2, 'bob@example.com', 'Bob');
INSERT INTO users VALUES (3, 'alice@example.com', 'Alice2');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE);
INSERT INTO users VALUES (1, NULL);
INSERT INTO users VALUES (2, NULL);
INSERT INTO users VALUES (3, NULL);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64 PRIMARY KEY, username STRING UNIQUE);
INSERT INTO accounts VALUES (1, 'alice');
INSERT INTO accounts VALUES (2, 'ALICE');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING UNIQUE);
INSERT INTO items VALUES (1, '');
INSERT INTO items VALUES (2, '');
DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations (id INT64 PRIMARY KEY, room_number INT64, date DATE, UNIQUE (room_number, date));
INSERT INTO reservations VALUES (1, 101, DATE '2024-01-15');
INSERT INTO reservations VALUES (2, 101, DATE '2024-01-16');
INSERT INTO reservations VALUES (3, 102, DATE '2024-01-15');
INSERT INTO reservations VALUES (4, 101, DATE '2024-01-15');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE, username STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com', 'alice123');
INSERT INTO users VALUES (2, 'alice@example.com', 'bob456');
INSERT INTO users VALUES (3, 'carol@example.com', 'alice123');
INSERT INTO users VALUES (4, 'dave@example.com', 'dave789');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 0);
INSERT INTO products VALUES (3, -5.00);
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (id INT64 PRIMARY KEY, score INT64 CHECK (score >= 1 AND score <= 5));
INSERT INTO ratings VALUES (1, 1);
INSERT INTO ratings VALUES (2, 3);
INSERT INTO ratings VALUES (3, 5);
INSERT INTO ratings VALUES (4, 0);
INSERT INTO ratings VALUES (5, 6);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, username STRING CHECK (LENGTH(username) >= 3));
INSERT INTO users VALUES (1, 'alice');
INSERT INTO users VALUES (2, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, NULL);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64 PRIMARY KEY, quantity INT64, discount FLOAT64, CHECK (quantity > 0 AND discount >= 0 AND discount <= 1.0));
INSERT INTO orders VALUES (1, 5, 0.1);
INSERT INTO orders VALUES (2, 0, 0.5);
INSERT INTO orders VALUES (3, 10, -0.1);
INSERT INTO orders VALUES (4, 10, 1.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING NOT NULL);
INSERT INTO users VALUES (1, 'alice@example.com');
INSERT INTO users VALUES (NULL, 'bob@example.com');
INSERT INTO users VALUES (2, NULL);
INSERT INTO users VALUES (1, 'charlie@example.com');
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL, username STRING NOT NULL);
INSERT INTO accounts VALUES (1, 'alice@example.com', 'alice');
INSERT INTO accounts VALUES (2, 'alice@example.com', 'bob');
INSERT INTO accounts VALUES (3, NULL, 'charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64 PRIMARY KEY, sku STRING UNIQUE NOT NULL, name STRING NOT NULL, price FLOAT64 DEFAULT 0.0 CHECK (price >= 0), stock INT64 DEFAULT 0 CHECK (stock >= 0) );
INSERT INTO products VALUES (1, 'SKU001', 'Widget', 9.99, 100);
INSERT INTO products (id, sku, name) VALUES (2, 'SKU002', 'Gadget');
INSERT INTO products (id, sku, name) VALUES (1, 'SKU003', 'Test');
INSERT INTO products VALUES (3, 'SKU001', 'Test', 5.0, 10);
INSERT INTO products VALUES (4, 'SKU004', 'Test', -5.0, 10);
INSERT INTO products VALUES (5, 'SKU005', NULL, 5.0, 10);
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

-- Tag: window_functions_window_functions_ordering_test_select_120
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ordering_test_select_121
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ordering_test_select_122
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ordering_test_select_123
SELECT * FROM users;
-- Tag: window_functions_window_functions_ordering_test_select_124
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ordering_test_select_125
SELECT price FROM products;
-- Tag: window_functions_window_functions_ordering_test_select_126
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ordering_test_select_127
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE, username STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com', 'alice123');
INSERT INTO users VALUES (2, 'alice@example.com', 'bob456');
INSERT INTO users VALUES (3, 'carol@example.com', 'alice123');
INSERT INTO users VALUES (4, 'dave@example.com', 'dave789');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 0);
INSERT INTO products VALUES (3, -5.00);
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (id INT64 PRIMARY KEY, score INT64 CHECK (score >= 1 AND score <= 5));
INSERT INTO ratings VALUES (1, 1);
INSERT INTO ratings VALUES (2, 3);
INSERT INTO ratings VALUES (3, 5);
INSERT INTO ratings VALUES (4, 0);
INSERT INTO ratings VALUES (5, 6);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, username STRING CHECK (LENGTH(username) >= 3));
INSERT INTO users VALUES (1, 'alice');
INSERT INTO users VALUES (2, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, NULL);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64 PRIMARY KEY, quantity INT64, discount FLOAT64, CHECK (quantity > 0 AND discount >= 0 AND discount <= 1.0));
INSERT INTO orders VALUES (1, 5, 0.1);
INSERT INTO orders VALUES (2, 0, 0.5);
INSERT INTO orders VALUES (3, 10, -0.1);
INSERT INTO orders VALUES (4, 10, 1.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING NOT NULL);
INSERT INTO users VALUES (1, 'alice@example.com');
INSERT INTO users VALUES (NULL, 'bob@example.com');
INSERT INTO users VALUES (2, NULL);
INSERT INTO users VALUES (1, 'charlie@example.com');
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL, username STRING NOT NULL);
INSERT INTO accounts VALUES (1, 'alice@example.com', 'alice');
INSERT INTO accounts VALUES (2, 'alice@example.com', 'bob');
INSERT INTO accounts VALUES (3, NULL, 'charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64 PRIMARY KEY, sku STRING UNIQUE NOT NULL, name STRING NOT NULL, price FLOAT64 DEFAULT 0.0 CHECK (price >= 0), stock INT64 DEFAULT 0 CHECK (stock >= 0) );
INSERT INTO products VALUES (1, 'SKU001', 'Widget', 9.99, 100);
INSERT INTO products (id, sku, name) VALUES (2, 'SKU002', 'Gadget');
INSERT INTO products (id, sku, name) VALUES (1, 'SKU003', 'Test');
INSERT INTO products VALUES (3, 'SKU001', 'Test', 5.0, 10);
INSERT INTO products VALUES (4, 'SKU004', 'Test', -5.0, 10);
INSERT INTO products VALUES (5, 'SKU005', NULL, 5.0, 10);
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

-- Tag: window_functions_window_functions_ordering_test_select_128
SELECT price FROM products;
-- Tag: window_functions_window_functions_ordering_test_select_129
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ordering_test_select_130
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);

-- Tag: window_functions_window_functions_ordering_test_select_131
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_132
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ordering_test_select_133
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_134
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 95), ('Dave', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180), (5, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (year INT64, quarter INT64, revenue INT64);
INSERT INTO sales VALUES (2023, 1, 100), (2023, 2, 120), (2024, 1, 150), (2024, 2, 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, revenue INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, revenue INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', NULL), ('Carol', 85), ('Dave', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);

-- Tag: window_functions_window_functions_ordering_test_select_006
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ordering_test_select_135
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ordering_test_select_007
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ordering_test_select_008
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ordering_test_select_136
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_137
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ordering_test_select_138
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_139
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ordering_test_select_140
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ordering_test_select_141
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_142
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_143
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_144
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1200), (3, 'West', 900), (4, 'West', 1100);

-- Tag: window_functions_window_functions_ordering_test_select_145
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, dept STRING, value INT64);
INSERT INTO data VALUES ('East', 'Sales', 100);
INSERT INTO data VALUES ('East', 'Sales', 200);
INSERT INTO data VALUES ('East', 'Eng', 150);
INSERT INTO data VALUES ('West', 'Sales', 120);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100.0);
INSERT INTO sales VALUES ('A', 200.0);
INSERT INTO sales VALUES ('B', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 'A', 100.0);
INSERT INTO sales VALUES ('East', 'B', 200.0);
INSERT INTO sales VALUES ('West', 'A', 150.0);

-- Tag: window_functions_window_functions_ordering_test_select_146
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_147
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_148
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_149
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_150
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ordering_test_select_151
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_152
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_153
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ordering_test_select_154
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ordering_test_select_155
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 'A', 100.0);
INSERT INTO sales VALUES ('East', 'B', 200.0);
INSERT INTO sales VALUES ('West', 'A', 150.0);

-- Tag: window_functions_window_functions_ordering_test_select_156
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_ordering_test_select_157
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ordering_test_select_158
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES \
(1, 'East', 100), (2, 'East', 150), \
(3, 'West', 120), (4, 'West', 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);

-- Tag: window_functions_window_functions_ordering_test_select_159
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ordering_test_select_160
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ordering_test_select_161
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ordering_test_select_162
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ordering_test_select_163
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_164
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_165
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_166
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ordering_test_select_167
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

