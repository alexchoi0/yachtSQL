-- Subqueries - SQL:2023
-- Description: Subqueries in SELECT, WHERE, and FROM clauses
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 100);

-- Tag: subqueries_subqueries_test_select_001
SELECT t1.id FROM t1 CROSS APPLY (SELECT val FROM t2 WHERE t2.id = t1.id) sub;

DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);
INSERT INTO nullable VALUES (1, NULL);
ALTER TABLE nullable ADD COLUMN extra STRING;
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
ALTER TABLE evolving ADD COLUMN name STRING;
ALTER TABLE evolving ADD COLUMN email STRING;
ALTER TABLE evolving DROP COLUMN email;
ALTER TABLE evolving RENAME COLUMN name TO full_name;
ALTER TABLE evolving ADD CONSTRAINT pk PRIMARY KEY (id);
INSERT INTO evolving VALUES (1, 'Alice');
ALTER TABLE nonexistent ADD COLUMN col INT64;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
ALTER TABLE users INVALID OPERATION;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN name STRING;
DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_002
SELECT value FROM nullable WHERE id = 1;
-- Tag: subqueries_subqueries_test_select_003
SELECT * FROM evolving;
-- Tag: subqueries_subqueries_test_select_004
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_005
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_006
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_007
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
ALTER TABLE evolving ADD COLUMN name STRING;
ALTER TABLE evolving ADD COLUMN email STRING;
ALTER TABLE evolving DROP COLUMN email;
ALTER TABLE evolving RENAME COLUMN name TO full_name;
ALTER TABLE evolving ADD CONSTRAINT pk PRIMARY KEY (id);
INSERT INTO evolving VALUES (1, 'Alice');
ALTER TABLE nonexistent ADD COLUMN col INT64;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
ALTER TABLE users INVALID OPERATION;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN name STRING;
DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_008
SELECT * FROM evolving;
-- Tag: subqueries_subqueries_test_select_009
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_010
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_011
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_012
SELECT id, full_name, email FROM users WHERE id = 1;

