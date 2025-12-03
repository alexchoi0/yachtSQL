-- Datetime Functions - SQL:2023
-- Description: Date and time functions: DATE, TIMESTAMP, INTERVAL
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_datetime_functions_test_select_001
SELECT CURRENT_DATE AS today;

-- Tag: functions_datetime_functions_test_select_002
SELECT CURRENT_DATE() AS today;

-- CURRENT_TIMESTAMP - Current timestamp with time zone
-- Tag: functions_datetime_functions_test_select_003
SELECT CURRENT_TIMESTAMP AS now;

-- Tag: functions_datetime_functions_test_select_004
SELECT CURRENT_TIMESTAMP() AS now;

-- NOW - Current timestamp (alias)
-- Tag: functions_datetime_functions_test_select_005
SELECT NOW() AS current_time;

-- CURRENT_TIME - Current time
-- Tag: functions_datetime_functions_test_select_006
SELECT CURRENT_TIME AS time_now;

-- ----------------------------------------------------------------------------
-- 2. EXTRACT FUNCTIONS
-- ----------------------------------------------------------------------------

-- EXTRACT - Extract date/time parts
-- Tag: functions_datetime_functions_test_select_007
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') AS year;

-- Tag: functions_datetime_functions_test_select_008
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') AS month;

-- Tag: functions_datetime_functions_test_select_009
SELECT EXTRACT(DAY FROM DATE '2024-03-15') AS day;

-- Tag: functions_datetime_functions_test_select_010
SELECT EXTRACT(QUARTER FROM DATE '2024-03-15') AS quarter;

-- Tag: functions_datetime_functions_test_select_011
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') AS week;

-- Tag: functions_datetime_functions_test_select_012
SELECT EXTRACT(DOW FROM DATE '2024-03-15') AS day_of_week;

-- Tag: functions_datetime_functions_test_select_013
SELECT EXTRACT(DOY FROM DATE '2024-03-15') AS day_of_year;

-- Tag: functions_datetime_functions_test_select_014
SELECT EXTRACT(ISODOW FROM DATE '2024-03-15') AS iso_day_of_week;

-- Extract from timestamp
-- Tag: functions_datetime_functions_test_select_015
SELECT EXTRACT(HOUR FROM TIMESTAMP '2024-03-15 14:30:45') AS hour;

-- Tag: functions_datetime_functions_test_select_016
SELECT EXTRACT(MINUTE FROM TIMESTAMP '2024-03-15 14:30:45') AS minute;

-- Tag: functions_datetime_functions_test_select_017
SELECT EXTRACT(SECOND FROM TIMESTAMP '2024-03-15 14:30:45.123') AS second;

-- Tag: functions_datetime_functions_test_select_018
SELECT EXTRACT(MILLISECOND FROM TIMESTAMP '2024-03-15 14:30:45.123456') AS millisecond;

-- Tag: functions_datetime_functions_test_select_019
SELECT EXTRACT(MICROSECOND FROM TIMESTAMP '2024-03-15 14:30:45.123456') AS microsecond;

-- Tag: functions_datetime_functions_test_select_020
SELECT EXTRACT(EPOCH FROM TIMESTAMP '2024-03-15 14:30:45') AS epoch;

-- DATE_PART - Alias for EXTRACT (PostgreSQL style)
-- Tag: functions_datetime_functions_test_select_021
SELECT DATE_PART('year', DATE '2024-03-15') AS year;

-- Tag: functions_datetime_functions_test_select_022
SELECT DATE_PART('month', DATE '2024-03-15') AS month;

-- Tag: functions_datetime_functions_test_select_023
SELECT DATE_PART('day', DATE '2024-03-15') AS day;

-- Tag: functions_datetime_functions_test_select_024
SELECT DATE_PART('hour', TIMESTAMP '2024-03-15 14:30:45') AS hour;

-- ----------------------------------------------------------------------------
-- 3. DATE_TRUNC FUNCTIONS
-- ----------------------------------------------------------------------------

-- Truncate to year
-- Tag: functions_datetime_functions_test_select_025
SELECT DATE_TRUNC('year', DATE '2024-03-15') AS truncated;

-- Tag: functions_datetime_functions_test_select_026
SELECT DATE_TRUNC('year', TIMESTAMP '2024-03-15 14:30:45') AS truncated;

