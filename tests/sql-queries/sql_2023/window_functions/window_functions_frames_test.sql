-- Window Functions Frames - SQL:2023
-- Description: Window frame specifications: ROWS, RANGE, UNBOUNDED
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
INSERT INTO products VALUES (1, 19.99);
INSERT INTO products VALUES (2, -10.0);
INSERT INTO products VALUES (3, 0.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees ( id INT64, age INT64 CHECK (age BETWEEN 18 AND 65) );
INSERT INTO employees VALUES (1, 18);
INSERT INTO employees VALUES (2, 30);
INSERT INTO employees VALUES (3, 65);
INSERT INTO employees VALUES (4, 17);
INSERT INTO employees VALUES (5, 66);
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

-- Tag: window_functions_window_functions_frames_test_select_001
SELECT * FROM items WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_002
SELECT COUNT(*) FROM dest;
UPDATE inventory SET stock = 50 WHERE id = 1;
UPDATE inventory SET stock = -10 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_003
SELECT stock FROM inventory WHERE id = 1;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees ( id INT64, age INT64 CHECK (age BETWEEN 18 AND 65) );
INSERT INTO employees VALUES (1, 18);
INSERT INTO employees VALUES (2, 30);
INSERT INTO employees VALUES (3, 65);
INSERT INTO employees VALUES (4, 17);
INSERT INTO employees VALUES (5, 66);
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

-- Tag: window_functions_window_functions_frames_test_select_004
SELECT * FROM items WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_005
SELECT COUNT(*) FROM dest;
UPDATE inventory SET stock = 50 WHERE id = 1;
UPDATE inventory SET stock = -10 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_006
SELECT stock FROM inventory WHERE id = 1;

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

UPDATE counters SET count = count + 1;
-- Tag: window_functions_window_functions_frames_test_select_007
SELECT * FROM counters WHERE count = 1;
DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_frames_test_select_008
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_009
SELECT * FROM data;
-- Tag: window_functions_window_functions_frames_test_select_010
SELECT * FROM data;
-- Tag: window_functions_window_functions_frames_test_select_011
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_012
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_013
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_frames_test_select_014
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_015
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_frames_test_select_016
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_frames_test_select_017
SELECT * FROM large;
-- Tag: window_functions_window_functions_frames_test_select_018
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_019
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_frames_test_select_020
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_frames_test_select_021
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_frames_test_select_022
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_frames_test_select_023
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_frames_test_select_024
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_frames_test_select_025
SELECT * FROM recovery_test;

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

DELETE FROM data WHERE value > 500;
-- Tag: window_functions_window_functions_frames_test_select_026
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_027
SELECT * FROM data;
-- Tag: window_functions_window_functions_frames_test_select_028
SELECT * FROM data;
-- Tag: window_functions_window_functions_frames_test_select_029
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_030
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_031
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_frames_test_select_032
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_033
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_frames_test_select_034
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_frames_test_select_035
SELECT * FROM large;
-- Tag: window_functions_window_functions_frames_test_select_036
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_037
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_frames_test_select_038
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_frames_test_select_039
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_frames_test_select_040
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_frames_test_select_041
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_frames_test_select_042
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_frames_test_select_043
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b'), (3, 'c');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, thread_id INT64);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, count INT64);
INSERT INTO counters VALUES (1, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, thread_id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE test ADD COLUMN age INT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE test;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table2 VALUES (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);

-- Tag: window_functions_window_functions_frames_test_select_044
SELECT * FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_045
SELECT customer_id, COUNT(*), SUM(amount)
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;
-- Tag: window_functions_window_functions_frames_test_select_046
SELECT c.name, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
-- Tag: window_functions_window_functions_frames_test_select_047
SELECT id, amount,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) as rank
FROM orders;
-- Tag: window_functions_window_functions_frames_test_select_048
SELECT * FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);
-- Tag: window_functions_window_functions_frames_test_select_049
SELECT COUNT(*) as count FROM test;
-- Tag: window_functions_window_functions_frames_test_select_050
SELECT count FROM counters WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_051
SELECT count FROM counters WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_052
SELECT COUNT(*) as count FROM test;
-- Tag: window_functions_window_functions_frames_test_select_053
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_054
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_055
SELECT value FROM test WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_056
SELECT value FROM test WHERE id = 1;
UPDATE test SET value = 200 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_057
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_058
SELECT COUNT(*) FROM test WHERE id > 500;
-- Tag: window_functions_window_functions_frames_test_select_059
SELECT * FROM table1;
-- Tag: window_functions_window_functions_frames_test_select_060
SELECT * FROM table2;
-- Tag: window_functions_window_functions_frames_test_select_061
SELECT * FROM table2;
-- Tag: window_functions_window_functions_frames_test_select_062
SELECT * FROM table1;
-- Tag: window_functions_window_functions_frames_test_select_063
SELECT * FROM test;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, thread_id INT64);
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64, count INT64);
INSERT INTO counters VALUES (1, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, thread_id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE test ADD COLUMN age INT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE test;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table2 VALUES (2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);

-- Tag: window_functions_window_functions_frames_test_select_064
SELECT customer_id, COUNT(*), SUM(amount)
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;
-- Tag: window_functions_window_functions_frames_test_select_065
SELECT c.name, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
-- Tag: window_functions_window_functions_frames_test_select_066
SELECT id, amount,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) as rank
FROM orders;
-- Tag: window_functions_window_functions_frames_test_select_067
SELECT * FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);
-- Tag: window_functions_window_functions_frames_test_select_068
SELECT COUNT(*) as count FROM test;
-- Tag: window_functions_window_functions_frames_test_select_069
SELECT count FROM counters WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_070
SELECT count FROM counters WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_071
SELECT COUNT(*) as count FROM test;
-- Tag: window_functions_window_functions_frames_test_select_072
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_073
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_074
SELECT value FROM test WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_075
SELECT value FROM test WHERE id = 1;
UPDATE test SET value = 200 WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_076
SELECT * FROM test;
-- Tag: window_functions_window_functions_frames_test_select_077
SELECT COUNT(*) FROM test WHERE id > 500;
-- Tag: window_functions_window_functions_frames_test_select_078
SELECT * FROM table1;
-- Tag: window_functions_window_functions_frames_test_select_079
SELECT * FROM table2;
-- Tag: window_functions_window_functions_frames_test_select_080
SELECT * FROM table2;
-- Tag: window_functions_window_functions_frames_test_select_081
SELECT * FROM table1;
-- Tag: window_functions_window_functions_frames_test_select_082
SELECT * FROM test;

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