ALTER TABLE nonexistent ADD COLUMN col INT64;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
ALTER TABLE users INVALID OPERATION;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN name STRING;
DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_013
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_014
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_015
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_016
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
ALTER TABLE users INVALID OPERATION;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN name STRING;
DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_017
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_018
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_019
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_020
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN name STRING;
DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_021
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_022
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_023
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_024
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS swap;
CREATE TABLE swap (a INT64, b INT64);
INSERT INTO swap VALUES (1, 2);
ALTER TABLE swap RENAME COLUMN a TO temp;
ALTER TABLE swap RENAME COLUMN b TO a;
ALTER TABLE swap RENAME COLUMN temp TO b;
DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_025
SELECT a, b FROM swap;
-- Tag: subqueries_subqueries_test_select_026
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_027
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_028
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS active;
CREATE TABLE active (id INT64, value INT64);
INSERT INTO active VALUES (1, 100);
ALTER TABLE active ADD COLUMN name STRING;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_029
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_030
SELECT * FROM active;
-- Tag: subqueries_subqueries_test_select_031
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
INSERT INTO users VALUES (1, 'Bob', 'bob@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_032
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price FLOAT64 CHECK (price > 0) );
ALTER TABLE products ADD COLUMN quantity INT64;
INSERT INTO products VALUES (1, -10.0, 5);
INSERT INTO products VALUES (2, 19.99, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_033
SELECT id, full_name, email FROM users WHERE id = 1;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users MODIFY COLUMN email STRING DEFAULT 'noemail@example.com';
ALTER TABLE users MODIFY COLUMN email STRING NOT NULL;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

-- Tag: subqueries_subqueries_test_select_034
SELECT id, full_name, email FROM users WHERE id = 1;

ALTER TABLE IF EXISTS nonexistent ADD COLUMN col INT64;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (value FLOAT64);
INSERT INTO floats VALUES (1.5);
INSERT INTO floats VALUES (5.5);
INSERT INTO floats VALUES (10.5);
INSERT INTO floats VALUES (15.5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
INSERT INTO words VALUES ('date');
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE '2024-01-01');
INSERT INTO events VALUES (DATE '2024-01-15');
INSERT INTO events VALUES (DATE '2024-02-01');
INSERT INTO events VALUES (DATE '2024-03-01');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_035
SELECT * FROM numbers WHERE value BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_036
SELECT * FROM floats WHERE value BETWEEN 5.0 AND 11.0;
-- Tag: subqueries_subqueries_test_select_037
SELECT * FROM words WHERE value BETWEEN 'banana' AND 'cherry';
-- Tag: subqueries_subqueries_test_select_038
SELECT * FROM events WHERE event_date BETWEEN DATE '2024-01-10' AND DATE '2024-02-10';
-- Tag: subqueries_subqueries_test_select_039
SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_040
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_041
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_042
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_043
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_044
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_045
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_046
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_047
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_048
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_049
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_050
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_051
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_052
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_053
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_054
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_055
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_056
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_057
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_058
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_059
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_060
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_061
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_062
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_063
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_064
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_065
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_066
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_067
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_068
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_069
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_070
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_071
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_072
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_073
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_074
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_075
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_076
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_077
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_078
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_079
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS floats;
CREATE TABLE floats (value FLOAT64);
INSERT INTO floats VALUES (1.5);
INSERT INTO floats VALUES (5.5);
INSERT INTO floats VALUES (10.5);
INSERT INTO floats VALUES (15.5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
INSERT INTO words VALUES ('date');
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE '2024-01-01');
INSERT INTO events VALUES (DATE '2024-01-15');
INSERT INTO events VALUES (DATE '2024-02-01');
INSERT INTO events VALUES (DATE '2024-03-01');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_080
SELECT * FROM floats WHERE value BETWEEN 5.0 AND 11.0;
-- Tag: subqueries_subqueries_test_select_081
SELECT * FROM words WHERE value BETWEEN 'banana' AND 'cherry';
-- Tag: subqueries_subqueries_test_select_082
SELECT * FROM events WHERE event_date BETWEEN DATE '2024-01-10' AND DATE '2024-02-10';
-- Tag: subqueries_subqueries_test_select_083
SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_084
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_085
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_086
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_087
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_088
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_089
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_090
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_091
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_092
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_093
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_094
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_095
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_096
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_097
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_098
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_099
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_100
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_101
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_102
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_103
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_104
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_105
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_106
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_107
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_108
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_109
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_110
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_111
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_112
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_113
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_114
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_115
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_116
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_117
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_118
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_119
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_120
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_121
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_122
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_123
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
INSERT INTO words VALUES ('date');
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE '2024-01-01');
INSERT INTO events VALUES (DATE '2024-01-15');
INSERT INTO events VALUES (DATE '2024-02-01');
INSERT INTO events VALUES (DATE '2024-03-01');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_124
SELECT * FROM words WHERE value BETWEEN 'banana' AND 'cherry';
-- Tag: subqueries_subqueries_test_select_125
SELECT * FROM events WHERE event_date BETWEEN DATE '2024-01-10' AND DATE '2024-02-10';
-- Tag: subqueries_subqueries_test_select_126
SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_127
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_128
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_129
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_130
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_131
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_132
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_133
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_134
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_135
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_136
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_137
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_138
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_139
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_140
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_141
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_142
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_143
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_144
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_145
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_146
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_147
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_148
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_149
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_150
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_151
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_152
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_153
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_154
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_155
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_156
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_157
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_158
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_159
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_160
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_161
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_162
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_163
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_164
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_165
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_166
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE '2024-01-01');
INSERT INTO events VALUES (DATE '2024-01-15');
INSERT INTO events VALUES (DATE '2024-02-01');
INSERT INTO events VALUES (DATE '2024-03-01');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_167
SELECT * FROM events WHERE event_date BETWEEN DATE '2024-01-10' AND DATE '2024-02-10';
-- Tag: subqueries_subqueries_test_select_168
SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_169
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_170
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_171
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_172
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_173
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_174
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_175
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_176
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_177
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_178
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_179
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_180
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_181
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_182
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_183
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_184
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_185
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_186
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_187
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_188
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_189
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_190
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_191
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_192
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_193
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_194
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_195
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_196
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_197
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_198
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_199
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_200
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_201
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_202
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_203
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_204
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_205
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_206
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_207
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_208
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_209
SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10;
-- Tag: subqueries_subqueries_test_select_210
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_211
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_212
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_213
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_214
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_215
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_216
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_217
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_218
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_219
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_220
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_221
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_222
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_223
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_224
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_225
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_226
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_227
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_228
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_229
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_230
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_231
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_232
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_233
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_234
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_235
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_236
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_237
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_238
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_239
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_240
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_241
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_242
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_243
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_244
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_245
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_246
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_247
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_248
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_249
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_250
SELECT * FROM numbers WHERE value BETWEEN 0 AND 10;
-- Tag: subqueries_subqueries_test_select_251
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_252
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_253
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_254
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_255
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_256
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_257
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_258
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_259
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_260
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_261
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_262
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_263
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_264
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_265
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_266
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_267
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_268
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_269
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_270
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_271
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_272
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_273
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_274
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_275
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_276
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_277
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_278
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_279
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_280
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_281
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_282
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_283
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_284
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_285
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_286
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_287
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_288
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_289
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_290
SELECT * FROM numbers WHERE value BETWEEN 10 AND 1;
-- Tag: subqueries_subqueries_test_select_291
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_292
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_293
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_294
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_295
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_296
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_297
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_298
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_299
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_300
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_301
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_302
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_303
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_304
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_305
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_306
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_307
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_308
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_309
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_310
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_311
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_312
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_313
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_314
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_315
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_316
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_317
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_318
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_319
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_320
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_321
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_322
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_323
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_324
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_325
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_326
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_327
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_328
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_329
SELECT * FROM numbers WHERE value BETWEEN 5 AND 5;
-- Tag: subqueries_subqueries_test_select_330
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_331
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_332
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_333
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_334
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_335
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_336
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_337
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_338
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_339
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_340
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_341
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_342
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_343
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_344
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_345
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_346
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_347
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_348
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_349
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_350
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_351
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_352
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_353
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_354
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_355
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_356
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_357
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_358
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_359
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_360
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_361
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_362
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_363
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_364
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_365
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_366
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
INSERT INTO numbers VALUES (5);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_367
SELECT * FROM numbers WHERE value IN (2, 4);
-- Tag: subqueries_subqueries_test_select_368
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_369
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_370
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_371
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_372
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_373
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_374
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_375
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_376
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_377
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_378
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_379
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_380
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_381
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_382
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_383
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_384
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_385
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_386
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_387
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_388
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_389
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_390
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_391
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_392
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_393
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_394
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_395
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_396
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_397
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_398
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_399
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_400
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_401
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_402
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_403
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('cherry');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_404
SELECT * FROM words WHERE value IN ('apple', 'cherry');
-- Tag: subqueries_subqueries_test_select_405
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_406
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_407
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_408
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_409
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_410
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_411
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_412
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_413
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_414
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_415
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_416
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_417
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_418
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_419
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_420
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_421
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_422
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_423
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_424
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_425
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_426
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_427
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_428
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_429
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_430
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_431
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_432
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_433
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_434
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_435
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_436
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_437
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_438
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_439
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_440
SELECT * FROM numbers WHERE value IN (1);
-- Tag: subqueries_subqueries_test_select_441
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_442
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_443
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_444
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_445
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_446
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_447
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_448
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_449
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_450
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_451
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_452
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_453
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_454
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_455
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_456
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_457
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_458
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_459
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_460
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_461
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_462
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_463
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_464
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_465
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_466
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_467
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_468
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_469
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_470
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_471
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_472
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_473
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_474
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_475
SELECT * FROM numbers WHERE value IN ();
-- Tag: subqueries_subqueries_test_select_476
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_477
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_478
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_479
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_480
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_481
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_482
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_483
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_484
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_485
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_486
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_487
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_488
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_489
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_490
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_491
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_492
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_493
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_494
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_495
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_496
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_497
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_498
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_499
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_500
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_501
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_502
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_503
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_504
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_505
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_506
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_507
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_508
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (4);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_509
SELECT * FROM numbers WHERE value NOT IN (2, 4);
-- Tag: subqueries_subqueries_test_select_510
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_511
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_512
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_513
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_514
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_515
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_516
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_517
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_518
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_519
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_520
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_521
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_522
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_523
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_524
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_525
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_526
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_527
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_528
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_529
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_530
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_531
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_532
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_533
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_534
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_535
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_536
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_537
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_538
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_539
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_540
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_541
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_542
SELECT * FROM numbers WHERE value IN (1, NULL);
-- Tag: subqueries_subqueries_test_select_543
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_544
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_545
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_546
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_547
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_548
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_549
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_550
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_551
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_552
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_553
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_554
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_555
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_556
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_557
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_558
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_559
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_560
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_561
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_562
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_563
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_564
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_565
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_566
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_567
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_568
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_569
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_570
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_571
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_572
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_573
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_574
SELECT * FROM numbers WHERE value IN (1, 2, 3);
-- Tag: subqueries_subqueries_test_select_575
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_576
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_577
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_578
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_579
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_580
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_581
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_582
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_583
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_584
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_585
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_586
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_587
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_588
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_589
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_590
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_591
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_592
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_593
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_594
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_595
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_596
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_597
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_598
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_599
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_600
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_601
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_602
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_603
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_604
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_605
SELECT * FROM numbers WHERE value NOT IN (3, NULL);
-- Tag: subqueries_subqueries_test_select_606
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_607
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_608
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_609
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_610
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_611
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_612
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_613
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_614
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_615
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_616
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_617
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_618
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_619
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_620
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_621
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_622
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_623
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_624
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_625
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_626
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_627
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_628
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_629
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_630
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_631
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_632
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_633
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_634
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_635
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_636
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_637
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_638
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_639
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_640
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_641
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_642
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_643
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_644
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_645
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_646
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_647
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_648
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_649
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_650
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_651
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_652
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_653
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_654
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_655
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_656
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_657
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_658
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_659
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_660
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_661
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_662
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_663
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_664
SELECT * FROM numbers WHERE value IN (1, 1, 1, 2);
-- Tag: subqueries_subqueries_test_select_665
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_666
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_667
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_668
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_669
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_670
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_671
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_672
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_673
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_674
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_675
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_676
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_677
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_678
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_679
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_680
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_681
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_682
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_683
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_684
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_685
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_686
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_687
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_688
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_689
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_690
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_691
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_692
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_693
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_694
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_695
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_696
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_697
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_698
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_699
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_700
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_701
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_702
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_703
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_704
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_705
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_706
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_707
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_708
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_709
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_710
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_711
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_712
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_713
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_714
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_715
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_716
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_717
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_718
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_719
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_720
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (2);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
INSERT INTO orders VALUES (3);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_721
SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_722
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_723
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_724
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_725
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_726
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_727
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_728
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_729
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_730
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_731
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_732
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_733
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_734
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_735
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_736
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_737
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_738
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_739
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_740
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_741
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_742
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_743
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_744
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_745
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_746
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_747
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_748
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_749
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_750
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_751
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_752
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_753
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_754
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_755
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_756
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_757
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_758
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_759
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_760
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_761
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_762
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_763
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_764
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_765
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_766
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_767
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_768
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_769
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_770
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_771
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_772
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_773
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (product_id INT64);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64);
INSERT INTO products VALUES (1);
INSERT INTO products VALUES (NULL);
INSERT INTO orders VALUES (1);
INSERT INTO orders VALUES (2);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('cat');
INSERT INTO words VALUES ('cut');
INSERT INTO words VALUES ('cart');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('pineapple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('hello world');
INSERT INTO words VALUES ('hello there');
INSERT INTO words VALUES ('goodbye');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('test.txt');
INSERT INTO words VALUES ('file.txt');
INSERT INTO words VALUES ('doc.pdf');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
INSERT INTO words VALUES ('apricot');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES (NULL);
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('');
INSERT INTO words VALUES ('a');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('APPLE');
INSERT INTO words VALUES ('apple');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('APPLY');
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('Apple');
INSERT INTO words VALUES ('Banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (NULL);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('apple');
INSERT INTO words VALUES ('application');
INSERT INTO words VALUES ('apricot');
INSERT INTO words VALUES ('banana');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('a1b2c3');
INSERT INTO words VALUES ('a1b3c3');
INSERT INTO words VALUES ('x1y2z3');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 3);
INSERT INTO numbers VALUES (10, 5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (5, 5);
INSERT INTO numbers VALUES (3, 7);
DROP TABLE IF EXISTS words;
CREATE TABLE words (value STRING);
INSERT INTO words VALUES ('50%');
INSERT INTO words VALUES ('100%');

-- Tag: subqueries_subqueries_test_select_774
SELECT * FROM orders WHERE product_id IN (SELECT id FROM products);
-- Tag: subqueries_subqueries_test_select_775
SELECT * FROM words WHERE value LIKE 'app%';
-- Tag: subqueries_subqueries_test_select_776
SELECT * FROM words WHERE value LIKE 'c_t';
-- Tag: subqueries_subqueries_test_select_777
SELECT * FROM words WHERE value LIKE '%app%';
-- Tag: subqueries_subqueries_test_select_778
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_779
SELECT * FROM words WHERE value LIKE 'hello%';
-- Tag: subqueries_subqueries_test_select_780
SELECT * FROM words WHERE value LIKE '%.txt';
-- Tag: subqueries_subqueries_test_select_781
SELECT * FROM words WHERE value LIKE 'apple';
-- Tag: subqueries_subqueries_test_select_782
SELECT * FROM words WHERE value NOT LIKE 'ap%';
-- Tag: subqueries_subqueries_test_select_783
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_784
SELECT * FROM words WHERE value LIKE '';
-- Tag: subqueries_subqueries_test_select_785
SELECT * FROM words WHERE value LIKE '%';
-- Tag: subqueries_subqueries_test_select_786
SELECT * FROM words WHERE value ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_787
SELECT * FROM words WHERE value ILIKE 'app%';
-- Tag: subqueries_subqueries_test_select_788
SELECT * FROM words WHERE value NOT ILIKE 'apple';
-- Tag: subqueries_subqueries_test_select_789
SELECT * FROM numbers WHERE value <> 2;
-- Tag: subqueries_subqueries_test_select_790
SELECT * FROM words WHERE value <> 'apple';
-- Tag: subqueries_subqueries_test_select_791
SELECT * FROM numbers WHERE value <> 1;
-- Tag: subqueries_subqueries_test_select_792
SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13);
-- Tag: subqueries_subqueries_test_select_793
SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot');
-- Tag: subqueries_subqueries_test_select_794
SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9);
-- Tag: subqueries_subqueries_test_select_795
SELECT * FROM words WHERE value LIKE 'a_b_c_';
-- Tag: subqueries_subqueries_test_select_796
SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15;
-- Tag: subqueries_subqueries_test_select_797
SELECT * FROM numbers WHERE a + b IN (10, 20);
-- Tag: subqueries_subqueries_test_select_798
SELECT * FROM words WHERE value LIKE '50%';

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Apple', 1.50), (2, 'Banana', 0.75), (3, 'Apricot', 2.00);
DROP TABLE IF EXISTS all_items;
CREATE TABLE all_items (id INT64);
DROP TABLE IF EXISTS sold_items;
CREATE TABLE sold_items (id INT64);
INSERT INTO all_items VALUES (1), (2), (3), (4);
INSERT INTO sold_items VALUES (2), (3);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, text STRING);
INSERT INTO mixed VALUES (1, 'test');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (123);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (500), (1000);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (message STRING);
INSERT INTO logs VALUES ('Error: File not found'), ('Warning: Low disk space'), ('Error: Connection timeout');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (5), (10);

