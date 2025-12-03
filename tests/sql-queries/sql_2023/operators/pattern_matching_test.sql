-- Pattern Matching - SQL:2023
-- Description: Pattern matching: LIKE, SIMILAR TO, regex
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Alison');
INSERT INTO users VALUES (3, 'Bob');
INSERT INTO users VALUES (4, 'Albert');
-- Tag: operators_pattern_matching_test_select_001
SELECT name FROM users WHERE name LIKE 'Al%' ORDER BY name;

DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'document.txt');
INSERT INTO files VALUES (2, 'report.txt');
INSERT INTO files VALUES (3, 'notes.pdf');
INSERT INTO files VALUES (4, 'data.txt');

-- Tag: operators_pattern_matching_test_select_002
SELECT filename FROM files WHERE filename LIKE '%.txt' ORDER BY filename;

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64, name STRING);
INSERT INTO equipment VALUES (1, 'Apple iPhone');
INSERT INTO equipment VALUES (2, 'Samsung Phone');
INSERT INTO equipment VALUES (3, 'Google Pixel Phone');
INSERT INTO equipment VALUES (4, 'Apple Watch');

-- Tag: operators_pattern_matching_test_select_003
SELECT name FROM equipment WHERE name LIKE '%Phone%';

DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AA');

-- Tag: operators_pattern_matching_test_select_004
SELECT code FROM codes WHERE code LIKE 'A_';

DROP TABLE IF EXISTS serials;
CREATE TABLE serials (id INT64, serial STRING);
INSERT INTO serials VALUES (1, 'AB12');
INSERT INTO serials VALUES (2, 'CD34');
INSERT INTO serials VALUES (3, 'EF567');

-- Tag: operators_pattern_matching_test_select_005
SELECT serial FROM serials WHERE serial LIKE '____';

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);
INSERT INTO logs VALUES (1, 'ERROR: Failed to connect');
INSERT INTO logs VALUES (2, 'ERROR: Connection timeout');
INSERT INTO logs VALUES (3, 'INFO: Connected successfully');
INSERT INTO logs VALUES (4, 'ERROR: Failed authentication');

-- Tag: operators_pattern_matching_test_select_006
SELECT message FROM logs WHERE message LIKE 'ERROR:%Failed%';

DROP TABLE IF EXISTS exact;
CREATE TABLE exact (id INT64, name STRING);
INSERT INTO exact VALUES (1, 'Alice');
INSERT INTO exact VALUES (2, 'alice');

-- Tag: operators_pattern_matching_test_select_007
SELECT name FROM exact WHERE name LIKE 'Alice';

DROP TABLE IF EXISTS null_like;
CREATE TABLE null_like (id INT64, name STRING);
INSERT INTO null_like VALUES (1, 'item');
INSERT INTO null_like VALUES (2, NULL);

-- Tag: operators_pattern_matching_test_select_008
SELECT id FROM null_like WHERE name LIKE '%';

DROP TABLE IF EXISTS not_like_test;
CREATE TABLE not_like_test (id INT64, email STRING);
INSERT INTO not_like_test VALUES (1, 'alice@example.com');
INSERT INTO not_like_test VALUES (2, 'bob@test.com');

-- Tag: operators_pattern_matching_test_select_009
SELECT email FROM not_like_test WHERE email NOT LIKE '%@example.com';

DROP TABLE IF EXISTS empty_str;
CREATE TABLE empty_str (id INT64, value STRING);
INSERT INTO empty_str VALUES (1, '');
INSERT INTO empty_str VALUES (2, 'text');

-- Tag: operators_pattern_matching_test_select_010
SELECT id FROM empty_str WHERE value LIKE '';

-- BETWEEN OPERATOR - Range Matching

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 5);
INSERT INTO numbers VALUES (2, 10);
INSERT INTO numbers VALUES (3, 15);
INSERT INTO numbers VALUES (4, 20);
INSERT INTO numbers VALUES (5, 25);
-- Tag: operators_pattern_matching_test_select_011
SELECT id FROM numbers WHERE value BETWEEN 10 AND 20 ORDER BY id;

