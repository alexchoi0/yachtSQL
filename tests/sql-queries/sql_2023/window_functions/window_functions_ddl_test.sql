-- Window Functions Ddl - SQL:2023
-- Description: Data Definition Language: CREATE, ALTER, DROP operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_ddl_test_select_001
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_ddl_test_select_002
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_ddl_test_select_003
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_ddl_test_select_004
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_ddl_test_select_005
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_ddl_test_select_006
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_ddl_test_select_007
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_008
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, flag BOOLEAN);
INSERT INTO test VALUES ('A', true), ('A', true), ('B', true), ('B', false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (false), (false), (false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (false), (true), (false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (true), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (false), (NULL), (false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, flag BOOLEAN);
INSERT INTO test VALUES ('A', false), ('A', false), ('B', false), ('B', true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (true), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_ddl_test_select_009
SELECT BOOL_AND(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_010
SELECT BOOL_AND(value > 5) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_011
SELECT category, BOOL_AND(flag) as result FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_012
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_013
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_014
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_015
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_016
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_017
SELECT BOOL_OR(value > 25) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_018
SELECT category, BOOL_OR(flag) as result FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_019
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_020
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_021
SELECT EVERY(value > 0) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_022
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_023
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_024
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_025
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_026
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_027
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, flag BOOLEAN);
INSERT INTO test VALUES ('A', false), ('A', false), ('B', false), ('B', true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (true), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_ddl_test_select_028
SELECT BOOL_OR(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_029
SELECT BOOL_OR(value > 25) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_030
SELECT category, BOOL_OR(flag) as result FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_031
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_032
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_033
SELECT EVERY(value > 0) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_034
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_035
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_036
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_037
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_038
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_039
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_ddl_test_select_040
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_041
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_042
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_043
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_044
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_045
SELECT EVERY() FROM test;

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

-- Tag: window_functions_window_functions_ddl_test_select_046
SELECT JSON_AGG(value) as json_array FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_047
SELECT category, JSON_AGG(value) as values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_048
SELECT JSON_AGG(flag) as json_array FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_049
SELECT JSON_AGG(d) as json_array FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_050
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_051
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_052
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_053
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_054
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_055
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_056
SELECT category, JSON_OBJECT_AGG(key, value) as obj FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_057
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_058
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_059
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, username STRING CHECK (LENGTH(username) >= 3 AND LENGTH(username) <= 20) );
INSERT INTO users VALUES (1, 'abc');
INSERT INTO users VALUES (2, 'john_doe_12345');
INSERT INTO users VALUES (3, 'ab');
INSERT INTO users VALUES (4, 'this_username_is_way_too_long');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, status STRING CHECK (status IN ('pending', 'approved', 'shipped', 'delivered')) );
INSERT INTO orders VALUES (1, 'pending');
INSERT INTO orders VALUES (2, 'shipped');
INSERT INTO orders VALUES (3, 'cancelled');
INSERT INTO orders VALUES (4, 'PENDING');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags ( id INT64, is_active BOOL CHECK (is_active = TRUE OR is_active = FALSE) );
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS rectangles;
CREATE TABLE rectangles ( id INT64, width FLOAT64, height FLOAT64, CHECK (width > 0 AND height > 0 AND width * height <= 1000) );
INSERT INTO rectangles VALUES (1, 10.0, 20.0);
INSERT INTO rectangles VALUES (2, 50.0, 50.0);
INSERT INTO rectangles VALUES (3, -5.0, 10.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( id INT64, start_date INT64, end_date INT64, CHECK (end_date >= start_date) );
INSERT INTO events VALUES (1, 20250101, 20250110);
INSERT INTO events VALUES (2, 20250101, 20250101);
INSERT INTO events VALUES (3, 20250110, 20250101);
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts ( id INT64, type STRING, amount FLOAT64, CHECK ( CASE WHEN type = 'percent' THEN amount >= 0 AND amount <= 100 WHEN type = 'fixed' THEN amount >= 0 ELSE FALSE END ) );
INSERT INTO discounts VALUES (1, 'percent', 15.0);
INSERT INTO discounts VALUES (2, 'fixed', 5.0);
INSERT INTO discounts VALUES (3, 'percent', 150.0);
INSERT INTO discounts VALUES (4, 'other', 10.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO items VALUES (1, NULL);
DROP TABLE IF EXISTS ranges;
CREATE TABLE ranges ( id INT64, min_val INT64, max_val INT64, CHECK (max_val > min_val) );
INSERT INTO ranges VALUES (1, NULL, 100);
INSERT INTO ranges VALUES (2, 50, NULL);
INSERT INTO ranges VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 NOT NULL CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, NULL);
INSERT INTO products VALUES (3, 0.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers ( id INT64, value INT64 CHECK (value >= -1000000 AND value <= 1000000) );
INSERT INTO numbers VALUES (1, -1000000);
INSERT INTO numbers VALUES (2, 1000000);
INSERT INTO numbers VALUES (3, -1000001);
INSERT INTO numbers VALUES (4, 1000001);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( id INT64, content STRING CHECK (LENGTH(content) > 0) );
INSERT INTO messages VALUES (1, 'Hello');
INSERT INTO messages VALUES (2, '');
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements ( id INT64, value FLOAT64 CHECK (value >= 0.0 AND value <= 100.0) );
INSERT INTO measurements VALUES (1, 0.0000001);
INSERT INTO measurements VALUES (2, 99.9999999);
DROP TABLE IF EXISTS circles;
CREATE TABLE circles ( id INT64, radius FLOAT64, CHECK (radius * radius * 3.14159 <= 1000) );
INSERT INTO circles VALUES (1, 5.0);
INSERT INTO circles VALUES (2, 20.0);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails ( id INT64, email STRING CHECK (email LIKE '_%@_%._%') );
INSERT INTO emails VALUES (1, 'user@example.com');
INSERT INTO emails VALUES (2, 'notanemail');
INSERT INTO emails VALUES (3, '@example.com');
DROP TABLE IF EXISTS access;
CREATE TABLE access ( id INT64, role STRING, level INT64, CHECK ((role = 'admin' AND level >= 5) OR (role = 'user' AND level >= 1 AND level <= 3)) );
INSERT INTO access VALUES (1, 'admin', 5);
INSERT INTO access VALUES (2, 'admin', 10);
INSERT INTO access VALUES (3, 'user', 1);
INSERT INTO access VALUES (4, 'user', 3);
INSERT INTO access VALUES (5, 'admin', 2);
INSERT INTO access VALUES (6, 'user', 5);
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (invalid syntax here) );
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (nonexistent_column > 0) );
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
DROP TABLE IF EXISTS source;
CREATE TABLE source ( id INT64, value INT64 );
DROP TABLE IF EXISTS dest;
CREATE TABLE dest ( id INT64, value INT64 CHECK (value > 0) );
INSERT INTO source VALUES (1, 10), (2, -5), (3, 20);
INSERT INTO dest SELECT * FROM source;
INSERT INTO dest SELECT * FROM source WHERE value > 0;
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, quantity INT64 CHECK (quantity > 0) );
INSERT INTO items VALUES (1, 5), (2, 10), (3, 1);
INSERT INTO items VALUES (4, 5), (5, -1), (6, 10);
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( id INT64, stock INT64 CHECK (stock >= 0) );
INSERT INTO inventory VALUES (1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, age INT64, username STRING, CONSTRAINT valid_age CHECK (age >= 18 AND age <= 120), CONSTRAINT valid_username CHECK (LENGTH(username) >= 3) );
INSERT INTO users VALUES (1, 25, 'john');
INSERT INTO users VALUES (2, 15, 'jane');
INSERT INTO users VALUES (3, 25, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
INSERT INTO products VALUES (1, 10.0), (2, -5.0);
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
ALTER TABLE products DROP CONSTRAINT positive_price;
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, quantity INT64, unit_price FLOAT64, discount_percent FLOAT64, CHECK (quantity > 0), CHECK (unit_price > 0), CHECK (discount_percent >= 0 AND discount_percent <= 100), CHECK (quantity * unit_price * (1 - discount_percent / 100) >= 0) );
INSERT INTO orders VALUES (1, 5, 10.0, 10.0);
INSERT INTO orders VALUES (2, -1, 10.0, 10.0);
INSERT INTO orders VALUES (3, 5, 10.0, 150.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, transaction_type STRING, amount FLOAT64, CHECK (transaction_type IN ('credit', 'debit')), CHECK ( (transaction_type = 'credit' AND amount > 0) OR (transaction_type = 'debit' AND amount < 0) ) );
INSERT INTO transactions VALUES (1, 'credit', 100.0);
INSERT INTO transactions VALUES (2, 'debit', -50.0);
INSERT INTO transactions VALUES (3, 'credit', -100.0);
INSERT INTO transactions VALUES (4, 'debit', 50.0);

-- Tag: window_functions_window_functions_ddl_test_select_060
SELECT * FROM items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_061
SELECT COUNT(*) FROM dest;
UPDATE inventory SET stock = 50 WHERE id = 1;
UPDATE inventory SET stock = -10 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_062
SELECT stock FROM inventory WHERE id = 1;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, status STRING CHECK (status IN ('pending', 'approved', 'shipped', 'delivered')) );
INSERT INTO orders VALUES (1, 'pending');
INSERT INTO orders VALUES (2, 'shipped');
INSERT INTO orders VALUES (3, 'cancelled');
INSERT INTO orders VALUES (4, 'PENDING');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags ( id INT64, is_active BOOL CHECK (is_active = TRUE OR is_active = FALSE) );
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS rectangles;
CREATE TABLE rectangles ( id INT64, width FLOAT64, height FLOAT64, CHECK (width > 0 AND height > 0 AND width * height <= 1000) );
INSERT INTO rectangles VALUES (1, 10.0, 20.0);
INSERT INTO rectangles VALUES (2, 50.0, 50.0);
INSERT INTO rectangles VALUES (3, -5.0, 10.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( id INT64, start_date INT64, end_date INT64, CHECK (end_date >= start_date) );
INSERT INTO events VALUES (1, 20250101, 20250110);
INSERT INTO events VALUES (2, 20250101, 20250101);
INSERT INTO events VALUES (3, 20250110, 20250101);
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts ( id INT64, type STRING, amount FLOAT64, CHECK ( CASE WHEN type = 'percent' THEN amount >= 0 AND amount <= 100 WHEN type = 'fixed' THEN amount >= 0 ELSE FALSE END ) );
INSERT INTO discounts VALUES (1, 'percent', 15.0);
INSERT INTO discounts VALUES (2, 'fixed', 5.0);
INSERT INTO discounts VALUES (3, 'percent', 150.0);
INSERT INTO discounts VALUES (4, 'other', 10.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO items VALUES (1, NULL);
DROP TABLE IF EXISTS ranges;
CREATE TABLE ranges ( id INT64, min_val INT64, max_val INT64, CHECK (max_val > min_val) );
INSERT INTO ranges VALUES (1, NULL, 100);
INSERT INTO ranges VALUES (2, 50, NULL);
INSERT INTO ranges VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 NOT NULL CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, NULL);
INSERT INTO products VALUES (3, 0.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers ( id INT64, value INT64 CHECK (value >= -1000000 AND value <= 1000000) );
INSERT INTO numbers VALUES (1, -1000000);
INSERT INTO numbers VALUES (2, 1000000);
INSERT INTO numbers VALUES (3, -1000001);
INSERT INTO numbers VALUES (4, 1000001);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( id INT64, content STRING CHECK (LENGTH(content) > 0) );
INSERT INTO messages VALUES (1, 'Hello');
INSERT INTO messages VALUES (2, '');
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements ( id INT64, value FLOAT64 CHECK (value >= 0.0 AND value <= 100.0) );
INSERT INTO measurements VALUES (1, 0.0000001);
INSERT INTO measurements VALUES (2, 99.9999999);
DROP TABLE IF EXISTS circles;
CREATE TABLE circles ( id INT64, radius FLOAT64, CHECK (radius * radius * 3.14159 <= 1000) );
INSERT INTO circles VALUES (1, 5.0);
INSERT INTO circles VALUES (2, 20.0);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails ( id INT64, email STRING CHECK (email LIKE '_%@_%._%') );
INSERT INTO emails VALUES (1, 'user@example.com');
INSERT INTO emails VALUES (2, 'notanemail');
INSERT INTO emails VALUES (3, '@example.com');
DROP TABLE IF EXISTS access;
CREATE TABLE access ( id INT64, role STRING, level INT64, CHECK ((role = 'admin' AND level >= 5) OR (role = 'user' AND level >= 1 AND level <= 3)) );
INSERT INTO access VALUES (1, 'admin', 5);
INSERT INTO access VALUES (2, 'admin', 10);
INSERT INTO access VALUES (3, 'user', 1);
INSERT INTO access VALUES (4, 'user', 3);
INSERT INTO access VALUES (5, 'admin', 2);
INSERT INTO access VALUES (6, 'user', 5);
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (invalid syntax here) );
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (nonexistent_column > 0) );
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
DROP TABLE IF EXISTS source;
CREATE TABLE source ( id INT64, value INT64 );
DROP TABLE IF EXISTS dest;
CREATE TABLE dest ( id INT64, value INT64 CHECK (value > 0) );
INSERT INTO source VALUES (1, 10), (2, -5), (3, 20);
INSERT INTO dest SELECT * FROM source;
INSERT INTO dest SELECT * FROM source WHERE value > 0;
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, quantity INT64 CHECK (quantity > 0) );
INSERT INTO items VALUES (1, 5), (2, 10), (3, 1);
INSERT INTO items VALUES (4, 5), (5, -1), (6, 10);
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( id INT64, stock INT64 CHECK (stock >= 0) );
INSERT INTO inventory VALUES (1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, age INT64, username STRING, CONSTRAINT valid_age CHECK (age >= 18 AND age <= 120), CONSTRAINT valid_username CHECK (LENGTH(username) >= 3) );
INSERT INTO users VALUES (1, 25, 'john');
INSERT INTO users VALUES (2, 15, 'jane');
INSERT INTO users VALUES (3, 25, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
INSERT INTO products VALUES (1, 10.0), (2, -5.0);
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
ALTER TABLE products DROP CONSTRAINT positive_price;
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, quantity INT64, unit_price FLOAT64, discount_percent FLOAT64, CHECK (quantity > 0), CHECK (unit_price > 0), CHECK (discount_percent >= 0 AND discount_percent <= 100), CHECK (quantity * unit_price * (1 - discount_percent / 100) >= 0) );
INSERT INTO orders VALUES (1, 5, 10.0, 10.0);
INSERT INTO orders VALUES (2, -1, 10.0, 10.0);
INSERT INTO orders VALUES (3, 5, 10.0, 150.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, transaction_type STRING, amount FLOAT64, CHECK (transaction_type IN ('credit', 'debit')), CHECK ( (transaction_type = 'credit' AND amount > 0) OR (transaction_type = 'debit' AND amount < 0) ) );
INSERT INTO transactions VALUES (1, 'credit', 100.0);
INSERT INTO transactions VALUES (2, 'debit', -50.0);
INSERT INTO transactions VALUES (3, 'credit', -100.0);
INSERT INTO transactions VALUES (4, 'debit', 50.0);

-- Tag: window_functions_window_functions_ddl_test_select_063
SELECT * FROM items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_064
SELECT COUNT(*) FROM dest;
UPDATE inventory SET stock = 50 WHERE id = 1;
UPDATE inventory SET stock = -10 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_065
SELECT stock FROM inventory WHERE id = 1;

DROP TABLE IF EXISTS flags;
CREATE TABLE flags ( id INT64, is_active BOOL CHECK (is_active = TRUE OR is_active = FALSE) );
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS rectangles;
CREATE TABLE rectangles ( id INT64, width FLOAT64, height FLOAT64, CHECK (width > 0 AND height > 0 AND width * height <= 1000) );
INSERT INTO rectangles VALUES (1, 10.0, 20.0);
INSERT INTO rectangles VALUES (2, 50.0, 50.0);
INSERT INTO rectangles VALUES (3, -5.0, 10.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( id INT64, start_date INT64, end_date INT64, CHECK (end_date >= start_date) );
INSERT INTO events VALUES (1, 20250101, 20250110);
INSERT INTO events VALUES (2, 20250101, 20250101);
INSERT INTO events VALUES (3, 20250110, 20250101);
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts ( id INT64, type STRING, amount FLOAT64, CHECK ( CASE WHEN type = 'percent' THEN amount >= 0 AND amount <= 100 WHEN type = 'fixed' THEN amount >= 0 ELSE FALSE END ) );
INSERT INTO discounts VALUES (1, 'percent', 15.0);
INSERT INTO discounts VALUES (2, 'fixed', 5.0);
INSERT INTO discounts VALUES (3, 'percent', 150.0);
INSERT INTO discounts VALUES (4, 'other', 10.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO items VALUES (1, NULL);
DROP TABLE IF EXISTS ranges;
CREATE TABLE ranges ( id INT64, min_val INT64, max_val INT64, CHECK (max_val > min_val) );
INSERT INTO ranges VALUES (1, NULL, 100);
INSERT INTO ranges VALUES (2, 50, NULL);
INSERT INTO ranges VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 NOT NULL CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, NULL);
INSERT INTO products VALUES (3, 0.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers ( id INT64, value INT64 CHECK (value >= -1000000 AND value <= 1000000) );
INSERT INTO numbers VALUES (1, -1000000);
INSERT INTO numbers VALUES (2, 1000000);
INSERT INTO numbers VALUES (3, -1000001);
INSERT INTO numbers VALUES (4, 1000001);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( id INT64, content STRING CHECK (LENGTH(content) > 0) );
INSERT INTO messages VALUES (1, 'Hello');
INSERT INTO messages VALUES (2, '');
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements ( id INT64, value FLOAT64 CHECK (value >= 0.0 AND value <= 100.0) );
INSERT INTO measurements VALUES (1, 0.0000001);
INSERT INTO measurements VALUES (2, 99.9999999);
DROP TABLE IF EXISTS circles;
CREATE TABLE circles ( id INT64, radius FLOAT64, CHECK (radius * radius * 3.14159 <= 1000) );
INSERT INTO circles VALUES (1, 5.0);
INSERT INTO circles VALUES (2, 20.0);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails ( id INT64, email STRING CHECK (email LIKE '_%@_%._%') );
INSERT INTO emails VALUES (1, 'user@example.com');
INSERT INTO emails VALUES (2, 'notanemail');
INSERT INTO emails VALUES (3, '@example.com');
DROP TABLE IF EXISTS access;
CREATE TABLE access ( id INT64, role STRING, level INT64, CHECK ((role = 'admin' AND level >= 5) OR (role = 'user' AND level >= 1 AND level <= 3)) );
INSERT INTO access VALUES (1, 'admin', 5);
INSERT INTO access VALUES (2, 'admin', 10);
INSERT INTO access VALUES (3, 'user', 1);
INSERT INTO access VALUES (4, 'user', 3);
INSERT INTO access VALUES (5, 'admin', 2);
INSERT INTO access VALUES (6, 'user', 5);
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (invalid syntax here) );
DROP TABLE IF EXISTS bad;
CREATE TABLE bad ( id INT64, value INT64 CHECK (nonexistent_column > 0) );
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
DROP TABLE IF EXISTS source;
CREATE TABLE source ( id INT64, value INT64 );
DROP TABLE IF EXISTS dest;
CREATE TABLE dest ( id INT64, value INT64 CHECK (value > 0) );
INSERT INTO source VALUES (1, 10), (2, -5), (3, 20);
INSERT INTO dest SELECT * FROM source;
INSERT INTO dest SELECT * FROM source WHERE value > 0;
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, quantity INT64 CHECK (quantity > 0) );
INSERT INTO items VALUES (1, 5), (2, 10), (3, 1);
INSERT INTO items VALUES (4, 5), (5, -1), (6, 10);
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( id INT64, stock INT64 CHECK (stock >= 0) );
INSERT INTO inventory VALUES (1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, age INT64, username STRING, CONSTRAINT valid_age CHECK (age >= 18 AND age <= 120), CONSTRAINT valid_username CHECK (LENGTH(username) >= 3) );
INSERT INTO users VALUES (1, 25, 'john');
INSERT INTO users VALUES (2, 15, 'jane');
INSERT INTO users VALUES (3, 25, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
INSERT INTO products VALUES (1, 10.0), (2, -5.0);
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 );
ALTER TABLE products ADD CONSTRAINT positive_price CHECK (price > 0);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64, CONSTRAINT positive_price CHECK (price > 0) );
INSERT INTO products VALUES (1, -5.0);
ALTER TABLE products DROP CONSTRAINT positive_price;
INSERT INTO products VALUES (2, -5.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, quantity INT64, unit_price FLOAT64, discount_percent FLOAT64, CHECK (quantity > 0), CHECK (unit_price > 0), CHECK (discount_percent >= 0 AND discount_percent <= 100), CHECK (quantity * unit_price * (1 - discount_percent / 100) >= 0) );
INSERT INTO orders VALUES (1, 5, 10.0, 10.0);
INSERT INTO orders VALUES (2, -1, 10.0, 10.0);
INSERT INTO orders VALUES (3, 5, 10.0, 150.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, transaction_type STRING, amount FLOAT64, CHECK (transaction_type IN ('credit', 'debit')), CHECK ( (transaction_type = 'credit' AND amount > 0) OR (transaction_type = 'debit' AND amount < 0) ) );
INSERT INTO transactions VALUES (1, 'credit', 100.0);
INSERT INTO transactions VALUES (2, 'debit', -50.0);
INSERT INTO transactions VALUES (3, 'credit', -100.0);
INSERT INTO transactions VALUES (4, 'debit', 50.0);