-- Tag: subqueries_subqueries_test_select_799
SELECT id FROM products WHERE name LIKE 'A%' AND price BETWEEN 1.0 AND 2.0;
-- Tag: subqueries_subqueries_test_select_800
SELECT id FROM all_items WHERE id NOT IN (SELECT id FROM sold_items);
-- Tag: subqueries_subqueries_test_select_801
SELECT id FROM mixed WHERE id BETWEEN 'a' AND 'z';
-- Tag: subqueries_subqueries_test_select_802
SELECT value FROM numbers WHERE value IN (1, 'two', 3);
-- Tag: subqueries_subqueries_test_select_803
SELECT value FROM numbers WHERE value LIKE '12%';
-- Tag: subqueries_subqueries_test_select_804
SELECT message FROM logs WHERE message LIKE 'Error: %';
-- Tag: subqueries_subqueries_test_select_805
SELECT value FROM numbers WHERE value BETWEEN 5 AND 5;

DROP TABLE IF EXISTS all_items;
CREATE TABLE all_items (id INT64);
DROP TABLE IF EXISTS sold_items;
CREATE TABLE sold_items (id INT64);
INSERT INTO all_items VALUES (1), (2), (3), (4);
INSERT INTO sold_items VALUES (2), (3);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, text STRING);
INSERT INTO mixed VALUES (1, 'test');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (123);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (500), (1000);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (message STRING);
INSERT INTO logs VALUES ('Error: File not found'), ('Warning: Low disk space'), ('Error: Connection timeout');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (5), (10);