DROP TABLE IF EXISTS temperatures;
CREATE TABLE temperatures (id INT64, celsius FLOAT64);
INSERT INTO temperatures VALUES (1, -5.5);
INSERT INTO temperatures VALUES (2, 0.0);
INSERT INTO temperatures VALUES (3, 15.5);
INSERT INTO temperatures VALUES (4, 22.3);
INSERT INTO temperatures VALUES (5, 35.8);

-- Tag: operators_pattern_matching_test_select_012
SELECT id FROM temperatures WHERE celsius BETWEEN 0.0 AND 25.0 ORDER BY id;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, val INT64);
INSERT INTO bounds VALUES (1, 10);
INSERT INTO bounds VALUES (2, 15);
INSERT INTO bounds VALUES (3, 20);

-- Tag: operators_pattern_matching_test_select_013
SELECT id FROM bounds WHERE val BETWEEN 10 AND 20 ORDER BY id;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 45);
INSERT INTO scores VALUES (2, 55);
INSERT INTO scores VALUES (3, 75);
INSERT INTO scores VALUES (4, 85);
INSERT INTO scores VALUES (5, 95);

-- Tag: operators_pattern_matching_test_select_014
SELECT id FROM scores WHERE score NOT BETWEEN 60 AND 90 ORDER BY id;

DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'Alice');
INSERT INTO names VALUES (2, 'Bob');
INSERT INTO names VALUES (3, 'Charlie');
INSERT INTO names VALUES (4, 'David');
INSERT INTO names VALUES (5, 'Eve');

-- Tag: operators_pattern_matching_test_select_015
SELECT name FROM names WHERE name BETWEEN 'Bob' AND 'David' ORDER BY name;

DROP TABLE IF EXISTS null_between;
CREATE TABLE null_between (id INT64, value INT64);
INSERT INTO null_between VALUES (1, 10);
INSERT INTO null_between VALUES (2, NULL);
INSERT INTO null_between VALUES (3, 20);

-- Tag: operators_pattern_matching_test_select_016
SELECT id FROM null_between WHERE value BETWEEN 5 AND 15;

-- IN OPERATOR - Set Membership

DROP TABLE IF EXISTS in_test;
CREATE TABLE in_test (id INT64, value INT64);
INSERT INTO in_test VALUES (1, 10);
INSERT INTO in_test VALUES (2, 20);
INSERT INTO in_test VALUES (3, 30);
INSERT INTO in_test VALUES (4, 40);
INSERT INTO in_test VALUES (5, 50);
-- Tag: operators_pattern_matching_test_select_017
SELECT id FROM in_test WHERE value IN (10, 30, 50) ORDER BY id;

DROP TABLE IF EXISTS in_single;
CREATE TABLE in_single (id INT64, value INT64);
INSERT INTO in_single VALUES (1, 100);
INSERT INTO in_single VALUES (2, 200);
INSERT INTO in_single VALUES (3, 300);

-- Tag: operators_pattern_matching_test_select_018
SELECT id FROM in_single WHERE value IN (200);

DROP TABLE IF EXISTS in_strings;
CREATE TABLE in_strings (id INT64, name STRING);
INSERT INTO in_strings VALUES (1, 'Alice');
INSERT INTO in_strings VALUES (2, 'Bob');
INSERT INTO in_strings VALUES (3, 'Charlie');
INSERT INTO in_strings VALUES (4, 'David');

-- Tag: operators_pattern_matching_test_select_019
SELECT id FROM in_strings WHERE name IN ('Alice', 'Charlie', 'Eve') ORDER BY id;

DROP TABLE IF EXISTS in_floats;
CREATE TABLE in_floats (id INT64, price FLOAT64);
INSERT INTO in_floats VALUES (1, 9.99);
INSERT INTO in_floats VALUES (2, 19.99);
INSERT INTO in_floats VALUES (3, 29.99);
INSERT INTO in_floats VALUES (4, 39.99);

