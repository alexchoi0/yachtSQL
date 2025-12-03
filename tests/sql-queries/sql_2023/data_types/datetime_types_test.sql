-- Datetime Types - SQL:2023
-- Description: Date and time data types: DATE, TIME, TIMESTAMP
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id INT64,
    event_date DATE
);

-- Insert dates using DATE literal
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');

-- Tag: data_types_datetime_types_test_select_001
SELECT * FROM events;

-- TIMESTAMP Type - Basic

-- TIMESTAMP type for date and time
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id INT64,
    created_at TIMESTAMP
);

-- Insert timestamps using TIMESTAMP literal
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');

-- Tag: data_types_datetime_types_test_select_002
SELECT * FROM logs;

-- DATETIME Type - Basic

-- DATETIME type (similar to TIMESTAMP, no timezone)
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    id INT64,
    scheduled DATETIME
);

INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');

-- Tag: data_types_datetime_types_test_select_003
SELECT * FROM appointments;

-- TIME Type - Basic

-- TIME type for time of day
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (
    id INT64,
    time TIME
);

INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

-- Tag: data_types_datetime_types_test_select_004
SELECT * FROM schedules;

-- Date Literals - Various Formats

DROP TABLE IF EXISTS date_formats;
CREATE TABLE date_formats (
    id INT64,
    date_col DATE
);

-- ISO 8601 format (YYYY-MM-DD)
INSERT INTO date_formats VALUES (1, DATE '2024-01-15');
INSERT INTO date_formats VALUES (2, DATE '2024-12-31');
INSERT INTO date_formats VALUES (3, DATE '2024-02-29');  -- Leap year

-- Tag: data_types_datetime_types_test_select_005
SELECT * FROM date_formats;

-- Timestamp Literals - Various Formats

DROP TABLE IF EXISTS timestamp_formats;
CREATE TABLE timestamp_formats (
    id INT64,
    ts TIMESTAMP
);

-- Full timestamp with seconds
INSERT INTO timestamp_formats VALUES (1, TIMESTAMP '2024-01-15 10:30:00');

-- Timestamp with milliseconds
INSERT INTO timestamp_formats VALUES (2, TIMESTAMP '2024-01-15 10:30:00.123');

-- Timestamp with microseconds
INSERT INTO timestamp_formats VALUES (3, TIMESTAMP '2024-01-15 10:30:00.123456');

-- Tag: data_types_datetime_types_test_select_006
SELECT * FROM timestamp_formats;

-- Current Date/Time Functions

DROP TABLE IF EXISTS test_current;
CREATE TABLE test_current (
    id INT64
);

INSERT INTO test_current VALUES (1);

-- CURRENT_DATE() returns today's date
-- Tag: data_types_datetime_types_test_select_007
SELECT id, CURRENT_DATE() as today FROM test_current;

-- CURRENT_TIMESTAMP() returns current timestamp
-- Tag: data_types_datetime_types_test_select_008
SELECT id, CURRENT_TIMESTAMP() as now FROM test_current;

-- CURRENT_TIME() returns current time
-- Tag: data_types_datetime_types_test_select_009
SELECT id, CURRENT_TIME() as time_now FROM test_current;

-- Date Arithmetic - DATE_ADD

DROP TABLE IF EXISTS test_date_add;
CREATE TABLE test_date_add (
    id INT64,
    start_date DATE
);

INSERT INTO test_date_add VALUES (1, DATE '2024-01-15');

-- Add days
-- Tag: data_types_datetime_types_test_select_010
SELECT DATE_ADD(start_date, INTERVAL 7 DAY) as week_later
FROM test_date_add;

-- Add months
-- Tag: data_types_datetime_types_test_select_011
SELECT DATE_ADD(start_date, INTERVAL 1 MONTH) as month_later
FROM test_date_add;

-- Add years
-- Tag: data_types_datetime_types_test_select_012
SELECT DATE_ADD(start_date, INTERVAL 1 YEAR) as year_later
FROM test_date_add;

-- Date Arithmetic - DATE_SUB

DROP TABLE IF EXISTS test_date_sub;
CREATE TABLE test_date_sub (
    id INT64,
    end_date DATE
);

INSERT INTO test_date_sub VALUES (1, DATE '2024-01-15');

-- Subtract days
-- Tag: data_types_datetime_types_test_select_013
SELECT DATE_SUB(end_date, INTERVAL 7 DAY) as week_earlier
FROM test_date_sub;

-- Date Difference - DATE_DIFF

DROP TABLE IF EXISTS test_date_diff;
CREATE TABLE test_date_diff (
    id INT64,
    date1 DATE,
    date2 DATE
);

INSERT INTO test_date_diff VALUES (1, DATE '2024-01-01', DATE '2024-01-15');