-- Tag: window_functions_window_functions_ddl_test_select_066
SELECT * FROM items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_067
SELECT COUNT(*) FROM dest;
UPDATE inventory SET stock = 50 WHERE id = 1;
UPDATE inventory SET stock = -10 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_068
SELECT stock FROM inventory WHERE id = 1;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
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

-- Tag: window_functions_window_functions_ddl_test_select_069
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_070
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_ddl_test_select_071
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_072
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_ddl_test_select_073
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_074
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_075
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_ddl_test_select_076
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_077
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_ddl_test_select_078
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_ddl_test_select_079
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_ddl_test_select_080
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_081
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_082
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_ddl_test_select_083
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_ddl_test_select_084
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

-- Tag: window_functions_window_functions_ddl_test_select_085
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_ddl_test_select_086
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_ddl_test_select_087
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_088
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_ddl_test_select_089
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

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

-- Tag: window_functions_window_functions_ddl_test_select_090
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_ddl_test_select_091
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_092
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_ddl_test_select_093
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

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

-- Tag: window_functions_window_functions_ddl_test_select_094
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_ddl_test_select_095
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_096
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_ddl_test_select_097
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
ALTER TABLE data ADD COLUMN new_col STRING DEFAULT 'test';
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice', 30);
ALTER TABLE users DROP COLUMN age;
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
ALTER TABLE evolving ADD COLUMN col1 STRING;
ALTER TABLE evolving ADD COLUMN col2 INT64 DEFAULT 42;
ALTER TABLE evolving DROP COLUMN col1;
ALTER TABLE evolving RENAME COLUMN col2 TO renamed_col;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (id INT64, value STRING);
INSERT INTO temp VALUES (1, 'first');
DROP TABLE temp;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (x FLOAT64, y FLOAT64);
INSERT INTO temp VALUES (1.5, 2.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_098
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_099
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_100
SELECT age FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_101
SELECT * FROM evolving;
-- Tag: window_functions_window_functions_ddl_test_select_102
SELECT * FROM temp;
-- Tag: window_functions_window_functions_ddl_test_select_103
SELECT COUNT(*) FROM users;
UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_104
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_105
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_106
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_107
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_108
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_109
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_110
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_111
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_112
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_113
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_114
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_115
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_116
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_117
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_118
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_119
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_120
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_121
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_122
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_123
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_124
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_125
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_126
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_127
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice', 30);
ALTER TABLE users DROP COLUMN age;
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
ALTER TABLE evolving ADD COLUMN col1 STRING;
ALTER TABLE evolving ADD COLUMN col2 INT64 DEFAULT 42;
ALTER TABLE evolving DROP COLUMN col1;
ALTER TABLE evolving RENAME COLUMN col2 TO renamed_col;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (id INT64, value STRING);
INSERT INTO temp VALUES (1, 'first');
DROP TABLE temp;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (x FLOAT64, y FLOAT64);
INSERT INTO temp VALUES (1.5, 2.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_128
SELECT age FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_129
SELECT * FROM evolving;
-- Tag: window_functions_window_functions_ddl_test_select_130
SELECT * FROM temp;
-- Tag: window_functions_window_functions_ddl_test_select_131
SELECT COUNT(*) FROM users;
UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_132
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_133
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_134
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_135
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_136
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_137
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_138
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_139
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_140
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_141
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_142
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_143
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_144
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_145
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_146
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_147
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_148
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_149
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_150
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_151
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_152
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_153
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_154
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_155
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
ALTER TABLE evolving ADD COLUMN col1 STRING;
ALTER TABLE evolving ADD COLUMN col2 INT64 DEFAULT 42;
ALTER TABLE evolving DROP COLUMN col1;
ALTER TABLE evolving RENAME COLUMN col2 TO renamed_col;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (id INT64, value STRING);
INSERT INTO temp VALUES (1, 'first');
DROP TABLE temp;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (x FLOAT64, y FLOAT64);
INSERT INTO temp VALUES (1.5, 2.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_156
SELECT * FROM evolving;
-- Tag: window_functions_window_functions_ddl_test_select_157
SELECT * FROM temp;
-- Tag: window_functions_window_functions_ddl_test_select_158
SELECT COUNT(*) FROM users;
UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_159
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_160
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_161
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_162
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_163
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_164
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_165
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_166
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_167
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_168
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_169
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_170
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_171
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_172
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_173
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_174
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_175
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_176
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_177
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_178
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_179
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_180
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_181
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_182
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS temp;
CREATE TABLE temp (id INT64, value STRING);
INSERT INTO temp VALUES (1, 'first');
DROP TABLE temp;
DROP TABLE IF EXISTS temp;
CREATE TABLE temp (x FLOAT64, y FLOAT64);
INSERT INTO temp VALUES (1.5, 2.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_183
SELECT * FROM temp;
-- Tag: window_functions_window_functions_ddl_test_select_184
SELECT COUNT(*) FROM users;
UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_185
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_186
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_187
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_188
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_189
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_190
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_191
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_192
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_193
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_194
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_195
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_196
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_197
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_198
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_199
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_200
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_201
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_202
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_203
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_204
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_205
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_206
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_207
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_208
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_209
SELECT COUNT(*) FROM users;
UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_210
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_211
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_212
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_213
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_214
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_215
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_216
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_217
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_218
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_219
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_220
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_221
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_222
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_223
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_224
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_225
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_226
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_227
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_228
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_229
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_230
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_231
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_232
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_233
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

UPDATE data SET value = nonexistent_column WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_234
SELECT value FROM data WHERE id = 1;
DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_235
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_236
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_237
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_238
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_239
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_240
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_241
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_242
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_243
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_244
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_245
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_246
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_247
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_248
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_249
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_250
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_251
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_252
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_253
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_254
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_255
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_256
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_257
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

DELETE FROM data WHERE nonexistent_column > 150;
-- Tag: window_functions_window_functions_ddl_test_select_258
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_259
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_260
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_261
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_262
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_263
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_264
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_265
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_266
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_267
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_268
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_269
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_270
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_271
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_272
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_273
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_274
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_275
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_276
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_277
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_278
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_279
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_280
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS bad_table;
CREATE TABLE bad_table (id INT64, value INVALID_TYPE);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_281
SELECT * FROM bad_table;
-- Tag: window_functions_window_functions_ddl_test_select_282
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_283
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_284
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_285
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_286
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_287
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_288
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_289
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_290
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_291
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_292
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_293
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_294
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_295
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_296
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_297
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_298
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_299
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_300
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_301
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_302
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN bad_col INVALID_TYPE;
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

-- Tag: window_functions_window_functions_ddl_test_select_303
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_304
SELECT COUNT(*) FROM logs;
UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_ddl_test_select_305
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_ddl_test_select_306
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_307
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_308
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_309
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_310
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_311
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_312
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_313
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_314
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_315
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_316
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_317
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_318
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_319
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_320
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_321
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_322
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_323
SELECT * FROM recovery_test;

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

-- Tag: window_functions_window_functions_ddl_test_select_324
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_ddl_test_select_325
SELECT * FROM large;
-- Tag: window_functions_window_functions_ddl_test_select_326
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_327
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_ddl_test_select_328
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_329
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_330
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_ddl_test_select_331
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_332
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_ddl_test_select_333
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
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

-- Tag: window_functions_window_functions_ddl_test_select_334
SELECT * FROM nonexistent_table;
-- Tag: window_functions_window_functions_ddl_test_select_335
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_336
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_337
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_ddl_test_select_338
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_ddl_test_select_339
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_340
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_341
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_ddl_test_select_342
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_ddl_test_select_343
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_344
SELECT *;
-- Tag: window_functions_window_functions_ddl_test_select_345
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_ddl_test_select_346
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_ddl_test_select_347
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_ddl_test_select_348
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_ddl_test_select_349
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_350
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_351
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_ddl_test_select_352
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
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

-- Tag: window_functions_window_functions_ddl_test_select_353
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_354
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_ddl_test_select_355
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_ddl_test_select_356
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_357
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_358
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_ddl_test_select_359
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_ddl_test_select_360
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_361
SELECT *;
-- Tag: window_functions_window_functions_ddl_test_select_362
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_ddl_test_select_363
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_ddl_test_select_364
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_ddl_test_select_365
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_ddl_test_select_366
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_367
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_368
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_ddl_test_select_369
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_ddl_test_select_370
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_ddl_test_select_371
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_372
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_373
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_ddl_test_select_374
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (10, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (10, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING);
INSERT INTO data VALUES ('10', '20');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING);
INSERT INTO data VALUES ('Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_ddl_test_select_375
SELECT * FROM nonexistent_table;
-- Tag: window_functions_window_functions_ddl_test_select_376
SELECT id, age FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_377
SELECT id FROM a JOIN b ON a.id = b.id;
-- Tag: window_functions_window_functions_ddl_test_select_378
SELECT category, value, COUNT(*) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_379
SELECT value FROM data HAVING value > 10;
-- Tag: window_functions_window_functions_ddl_test_select_380
SELECT a / b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_381
SELECT a % b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_382
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_383
SELECT a * b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_384
SELECT a - b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_385
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_386
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_ddl_test_select_387
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_388
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_389
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_390
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_391
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_392
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_ddl_test_select_393
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_394
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_395
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_396
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_ddl_test_select_397
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_ddl_test_select_398
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_399
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_400
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_401
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_402
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_403
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_404
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_ddl_test_select_405
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_406
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_407
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_408
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_ddl_test_select_409
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_410
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_411
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_412
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_ddl_test_select_413
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_ddl_test_select_414
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_415
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_416
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_417
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_418
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_419
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_420
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_ddl_test_select_421
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_422
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_423
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_424
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_ddl_test_select_425
SELECT * FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_426
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_427
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_428
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_ddl_test_select_429
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_ddl_test_select_430
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_431
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_432
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_433
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_434
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_435
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_436
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_ddl_test_select_437
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_438
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_ddl_test_select_439
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_ddl_test_select_440
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_441
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_442
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_443
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_444
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_445
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_446
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_ddl_test_select_447
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_ddl_test_select_448
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_ddl_test_select_449
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_450
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_451
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_452
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_453
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_454
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_455
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_ddl_test_select_456
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_457
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_458
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_459
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_460
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_461
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_462
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_ddl_test_select_463
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_464
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_465
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_466
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_467
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_468
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_469
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_ddl_test_select_470
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_471
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_472
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_473
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_474
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_475
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_476
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_ddl_test_select_477
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_478
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_ddl_test_select_479
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_480
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_481
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_ddl_test_select_482
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_ddl_test_select_483
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64, value STRING);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64, value STRING);
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

-- Tag: window_functions_window_functions_ddl_test_select_484
SELECT * FROM nonexistent_table;
-- Tag: window_functions_window_functions_ddl_test_select_485
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_486
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_ddl_test_select_487
SELECT * FROM data WHERE int_val = str_val;
-- Tag: window_functions_window_functions_ddl_test_select_488
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_ddl_test_select_489
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_490
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_491
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_492
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_493
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_494
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_ddl_test_select_495
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_ddl_test_select_496
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_ddl_test_select_497
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_498
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_ddl_test_select_499
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_ddl_test_select_500
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_ddl_test_select_501
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_ddl_test_select_502
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_001
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_503
SELECT userid FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_504
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_ddl_test_select_505
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_ddl_test_select_506
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_ddl_test_select_507
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_ddl_test_select_508
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_ddl_test_select_002
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_509
SELECT userid FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_510
SELECT * FROM user;

DROP TABLE IF EXISTS t;
CREATE TABLE t (col1 INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val STRING);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val STRING);
INSERT INTO t1 VALUES (1, 'a');
INSERT INTO t2 VALUES (1, 'b');
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
INSERT INTO t VALUES (10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val FLOAT64);
INSERT INTO t VALUES (-1.0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE nonexistent;
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

-- Tag: window_functions_window_functions_ddl_test_select_511
SELECT * FROM nonexistent_table;
-- Tag: window_functions_window_functions_ddl_test_select_512
SELECT nonexistent_column FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_513
SELECT id FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_514
SELECT NONEXISTENT_FUNCTION(val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_515
SELECT ABS(val, val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_516
SELECT val / 0 FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_517
SELECT SQRT(val) FROM t;
UPDATE nonexistent SET col = 1;
-- Tag: window_functions_window_functions_ddl_test_select_518
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_519
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_ddl_test_select_520
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_ddl_test_select_521
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_522
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_ddl_test_select_523
SELECT * FROM cte;
-- Tag: window_functions_window_functions_ddl_test_select_524
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_ddl_test_select_525
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_526
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_527
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_ddl_test_select_528
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE nonexistent;
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
-- Tag: window_functions_window_functions_ddl_test_select_529
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_530
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_ddl_test_select_531
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_ddl_test_select_532
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_533
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_ddl_test_select_534
SELECT * FROM cte;
-- Tag: window_functions_window_functions_ddl_test_select_535
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_ddl_test_select_536
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_537
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_538
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_ddl_test_select_539
SELECT * FROM t LIMIT -1;

DROP TABLE nonexistent;
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
-- Tag: window_functions_window_functions_ddl_test_select_540
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_541
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_ddl_test_select_542
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_ddl_test_select_543
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_544
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_ddl_test_select_545
SELECT * FROM cte;
-- Tag: window_functions_window_functions_ddl_test_select_546
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_ddl_test_select_547
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_548
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_549
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_ddl_test_select_550
SELECT * FROM t LIMIT -1;

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
-- Tag: window_functions_window_functions_ddl_test_select_551
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_552
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_ddl_test_select_553
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_ddl_test_select_554
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_ddl_test_select_555
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_ddl_test_select_556
SELECT * FROM cte;
-- Tag: window_functions_window_functions_ddl_test_select_557
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_ddl_test_select_558
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_559
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_ddl_test_select_560
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_ddl_test_select_561
SELECT * FROM t LIMIT -1;

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

-- Tag: window_functions_window_functions_ddl_test_select_562
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_ddl_test_select_563
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_ddl_test_select_564
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_ddl_test_select_565
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_ddl_test_select_566
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_567
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_568
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

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
-- Tag: window_functions_window_functions_ddl_test_select_569
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

-- Tag: window_functions_window_functions_ddl_test_select_570
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_571
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_572
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_573
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_574
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_575
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_ddl_test_select_576
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_577
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_578
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_ddl_test_select_579
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_ddl_test_select_580
SELECT id FROM data WHERE name = 'Alice';

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
-- Tag: window_functions_window_functions_ddl_test_select_581
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

-- Tag: window_functions_window_functions_ddl_test_select_582
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_583
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_584
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_585
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_586
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_587
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_ddl_test_select_588
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_589
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_590
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_ddl_test_select_591
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_ddl_test_select_592
SELECT id FROM data WHERE name = 'Alice';

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
-- Tag: window_functions_window_functions_ddl_test_select_593
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

-- Tag: window_functions_window_functions_ddl_test_select_594
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_595
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_596
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_597
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_598
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_599
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_ddl_test_select_600
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_601
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_602
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_ddl_test_select_603
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_ddl_test_select_604
SELECT id FROM data WHERE name = 'Alice';

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
-- Tag: window_functions_window_functions_ddl_test_select_605
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

-- Tag: window_functions_window_functions_ddl_test_select_606
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_607
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_ddl_test_select_608
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_609
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_610
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_611
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_ddl_test_select_612
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_613
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_614
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_ddl_test_select_615
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_ddl_test_select_616
SELECT id FROM data WHERE name = 'Alice';

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
-- Tag: window_functions_window_functions_ddl_test_select_617
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

-- Tag: window_functions_window_functions_ddl_test_select_618
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_619
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_ddl_test_select_620
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_ddl_test_select_621
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
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

-- Tag: window_functions_window_functions_ddl_test_select_622
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_623
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_624
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_625
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_626
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_627
SELECT JSON_ARRAYAGG(flag) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_628
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_629
SELECT JSON_ARRAYAGG(text) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_630
SELECT JSON_ARRAYAGG(d) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_631
SELECT region, JSON_ARRAYAGG(amount) as amounts FROM sales GROUP BY region ORDER BY region;
-- Tag: window_functions_window_functions_ddl_test_select_632
SELECT category, JSON_ARRAYAGG(value) as arr FROM test GROUP BY category HAVING SUM(value) > 10 ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_633
SELECT JSON_ARRAYAGG(id) as ids, JSON_ARRAYAGG(name) as names, JSON_ARRAYAGG(score) as scores FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_634
SELECT JSON_ARRAYAGG() FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_635
SELECT JSON_ARRAYAGG(a, b) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_636
SELECT * FROM test WHERE JSON_ARRAYAGG(value) IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_637
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_638
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_639
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_640
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_641
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_642
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_643
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_644
SELECT JSON_OBJECTAGG(k, v) as obj FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_645
SELECT JSON_OBJECTAGG(k, v_int) as obj1, JSON_OBJECTAGG(k, v_str) as obj2, JSON_OBJECTAGG(k, v_bool) as obj3 FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_646
SELECT env, JSON_OBJECTAGG(key, value) as config FROM config GROUP BY env ORDER BY env;
-- Tag: window_functions_window_functions_ddl_test_select_647
SELECT category, JSON_OBJECTAGG(key, value) as obj FROM data GROUP BY category HAVING SUM(value) > 10;
-- Tag: window_functions_window_functions_ddl_test_select_648
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_649
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_650
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: window_functions_window_functions_ddl_test_select_651
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_652
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: window_functions_window_functions_ddl_test_select_653
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: window_functions_window_functions_ddl_test_select_654
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL, expected STRING);
INSERT INTO logic VALUES
(1, TRUE, TRUE, 'TRUE'),
(2, TRUE, FALSE, 'FALSE'),
(3, TRUE, NULL, 'NULL'),
(4, FALSE, TRUE, 'FALSE'),
(5, FALSE, FALSE, 'FALSE'),
(6, FALSE, NULL, 'FALSE'),
(7, NULL, TRUE, 'NULL'),
(8, NULL, FALSE, 'FALSE'),
(9, NULL, NULL, 'NULL');
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL);
INSERT INTO logic VALUES
(1, TRUE, TRUE),
(2, TRUE, FALSE),
(3, TRUE, NULL),
(4, FALSE, TRUE),
(5, FALSE, FALSE),
(6, FALSE, NULL),
(7, NULL, TRUE),
(8, NULL, FALSE),
(9, NULL, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL);
INSERT INTO test VALUES
(1, TRUE, TRUE),  -- (TRUE OR NULL) AND TRUE = TRUE AND TRUE = TRUE
(2, TRUE, FALSE), -- (TRUE OR NULL) AND FALSE = TRUE AND FALSE = FALSE
(3, FALSE, TRUE), -- (FALSE OR NULL) AND TRUE = NULL AND TRUE = NULL
(4, FALSE, FALSE) -- (FALSE OR NULL) AND FALSE = NULL AND FALSE = FALSE;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_ddl_test_select_655
SELECT id FROM logic WHERE a AND b;
-- Tag: window_functions_window_functions_ddl_test_select_656
SELECT id FROM logic WHERE a OR b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_657
SELECT id FROM test WHERE (val + 5) > 20 ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_658
SELECT id FROM test WHERE (a OR NULL) AND b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_659
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_660
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_661
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_662
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_663
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_ddl_test_select_664
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_ddl_test_select_665
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_666
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_667
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_668
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_669
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_670
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_671
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_672
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_673
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_674
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_675
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_ddl_test_select_676
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_ddl_test_select_677
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_ddl_test_select_678
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_679
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_ddl_test_select_680
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL);
INSERT INTO logic VALUES
(1, TRUE, TRUE),
(2, TRUE, FALSE),
(3, TRUE, NULL),
(4, FALSE, TRUE),
(5, FALSE, FALSE),
(6, FALSE, NULL),
(7, NULL, TRUE),
(8, NULL, FALSE),
(9, NULL, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL);
INSERT INTO test VALUES
(1, TRUE, TRUE),  -- (TRUE OR NULL) AND TRUE = TRUE AND TRUE = TRUE
(2, TRUE, FALSE), -- (TRUE OR NULL) AND FALSE = TRUE AND FALSE = FALSE
(3, FALSE, TRUE), -- (FALSE OR NULL) AND TRUE = NULL AND TRUE = NULL
(4, FALSE, FALSE) -- (FALSE OR NULL) AND FALSE = NULL AND FALSE = FALSE;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_ddl_test_select_681
SELECT id FROM logic WHERE a OR b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_682
SELECT id FROM test WHERE (val + 5) > 20 ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_683
SELECT id FROM test WHERE (a OR NULL) AND b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_684
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_685
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_686
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_687
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_688
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_ddl_test_select_689
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_ddl_test_select_690
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_691
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_692
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_693
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_694
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_695
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_696
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_697
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_698
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_699
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_700
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_ddl_test_select_701
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_ddl_test_select_702
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_ddl_test_select_703
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_704
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_ddl_test_select_705
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_ddl_test_select_706
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_707
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_708
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_ddl_test_select_709
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_710
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_ddl_test_select_711
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_ddl_test_select_712
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_ddl_test_select_713
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_714
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_ddl_test_select_715
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, active BOOL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO data VALUES (1, TRUE, NULL, FALSE);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (id INT64, flag BOOL);
INSERT INTO nulls VALUES (1, NULL);
INSERT INTO nulls VALUES (2, NULL);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (id INT64, a INT64, b INT64);
INSERT INTO nums VALUES (1, 5, 10);
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO complex VALUES (1, TRUE, TRUE, FALSE);
INSERT INTO complex VALUES (2, FALSE, TRUE, FALSE);
INSERT INTO complex VALUES (3, TRUE, FALSE, TRUE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'true');
INSERT INTO data VALUES (2, 'false');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);

-- Tag: window_functions_window_functions_ddl_test_select_716
SELECT COUNT(*) FROM large WHERE NOT active;
-- Tag: window_functions_window_functions_ddl_test_select_717
SELECT id FROM data WHERE NOT ((a AND b) OR c);
-- Tag: window_functions_window_functions_ddl_test_select_718
SELECT id FROM nulls WHERE NOT flag;
-- Tag: window_functions_window_functions_ddl_test_select_719
SELECT id FROM nums WHERE NOT a < b;
-- Tag: window_functions_window_functions_ddl_test_select_720
SELECT id FROM complex WHERE NOT a AND b OR c ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_721
SELECT NOT;
-- Tag: window_functions_window_functions_ddl_test_select_722
SELECT NOT 42;
-- Tag: window_functions_window_functions_ddl_test_select_723
SELECT NOT 'hello';
-- Tag: window_functions_window_functions_ddl_test_select_724
SELECT id FROM data WHERE NOT CAST(value AS BOOL) ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_725
SELECT id FROM data WHERE NOT (CASE WHEN value > 15 THEN TRUE ELSE FALSE END) ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_ddl_test_select_726
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_727
SELECT n + 1
FROM non_existent_table -- Table doesn't exist!
WHERE n < 5
)
-- Tag: window_functions_window_functions_ddl_test_select_728
SELECT * FROM broken;
WITH numbers AS ( -- Missing RECURSIVE!
-- Tag: window_functions_window_functions_ddl_test_select_729
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_730
SELECT n + 1 FROM numbers WHERE n < 5
)
-- Tag: window_functions_window_functions_ddl_test_select_731
SELECT * FROM numbers;
WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_ddl_test_select_732
SELECT id FROM data WHERE id = 999 -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_733
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_ddl_test_select_734
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_ddl_test_select_735
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_736
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_ddl_test_select_737
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_ddl_test_select_738
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_739
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_ddl_test_select_740
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_ddl_test_select_741
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_ddl_test_select_742
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_743
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_ddl_test_select_744
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_ddl_test_select_745
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_ddl_test_select_746
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_ddl_test_select_003
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

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