-- Tag: window_functions_window_functions_frames_test_select_083
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_frames_test_select_084
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_frames_test_select_085
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_frames_test_select_086
SELECT * FROM cte;
-- Tag: window_functions_window_functions_frames_test_select_087
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_frames_test_select_088
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_frames_test_select_089
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_frames_test_select_090
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_frames_test_select_091
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS all_values;
CREATE TABLE all_values (value INT64);
INSERT INTO all_values VALUES (10);
INSERT INTO all_values VALUES (20);
INSERT INTO all_values VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (20);
INSERT INTO filter VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 20);
INSERT INTO data VALUES (2, 40);
INSERT INTO data VALUES (3, 60);
INSERT INTO data VALUES (4, 80);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (10);
INSERT INTO multipliers VALUES (20);
INSERT INTO multipliers VALUES (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64, dept_id INT64);
INSERT INTO employees VALUES (1, 'Alice', 70000.0, 1);
INSERT INTO employees VALUES (2, 'Bob', 60000.0, 1);
INSERT INTO employees VALUES (3, 'Charlie', 80000.0, 2);
INSERT INTO employees VALUES (4, 'David', 90000.0, 2);
DROP TABLE IF EXISTS high_performers;
CREATE TABLE high_performers (emp_id INT64, dept_id INT64);
INSERT INTO high_performers VALUES (1, 1);
INSERT INTO high_performers VALUES (4, 2);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
INSERT INTO employees VALUES (5, 'Eve', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Widget', 9.99);
INSERT INTO products VALUES (2, 'Gadget', 19.99);
INSERT INTO products VALUES (3, 'Gizmo', 29.99);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, quantity INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 50);
INSERT INTO sales VALUES (3, 150);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 30);
INSERT INTO numbers VALUES (4, 40);
INSERT INTO numbers VALUES (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'deleted');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
INSERT INTO all_products VALUES (4, 'Doohickey');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
INSERT INTO sold_products VALUES (4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (20);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
INSERT INTO data VALUES (4, 40);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64);
INSERT INTO employees VALUES (1, 'Alice', 1);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 2);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS projects;
CREATE TABLE projects (id INT64, emp_id INT64, dept_id INT64);
INSERT INTO projects VALUES (1, 1, 1);
INSERT INTO projects VALUES (2, 3, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (NULL);
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

-- Tag: window_functions_window_functions_frames_test_select_092
SELECT id FROM data WHERE value IN (SELECT value FROM all_values) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_093
SELECT id FROM data WHERE value IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_094
SELECT id FROM data WHERE value IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_095
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_096
SELECT name FROM employees e WHERE e.id IN (SELECT emp_id FROM high_performers h WHERE h.dept_id = e.dept_id) ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_097
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_098
SELECT name FROM products WHERE id IN (SELECT product_id FROM sales WHERE quantity > 75) ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_099
SELECT id FROM numbers WHERE value NOT IN (10, 30, 50) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_100
SELECT id FROM data WHERE value NOT IN (10, 20, 30);
-- Tag: window_functions_window_functions_frames_test_select_101
SELECT id FROM data WHERE value NOT IN (100, 200, 300) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_102
SELECT id FROM data WHERE status NOT IN ('deleted', 'inactive') ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_103
SELECT id FROM data WHERE value NOT IN (10, 20) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_104
SELECT name FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_105
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_106
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_107
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_108
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_109
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_110
SELECT name FROM employees e WHERE e.id NOT IN (SELECT emp_id FROM projects p WHERE p.dept_id = e.dept_id) ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_111
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_112
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_113
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_frames_test_select_114
SELECT id FROM products WHERE active = true ORDER BY id;
UPDATE employees SET status = 'inactive' WHERE id NOT IN (SELECT emp_id FROM resignations WHERE emp_id IS NOT NULL);
-- Tag: window_functions_window_functions_frames_test_select_115
SELECT name FROM employees WHERE status = 'inactive' ORDER BY name;
DELETE FROM temp_data WHERE value IN (SELECT value FROM delete_list);
-- Tag: window_functions_window_functions_frames_test_select_116
SELECT id FROM temp_data ORDER BY id;
DELETE FROM all_records WHERE value NOT IN (SELECT value FROM keep_list WHERE value IS NOT NULL);
-- Tag: window_functions_window_functions_frames_test_select_117
SELECT id FROM all_records ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_118
SELECT id, CASE WHEN status IN ('active', 'pending') THEN 'good' ELSE 'bad' END as health FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_119
SELECT id, CASE WHEN value NOT IN (10, 30) THEN 'excluded' ELSE 'included' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_120
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_121
SELECT COUNT(*) FROM data WHERE id NOT IN (SELECT id FROM filter WHERE id IS NOT NULL);
-- Tag: window_functions_window_functions_frames_test_select_122
SELECT id FROM level1 WHERE value IN (SELECT l1_value FROM level2 WHERE id IN (SELECT l2_id FROM level3));
-- Tag: window_functions_window_functions_frames_test_select_123
SELECT id FROM data WHERE value IN ('foo', 'bar');
-- Tag: window_functions_window_functions_frames_test_select_124
SELECT id FROM data WHERE value IN (SELECT col1, col2 FROM multi);
-- Tag: window_functions_window_functions_frames_test_select_125
SELECT id FROM empty_data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_126
SELECT COUNT(*) FROM data WHERE value IN (10, 30);
-- Tag: window_functions_window_functions_frames_test_select_127
SELECT COUNT(*) FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_128
SELECT id FROM data WHERE value IN (SELECT DISTINCT value FROM filter);
-- Tag: window_functions_window_functions_frames_test_select_129
SELECT id FROM data WHERE value IN (SELECT value FROM filter ORDER BY value DESC) ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_130
SELECT id FROM data WHERE value IN (10, 30) AND status = 'active' ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_131
SELECT id FROM data WHERE value NOT IN (10, 20) AND flag = true ORDER BY id;

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
-- Tag: window_functions_window_functions_frames_test_select_132
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

-- Tag: window_functions_window_functions_frames_test_select_133
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_134
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_135
SELECT * FROM data WHERE id = 2;
-- Tag: window_functions_window_functions_frames_test_select_136
SELECT COUNT(*) FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_137
SELECT COUNT(*) FROM data WHERE age IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_138
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_139
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_140
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_frames_test_select_141
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_142
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_143
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_144
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_145
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_146
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_147
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_148
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_frames_test_select_149
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_frames_test_select_150
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_151
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_152
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_frames_test_select_153
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_frames_test_select_154
SELECT id FROM data WHERE name = 'Alice';

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
-- Tag: window_functions_window_functions_frames_test_select_155
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

-- Tag: window_functions_window_functions_frames_test_select_156
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_157
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_158
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_frames_test_select_159
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_frames_test_select_160
SELECT id FROM data WHERE name = 'Alice';

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

-- Tag: window_functions_window_functions_frames_test_select_161
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_frames_test_select_162
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_frames_test_select_163
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_frames_test_select_164
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_frames_test_select_165
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_frames_test_select_166
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_167
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_frames_test_select_168
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_frames_test_select_169
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_frames_test_select_170
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_frames_test_select_171
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_frames_test_select_172
SELECT COUNT(*) as cnt FROM temp_data;

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

-- Tag: window_functions_window_functions_frames_test_select_173
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_frames_test_select_174
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_frames_test_select_175
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_frames_test_select_176
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_177
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_frames_test_select_178
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_frames_test_select_179
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_180
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_181
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_frames_test_select_182
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_frames_test_select_183
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_frames_test_select_184
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_frames_test_select_185
SELECT * FROM test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_frames_test_select_186
SELECT id FROM data WHERE id = 999  -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_187
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_frames_test_select_188
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_frames_test_select_189
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_190
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_frames_test_select_191
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_frames_test_select_192
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_193
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_frames_test_select_194
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_frames_test_select_195
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_frames_test_select_196
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_197
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_frames_test_select_198
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_frames_test_select_199
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_frames_test_select_200
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_frames_test_select_001
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

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

-- Tag: window_functions_window_functions_frames_test_select_201
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_202
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_203
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_204
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_205
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_frames_test_select_206
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_frames_test_select_207
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_208
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

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

-- Tag: window_functions_window_functions_frames_test_select_209
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_210
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_211
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_frames_test_select_212
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_frames_test_select_213
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_214
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_frames_test_select_215
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_216
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_frames_test_select_217
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_frames_test_select_218
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_frames_test_select_219
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_220
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_221
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_222
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_223
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_224
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_225
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_frames_test_select_226
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_frames_test_select_227
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_frames_test_select_228
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

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

-- Tag: window_functions_window_functions_frames_test_select_229
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_frames_test_select_230
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_231
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_frames_test_select_232
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_frames_test_select_233
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_frames_test_select_234
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_frames_test_select_235
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_frames_test_select_236
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_237
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_238
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_239
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_240
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_241
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_242
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_frames_test_select_243
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_frames_test_select_244
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_frames_test_select_245
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

-- Tag: window_functions_window_functions_frames_test_select_246
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_247
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_248
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_249
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_frames_test_select_250
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_frames_test_select_251
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_frames_test_select_252
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price NUMERIC(10, 2) );
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 10.00);
INSERT INTO products VALUES (3, 15.50);
INSERT INTO products VALUES (4, 20.00);
INSERT INTO products VALUES (5, 20.01);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT64, balance NUMERIC(15, 2) );
INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, NULL);
INSERT INTO accounts VALUES (3, 0.00);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( amount NUMERIC(10, 2) );
INSERT INTO transactions VALUES (0.10);
INSERT INTO transactions VALUES (0.20);
INSERT INTO transactions VALUES (0.30);
DROP TABLE IF EXISTS values;
CREATE TABLE values (val NUMERIC(10, 2));
INSERT INTO values VALUES (10.00);
INSERT INTO values VALUES (20.00);
INSERT INTO values VALUES (30.00);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (price NUMERIC(10, 4));
INSERT INTO prices VALUES (1.5000);
INSERT INTO prices VALUES (1.50);
INSERT INTO prices VALUES (1.5);
INSERT INTO prices VALUES (2.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount NUMERIC(10, 2) );
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('B', 200.50);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (val NUMERIC(10, 2));
INSERT INTO amounts VALUES (100.00);
INSERT INTO amounts VALUES (-50.25);
INSERT INTO amounts VALUES (0.00);
INSERT INTO amounts VALUES (25.50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val NUMERIC(10, 2));
INSERT INTO data VALUES (100.00);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (50.00);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales ( day INT64, amount INT64 );
INSERT INTO daily_sales VALUES (1, 100);
INSERT INTO daily_sales VALUES (2, 150);
INSERT INTO daily_sales VALUES (3, 120);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( seq INT64, event STRING );
INSERT INTO events VALUES (1, 'start');
INSERT INTO events VALUES (2, 'process');
INSERT INTO events VALUES (3, 'end');
DROP TABLE IF EXISTS items;
CREATE TABLE items ( name STRING, value INT64 );
INSERT INTO items VALUES ('A', 10);
INSERT INTO items VALUES ('B', 10);
INSERT INTO items VALUES ('C', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (10.0);
INSERT INTO data VALUES (20.0);
INSERT INTO data VALUES (30.0);
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (val FLOAT64);
INSERT INTO samples VALUES (10.0);
INSERT INTO samples VALUES (20.0);
INSERT INTO samples VALUES (30.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_frames_test_select_253
SELECT id FROM products WHERE price BETWEEN 10.00 AND 20.00 ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_254
SELECT id FROM accounts WHERE balance > 0;
-- Tag: window_functions_window_functions_frames_test_select_255
SELECT id FROM accounts WHERE balance IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_256
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_frames_test_select_257
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_frames_test_select_258
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_frames_test_select_259
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_frames_test_select_260
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_frames_test_select_261
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_frames_test_select_262
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_frames_test_select_263
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_frames_test_select_264
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_265
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_266
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_frames_test_select_267
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_frames_test_select_268
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_frames_test_select_269
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_270
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_frames_test_select_271
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_272
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_273
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_274
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_275
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_frames_test_select_276
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_frames_test_select_277
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_frames_test_select_278
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_frames_test_select_279
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_frames_test_select_280
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_frames_test_select_281
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_frames_test_select_282
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_frames_test_select_283
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_frames_test_select_284
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_frames_test_select_285
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_frames_test_select_286
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_frames_test_select_287
SELECT * FROM users;
-- Tag: window_functions_window_functions_frames_test_select_288
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_frames_test_select_289
SELECT price FROM products;
-- Tag: window_functions_window_functions_frames_test_select_290
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_frames_test_select_291
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_frames_test_select_292
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_frames_test_select_293
SELECT * FROM users;
-- Tag: window_functions_window_functions_frames_test_select_294
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_frames_test_select_295
SELECT price FROM products;
-- Tag: window_functions_window_functions_frames_test_select_296
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_frames_test_select_297
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_frames_test_select_298
SELECT price FROM products;
-- Tag: window_functions_window_functions_frames_test_select_299
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_frames_test_select_300
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a BOOL, b BOOL);
INSERT INTO data VALUES (1, TRUE, TRUE);
INSERT INTO data VALUES (2, TRUE, NULL);
INSERT INTO data VALUES (3, FALSE, NULL);
INSERT INTO data VALUES (4, NULL, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val INT64);
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t2 VALUES (1, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t1 VALUES (2, 42);
INSERT INTO t2 VALUES (1);
DROP TABLE IF EXISTS left_table;
CREATE TABLE left_table (id INT64, val STRING);
DROP TABLE IF EXISTS right_table;
CREATE TABLE right_table (id INT64, data STRING);
INSERT INTO left_table VALUES (1, 'A');
INSERT INTO left_table VALUES (2, 'B');
INSERT INTO right_table VALUES (1, 'X');
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_frames_test_select_301
SELECT id FROM data WHERE NULL = 5;
-- Tag: window_functions_window_functions_frames_test_select_302
SELECT val FROM data WHERE val = NULL;
-- Tag: window_functions_window_functions_frames_test_select_303
SELECT val FROM data WHERE val IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_304
SELECT id FROM data WHERE a AND b ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_305
SELECT t1.id FROM t1 JOIN t2 ON t1.val = t2.val;
-- Tag: window_functions_window_functions_frames_test_select_306
SELECT t1.id FROM t1 JOIN t2 ON t1.id = t2.id WHERE t1.val IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_307
SELECT lt.id, lt.val, rt.data
FROM left_table lt
LEFT JOIN right_table rt ON lt.id = rt.id
ORDER BY lt.id;
-- Tag: window_functions_window_functions_frames_test_select_308
SELECT COUNT(*) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_309
SELECT COUNT(val) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_310
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_frames_test_select_311
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_frames_test_select_312
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_frames_test_select_313
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_314
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_315
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_frames_test_select_316
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_frames_test_select_317
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_frames_test_select_318
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_frames_test_select_319
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_320
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_321
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_322
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_frames_test_select_002
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_frames_test_select_323
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_frames_test_select_324
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_frames_test_select_325
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_frames_test_select_326
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_frames_test_select_327
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_frames_test_select_328
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_frames_test_select_329
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_frames_test_select_330
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_frames_test_select_331
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_frames_test_select_332
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_frames_test_select_333
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_frames_test_select_334
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_frames_test_select_335
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_frames_test_select_336
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_frames_test_select_337
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a BOOL, b BOOL);
INSERT INTO data VALUES (1, TRUE, TRUE);
INSERT INTO data VALUES (2, TRUE, NULL);
INSERT INTO data VALUES (3, FALSE, NULL);
INSERT INTO data VALUES (4, NULL, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val INT64);
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t2 VALUES (1, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t1 VALUES (2, 42);
INSERT INTO t2 VALUES (1);
DROP TABLE IF EXISTS left_table;
CREATE TABLE left_table (id INT64, val STRING);
DROP TABLE IF EXISTS right_table;
CREATE TABLE right_table (id INT64, data STRING);
INSERT INTO left_table VALUES (1, 'A');
INSERT INTO left_table VALUES (2, 'B');
INSERT INTO right_table VALUES (1, 'X');
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_frames_test_select_338
SELECT val FROM data WHERE val = NULL;
-- Tag: window_functions_window_functions_frames_test_select_339
SELECT val FROM data WHERE val IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_340
SELECT id FROM data WHERE a AND b ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_341
SELECT t1.id FROM t1 JOIN t2 ON t1.val = t2.val;
-- Tag: window_functions_window_functions_frames_test_select_342
SELECT t1.id FROM t1 JOIN t2 ON t1.id = t2.id WHERE t1.val IS NULL;
-- Tag: window_functions_window_functions_frames_test_select_343
SELECT lt.id, lt.val, rt.data
FROM left_table lt
LEFT JOIN right_table rt ON lt.id = rt.id
ORDER BY lt.id;
-- Tag: window_functions_window_functions_frames_test_select_344
SELECT COUNT(*) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_345
SELECT COUNT(val) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_346
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_frames_test_select_347
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_frames_test_select_348
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_frames_test_select_349
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_frames_test_select_350
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_frames_test_select_351
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_frames_test_select_352
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_frames_test_select_353
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_frames_test_select_354
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_frames_test_select_355
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_356
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_357
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_frames_test_select_358
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_frames_test_select_003
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_frames_test_select_359
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_frames_test_select_360
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_frames_test_select_361
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_frames_test_select_362
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_frames_test_select_363
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_frames_test_select_364
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_frames_test_select_365
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_frames_test_select_366
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_frames_test_select_367
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_frames_test_select_368
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_frames_test_select_369
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_frames_test_select_370
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_frames_test_select_371
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_frames_test_select_372
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_frames_test_select_373
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

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
-- Tag: window_functions_window_functions_frames_test_select_374
SELECT * FROM squared;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100), (2, 200), (3, 150);
DROP VIEW IF EXISTS sales_with_rank;
CREATE VIEW sales_with_rank AS
-- Tag: window_functions_window_functions_frames_test_select_375
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

REFRESH MATERIALIZED VIEW CONCURRENTLY data_view;
-- Tag: window_functions_window_functions_frames_test_select_376
SELECT * FROM view2;
-- Tag: window_functions_window_functions_frames_test_select_377
SELECT * FROM view2;
-- Tag: window_functions_window_functions_frames_test_select_378
SELECT * FROM dependent_view;
-- Tag: window_functions_window_functions_frames_test_select_379
SELECT * FROM empty_view;
-- Tag: window_functions_window_functions_frames_test_select_380
SELECT * FROM nullable_view ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_381
SELECT * FROM squares ORDER BY n;
-- Tag: window_functions_window_functions_frames_test_select_382
SELECT * FROM sales_with_rank ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_383
SELECT * FROM young_users;
-- Tag: window_functions_window_functions_frames_test_select_384
SELECT * FROM active_users;
-- Tag: window_functions_window_functions_frames_test_select_385
SELECT * FROM star_view;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
INSERT INTO scores VALUES (40);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
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

-- Tag: window_functions_window_functions_frames_test_select_386
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_387
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_388
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_389
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_390
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_391
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_392
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_frames_test_select_393
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_394
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
INSERT INTO scores VALUES (40);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
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

-- Tag: window_functions_window_functions_frames_test_select_395
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_396
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_397
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_398
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_399
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_400
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_frames_test_select_401
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_402
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_403
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_404
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_405
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_406
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_407
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_408
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_004
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_409
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_005
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_006
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_410
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_411
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_412
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_413
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_414
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_415
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_416
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_417
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_418
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_419
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_420
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_421
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_422
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_423
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_007
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_424
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_008
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_009
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_425
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_426
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_427
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_428
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_429
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_430
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_431
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_432
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_433
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_434
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_435
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_436
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_437
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_010
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_438
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_011
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_012
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_439
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_440
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_441
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_442
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_443
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_444
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_445
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_446
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_447
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_448
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_449
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_450
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_013
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_451
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_014
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_015
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_452
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_453
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_454
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_455
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_456
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_457
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_458
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_459
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_460
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_461
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_462
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_016
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_463
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_017
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_018
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_464
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_465
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_466
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_467
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_468
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_469
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_470
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_471
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_472
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
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

-- Tag: window_functions_window_functions_frames_test_select_473
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_frames_test_select_019
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_474
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_frames_test_select_020
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_frames_test_select_021
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_frames_test_select_475
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_476
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_frames_test_select_477
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_478
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_479
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_480
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_481
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_482
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_483
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_frames_test_select_484
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_frames_test_select_485
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_frames_test_select_486
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_frames_test_select_487
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_frames_test_select_488
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_frames_test_select_489
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_490
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_491
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_492
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_493
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_494
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_495
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_496
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_497
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_498
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_499
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_500
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_501
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_502
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_503
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_504
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_505
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_506
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_507
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_508
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_509
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_510
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_511
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_512
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_513
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_514
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_515
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_516
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_517
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_518
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_519
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_520
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_521
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_522
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_523
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_524
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_525
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_526
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_527
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_528
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_529
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_530
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_531
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_532
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_533
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_534
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_535
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_536
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_537
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_538
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_539
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_540
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_541
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_542
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_543
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_544
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_545
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_546
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_547
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_548
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_549
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_550
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_551
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_552
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_553
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_554
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_555
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_556
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_557
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_558
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_559
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_560
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_561
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_562
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_563
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_564
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
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

-- Tag: window_functions_window_functions_frames_test_select_565
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_566
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_567
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_568
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_frames_test_select_569
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_570
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_frames_test_select_571
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_frames_test_select_572
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_frames_test_select_573
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_frames_test_select_574
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_frames_test_select_575
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_frames_test_select_576
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_frames_test_select_577
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_578
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_579
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_580
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_frames_test_select_581
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_582
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_frames_test_select_583
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_584
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_frames_test_select_585
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_586
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_587
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_frames_test_select_588
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_589
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_frames_test_select_590
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_591
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_frames_test_select_592
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_593
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_frames_test_select_594
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_595
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_frames_test_select_596
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_597
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
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

-- Tag: window_functions_window_functions_frames_test_select_598
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_599
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_600
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_601
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_602
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_603
SELECT * FROM ( \
-- Tag: window_functions_window_functions_frames_test_select_604
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_605
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_606
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_607
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_608
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_609
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
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

-- Tag: window_functions_window_functions_frames_test_select_610
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_611
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_612
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_613
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_614
SELECT * FROM ( \
-- Tag: window_functions_window_functions_frames_test_select_615
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_616
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_617
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_618
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_619
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_620
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
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

-- Tag: window_functions_window_functions_frames_test_select_621
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_frames_test_select_622
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_623
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_frames_test_select_624
SELECT * FROM ( \
-- Tag: window_functions_window_functions_frames_test_select_625
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_frames_test_select_626
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_627
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_628
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_frames_test_select_629
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_frames_test_select_630
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

