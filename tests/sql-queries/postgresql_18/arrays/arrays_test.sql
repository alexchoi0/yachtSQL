-- ============================================================================
-- Arrays - PostgreSQL 18
-- ============================================================================
-- Source: Migrated from date_time_functions_advanced.rs
-- Description: ARRAY data type and array manipulation functions
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (name STRING, start_date DATE, duration_days INT64);
INSERT INTO projects VALUES ('Project A', DATE '2024-01-01', 90);
DROP TABLE IF EXISTS events;
CREATE TABLE events (name STRING, event_time TIMESTAMP);
INSERT INTO events VALUES ('Event C', TIMESTAMP '2024-01-15 15:00:00');
INSERT INTO events VALUES ('Event A', TIMESTAMP '2024-01-15 10:00:00');
INSERT INTO events VALUES ('Event B', TIMESTAMP '2024-01-15 12:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT name, start_date, DATE_ADD(start_date, INTERVAL duration_days DAY) AS end_date, DATE_DIFF(DATE_ADD(start_date, INTERVAL duration_days DAY), CURRENT_DATE(), DAY) AS days_remaining FROM projects;
SELECT name FROM events ORDER BY event_time;
SELECT DATE_ADD(DATE '2024-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2023-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2024-01-31', INTERVAL 1 MONTH) AS result;
SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_timestamp_ordering
-- Source: date_time_functions_advanced.rs:622
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (name STRING, event_time TIMESTAMP);
INSERT INTO events VALUES ('Event C', TIMESTAMP '2024-01-15 15:00:00');
INSERT INTO events VALUES ('Event A', TIMESTAMP '2024-01-15 10:00:00');
INSERT INTO events VALUES ('Event B', TIMESTAMP '2024-01-15 12:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT name FROM events ORDER BY event_time;
SELECT DATE_ADD(DATE '2024-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2023-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2024-01-31', INTERVAL 1 MONTH) AS result;
SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_leap_year_february_29
-- Source: date_time_functions_advanced.rs:649
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(DATE '2024-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2023-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2024-01-31', INTERVAL 1 MONTH) AS result;
SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_non_leap_year_february
-- Source: date_time_functions_advanced.rs:659
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(DATE '2023-02-28', INTERVAL 1 DAY) AS result;
SELECT DATE_ADD(DATE '2024-01-31', INTERVAL 1 MONTH) AS result;
SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_month_end_handling
-- Source: date_time_functions_advanced.rs:669
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(DATE '2024-01-31', INTERVAL 1 MONTH) AS result;
SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_year_boundary_crossing
-- Source: date_time_functions_advanced.rs:679
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(DATE '2023-12-31', INTERVAL 1 DAY) AS result;
SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_large_date_diff
-- Source: date_time_functions_advanced.rs:689
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_DIFF(DATE '2024-12-31', DATE '2000-01-01', DAY) AS diff;
SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_date_range_generation
-- Source: date_time_functions_advanced.rs:699
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(DATE '2024-01-01', INTERVAL n DAY) AS date FROM UNNEST(GENERATE_ARRAY(0, 6)) AS n ORDER BY date;
SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;