-- Tag: window_functions_window_functions_ddl_test_select_747
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_748
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_749
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_ddl_test_select_750
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_751
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_ddl_test_select_752
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_ddl_test_select_753
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_ddl_test_select_754
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_ddl_test_select_755
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_ddl_test_select_756
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_757
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_758
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_759
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_760
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_761
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_762
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_ddl_test_select_763
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_ddl_test_select_764
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_ddl_test_select_765
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

CREATE SEQUENCE seq_basic;
CREATE SEQUENCE seq_start START WITH 100;
CREATE SEQUENCE seq_inc INCREMENT BY 10;
CREATE SEQUENCE seq_range START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 10 NO CYCLE;
CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_766
SELECT NEXTVAL('seq_basic') as val;
-- Tag: window_functions_window_functions_ddl_test_select_767
SELECT NEXTVAL('seq_start') as val;
-- Tag: window_functions_window_functions_ddl_test_select_768
SELECT NEXTVAL('seq_inc') as v1, NEXTVAL('seq_inc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_769
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_770
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_771
SELECT NEXTVAL('seq_cycle') as v1, NEXTVAL('seq_cycle') as v2, NEXTVAL('seq_cycle') as v3, NEXTVAL('seq_cycle') as v4;
-- Tag: window_functions_window_functions_ddl_test_select_772
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_773
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_774
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_775
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_776
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_777
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_778
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_779
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_780
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_781
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_782
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_783
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_784
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_785
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_786
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_787
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_788
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_789
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_790
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_791
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_792
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_793
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_794
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_795
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_796
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_797
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_798
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_799
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_800
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_801
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_802
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_803
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_804
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_805
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_806
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_807
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_808
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_809
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_810
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_811
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_812
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_813
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_814
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_815
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_816
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_817
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_818
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_819
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_820
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_821
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_822
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_823
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_824
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_825
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_start START WITH 100;
CREATE SEQUENCE seq_inc INCREMENT BY 10;
CREATE SEQUENCE seq_range START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 10 NO CYCLE;
CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_826
SELECT NEXTVAL('seq_start') as val;
-- Tag: window_functions_window_functions_ddl_test_select_827
SELECT NEXTVAL('seq_inc') as v1, NEXTVAL('seq_inc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_828
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_829
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_830
SELECT NEXTVAL('seq_cycle') as v1, NEXTVAL('seq_cycle') as v2, NEXTVAL('seq_cycle') as v3, NEXTVAL('seq_cycle') as v4;
-- Tag: window_functions_window_functions_ddl_test_select_831
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_832
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_833
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_834
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_835
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_836
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_837
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_838
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_839
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_840
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_841
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_842
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_843
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_844
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_845
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_846
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_847
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_848
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_849
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_850
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_851
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_852
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_853
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_854
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_855
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_856
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_857
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_858
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_859
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_860
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_861
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_862
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_863
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_864
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_865
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_866
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_867
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_868
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_869
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_870
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_871
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_872
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_873
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_874
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_875
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_876
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_877
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_878
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_879
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_880
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_881
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_882
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_883
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_884
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_inc INCREMENT BY 10;
CREATE SEQUENCE seq_range START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 10 NO CYCLE;
CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_885
SELECT NEXTVAL('seq_inc') as v1, NEXTVAL('seq_inc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_886
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_887
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_ddl_test_select_888
SELECT NEXTVAL('seq_cycle') as v1, NEXTVAL('seq_cycle') as v2, NEXTVAL('seq_cycle') as v3, NEXTVAL('seq_cycle') as v4;
-- Tag: window_functions_window_functions_ddl_test_select_889
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_890
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_891
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_892
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_893
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_894
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_895
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_896
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_897
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_898
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_899
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_900
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_901
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_902
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_903
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_904
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_905
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_906
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_907
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_908
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_909
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_910
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_911
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_912
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_913
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_914
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_915
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_916
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_917
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_918
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_919
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_920
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_921
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_922
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_923
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_924
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_925
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_926
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_927
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_928
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_929
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_930
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_931
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_932
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_933
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_934
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_935
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_936
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_937
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_938
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_939
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_940
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_941
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_942
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_943
SELECT NEXTVAL('seq_cycle') as v1, NEXTVAL('seq_cycle') as v2, NEXTVAL('seq_cycle') as v3, NEXTVAL('seq_cycle') as v4;
-- Tag: window_functions_window_functions_ddl_test_select_944
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_945
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_946
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_947
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_948
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_949
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_950
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_951
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_952
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_953
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_954
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_955
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_956
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_957
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_958
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_959
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_960
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_961
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_962
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_963
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_964
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_965
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_966
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_967
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_968
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_969
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_970
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_971
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_972
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_973
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_974
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_975
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_976
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_977
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_978
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_979
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_980
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_981
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_982
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_983
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_984
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_985
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_986
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_987
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_988
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_989
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_990
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_991
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_992
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_993
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_994
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_995
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_996
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_997
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_998
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_ddl_test_select_999
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1000
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_1001
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1002
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1003
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1004
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1005
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1006
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1007
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1008
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1009
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1010
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1011
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1012
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1013
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1014
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1015
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1016
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1017
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1018
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1019
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1020
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1021
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1022
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1023
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1024
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1025
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1026
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1027
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1028
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1029
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1030
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1031
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1032
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1033
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1034
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1035
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1036
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1037
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1038
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1039
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1040
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1041
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1042
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1043
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1044
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1045
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1046
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1047
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1048
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1049
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1050
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1051
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1052
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1053
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_1054
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1055
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1056
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1057
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1058
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1059
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1060
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1061
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1062
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1063
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1064
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1065
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1066
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1067
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1068
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1069
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1070
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1071
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1072
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1073
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1074
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1075
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1076
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1077
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1078
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1079
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1080
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1081
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1082
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1083
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1084
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1085
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1086
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1087
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1088
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1089
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1090
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1091
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1092
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1093
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1094
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1095
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1096
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1097
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1098
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1099
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1100
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1101
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1102
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1103
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1104
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1105
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1106
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_1107
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1108
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1109
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1110
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1111
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1112
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1113
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1114
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1115
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1116
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1117
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1118
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1119
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1120
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1121
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1122
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1123
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1124
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1125
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1126
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1127
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1128
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1129
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1130
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1131
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1132
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1133
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1134
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1135
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1136
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1137
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1138
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1139
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1140
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1141
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1142
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1143
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1144
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1145
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1146
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1147
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1148
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1149
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1150
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1151
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1152
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1153
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1154
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1155
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1156
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1157
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1158
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_ddl_test_select_1159
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1160
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1161
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1162
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1163
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1164
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1165
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1166
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1167
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1168
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1169
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1170
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1171
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1172
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1173
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1174
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1175
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1176
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1177
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1178
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1179
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1180
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1181
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1182
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1183
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1184
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1185
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1186
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1187
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1188
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1189
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1190
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1191
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1192
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1193
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1194
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1195
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1196
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1197
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1198
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1199
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1200
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1201
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1202
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1203
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1204
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1205
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1206
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1207
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1208
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1209
SELECT id FROM items ORDER BY id;

DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1210
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1211
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1212
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1213
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1214
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1215
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1216
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1217
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1218
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1219
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1220
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1221
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1222
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1223
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1224
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1225
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1226
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1227
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1228
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1229
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1230
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1231
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1232
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1233
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1234
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1235
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1236
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1237
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1238
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1239
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1240
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1241
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1242
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1243
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1244
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1245
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1246
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1247
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1248
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1249
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1250
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1251
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1252
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1253
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1254
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1255
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1256
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1257
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1258
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1259
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1260
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1261
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_ddl_test_select_1262
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1263
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1264
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1265
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1266
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1267
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1268
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1269
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1270
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1271
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1272
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1273
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1274
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1275
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1276
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1277
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1278
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1279
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1280
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1281
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1282
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1283
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1284
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1285
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1286
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1287
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1288
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1289
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1290
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1291
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1292
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1293
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1294
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1295
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1296
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1297
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1298
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1299
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1300
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1301
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1302
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1303
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1304
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1305
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1306
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1307
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1308
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1309
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1310
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1311
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
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

-- Tag: window_functions_window_functions_ddl_test_select_1312
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1313
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_ddl_test_select_1314
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1315
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1316
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_ddl_test_select_1317
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1318
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1319
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1320
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_ddl_test_select_1321
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1322
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1323
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_ddl_test_select_1324
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1325
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_ddl_test_select_1326
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1327
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1328
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_ddl_test_select_1329
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1330
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_ddl_test_select_1331
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1332
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_ddl_test_select_1333
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1334
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_ddl_test_select_1335
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1336
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_ddl_test_select_1337
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_ddl_test_select_1338
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_ddl_test_select_1339
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1340
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_ddl_test_select_1341
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_ddl_test_select_1342
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_ddl_test_select_1343
SELECT LASTVAL();
-- Tag: window_functions_window_functions_ddl_test_select_1344
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1345
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1346
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1347
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1348
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1349
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1350
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1351
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1352
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1353
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1354
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1355
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1356
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1357
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1358
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1359
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1360
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_ddl_test_select_1361
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_ddl_test_select_1362
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_ddl_test_select_1363
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1364
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1365
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1366
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1367
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_ddl_test_select_1368
SELECT id FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1369
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_ddl_test_select_1370
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1371
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1372
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_ddl_test_select_1373
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
INSERT INTO users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 102, 'B');
INSERT INTO enrollments VALUES (2, 101, 'C');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1374
SELECT id, name FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1375
SELECT id FROM users ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1376
SELECT * FROM enrollments;
-- Tag: window_functions_window_functions_ddl_test_select_1377
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1378
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1379
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1380
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1381
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1382
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1383
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1384
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1385
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1386
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1387
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1388
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1389
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1390
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1391
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1392
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1393
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1394
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
INSERT INTO users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 102, 'B');
INSERT INTO enrollments VALUES (2, 101, 'C');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1395
SELECT id FROM users ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1396
SELECT * FROM enrollments;
-- Tag: window_functions_window_functions_ddl_test_select_1397
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1398
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1399
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1400
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1401
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1402
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1403
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1404
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1405
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1406
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1407
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1408
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1409
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1410
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1411
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1412
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1413
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1414
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
INSERT INTO users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 102, 'B');
INSERT INTO enrollments VALUES (2, 101, 'C');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1415
SELECT id FROM users ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1416
SELECT * FROM enrollments;
-- Tag: window_functions_window_functions_ddl_test_select_1417
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1418
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1419
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1420
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1421
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1422
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1423
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1424
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1425
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1426
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1427
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1428
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1429
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1430
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1431
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1432
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1433
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1434
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');
INSERT INTO users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 102, 'B');
INSERT INTO enrollments VALUES (2, 101, 'C');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1435
SELECT id FROM users ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1436
SELECT * FROM enrollments;
-- Tag: window_functions_window_functions_ddl_test_select_1437
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1438
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1439
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1440
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1441
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1442
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1443
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1444
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1445
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1446
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1447
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1448
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1449
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1450
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1451
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1452
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1453
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1454
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 102, 'B');
INSERT INTO enrollments VALUES (2, 101, 'C');
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1455
SELECT * FROM enrollments;
-- Tag: window_functions_window_functions_ddl_test_select_1456
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1457
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1458
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1459
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1460
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1461
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1462
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1463
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1464
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1465
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1466
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1467
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1468
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1469
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1470
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1471
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1472
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1473
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (student_id INT64, course_id INT64, grade STRING, PRIMARY KEY (student_id, course_id));
INSERT INTO enrollments VALUES (1, 101, 'A');
INSERT INTO enrollments VALUES (1, 101, 'B');
DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1474
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1475
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1476
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1477
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1478
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1479
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1480
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1481
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1482
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1483
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1484
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1485
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1486
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1487
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1488
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1489
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1490
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1491
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS products;
CREATE TABLE products (sku STRING PRIMARY KEY, name STRING, price FLOAT64);
INSERT INTO products VALUES ('SKU001', 'Widget', 9.99);
INSERT INTO products VALUES ('SKU002', 'Gadget', 19.99);
INSERT INTO products VALUES ('SKU001', 'Duplicate', 5.00);
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1492
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1493
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1494
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1495
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1496
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1497
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1498
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1499
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1500
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1501
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1502
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1503
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1504
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1505
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1506
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1507
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1508
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1509
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code STRING PRIMARY KEY, description STRING);
INSERT INTO codes VALUES ('abc', 'Lower');
INSERT INTO codes VALUES ('ABC', 'Upper');
DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1510
SELECT * FROM codes;
-- Tag: window_functions_window_functions_ddl_test_select_1511
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1512
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1513
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1514
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1515
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1516
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1517
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1518
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1519
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1520
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1521
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1522
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1523
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1524
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1525
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1526
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1527
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS items;
CREATE TABLE items (code STRING PRIMARY KEY, name STRING);
INSERT INTO items VALUES ('', 'Empty Code');
INSERT INTO items VALUES ('A', 'Code A');
INSERT INTO items VALUES ('', 'Another Empty');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1528
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1529
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1530
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1531
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1532
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1533
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1534
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1535
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1536
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1537
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1538
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1539
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1540
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1541
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1542
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1543
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1544
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (1), (2), (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING NOT NULL);
INSERT INTO users VALUES (1, NULL);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, code STRING NOT NULL);
INSERT INTO items VALUES (1, '');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 NOT NULL, name STRING NOT NULL, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (NULL, 'Gadget', 19.99);
INSERT INTO products VALUES (2, NULL, 29.99);
INSERT INTO products VALUES (3, 'Thing', NULL);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 NOT NULL);
INSERT INTO numbers VALUES (0);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
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

