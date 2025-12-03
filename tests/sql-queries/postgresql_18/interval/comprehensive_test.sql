-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/interval_data_type_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic INTERVAL creation
-- Expected: Create interval values with different units
SELECT INTERVAL '1' HOUR as one_hour;
SELECT INTERVAL '2' DAY as two_days;
SELECT INTERVAL '3' MONTH as three_months;
SELECT INTERVAL '1' YEAR as one_year;

-- Test: INTERVAL with compound values
-- Expected: Multiple unit specifications
SELECT INTERVAL '1 day 2 hours 30 minutes' as duration;
SELECT INTERVAL '2 years 3 months 4 days' as long_duration;

-- Test: INTERVAL arithmetic - add to TIMESTAMP
-- Expected: Add interval to timestamp
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:00:00');

SELECT event_time,
       event_time + INTERVAL '1' HOUR as one_hour_later,
       event_time + INTERVAL '1' DAY as one_day_later
FROM events WHERE id = 1;
-- Result: Shows original time and calculated times

-- Test: INTERVAL arithmetic - subtract from TIMESTAMP
-- Expected: Subtract interval from timestamp
SELECT event_time,
       event_time - INTERVAL '2' HOUR as two_hours_earlier,
       event_time - INTERVAL '1' DAY as one_day_earlier
FROM events WHERE id = 1;

-- Test: TIMESTAMP difference returns INTERVAL
-- Expected: Subtracting timestamps gives interval
SELECT
    TIMESTAMP '2024-01-15 15:00:00' - TIMESTAMP '2024-01-15 10:00:00' as time_diff;
-- Result: INTERVAL '5 hours'

-- Test: INTERVAL comparison
-- Expected: Can compare intervals
SELECT
    INTERVAL '2' HOUR > INTERVAL '1' HOUR as comparison1,
    INTERVAL '1' DAY > INTERVAL '23' HOUR as comparison2;
-- Result: true, true

-- Test: INTERVAL addition
-- Expected: Add intervals together
SELECT
    INTERVAL '1' HOUR + INTERVAL '30' MINUTE as total_duration;
-- Result: INTERVAL '1 hour 30 minutes'

-- Test: INTERVAL subtraction
-- Expected: Subtract intervals
SELECT
    INTERVAL '2' HOUR - INTERVAL '30' MINUTE as remaining;
-- Result: INTERVAL '1 hour 30 minutes'

-- Test: INTERVAL multiplication
-- Expected: Multiply interval by scalar
SELECT
    INTERVAL '1' HOUR * 3 as triple_duration;
-- Result: INTERVAL '3 hours'

-- Test: INTERVAL division
-- Expected: Divide interval by scalar
SELECT
    INTERVAL '6' HOUR / 2 as half_duration;
-- Result: INTERVAL '3 hours'

-- Test: Negative INTERVAL
-- Expected: Intervals can be negative
SELECT
    TIMESTAMP '2024-01-15 10:00:00' + INTERVAL '-2' HOUR as result;
-- Result: 2024-01-15 08:00:00

-- Test: INTERVAL with YEAR-MONTH
-- Expected: Year and month intervals
SELECT INTERVAL '13' MONTH as months;
-- Result: INTERVAL '1 year 1 month'

-- Test: INTERVAL with fractional seconds
-- Expected: Microsecond precision
SELECT INTERVAL '1.5' SECOND as duration;
-- Result: INTERVAL '1.5 seconds'

-- Test: INTERVAL with days and time
-- Expected: Combined day and time components
SELECT INTERVAL '2 days 03:04:05' as duration;
-- Result: INTERVAL '2 days 3 hours 4 minutes 5 seconds'

-- Test: EXTRACT from INTERVAL
-- Expected: Get components from interval
SELECT
    EXTRACT(HOUR FROM INTERVAL '2 days 3 hours') as hours,
    EXTRACT(DAY FROM INTERVAL '2 days 3 hours') as days;
-- Result: hours=3, days=2

-- Test: NULL INTERVAL
-- Expected: NULL interval in arithmetic returns NULL
SELECT
    TIMESTAMP '2024-01-15 10:00:00' + CAST(NULL AS INTERVAL) as result;
-- Result: NULL

-- Test: INTERVAL in WHERE clause
-- Expected: Filter by time ranges
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled_time TIMESTAMP);
INSERT INTO appointments VALUES
    (1, TIMESTAMP '2024-01-15 09:00:00'),
    (2, TIMESTAMP '2024-01-15 11:00:00'),
    (3, TIMESTAMP '2024-01-15 14:00:00');

SELECT id FROM appointments
WHERE scheduled_time BETWEEN
    TIMESTAMP '2024-01-15 10:00:00' - INTERVAL '2' HOUR
    AND TIMESTAMP '2024-01-15 10:00:00' + INTERVAL '2' HOUR;
-- Result: ids within 2-hour window around 10:00

-- Test: INTERVAL in ORDER BY
-- Expected: Order by interval duration
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, duration INTERVAL);
INSERT INTO tasks VALUES
    (1, INTERVAL '2' HOUR),
    (2, INTERVAL '30' MINUTE),
    (3, INTERVAL '1' DAY);