-- Calculate difference in days
-- Tag: data_types_datetime_types_test_select_014
SELECT DATE_DIFF(date2, date1, DAY) as days_between
FROM test_date_diff;

-- EXTRACT Function - Date Parts

DROP TABLE IF EXISTS test_extract;
CREATE TABLE test_extract (
    id INT64,
    dt DATE
);

INSERT INTO test_extract VALUES (1, DATE '2024-03-15');

-- Extract year
-- Tag: data_types_datetime_types_test_select_015
SELECT EXTRACT(YEAR FROM dt) as year FROM test_extract;

-- Extract month
-- Tag: data_types_datetime_types_test_select_016
SELECT EXTRACT(MONTH FROM dt) as month FROM test_extract;

-- Extract day
-- Tag: data_types_datetime_types_test_select_017
SELECT EXTRACT(DAY FROM dt) as day FROM test_extract;

-- Extract day of week (1=Sunday, 7=Saturday)
-- Tag: data_types_datetime_types_test_select_018
SELECT EXTRACT(DAYOFWEEK FROM dt) as dow FROM test_extract;

-- Extract day of year (1-366)
-- Tag: data_types_datetime_types_test_select_019
SELECT EXTRACT(DAYOFYEAR FROM dt) as doy FROM test_extract;

-- EXTRACT Function - Time Parts

DROP TABLE IF EXISTS test_extract_time;
CREATE TABLE test_extract_time (
    id INT64,
    ts TIMESTAMP
);

INSERT INTO test_extract_time VALUES (1, TIMESTAMP '2024-03-15 14:30:45');

-- Extract hour
-- Tag: data_types_datetime_types_test_select_020
SELECT EXTRACT(HOUR FROM ts) as hour FROM test_extract_time;

-- Extract minute
-- Tag: data_types_datetime_types_test_select_021
SELECT EXTRACT(MINUTE FROM ts) as minute FROM test_extract_time;

-- Extract second
-- Tag: data_types_datetime_types_test_select_022
SELECT EXTRACT(SECOND FROM ts) as second FROM test_extract_time;

-- DATE_TRUNC Function - Truncate to Unit

DROP TABLE IF EXISTS test_date_trunc;
CREATE TABLE test_date_trunc (
    id INT64,
    dt DATE
);

INSERT INTO test_date_trunc VALUES (1, DATE '2024-03-15');

-- Truncate to year
-- Tag: data_types_datetime_types_test_select_023
SELECT DATE_TRUNC(dt, YEAR) as year_start FROM test_date_trunc;

-- Truncate to month
-- Tag: data_types_datetime_types_test_select_024
SELECT DATE_TRUNC(dt, MONTH) as month_start FROM test_date_trunc;

-- Truncate to week
-- Tag: data_types_datetime_types_test_select_025
SELECT DATE_TRUNC(dt, WEEK) as week_start FROM test_date_trunc;

-- FORMAT_DATE Function - Custom Formatting

DROP TABLE IF EXISTS test_format_date;
CREATE TABLE test_format_date (
    id INT64,
    dt DATE
);

INSERT INTO test_format_date VALUES (1, DATE '2024-03-15');

-- Format as string
-- Tag: data_types_datetime_types_test_select_026
SELECT FORMAT_DATE('%Y-%m-%d', dt) as formatted FROM test_format_date;

-- Tag: data_types_datetime_types_test_select_027
SELECT FORMAT_DATE('%B %d, %Y', dt) as formatted FROM test_format_date;

-- FORMAT_TIMESTAMP Function

DROP TABLE IF EXISTS test_format_timestamp;
CREATE TABLE test_format_timestamp (
    id INT64,
    ts TIMESTAMP
);

INSERT INTO test_format_timestamp VALUES (1, TIMESTAMP '2024-03-15 14:30:45');

-- Format timestamp
-- Tag: data_types_datetime_types_test_select_028
SELECT FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts) as formatted
FROM test_format_timestamp;

-- PARSE_DATE Function - Parse from String

DROP TABLE IF EXISTS test_parse_date;
CREATE TABLE test_parse_date (
    id INT64,
    date_str STRING
);

INSERT INTO test_parse_date VALUES (1, '2024-03-15');

-- Parse string to date
-- Tag: data_types_datetime_types_test_select_029
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as parsed
FROM test_parse_date;

-- PARSE_TIMESTAMP Function - Parse from String

DROP TABLE IF EXISTS test_parse_timestamp;
CREATE TABLE test_parse_timestamp (
    id INT64,
    ts_str STRING
);

INSERT INTO test_parse_timestamp VALUES (1, '2024-03-15 14:30:45');

-- Parse string to timestamp
-- Tag: data_types_datetime_types_test_select_030
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as parsed
FROM test_parse_timestamp;

-- Date Comparisons

DROP TABLE IF EXISTS test_date_comparison;
CREATE TABLE test_date_comparison (
    id INT64,
    event_date DATE
);