-- Tag: window_functions_window_functions_ddl_test_select_1545
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1546
SELECT code FROM items;
-- Tag: window_functions_window_functions_ddl_test_select_1547
SELECT value FROM numbers;
-- Tag: window_functions_window_functions_ddl_test_select_1548
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_ddl_test_select_1549
SELECT status FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1550
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_ddl_test_select_1551
SELECT error FROM logs;
-- Tag: window_functions_window_functions_ddl_test_select_1552
SELECT discount FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1553
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_ddl_test_select_1554
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_ddl_test_select_1555
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_ddl_test_select_1556
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_ddl_test_select_1557
SELECT * FROM users;
-- Tag: window_functions_window_functions_ddl_test_select_1558
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_ddl_test_select_1559
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1560
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1561
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1562
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1563
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1564
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1565
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1566
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1567
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1568
SELECT price FROM products;
-- Tag: window_functions_window_functions_ddl_test_select_1569
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1570
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1571
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1572
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1573
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1574
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_ddl_test_select_1575
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_ddl_test_select_1576
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice', 30), (2, 'Bob', 25), (3, 'Charlie', 35);
DROP VIEW IF EXISTS adult_users;
CREATE VIEW adult_users AS SELECT * FROM users WHERE age >= 18;
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64, quantity INT64);
INSERT INTO products VALUES (1, 'Widget', 10.50, 100), (2, 'Gadget', 25.00, 50);
DROP VIEW IF EXISTS product_inventory;
CREATE VIEW product_inventory AS SELECT id, name, price, quantity, price * quantity AS total_value FROM products;
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary INT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES (1, 'Alice', 1, 80000), (2, 'Bob', 2, 60000), (3, 'Charlie', 1, 90000);
DROP VIEW IF EXISTS employee_details;
CREATE VIEW employee_details AS
-- Tag: window_functions_window_functions_ddl_test_select_1577
SELECT e.id, e.name, d.name AS department, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, region STRING);
INSERT INTO sales VALUES (1, 'Widget', 100, 'North'), (2, 'Widget', 150, 'South'), (3, 'Gadget', 200, 'North');
DROP VIEW IF EXISTS sales_by_region;
CREATE VIEW sales_by_region AS
-- Tag: window_functions_window_functions_ddl_test_select_1578
SELECT region, SUM(amount) AS total_sales, COUNT(*) AS sale_count
FROM sales
GROUP BY region;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, total FLOAT64);
INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150), (4, 2, 175);
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: window_functions_window_functions_ddl_test_select_1579
SELECT DISTINCT customer_id,
(SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS order_count,
(SELECT SUM(total) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS total_spent
FROM orders o1;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1580
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1581
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1582
SELECT * FROM adult_users ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1583
SELECT * FROM product_inventory ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1584
SELECT * FROM employee_details ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1585
SELECT * FROM sales_by_region ORDER BY region;
-- Tag: window_functions_window_functions_ddl_test_select_1586
SELECT * FROM customer_order_stats ORDER BY customer_id;
-- Tag: window_functions_window_functions_ddl_test_select_1587
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1588
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1589
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1590
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1591
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1592
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1593
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1594
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1595
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1596
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1597
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1598
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1599
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1600
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1601
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1602
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1603
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1604
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1605
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1606
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1607
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1608
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1609
SELECT * FROM star_view;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64, quantity INT64);
INSERT INTO products VALUES (1, 'Widget', 10.50, 100), (2, 'Gadget', 25.00, 50);
DROP VIEW IF EXISTS product_inventory;
CREATE VIEW product_inventory AS SELECT id, name, price, quantity, price * quantity AS total_value FROM products;
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary INT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES (1, 'Alice', 1, 80000), (2, 'Bob', 2, 60000), (3, 'Charlie', 1, 90000);
DROP VIEW IF EXISTS employee_details;
CREATE VIEW employee_details AS
-- Tag: window_functions_window_functions_ddl_test_select_1610
SELECT e.id, e.name, d.name AS department, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, region STRING);
INSERT INTO sales VALUES (1, 'Widget', 100, 'North'), (2, 'Widget', 150, 'South'), (3, 'Gadget', 200, 'North');
DROP VIEW IF EXISTS sales_by_region;
CREATE VIEW sales_by_region AS
-- Tag: window_functions_window_functions_ddl_test_select_1611
SELECT region, SUM(amount) AS total_sales, COUNT(*) AS sale_count
FROM sales
GROUP BY region;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, total FLOAT64);
INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150), (4, 2, 175);
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: window_functions_window_functions_ddl_test_select_1612
SELECT DISTINCT customer_id,
(SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS order_count,
(SELECT SUM(total) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS total_spent
FROM orders o1;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1613
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1614
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1615
SELECT * FROM product_inventory ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1616
SELECT * FROM employee_details ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1617
SELECT * FROM sales_by_region ORDER BY region;
-- Tag: window_functions_window_functions_ddl_test_select_1618
SELECT * FROM customer_order_stats ORDER BY customer_id;
-- Tag: window_functions_window_functions_ddl_test_select_1619
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1620
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1621
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1622
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1623
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1624
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1625
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1626
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1627
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1628
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1629
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1630
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1631
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1632
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1633
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1634
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1635
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1636
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1637
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1638
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1639
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1640
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1641
SELECT * FROM star_view;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary INT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES (1, 'Alice', 1, 80000), (2, 'Bob', 2, 60000), (3, 'Charlie', 1, 90000);
DROP VIEW IF EXISTS employee_details;
CREATE VIEW employee_details AS
-- Tag: window_functions_window_functions_ddl_test_select_1642
SELECT e.id, e.name, d.name AS department, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.id;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, region STRING);
INSERT INTO sales VALUES (1, 'Widget', 100, 'North'), (2, 'Widget', 150, 'South'), (3, 'Gadget', 200, 'North');
DROP VIEW IF EXISTS sales_by_region;
CREATE VIEW sales_by_region AS
-- Tag: window_functions_window_functions_ddl_test_select_1643
SELECT region, SUM(amount) AS total_sales, COUNT(*) AS sale_count
FROM sales
GROUP BY region;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, total FLOAT64);
INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150), (4, 2, 175);
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: window_functions_window_functions_ddl_test_select_1644
SELECT DISTINCT customer_id,
(SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS order_count,
(SELECT SUM(total) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS total_spent
FROM orders o1;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1645
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1646
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1647
SELECT * FROM employee_details ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1648
SELECT * FROM sales_by_region ORDER BY region;
-- Tag: window_functions_window_functions_ddl_test_select_1649
SELECT * FROM customer_order_stats ORDER BY customer_id;
-- Tag: window_functions_window_functions_ddl_test_select_1650
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1651
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1652
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1653
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1654
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1655
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1656
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1657
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1658
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1659
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1660
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1661
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1662
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1663
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1664
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1665
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1666
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1667
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1668
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1669
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1670
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1671
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1672
SELECT * FROM star_view;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, region STRING);
INSERT INTO sales VALUES (1, 'Widget', 100, 'North'), (2, 'Widget', 150, 'South'), (3, 'Gadget', 200, 'North');
DROP VIEW IF EXISTS sales_by_region;
CREATE VIEW sales_by_region AS
-- Tag: window_functions_window_functions_ddl_test_select_1673
SELECT region, SUM(amount) AS total_sales, COUNT(*) AS sale_count
FROM sales
GROUP BY region;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, total FLOAT64);
INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150), (4, 2, 175);
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: window_functions_window_functions_ddl_test_select_1674
SELECT DISTINCT customer_id,
(SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS order_count,
(SELECT SUM(total) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS total_spent
FROM orders o1;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1675
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1676
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1677
SELECT * FROM sales_by_region ORDER BY region;
-- Tag: window_functions_window_functions_ddl_test_select_1678
SELECT * FROM customer_order_stats ORDER BY customer_id;
-- Tag: window_functions_window_functions_ddl_test_select_1679
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1680
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1681
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1682
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1683
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1684
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1685
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1686
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1687
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1688
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1689
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1690
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1691
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1692
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1693
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1694
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1695
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1696
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1697
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1698
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1699
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1700
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1701
SELECT * FROM star_view;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, total FLOAT64);
INSERT INTO orders VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150), (4, 2, 175);
DROP VIEW IF EXISTS customer_order_stats;
CREATE VIEW customer_order_stats AS
-- Tag: window_functions_window_functions_ddl_test_select_1702
SELECT DISTINCT customer_id,
(SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS order_count,
(SELECT SUM(total) FROM orders o2 WHERE o2.customer_id = o1.customer_id) AS total_spent
FROM orders o1;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1703
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1704
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1705
SELECT * FROM customer_order_stats ORDER BY customer_id;
-- Tag: window_functions_window_functions_ddl_test_select_1706
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1707
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1708
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1709
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1710
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1711
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1712
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1713
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1714
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1715
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1716
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1717
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1718
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1719
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1720
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1721
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1722
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1723
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1724
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1725
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1726
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1727
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1728
SELECT * FROM star_view;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS data_view;
CREATE VIEW data_view AS SELECT * FROM data WHERE value > 10;
CREATE OR REPLACE VIEW data_view AS SELECT * FROM data WHERE value > 20;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1729
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1730
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1731
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1732
SELECT * FROM data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1733
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1734
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1735
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1736
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1737
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1738
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1739
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1740
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1741
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1742
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1743
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1744
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1745
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1746
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1747
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1748
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1749
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1750
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1751
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1752
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1753
SELECT * FROM star_view;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, price FLOAT64);
INSERT INTO items VALUES (1, 'Item1', 10.0), (2, 'Item2', 20.0);
DROP VIEW IF EXISTS item_view;
CREATE VIEW item_view AS SELECT id, name FROM items;
CREATE OR REPLACE VIEW item_view AS SELECT id, price FROM items;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1754
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1755
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1756
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1757
SELECT * FROM item_view;
-- Tag: window_functions_window_functions_ddl_test_select_1758
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1759
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1760
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1761
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1762
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1763
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1764
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1765
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1766
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1767
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1768
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1769
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1770
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1771
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1772
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1773
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1774
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1775
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1776
SELECT * FROM star_view;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test_view;
CREATE VIEW test_view AS SELECT * FROM test;
DROP VIEW test_view;
DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1777
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1778
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1779
SELECT * FROM test_view;
-- Tag: window_functions_window_functions_ddl_test_select_1780
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1781
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1782
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1783
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1784
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1785
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1786
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1787
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1788
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1789
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1790
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1791
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1792
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1793
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1794
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1795
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1796
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1797
SELECT * FROM star_view;