SELECT id FROM tasks ORDER BY duration;
-- Result: id=2 (30 min), id=1 (2 hours), id=3 (1 day)

-- Test: INTERVAL with CURRENT_TIMESTAMP
-- Expected: Calculate relative times
SELECT
    CURRENT_TIMESTAMP as now,
    CURRENT_TIMESTAMP - INTERVAL '1' DAY as yesterday,
    CURRENT_TIMESTAMP + INTERVAL '1' WEEK as next_week;

-- Test: AGE function (returns INTERVAL)
-- Expected: Calculate age/difference between timestamps
SELECT AGE(TIMESTAMP '2024-01-15', TIMESTAMP '2024-01-01') as age;
-- Result: INTERVAL '14 days'

-- Test: JUSTIFY_DAYS function
-- Expected: Convert 30-day chunks to months
SELECT JUSTIFY_DAYS(INTERVAL '35 days') as justified;
-- Result: INTERVAL '1 month 5 days'

-- Test: JUSTIFY_HOURS function
-- Expected: Convert 24-hour chunks to days
SELECT JUSTIFY_HOURS(INTERVAL '27 hours') as justified;
-- Result: INTERVAL '1 day 3 hours'

-- Test: JUSTIFY_INTERVAL function
-- Expected: Normalize interval to standard form
SELECT JUSTIFY_INTERVAL(INTERVAL '27 hours 35 days') as justified;
-- Result: INTERVAL '1 month 6 days 3 hours'

-- Test: TO_CHAR with INTERVAL
-- Expected: Format interval as string
SELECT TO_CHAR(INTERVAL '2 days 3:04:05', 'DD HH24:MI:SS') as formatted;
-- Result: '02 03:04:05'

-- Test: CAST STRING to INTERVAL
-- Expected: Parse interval from string
SELECT CAST('2 hours 30 minutes' AS INTERVAL) as duration;
-- Result: INTERVAL '2:30:00'

-- Test: CAST INTERVAL to STRING
-- Expected: Convert interval to text
SELECT CAST(INTERVAL '2 days 3 hours' AS STRING) as text;
-- Result: '2 days 03:00:00'

-- Test: INTERVAL in aggregation
-- Expected: Sum intervals
DROP TABLE IF EXISTS time_logs;
CREATE TABLE time_logs (id INT64, duration INTERVAL);
INSERT INTO time_logs VALUES
    (1, INTERVAL '2' HOUR),
    (2, INTERVAL '3' HOUR),
    (3, INTERVAL '1' HOUR);

SELECT SUM(duration) as total_time FROM time_logs;
-- Result: INTERVAL '6 hours'

-- Test: INTERVAL in CASE expression
-- Expected: Conditional interval calculation
SELECT id,
    CASE
        WHEN id = 1 THEN INTERVAL '1' HOUR
        WHEN id = 2 THEN INTERVAL '2' HOUR
        ELSE INTERVAL '30' MINUTE
    END as duration
FROM appointments;

-- Test: Very long INTERVAL
-- Expected: Handle large time spans
SELECT INTERVAL '100 years' as long_interval;
SELECT INTERVAL '10000 days' as many_days;

-- Test: Very short INTERVAL
-- Expected: Handle microsecond precision
SELECT INTERVAL '0.000001' SECOND as microsecond;

-- Test: INTERVAL with DATE arithmetic
-- Expected: Add interval to DATE
SELECT DATE '2024-01-15' + INTERVAL '1' MONTH as next_month;
-- Result: DATE '2024-02-15'

-- Test: OVERLAPS with INTERVAL
-- Expected: Check if time ranges overlap
SELECT
    (TIMESTAMP '2024-01-15 10:00:00', INTERVAL '2' HOUR)
    OVERLAPS
    (TIMESTAMP '2024-01-15 11:00:00', INTERVAL '2' HOUR)
    as ranges_overlap;
-- Result: true

-- Test: INTERVAL with DEFAULT column value
-- Expected: Use interval as default
DROP TABLE IF EXISTS expiring_sessions;
CREATE TABLE expiring_sessions (
    id INT64,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP + INTERVAL '1' HOUR
);

INSERT INTO expiring_sessions (id) VALUES (1);
-- expires_at automatically set to 1 hour from now

-- Test: Business day calculation
-- Expected: Add only weekdays (requires complex logic)
-- Note: Requires function or complex CASE logic

-- Test: Month-end aware arithmetic
-- Expected: Adding month to Jan 31 handles Feb correctly
SELECT DATE '2024-01-31' + INTERVAL '1' MONTH as result;
-- Result: Varies by implementation (2024-02-29 or 2024-03-02)

-- Test: Leap year handling
-- Expected: Interval arithmetic respects leap years
SELECT DATE '2024-02-29' + INTERVAL '1' YEAR as next_year;
-- Result: 2025-02-28 (no leap day in 2025)

-- Test: DST transition with INTERVAL
-- Expected: Interval arithmetic handles DST correctly
-- Note: Depends on TIMESTAMPTZ, not TIMESTAMP

-- Test: ISO 8601 interval format
-- Expected: Parse standard interval format
SELECT INTERVAL 'P1Y2M3DT4H5M6S' as iso_interval;
-- Result: 1 year 2 months 3 days 4 hours 5 minutes 6 seconds