-- Truncate to month
-- Tag: functions_datetime_functions_test_select_027
SELECT DATE_TRUNC('month', DATE '2024-03-15') AS truncated;

-- Tag: functions_datetime_functions_test_select_028
SELECT DATE_TRUNC('month', TIMESTAMP '2024-03-15 14:30:45') AS truncated;

-- Truncate to day
-- Tag: functions_datetime_functions_test_select_029
SELECT DATE_TRUNC('day', TIMESTAMP '2024-03-15 14:30:45') AS truncated;

-- Truncate to hour
-- Tag: functions_datetime_functions_test_select_030
SELECT DATE_TRUNC('hour', TIMESTAMP '2024-03-15 14:30:45') AS truncated;

-- Truncate to minute
-- Tag: functions_datetime_functions_test_select_031
SELECT DATE_TRUNC('minute', TIMESTAMP '2024-03-15 14:30:45') AS truncated;

-- Truncate to second
-- Tag: functions_datetime_functions_test_select_032
SELECT DATE_TRUNC('second', TIMESTAMP '2024-03-15 14:30:45.123456') AS truncated;

-- Truncate to quarter
-- Tag: functions_datetime_functions_test_select_033
SELECT DATE_TRUNC('quarter', DATE '2024-03-15') AS truncated;

-- Tag: functions_datetime_functions_test_select_034
SELECT DATE_TRUNC('quarter', DATE '2024-07-15') AS truncated;

-- Truncate to week
-- Tag: functions_datetime_functions_test_select_035
SELECT DATE_TRUNC('week', DATE '2024-03-15') AS truncated;

-- ----------------------------------------------------------------------------
-- 4. DATE ARITHMETIC
-- ----------------------------------------------------------------------------

-- DATE_ADD - Add interval to date
-- Tag: functions_datetime_functions_test_select_036
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 7 DAY) AS result;

-- Tag: functions_datetime_functions_test_select_037
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 1 MONTH) AS result;

-- Tag: functions_datetime_functions_test_select_038
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 1 YEAR) AS result;

-- Tag: functions_datetime_functions_test_select_039
SELECT DATE_ADD(TIMESTAMP '2024-01-15 10:30:00', INTERVAL 2 HOUR) AS result;

-- Tag: functions_datetime_functions_test_select_040
SELECT DATE_ADD(TIMESTAMP '2024-01-15 10:30:00', INTERVAL 45 MINUTE) AS result;

-- Tag: functions_datetime_functions_test_select_041
SELECT DATE_ADD(TIMESTAMP '2024-01-15 10:30:00', INTERVAL 30 SECOND) AS result;

-- DATE_SUB - Subtract interval from date
-- Tag: functions_datetime_functions_test_select_042
SELECT DATE_SUB(DATE '2024-01-15', INTERVAL 7 DAY) AS result;

-- Tag: functions_datetime_functions_test_select_043
SELECT DATE_SUB(DATE '2024-01-15', INTERVAL 1 MONTH) AS result;

-- Tag: functions_datetime_functions_test_select_044
SELECT DATE_SUB(DATE '2024-01-15', INTERVAL 1 YEAR) AS result;

-- Alternative syntax: date + INTERVAL
-- Tag: functions_datetime_functions_test_select_045
SELECT DATE '2024-01-15' + INTERVAL '7' DAY AS result;

-- Tag: functions_datetime_functions_test_select_046
SELECT DATE '2024-01-15' + INTERVAL '1' MONTH AS result;

-- Tag: functions_datetime_functions_test_select_047
SELECT DATE '2024-01-15' - INTERVAL '7' DAY AS result;

-- Tag: functions_datetime_functions_test_select_048
SELECT TIMESTAMP '2024-01-15 10:30:00' + INTERVAL '2' HOUR AS result;

-- Compound intervals
-- Tag: functions_datetime_functions_test_select_049
SELECT DATE '2024-01-15' + INTERVAL '1-2' YEAR TO MONTH AS result;

-- Tag: functions_datetime_functions_test_select_050
SELECT TIMESTAMP '2024-01-15 10:30:00' + INTERVAL '1:30:45' HOUR TO SECOND AS result;

-- ----------------------------------------------------------------------------
-- 5. DATE DIFFERENCE
-- ----------------------------------------------------------------------------

