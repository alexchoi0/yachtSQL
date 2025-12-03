-- Window Functions Errors - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_errors_test_select_001
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_errors_test_select_002
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_errors_test_select_003
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_errors_test_select_004
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_errors_test_select_005
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_errors_test_select_006
SELECT *;
-- Tag: window_functions_window_functions_errors_test_select_007
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_errors_test_select_008
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_errors_test_select_009
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_errors_test_select_010
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_errors_test_select_011
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_errors_test_select_012
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_errors_test_select_013
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_errors_test_select_014
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_errors_test_select_015
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_errors_test_select_016
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_errors_test_select_017
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_errors_test_select_001
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_errors_test_select_018
SELECT userid FROM users;
-- Tag: window_functions_window_functions_errors_test_select_019
SELECT * FROM user;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);

-- Tag: window_functions_window_functions_errors_test_select_020
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