INSERT INTO test_date_comparison VALUES (1, DATE '2024-01-15');
INSERT INTO test_date_comparison VALUES (2, DATE '2024-06-15');
INSERT INTO test_date_comparison VALUES (3, DATE '2024-12-15');

-- Equality
-- Tag: data_types_datetime_types_test_select_031
SELECT * FROM test_date_comparison WHERE event_date = DATE '2024-06-15';

-- Greater than
-- Tag: data_types_datetime_types_test_select_032
SELECT * FROM test_date_comparison WHERE event_date > DATE '2024-06-01';

-- Between
-- Tag: data_types_datetime_types_test_select_033
SELECT * FROM test_date_comparison
WHERE event_date BETWEEN DATE '2024-01-01' AND DATE '2024-06-30';

-- Timestamp Comparisons

DROP TABLE IF EXISTS test_timestamp_comparison;
CREATE TABLE test_timestamp_comparison (
    id INT64,
    created TIMESTAMP
);

INSERT INTO test_timestamp_comparison VALUES (1, TIMESTAMP '2024-01-15 10:00:00');
INSERT INTO test_timestamp_comparison VALUES (2, TIMESTAMP '2024-01-15 14:00:00');
INSERT INTO test_timestamp_comparison VALUES (3, TIMESTAMP '2024-01-15 18:00:00');

-- Time-based filtering
-- Tag: data_types_datetime_types_test_select_034
SELECT * FROM test_timestamp_comparison
WHERE created > TIMESTAMP '2024-01-15 12:00:00';

-- NULL Handling

DROP TABLE IF EXISTS test_date_null;
CREATE TABLE test_date_null (
    id INT64,
    event_date DATE
);

INSERT INTO test_date_null VALUES (1, DATE '2024-01-15');
INSERT INTO test_date_null VALUES (2, NULL);

-- IS NULL
-- Tag: data_types_datetime_types_test_select_035
SELECT * FROM test_date_null WHERE event_date IS NULL;

-- IS NOT NULL
-- Tag: data_types_datetime_types_test_select_036
SELECT * FROM test_date_null WHERE event_date IS NOT NULL;

-- Date/Time with ORDER BY

DROP TABLE IF EXISTS test_date_order;
CREATE TABLE test_date_order (
    id INT64,
    event_date DATE
);

INSERT INTO test_date_order VALUES (3, DATE '2024-12-15');
INSERT INTO test_date_order VALUES (1, DATE '2024-01-15');
INSERT INTO test_date_order VALUES (2, DATE '2024-06-15');

-- Order by date ascending
-- Tag: data_types_datetime_types_test_select_037
SELECT * FROM test_date_order ORDER BY event_date ASC;

-- Order by date descending
-- Tag: data_types_datetime_types_test_select_038
SELECT * FROM test_date_order ORDER BY event_date DESC;

-- Date/Time Aggregations

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT64,
    sale_date DATE,
    amount INT64
);

INSERT INTO sales VALUES (1, DATE '2024-01-15', 100);
INSERT INTO sales VALUES (2, DATE '2024-01-20', 150);
INSERT INTO sales VALUES (3, DATE '2024-02-10', 200);

-- Group by month
-- Tag: data_types_datetime_types_test_select_001
SELECT
    DATE_TRUNC(sale_date, MONTH) as month,
    SUM(amount) as total_sales
FROM sales
GROUP BY DATE_TRUNC(sale_date, MONTH)
ORDER BY month;
-- (2024-01-01, 250)
-- (2024-02-01, 200)

-- Min/Max Dates

DROP TABLE IF EXISTS test_min_max_date;
CREATE TABLE test_min_max_date (
    event_date DATE
);

INSERT INTO test_min_max_date VALUES (DATE '2024-01-15');
INSERT INTO test_min_max_date VALUES (DATE '2024-06-15');
INSERT INTO test_min_max_date VALUES (DATE '2024-12-15');

-- Find earliest and latest dates
-- Tag: data_types_datetime_types_test_select_039
SELECT MIN(event_date) as earliest, MAX(event_date) as latest
FROM test_min_max_date;

-- Special Dates

DROP TABLE IF EXISTS test_special_dates;
CREATE TABLE test_special_dates (
    id INT64,
    special_date DATE
);

-- Leap year
INSERT INTO test_special_dates VALUES (1, DATE '2024-02-29');

-- Year boundaries
INSERT INTO test_special_dates VALUES (2, DATE '2024-01-01');
INSERT INTO test_special_dates VALUES (3, DATE '2024-12-31');

-- Month boundaries
INSERT INTO test_special_dates VALUES (4, DATE '2024-02-28');
INSERT INTO test_special_dates VALUES (5, DATE '2024-03-01');

-- Tag: data_types_datetime_types_test_select_040
SELECT * FROM test_special_dates;

-- End of File