-- DATE_DIFF - Difference between dates
-- Tag: functions_datetime_functions_test_select_051
SELECT DATE_DIFF(DATE '2024-01-22', DATE '2024-01-15', DAY) AS days;

-- Tag: functions_datetime_functions_test_select_052
SELECT DATE_DIFF(DATE '2024-02-15', DATE '2024-01-15', MONTH) AS months;

-- Tag: functions_datetime_functions_test_select_053
SELECT DATE_DIFF(DATE '2025-01-15', DATE '2024-01-15', YEAR) AS years;

-- Tag: functions_datetime_functions_test_select_054
SELECT DATE_DIFF(TIMESTAMP '2024-01-15 12:30:00', TIMESTAMP '2024-01-15 10:30:00', HOUR) AS hours;

-- Tag: functions_datetime_functions_test_select_055
SELECT DATE_DIFF(TIMESTAMP '2024-01-15 11:15:00', TIMESTAMP '2024-01-15 10:30:00', MINUTE) AS minutes;

-- Tag: functions_datetime_functions_test_select_056
SELECT DATE_DIFF(TIMESTAMP '2024-01-15 10:30:30', TIMESTAMP '2024-01-15 10:30:00', SECOND) AS seconds;

-- DATE_DIFF - Simple day difference (MySQL style)
-- Tag: functions_datetime_functions_test_select_057
SELECT DATE_DIFF(DATE '2024-01-22', DATE '2024-01-15') AS days;

-- Tag: functions_datetime_functions_test_select_058
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-22') AS days;

-- AGE - Interval between dates (PostgreSQL)
-- Tag: functions_datetime_functions_test_select_059
SELECT AGE(DATE '2024-01-22', DATE '2024-01-15') AS interval_diff;

-- ----------------------------------------------------------------------------
-- 6. DATE FORMATTING
-- ----------------------------------------------------------------------------

-- DATE_FORMAT - Format date as string (MySQL style)
-- Tag: functions_datetime_functions_test_select_060
SELECT DATE_FORMAT(DATE '2024-03-15', '%Y-%m-%d') AS formatted;

-- Tag: functions_datetime_functions_test_select_061
SELECT DATE_FORMAT(DATE '2024-03-15', '%Y/%m/%d') AS formatted;

-- Tag: functions_datetime_functions_test_select_062
SELECT DATE_FORMAT(DATE '2024-03-15', '%d-%b-%Y') AS formatted;

-- Tag: functions_datetime_functions_test_select_063
SELECT DATE_FORMAT(TIMESTAMP '2024-03-15 14:30:45', '%Y-%m-%d %H:%i:%s') AS formatted;

-- Tag: functions_datetime_functions_test_select_064
SELECT DATE_FORMAT(TIMESTAMP '2024-03-15 14:30:45', '%W, %M %d, %Y') AS formatted;

-- TO_CHAR - Format date as string (PostgreSQL style)
-- Tag: functions_datetime_functions_test_select_065
SELECT TO_CHAR(DATE '2024-03-15', 'YYYY-MM-DD') AS formatted;

-- Tag: functions_datetime_functions_test_select_066
SELECT TO_CHAR(DATE '2024-03-15', 'DD-Mon-YYYY') AS formatted;

-- Tag: functions_datetime_functions_test_select_067
SELECT TO_CHAR(TIMESTAMP '2024-03-15 14:30:45', 'YYYY-MM-DD HH24:MI:SS') AS formatted;

-- Tag: functions_datetime_functions_test_select_068
SELECT TO_CHAR(TIMESTAMP '2024-03-15 14:30:45', 'Day, Month DD, YYYY') AS formatted;

-- FORMAT_DATE - BigQuery style
-- Tag: functions_datetime_functions_test_select_069
SELECT FORMAT_DATE('%Y-%m-%d', DATE '2024-03-15') AS formatted;

-- Tag: functions_datetime_functions_test_select_070
SELECT FORMAT_DATE('%B %d, %Y', DATE '2024-03-15') AS formatted;

-- ----------------------------------------------------------------------------
-- 7. DATE PARSING
-- ----------------------------------------------------------------------------

-- PARSE_DATE - Parse string to date (BigQuery)
-- Tag: functions_datetime_functions_test_select_071
SELECT PARSE_DATE('%Y-%m-%d', '2024-03-15') AS parsed;