-- Tag: subqueries_subqueries_test_select_806
SELECT id FROM all_items WHERE id NOT IN (SELECT id FROM sold_items);
-- Tag: subqueries_subqueries_test_select_807
SELECT id FROM mixed WHERE id BETWEEN 'a' AND 'z';
-- Tag: subqueries_subqueries_test_select_808
SELECT value FROM numbers WHERE value IN (1, 'two', 3);
-- Tag: subqueries_subqueries_test_select_809
SELECT value FROM numbers WHERE value LIKE '12%';
-- Tag: subqueries_subqueries_test_select_810
SELECT message FROM logs WHERE message LIKE 'Error: %';
-- Tag: subqueries_subqueries_test_select_811
SELECT value FROM numbers WHERE value BETWEEN 5 AND 5;

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

DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: subqueries_subqueries_test_select_812
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: subqueries_subqueries_test_select_813
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: subqueries_subqueries_test_select_814
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: subqueries_subqueries_test_select_815
SELECT * FROM data WHERE value ~ '123';
-- Tag: subqueries_subqueries_test_select_816
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: subqueries_subqueries_test_select_817
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: subqueries_subqueries_test_select_818
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: subqueries_subqueries_test_select_819
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: subqueries_subqueries_test_select_820
SELECT * FROM data WHERE value ~ '123';
-- Tag: subqueries_subqueries_test_select_821
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: subqueries_subqueries_test_select_822
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

