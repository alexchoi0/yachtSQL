-- Views - SQL:2023
-- Description: Views and materialized views
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
ALTER TABLE users ADD COLUMN email STRING;
ALTER TABLE users ADD COLUMN age INT64;
ALTER TABLE users RENAME COLUMN name TO full_name;
ALTER TABLE users DROP COLUMN age;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
ALTER TABLE data ADD COLUMN status STRING DEFAULT 'ok';
ALTER TABLE ghost_table ADD COLUMN x INT64;
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64);
ALTER TABLE empty ADD COLUMN required STRING NOT NULL;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, quantity INT64, price FLOAT64);
INSERT INTO sales VALUES (1, 10, 5.0);
DROP VIEW IF EXISTS sales_total;
CREATE VIEW sales_total AS SELECT id, quantity * price AS total FROM sales;
ALTER TABLE sales ALTER COLUMN quantity TYPE FLOAT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: views_views_test_select_001
SELECT id, full_name, email FROM users;
-- Tag: views_views_test_select_002
SELECT * FROM data;
-- Tag: views_views_test_select_003
SELECT * FROM sales_total;
-- Tag: views_views_test_select_004
SELECT * FROM test;
-- Tag: views_views_test_select_005
SELECT ID, Name, email FROM Users;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
ALTER TABLE data ADD COLUMN status STRING DEFAULT 'ok';
ALTER TABLE ghost_table ADD COLUMN x INT64;
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64);
ALTER TABLE empty ADD COLUMN required STRING NOT NULL;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, quantity INT64, price FLOAT64);
INSERT INTO sales VALUES (1, 10, 5.0);
DROP VIEW IF EXISTS sales_total;
CREATE VIEW sales_total AS SELECT id, quantity * price AS total FROM sales;
ALTER TABLE sales ALTER COLUMN quantity TYPE FLOAT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: views_views_test_select_006
SELECT * FROM data;
-- Tag: views_views_test_select_007
SELECT * FROM sales_total;
-- Tag: views_views_test_select_008
SELECT * FROM test;
-- Tag: views_views_test_select_009
SELECT ID, Name, email FROM Users;

ALTER TABLE ghost_table ADD COLUMN x INT64;
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64);
ALTER TABLE empty ADD COLUMN required STRING NOT NULL;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, quantity INT64, price FLOAT64);
INSERT INTO sales VALUES (1, 10, 5.0);
DROP VIEW IF EXISTS sales_total;
CREATE VIEW sales_total AS SELECT id, quantity * price AS total FROM sales;
ALTER TABLE sales ALTER COLUMN quantity TYPE FLOAT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: views_views_test_select_010
SELECT * FROM sales_total;
-- Tag: views_views_test_select_011
SELECT * FROM test;
-- Tag: views_views_test_select_012
SELECT ID, Name, email FROM Users;

DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64);
ALTER TABLE empty ADD COLUMN required STRING NOT NULL;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, quantity INT64, price FLOAT64);
INSERT INTO sales VALUES (1, 10, 5.0);
DROP VIEW IF EXISTS sales_total;
CREATE VIEW sales_total AS SELECT id, quantity * price AS total FROM sales;
ALTER TABLE sales ALTER COLUMN quantity TYPE FLOAT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: views_views_test_select_013
SELECT * FROM sales_total;
-- Tag: views_views_test_select_014
SELECT * FROM test;
-- Tag: views_views_test_select_015
SELECT ID, Name, email FROM Users;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, quantity INT64, price FLOAT64);
INSERT INTO sales VALUES (1, 10, 5.0);
DROP VIEW IF EXISTS sales_total;
CREATE VIEW sales_total AS SELECT id, quantity * price AS total FROM sales;
ALTER TABLE sales ALTER COLUMN quantity TYPE FLOAT64;
DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: views_views_test_select_016
SELECT * FROM sales_total;
-- Tag: views_views_test_select_017
SELECT * FROM test;
-- Tag: views_views_test_select_018
SELECT ID, Name, email FROM Users;

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

-- Tag: views_views_test_select_019
SELECT * FROM wide;
-- Tag: views_views_test_select_020
SELECT * FROM target ORDER BY id;
-- Tag: views_views_test_select_021
SELECT * FROM second_ctas;

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

-- Tag: views_views_test_select_022
SELECT * FROM target ORDER BY id;
-- Tag: views_views_test_select_023
SELECT * FROM second_ctas;

DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 100), (2, 200), (3, 300);
CREATE TABLE first_ctas AS SELECT * FROM source WHERE value > 100;
CREATE TABLE second_ctas AS SELECT * FROM first_ctas WHERE id > 2;

-- Tag: views_views_test_select_024
SELECT * FROM second_ctas;

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

-- Tag: views_views_test_select_025
SELECT * FROM young_users;
-- Tag: views_views_test_select_026
SELECT * FROM active_users;
-- Tag: views_views_test_select_027
SELECT * FROM star_view;

DROP TABLE IF EXISTS columns_test;
CREATE TABLE columns_test (a INT64, b STRING, c FLOAT64);
INSERT INTO columns_test VALUES (1, 'test', 1.5);
DROP VIEW IF EXISTS star_view;
CREATE VIEW star_view AS SELECT * FROM columns_test;

-- Tag: views_views_test_select_028
SELECT * FROM star_view;