-- Tag: operators_pattern_matching_test_select_020
SELECT id FROM in_floats WHERE price IN (9.99, 29.99) ORDER BY id;

DROP TABLE IF EXISTS in_no_match;
CREATE TABLE in_no_match (id INT64, value INT64);
INSERT INTO in_no_match VALUES (1, 10);
INSERT INTO in_no_match VALUES (2, 20);
INSERT INTO in_no_match VALUES (3, 30);

-- Tag: operators_pattern_matching_test_select_021
SELECT id FROM in_no_match WHERE value IN (100, 200, 300);

DROP TABLE IF EXISTS in_null_col;
CREATE TABLE in_null_col (id INT64, value INT64);
INSERT INTO in_null_col VALUES (1, 10);
INSERT INTO in_null_col VALUES (2, NULL);
INSERT INTO in_null_col VALUES (3, 30);

-- Tag: operators_pattern_matching_test_select_022
SELECT id FROM in_null_col WHERE value IN (10, 20, 30);

DROP TABLE IF EXISTS in_null_list;
CREATE TABLE in_null_list (id INT64, value INT64);
INSERT INTO in_null_list VALUES (1, 10);
INSERT INTO in_null_list VALUES (2, 20);

-- Tag: operators_pattern_matching_test_select_023
SELECT id FROM in_null_list WHERE value IN (10, NULL);

DROP TABLE IF EXISTS not_in_test;
CREATE TABLE not_in_test (id INT64, value INT64);
INSERT INTO not_in_test VALUES (1, 10);
INSERT INTO not_in_test VALUES (2, 20);
INSERT NOT_in_test VALUES (3, 30);
INSERT INTO not_in_test VALUES (4, 40);

-- Tag: operators_pattern_matching_test_select_024
SELECT id FROM not_in_test WHERE value NOT IN (10, 30) ORDER BY id;

-- Note: NOT IN with NULL is a common SQL gotcha!
DROP TABLE IF EXISTS not_in_null;
CREATE TABLE not_in_null (id INT64, value INT64);
INSERT INTO not_in_null VALUES (1, 10);
INSERT INTO not_in_null VALUES (2, 20);

-- Tag: operators_pattern_matching_test_select_025
SELECT id FROM not_in_null WHERE value NOT IN (30, NULL);

-- Note: Some implementations may not support empty IN list
-- CREATE TABLE in_empty (id INT64, value INT64);
-- INSERT INTO in_empty VALUES (1, 10);
-- SELECT id FROM in_empty WHERE value IN ();

DROP TABLE IF EXISTS equal_bounds;
CREATE TABLE equal_bounds (id INT64, value INT64);
INSERT INTO equal_bounds VALUES (1, 10);
INSERT INTO equal_bounds VALUES (2, 20);

-- Tag: operators_pattern_matching_test_select_026
SELECT id FROM equal_bounds WHERE value BETWEEN 10 AND 10;

DROP TABLE IF EXISTS reversed;
CREATE TABLE reversed (id INT64, value INT64);
INSERT INTO reversed VALUES (1, 10);
INSERT INTO reversed VALUES (2, 20);

-- Tag: operators_pattern_matching_test_select_027
SELECT id FROM reversed WHERE value BETWEEN 20 AND 10;

DROP TABLE IF EXISTS complex;
CREATE TABLE complex (id INT64, name STRING, age INT64, status STRING);
INSERT INTO complex VALUES (1, 'Alice', 25, 'active');
INSERT INTO complex VALUES (2, 'Bob', 30, 'inactive');
INSERT INTO complex VALUES (3, 'Alison', 28, 'active');
INSERT INTO complex VALUES (4, 'Charlie', 35, 'pending');

-- Tag: operators_pattern_matching_test_select_028
SELECT * FROM complex WHERE name LIKE 'Al%' AND age BETWEEN 20 AND 30 AND status IN ('active', 'pending') ORDER BY id;