-- Tag: subqueries_subqueries_test_select_823
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: subqueries_subqueries_test_select_824
SELECT * FROM data WHERE value ~ '123';
-- Tag: subqueries_subqueries_test_select_825
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: subqueries_subqueries_test_select_826
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

-- Tag: subqueries_subqueries_test_select_827
SELECT * FROM data WHERE value ~ '123';
-- Tag: subqueries_subqueries_test_select_828
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: subqueries_subqueries_test_select_829
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

-- Tag: subqueries_subqueries_test_select_830
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: subqueries_subqueries_test_select_831
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

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

-- Tag: subqueries_subqueries_test_select_832
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: subqueries_subqueries_test_select_833
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: subqueries_subqueries_test_select_834
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: subqueries_subqueries_test_select_835
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: subqueries_subqueries_test_select_836
SELECT name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_837
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

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

-- Tag: subqueries_subqueries_test_select_838
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: subqueries_subqueries_test_select_839
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: subqueries_subqueries_test_select_840
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: subqueries_subqueries_test_select_841
SELECT name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_842
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

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

-- Tag: subqueries_subqueries_test_select_843
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: subqueries_subqueries_test_select_844
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: subqueries_subqueries_test_select_845
SELECT name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_846
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

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

-- Tag: subqueries_subqueries_test_select_847
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: subqueries_subqueries_test_select_848
SELECT name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_849
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

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