-- Tag: functions_datetime_functions_test_select_072
SELECT PARSE_DATE('%d-%b-%Y', '15-Mar-2024') AS parsed;

-- PARSE_DATE - Parse string to date (MySQL)
-- Tag: functions_datetime_functions_test_select_073
SELECT PARSE_DATE('2024-03-15', '%Y-%m-%d') AS parsed;

-- Tag: functions_datetime_functions_test_select_074
SELECT PARSE_DATE('15/03/2024', '%d/%m/%Y') AS parsed;

-- TO_DATE - Parse string to date (PostgreSQL)
-- Tag: functions_datetime_functions_test_select_075
SELECT TO_DATE('2024-03-15', 'YYYY-MM-DD') AS parsed;

-- Tag: functions_datetime_functions_test_select_076
SELECT TO_DATE('15-Mar-2024', 'DD-Mon-YYYY') AS parsed;

-- PARSE_TIMESTAMP - Parse string to timestamp
-- Tag: functions_datetime_functions_test_select_077
SELECT PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', '2024-03-15 14:30:45') AS parsed;

-- TO_TIMESTAMP - Parse string to timestamp
-- Tag: functions_datetime_functions_test_select_078
SELECT TO_TIMESTAMP('2024-03-15 14:30:45', 'YYYY-MM-DD HH24:MI:SS') AS parsed;

-- ----------------------------------------------------------------------------
-- 8. DATE CONSTRUCTORS
-- ----------------------------------------------------------------------------

-- MAKE_DATE - Construct date from parts
-- Tag: functions_datetime_functions_test_select_079
SELECT MAKE_DATE(2024, 3, 15) AS constructed;

-- Tag: functions_datetime_functions_test_select_080
SELECT MAKE_DATE(2024, 1, 1) AS new_year;

-- MAKE_TIMESTAMP - Construct timestamp from parts
-- Tag: functions_datetime_functions_test_select_081
SELECT MAKE_TIMESTAMP(2024, 3, 15, 14, 30, 45) AS constructed;

-- Tag: functions_datetime_functions_test_select_082
SELECT MAKE_TIMESTAMP(2024, 3, 15, 14, 30, 45.123456) AS constructed;

-- MAKE_TIME - Construct time from parts
-- Tag: functions_datetime_functions_test_select_083
SELECT MAKE_TIME(14, 30, 45) AS constructed;

-- ----------------------------------------------------------------------------
-- 9. DATE/TIME COMPONENTS
-- ----------------------------------------------------------------------------

-- YEAR, MONTH, DAY - Extract components (simple functions)
-- Tag: functions_datetime_functions_test_select_084
SELECT YEAR(DATE '2024-03-15') AS year;

-- Tag: functions_datetime_functions_test_select_085
SELECT MONTH(DATE '2024-03-15') AS month;

-- Tag: functions_datetime_functions_test_select_086
SELECT DAY(DATE '2024-03-15') AS day;

-- Tag: functions_datetime_functions_test_select_087
SELECT DAYOFMONTH(DATE '2024-03-15') AS day;

-- Tag: functions_datetime_functions_test_select_088
SELECT DAYOFWEEK(DATE '2024-03-15') AS dow;

-- Tag: functions_datetime_functions_test_select_089
SELECT DAYOFYEAR(DATE '2024-03-15') AS doy;

-- HOUR, MINUTE, SECOND - Extract time components
-- Tag: functions_datetime_functions_test_select_090
SELECT HOUR(TIMESTAMP '2024-03-15 14:30:45') AS hour;

-- Tag: functions_datetime_functions_test_select_091
SELECT MINUTE(TIMESTAMP '2024-03-15 14:30:45') AS minute;

-- Tag: functions_datetime_functions_test_select_092
SELECT SECOND(TIMESTAMP '2024-03-15 14:30:45.123') AS second;

-- WEEKDAY, WEEK - Week-related functions
-- Tag: functions_datetime_functions_test_select_093
SELECT WEEKDAY(DATE '2024-03-15') AS weekday;

-- Tag: functions_datetime_functions_test_select_094
SELECT WEEK(DATE '2024-03-15') AS week;

