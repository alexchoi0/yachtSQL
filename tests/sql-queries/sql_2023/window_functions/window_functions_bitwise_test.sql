-- Window Functions Bitwise - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, 10), (3, 14);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, flag BOOL);
INSERT INTO test VALUES
('A', TRUE), ('A', TRUE), ('A', TRUE),
('B', TRUE), ('B', FALSE), ('B', TRUE);
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

-- Tag: window_functions_window_functions_bitwise_test_select_001
SELECT BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or,
BIT_XOR(value) as bit_xor
FROM test;
-- Tag: window_functions_window_functions_bitwise_test_select_002
SELECT category
FROM test
GROUP BY category
HAVING BOOL_AND(flag) = TRUE;
-- Tag: window_functions_window_functions_bitwise_test_select_003
SELECT category,
BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_bitwise_test_select_004
SELECT BOOL_AND(flag) as bool_and,
BOOL_OR(NOT flag) as or_not
FROM test;
-- Tag: window_functions_window_functions_bitwise_test_select_005
SELECT BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test;
-- Tag: window_functions_window_functions_bitwise_test_select_006
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_bitwise_test_select_007
SELECT BIT_AND(value) FROM test;