DROP VIEW non_existent_view;
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1798
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1799
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1800
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1801
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1802
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1803
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1804
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1805
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1806
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1807
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1808
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1809
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1810
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1811
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1812
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1813
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1814
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1815
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1816
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1817
SELECT * FROM star_view;

DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (id INT64, value INT64);
INSERT INTO base_table VALUES (1, 100);
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view AS SELECT * FROM base_table;
DROP VIEW table_view;
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1818
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1819
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1820
SELECT * FROM base_table;
-- Tag: window_functions_window_functions_ddl_test_select_1821
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1822
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1823
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1824
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1825
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1826
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1827
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1828
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1829
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1830
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1831
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1832
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1833
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1834
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1835
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1836
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1837
SELECT * FROM star_view;

DROP TABLE IF EXISTS persons;
CREATE TABLE persons (id INT64, name STRING, age INT64);
DROP VIEW IF EXISTS persons_view;
CREATE VIEW persons_view AS SELECT * FROM persons;
INSERT INTO persons_view VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1838
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1839
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1840
SELECT * FROM persons;
UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1841
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1842
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1843
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1844
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1845
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1846
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1847
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1848
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1849
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1850
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1851
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1852
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1853
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1854
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1855
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1856
SELECT * FROM star_view;

DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64, status STRING);
INSERT INTO records VALUES (1, 'active'), (2, 'inactive');
DROP VIEW IF EXISTS active_records;
CREATE VIEW active_records AS SELECT * FROM records WHERE status = 'active';
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1857
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1858
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