-- Tag: subqueries_subqueries_test_select_850
SELECT name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_851
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: subqueries_subqueries_test_select_852
SELECT (SELECT value FROM data) as single_value;
-- Tag: subqueries_subqueries_test_select_853
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: subqueries_subqueries_test_select_854
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: subqueries_subqueries_test_select_855
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: subqueries_subqueries_test_select_856
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_857
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_858
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_859
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: subqueries_subqueries_test_select_860
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_861
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_862
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_863
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_864
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_865
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_866
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_867
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: subqueries_subqueries_test_select_868
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_869
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_870
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_871
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_872
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_873
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_874
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: subqueries_subqueries_test_select_875
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_876
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_877
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_878
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_879
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_880
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_881
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_882
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_883
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_884
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_885
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_886
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_887
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: subqueries_subqueries_test_select_888
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_889
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_890
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_891
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_892
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: subqueries_subqueries_test_select_893
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_894
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_895
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_896
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: subqueries_subqueries_test_select_897
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_898
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_899
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: subqueries_subqueries_test_select_900
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: subqueries_subqueries_test_select_901
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value FLOAT64);
INSERT INTO test VALUES (1.0), (-1.0), (0.0);
DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
INSERT INTO dest SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, age INT64, active BOOL);
INSERT INTO test (id, name) VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b INT64, c INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_902
SELECT age, active FROM test WHERE id = 1;
-- Tag: subqueries_subqueries_test_select_903
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS source;
CREATE TABLE source (value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (value INT64);
INSERT INTO source VALUES (1), (2), (2), (3), (3), (3);
INSERT INTO dest SELECT DISTINCT value FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, age INT64, active BOOL);
INSERT INTO test (id, name) VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b INT64, c INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_904
SELECT age, active FROM test WHERE id = 1;
-- Tag: subqueries_subqueries_test_select_905
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING, age INT64, active BOOL);
INSERT INTO test (id, name) VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b INT64, c INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_906
SELECT age, active FROM test WHERE id = 1;
-- Tag: subqueries_subqueries_test_select_907
SELECT updated_at FROM config WHERE key = 'language';

INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b INT64, c INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_908
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64, b INT64, c INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_909
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS source;
CREATE TABLE source (a INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (x INT64, y INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_910
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS source;
CREATE TABLE source (text STRING);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (num INT64);
INSERT INTO source VALUES ('not a number');
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_911
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test VALUES (1, 2), (3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_912
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64, c INT64);
INSERT INTO test (a, b) VALUES (1, 2, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_913
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, z) VALUES (1, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_914
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, b INT64);
INSERT INTO test (a, a) VALUES (1, 2);
DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_915
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS raw_events;
CREATE TABLE raw_events ( event_id INT64, event_type STRING, value INT64, timestamp INT64 );
DROP TABLE IF EXISTS processed_events;
CREATE TABLE processed_events ( id INT64, category STRING, amount INT64 );
INSERT INTO raw_events VALUES (1, 'purchase', 100, 1000), (2, 'refund', -50, 1001), (3, 'purchase', 200, 1002);
INSERT INTO processed_events SELECT event_id, UPPER(event_type), value FROM raw_events WHERE event_type = 'purchase' AND value > 0;
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_916
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old ( user_id INT64, first_name STRING, last_name STRING );
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new ( id INT64, full_name STRING );
INSERT INTO users_old VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith');
INSERT INTO users_new SELECT user_id, CONCAT(first_name, ' ', last_name) FROM users_old;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_917
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, name STRING, price FLOAT64, in_stock BOOL );
INSERT INTO products VALUES (1, 'Widget', 19.99, true), (2, 'Gadget', 29.99, true), (3, 'Doohickey', 9.99, false), (4, 'Thingamajig', 39.99, true);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_918
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, version INT64, data STRING);
DROP TABLE IF EXISTS production;
CREATE TABLE production (id INT64, version INT64, data STRING);
INSERT INTO production VALUES (1, 1, 'v1'), (2, 1, 'v1');
INSERT INTO staging VALUES (1, 2, 'v2'), (2, 1, 'v1'), (3, 1, 'new');
INSERT INTO production SELECT s.id, s.version, s.data FROM staging s WHERE NOT EXISTS ( SELECT 1 FROM production p WHERE p.id = s.id AND p.version >= s.version );
DROP TABLE IF EXISTS config;
CREATE TABLE config ( key STRING, value STRING, updated_at INT64 );
INSERT INTO config VALUES ('theme', 'dark', 1000);
INSERT INTO config (key, value) VALUES ('language', 'en');