-- Tag: functions_datetime_functions_test_select_095
SELECT ISOWEEK(DATE '2024-03-15') AS isoweek;

-- QUARTER - Get quarter
-- Tag: functions_datetime_functions_test_select_096
SELECT QUARTER(DATE '2024-03-15') AS quarter;

-- Tag: functions_datetime_functions_test_select_097
SELECT QUARTER(DATE '2024-07-15') AS quarter;

-- ----------------------------------------------------------------------------
-- 10. SPECIAL DATE FUNCTIONS
-- ----------------------------------------------------------------------------

-- LAST_DAY - Last day of month
-- Tag: functions_datetime_functions_test_select_098
SELECT LAST_DAY(DATE '2024-02-15') AS last_day;

-- Tag: functions_datetime_functions_test_select_099
SELECT LAST_DAY(DATE '2023-02-15') AS last_day;

-- Tag: functions_datetime_functions_test_select_100
SELECT LAST_DAY(DATE '2024-01-15') AS last_day;

-- FIRST_DAY - First day of period
-- Tag: functions_datetime_functions_test_select_101
SELECT DATE_TRUNC('month', DATE '2024-03-15') AS first_day;

-- DATE - Extract date from timestamp
-- Tag: functions_datetime_functions_test_select_102
SELECT DATE(TIMESTAMP '2024-03-15 14:30:45') AS date_part;

-- TIME - Extract time from timestamp
-- Tag: functions_datetime_functions_test_select_103
SELECT TIME(TIMESTAMP '2024-03-15 14:30:45') AS time_part;

-- ----------------------------------------------------------------------------
-- 11. INTERVAL LITERALS
-- ----------------------------------------------------------------------------

-- Create intervals
-- Tag: functions_datetime_functions_test_select_104
SELECT INTERVAL '1' DAY AS interval_day;

-- Tag: functions_datetime_functions_test_select_105
SELECT INTERVAL '1' MONTH AS interval_month;

-- Tag: functions_datetime_functions_test_select_106
SELECT INTERVAL '1' YEAR AS interval_year;

-- Tag: functions_datetime_functions_test_select_107
SELECT INTERVAL '2:30:00' HOUR TO SECOND AS interval_time;

-- Tag: functions_datetime_functions_test_select_108
SELECT INTERVAL '1-6' YEAR TO MONTH AS interval_period;

-- ----------------------------------------------------------------------------
-- 12. INTEGRATION SCENARIOS
-- ----------------------------------------------------------------------------

-- Age calculation
-- Tag: functions_datetime_functions_test_select_109
SELECT DATE_DIFF(CURRENT_DATE, DATE '1990-05-15', YEAR) AS age_years;

-- Business days calculation (simplified)
-- Tag: functions_datetime_functions_test_select_110
SELECT DATE_DIFF(DATE '2024-01-22', DATE '2024-01-15', DAY) AS calendar_days;

-- First and last day of current month
-- Tag: functions_datetime_functions_test_select_111
SELECT DATE_TRUNC('month', CURRENT_DATE) AS first_day,
       LAST_DAY(CURRENT_DATE) AS last_day;

-- Extract year-month for grouping
-- Tag: functions_datetime_functions_test_select_112
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') * 100 + EXTRACT(MONTH FROM DATE '2024-03-15') AS year_month;

-- Time since epoch
-- Tag: functions_datetime_functions_test_select_113
SELECT EXTRACT(EPOCH FROM TIMESTAMP '2024-01-01 00:00:00') AS seconds_since_epoch;

-- NULL handling
-- Tag: functions_datetime_functions_test_select_114
SELECT EXTRACT(YEAR FROM NULL) AS year,
       DATE_ADD(NULL, INTERVAL 1 DAY) AS added,
       DATE_DIFF(NULL, CURRENT_DATE, DAY) AS diff;

-- Date range check
-- Tag: functions_datetime_functions_test_select_115
SELECT DATE '2024-03-15' BETWEEN DATE '2024-01-01' AND DATE '2024-12-31' AS is_in_range;

-- End of quarter calculation
-- Tag: functions_datetime_functions_test_select_116
SELECT DATE_TRUNC('quarter', DATE '2024-03-15') + INTERVAL '3' MONTH - INTERVAL '1' DAY AS quarter_end;

-- End of Date/Time Functions Tests