UPDATE active_records SET status = 'pending' WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1859
SELECT * FROM records WHERE id = 1;
DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1860
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1861
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1862
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1863
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1864
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1865
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1866
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1867
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1868
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1869
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1870
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1871
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1872
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1873
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1874
SELECT * FROM star_view;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING, deleted BOOL);
INSERT INTO items VALUES (1, 'Item1', false), (2, 'Item2', false);
DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS SELECT * FROM items WHERE deleted = false;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1875
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1876
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

DELETE FROM active_items WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1877
SELECT * FROM items;
UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1878
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1879
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1880
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1881
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1882
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1883
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1884
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1885
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1886
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1887
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1888
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1889
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1890
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1891
SELECT * FROM star_view;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, level STRING);
INSERT INTO logs VALUES (1, 'ERROR'), (2, 'INFO');
DROP VIEW IF EXISTS log_summary;
CREATE VIEW log_summary AS SELECT level, COUNT(*) AS count FROM logs GROUP BY level;
INSERT INTO log_summary VALUES ('DEBUG', 5);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1892
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1893
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1894
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1895
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1896
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1897
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1898
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1899
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1900
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1901
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1902
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1903
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1904
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1905
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1906
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1907
SELECT * FROM star_view;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val1 INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val2 INT64);
DROP VIEW IF EXISTS joined_view;
CREATE VIEW joined_view AS SELECT t1.id, val1, val2 FROM t1 JOIN t2 ON t1.id = t2.id;
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1908
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1909
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