-- Tag: subqueries_subqueries_test_select_919
SELECT updated_at FROM config WHERE key = 'language';

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: subqueries_subqueries_test_select_920
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE TRUE);
-- Tag: subqueries_subqueries_test_select_921
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: subqueries_subqueries_test_select_922
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: subqueries_subqueries_test_select_923
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: subqueries_subqueries_test_select_924
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: subqueries_subqueries_test_select_925
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS normalized;
CREATE TABLE normalized (v NUMERIC);
INSERT INTO normalized SELECT CAST(123.45 AS NUMERIC);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (v NUMERIC);
INSERT INTO nullable VALUES (NULL);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_926
SELECT CAST(0.0001 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_927
SELECT CAST(999999999999999999 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_928
SELECT CAST(12345678901234567890.12345 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_929
SELECT v FROM normalized;
-- Tag: subqueries_subqueries_test_select_930
SELECT v FROM nullable;
-- Tag: subqueries_subqueries_test_select_931
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_932
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_933
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS normalized;
CREATE TABLE normalized (v NUMERIC);
INSERT INTO normalized SELECT CAST(123.45 AS NUMERIC);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (v NUMERIC);
INSERT INTO nullable VALUES (NULL);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_934
SELECT CAST(999999999999999999 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_935
SELECT CAST(12345678901234567890.12345 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_936
SELECT v FROM normalized;
-- Tag: subqueries_subqueries_test_select_937
SELECT v FROM nullable;
-- Tag: subqueries_subqueries_test_select_938
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_939
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_940
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS normalized;
CREATE TABLE normalized (v NUMERIC);
INSERT INTO normalized SELECT CAST(123.45 AS NUMERIC);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (v NUMERIC);
INSERT INTO nullable VALUES (NULL);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_941
SELECT CAST(12345678901234567890.12345 AS NUMERIC);
-- Tag: subqueries_subqueries_test_select_942
SELECT v FROM normalized;
-- Tag: subqueries_subqueries_test_select_943
SELECT v FROM nullable;
-- Tag: subqueries_subqueries_test_select_944
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_945
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_946
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS normalized;
CREATE TABLE normalized (v NUMERIC);
INSERT INTO normalized SELECT CAST(123.45 AS NUMERIC);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (v NUMERIC);
INSERT INTO nullable VALUES (NULL);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_947
SELECT v FROM normalized;
-- Tag: subqueries_subqueries_test_select_948
SELECT v FROM nullable;
-- Tag: subqueries_subqueries_test_select_949
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_950
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_951
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (v NUMERIC);
INSERT INTO nullable VALUES (NULL);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_952
SELECT v FROM nullable;
-- Tag: subqueries_subqueries_test_select_953
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_954
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_955
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_956
SELECT CASE WHEN 1=1 THEN CAST(100.00 AS NUMERIC) ELSE CAST(200.00 AS NUMERIC) END;
-- Tag: subqueries_subqueries_test_select_957
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_958
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_959
SELECT COALESCE(NULL, CAST(50.00 AS NUMERIC));
-- Tag: subqueries_subqueries_test_select_960
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (a NUMERIC);
INSERT INTO amounts VALUES (100.00);

-- Tag: subqueries_subqueries_test_select_961
SELECT (SELECT a FROM amounts) as amt;

DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim (x FLOAT64, y FLOAT64, z FLOAT64);
INSERT INTO multi_dim VALUES \ (1.0, 2.0, 3.0), \ (2.0, 4.0, 6.0), \ (3.0, 6.0, 9.0);

-- Tag: subqueries_subqueries_test_select_962
SELECT STDDEV_POP(doubled) as std \ FROM (SELECT value * 2 as doubled FROM raw_data);
-- Tag: subqueries_subqueries_test_select_963
SELECT \ CORR(x, y) as corr_xy, \ CORR(x, z) as corr_xz, \ CORR(y, z) as corr_yz \ FROM multi_dim;
-- Tag: subqueries_subqueries_test_select_964
SELECT \ STDDEV_POP(CASE WHEN value > 0 THEN value ELSE 0 END) as std_positive \ FROM conditional;
-- Tag: subqueries_subqueries_test_select_965
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as med \ FROM (SELECT value FROM limited ORDER BY id LIMIT 3);

DROP TABLE IF EXISTS multi_dim;
CREATE TABLE multi_dim (x FLOAT64, y FLOAT64, z FLOAT64);
INSERT INTO multi_dim VALUES \ (1.0, 2.0, 3.0), \ (2.0, 4.0, 6.0), \ (3.0, 6.0, 9.0);

-- Tag: subqueries_subqueries_test_select_966
SELECT \ CORR(x, y) as corr_xy, \ CORR(x, z) as corr_xz, \ CORR(y, z) as corr_yz \ FROM multi_dim;
-- Tag: subqueries_subqueries_test_select_967
SELECT \ STDDEV_POP(CASE WHEN value > 0 THEN value ELSE 0 END) as std_positive \ FROM conditional;
-- Tag: subqueries_subqueries_test_select_968
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as med \ FROM (SELECT value FROM limited ORDER BY id LIMIT 3);

-- Tag: subqueries_subqueries_test_select_969
SELECT \ STDDEV_POP(CASE WHEN value > 0 THEN value ELSE 0 END) as std_positive \ FROM conditional;
-- Tag: subqueries_subqueries_test_select_970
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as med \ FROM (SELECT value FROM limited ORDER BY id LIMIT 3);

-- Tag: subqueries_subqueries_test_select_971
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as med \ FROM (SELECT value FROM limited ORDER BY id LIMIT 3);

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: subqueries_subqueries_test_select_972
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: subqueries_subqueries_test_select_973
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: subqueries_subqueries_test_select_974
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2);
CREATE TABLE IF NOT EXISTS dest AS SELECT * FROM source;
CREATE TABLE IF NOT EXISTS dest AS SELECT * FROM source;
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2), (3), (4), (5);
CREATE TABLE paginated AS SELECT * FROM source LIMIT 2 OFFSET 2;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (n INT64);
INSERT INTO numbers VALUES (1), (5), (10), (15), (20);
CREATE TABLE filtered AS SELECT n FROM numbers WHERE n BETWEEN 5 AND 15;
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1), ('B', 2), ('C', 3), ('D', 4);
CREATE TABLE selected AS SELECT * FROM data WHERE category IN ('A', 'C');
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('Alice'), ('Bob'), ('Andrew'), ('Charlie');
CREATE TABLE a_names AS SELECT name FROM names WHERE name LIKE 'A%';
DROP TABLE IF EXISTS empty_source;
CREATE TABLE empty_source (id INT64, name STRING);
CREATE TABLE empty_dest AS SELECT * FROM empty_source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
CREATE TABLE filtered AS SELECT * FROM data WHERE id NOT IN (2, 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL), (2, 20), (3, NULL), (4, 40);
CREATE TABLE nulls_only AS SELECT * FROM data WHERE value IS NULL;
CREATE TABLE not_nulls AS SELECT * FROM data WHERE value IS NOT NULL;

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

-- Tag: subqueries_subqueries_test_select_975
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: subqueries_subqueries_test_select_976
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: subqueries_subqueries_test_select_977
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);