UPDATE joined_view SET val1 = 100 WHERE id = 1;
-- Tag: window_functions_window_functions_ddl_test_select_1910
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1911
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1912
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1913
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1914
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1915
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1916
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1917
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1918
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1919
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1920
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1921
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1922
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1923
SELECT * FROM star_view;

DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_type STRING, count INT64);
INSERT INTO events VALUES (1, 'click', 100), (2, 'view', 500);
DROP MATERIALIZED VIEW IF EXISTS event_summary;
CREATE MATERIALIZED VIEW event_summary AS SELECT event_type, SUM(count) AS total FROM events GROUP BY event_type;
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1924
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1925
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1926
SELECT * FROM event_summary ORDER BY event_type;
-- Tag: window_functions_window_functions_ddl_test_select_1927
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1928
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1929
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1930
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1931
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1932
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1933
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1934
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1935
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1936
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1937
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1938
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1939
SELECT * FROM star_view;

DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, value INT64);
INSERT INTO counters VALUES (1, 10);
DROP MATERIALIZED VIEW IF EXISTS counter_view;
CREATE MATERIALIZED VIEW counter_view AS SELECT SUM(value) AS total FROM counters;
INSERT INTO counters VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP MATERIALIZED VIEW IF EXISTS data_view;
CREATE MATERIALIZED VIEW data_view AS SELECT * FROM data;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1940
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1941
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1942
SELECT * FROM counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1943
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW counter_view;
-- Tag: window_functions_window_functions_ddl_test_select_1944
SELECT * FROM counter_view;
REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_ddl_test_select_1945
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1946
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1947
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1948
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1949
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1950
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1951
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1952
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1953
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1954
SELECT * FROM star_view;

DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64, value INT64);
INSERT INTO base VALUES (1, 10), (2, 20), (3, 30);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base WHERE value > 10;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1 WHERE value < 30;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1955
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1956
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1957
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1958
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1959
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1960
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1961
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1962
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1963
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1964
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1965
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1966
SELECT * FROM star_view;

DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 CASCADE;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1967
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1968
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1969
SELECT * FROM view2;
-- Tag: window_functions_window_functions_ddl_test_select_1970
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1971
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1972
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1973
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1974
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1975
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1976
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1977
SELECT * FROM star_view;

DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS view1;
CREATE VIEW view1 AS SELECT * FROM base;
DROP VIEW IF EXISTS view2;
CREATE VIEW view2 AS SELECT * FROM view1;
DROP VIEW view1 RESTRICT;
DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1978
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1979
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1980
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1981
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1982
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1983
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1984
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1985
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1986
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1987
SELECT * FROM star_view;

DROP TABLE IF EXISTS base;
CREATE TABLE base (id INT64);
DROP VIEW IF EXISTS dependent_view;
CREATE VIEW dependent_view AS SELECT * FROM base;
DROP TABLE base;
DROP TABLE base CASCADE;
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1988
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1989
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_1990
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_ddl_test_select_1991
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_1992
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_1993
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_1994
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_1995
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_1996
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_1997
SELECT * FROM star_view;

DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64);
DROP VIEW IF EXISTS empty_view;
CREATE VIEW empty_view AS SELECT * FROM empty_table;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_1998
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_1999
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_2000
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_ddl_test_select_2001
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_2002
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_2003
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_2004
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_2005
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_2006
SELECT * FROM star_view;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP VIEW IF EXISTS test;
CREATE VIEW test AS SELECT * FROM test;
DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_2007
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_2008
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_2009
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_2010
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_2011
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_2012
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_2013
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_2014
SELECT * FROM star_view;

DROP TABLE IF EXISTS nullable_data;
CREATE TABLE nullable_data (id INT64, value INT64);
INSERT INTO nullable_data VALUES (1, NULL), (2, 20);
DROP VIEW IF EXISTS nullable_view;
CREATE VIEW nullable_view AS SELECT * FROM nullable_data;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_2015
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_2016
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_2017
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_ddl_test_select_2018
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_2019
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_2020
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_2021
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_2022
SELECT * FROM star_view;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (2), (3);
DROP VIEW IF EXISTS squares;
CREATE VIEW squares AS
WITH squared AS (SELECT n, n * n AS n_squared FROM numbers)
-- Tag: window_functions_window_functions_ddl_test_select_2023
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_2024
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_2025
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_ddl_test_select_2026
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_2027
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_2028
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_2029
SELECT * FROM star_view;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_ddl_test_select_2030
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, status STRING);
INSERT INTO users VALUES (1, 25, 'active'), (2, 35, 'inactive'), (3, 45, 'active');
DROP VIEW IF EXISTS young_users;
CREATE VIEW young_users AS SELECT * FROM users WHERE age < 30;
DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active';
DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: window_functions_window_functions_ddl_test_select_2031
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_ddl_test_select_2032
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_ddl_test_select_2033
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_ddl_test_select_2034
SELECT * FROM star_view;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);

-- Tag: window_functions_window_functions_ddl_test_select_2035
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ddl_test_select_2036
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

