-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/timestamp_with_time_zone_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic TIMESTAMPTZ with UTC offset
-- Expected: Parsed and stored as UTC
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+05:00' AS ts;
-- Result: 2024-01-15 05:00:00+00:00 (converted to UTC)

-- Test: TIMESTAMPTZ with named timezone
-- Expected: Parse using IANA timezone database
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York' AS ts;
-- Result: 2024-01-15 15:00:00+00:00 (NY is UTC-5 in January)

-- Test: TIMESTAMPTZ with UTC
-- Expected: No conversion needed
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS ts;
-- Result: 2024-01-15 10:00:00+00:00

-- Test: ISO 8601 format
-- Expected: Standard format parsing
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15T10:00:00+05:00' AS ts;
-- Result: 2024-01-15 05:00:00+00:00

-- Test: AT TIME ZONE conversion
-- Expected: Convert UTC to another timezone
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'
       AT TIME ZONE 'America/New_York' AS ts;
-- Result: 2024-01-15 10:00:00-05:00 (displayed in NY time)

-- Test: AT TIME ZONE from plain TIMESTAMP
-- Expected: Interpret plain timestamp as being in specified zone
SELECT TIMESTAMP '2024-01-15 10:00:00'
       AT TIME ZONE 'America/New_York' AS ts;
-- Result: 2024-01-15 15:00:00+00:00 (10 AM NY = 3 PM UTC)

-- Test: AT TIME ZONE round trip
-- Expected: Convert through multiple timezones preserves moment
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
       AT TIME ZONE 'UTC'
       AT TIME ZONE 'America/New_York' AS ts;
-- Result: 2024-01-15 10:00:00-05:00 (back to original)

-- Test: AT TIME ZONE across multiple timezones
-- Expected: Convert NY time to Tokyo time
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
       AT TIME ZONE 'Asia/Tokyo' AS ts;
-- Result: 2024-01-16 00:00:00+09:00 (next day in Tokyo)

-- Test: DST spring forward (non-existent time)
-- Expected: Handle 2:30 AM that doesn't exist during DST transition
SELECT TIMESTAMP WITH TIME ZONE '2024-03-10 02:30:00 America/New_York' AS ts;
-- Result: Implementation chooses 3:30 AM EDT or errors

-- Test: DST fall back (ambiguous time)
-- Expected: Handle 1:30 AM that occurs twice
SELECT TIMESTAMP WITH TIME ZONE '2024-11-03 01:30:00 America/New_York' AS ts;
-- Result: Chooses standard time (EST) interpretation

-- Test: Arithmetic across DST boundary
-- Expected: Adding 24 hours across DST change
SELECT TIMESTAMP WITH TIME ZONE '2024-03-09 12:00:00 America/New_York'
       + INTERVAL '24' HOUR AS ts;
-- Result: 2024-03-10 12:00:00 EDT (absolute 24 hours)

-- Test: Add INTERVAL to TIMESTAMPTZ
-- Expected: Interval arithmetic
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
       + INTERVAL '2' HOUR AS ts;
-- Result: 2024-01-15 12:00:00+00:00

-- Test: Subtract INTERVAL from TIMESTAMPTZ
-- Expected: Interval arithmetic
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
       - INTERVAL '3' HOUR AS ts;
-- Result: 2024-01-15 07:00:00+00:00

-- Test: TIMESTAMPTZ difference returns INTERVAL
-- Expected: Subtract timestamps to get duration
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'
       - TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS time_diff;
-- Result: INTERVAL '5 hours'

-- Test: TIMESTAMPTZ difference across timezones
-- Expected: Difference calculated in UTC
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
       - TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS time_diff;
-- Result: INTERVAL '5 hours' (NY 10 AM EST = 3 PM UTC)

-- Test: Equality across timezones
-- Expected: Same UTC moment equals regardless of display zone
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
       = TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC' AS are_equal;
-- Result: true

-- Test: Less than comparison
-- Expected: Compare UTC moments
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
       < TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC' AS is_less;
-- Result: true

-- Test: ORDER BY TIMESTAMPTZ
-- Expected: Sort by UTC moment
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP WITH TIME ZONE);
INSERT INTO events VALUES
    (1, TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'),
    (2, TIMESTAMP WITH TIME ZONE '2024-01-15 08:00:00 America/New_York'),
    (3, TIMESTAMP WITH TIME ZONE '2024-01-15 20:00:00 Asia/Tokyo');

SELECT id FROM events ORDER BY event_time;
-- Result: Order by UTC: 1 (10:00), 3 (11:00), 2 (13:00)

-- Test: Compare TIMESTAMPTZ with plain TIMESTAMP
-- Expected: Plain timestamp interpreted as UTC
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
       > TIMESTAMP '2024-01-15 09:00:00' AS is_greater;
-- Result: true

-- Test: NULL TIMESTAMPTZ comparisons
-- Expected: NULL comparisons return NULL
SELECT CAST(NULL AS TIMESTAMP WITH TIME ZONE)
       = TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS result;
-- Result: NULL

-- Test: Store and retrieve NULL TIMESTAMPTZ
-- Expected: NULL handling in tables
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP WITH TIME ZONE);
INSERT INTO logs VALUES (1, NULL);

SELECT logged_at FROM logs WHERE id = 1;
-- Result: NULL

-- Test: Arithmetic with NULL TIMESTAMPTZ
-- Expected: NULL propagation
SELECT CAST(NULL AS TIMESTAMP WITH TIME ZONE) + INTERVAL '1' HOUR AS result;
-- Result: NULL

-- Test: Minimum TIMESTAMPTZ value
-- Expected: Epoch timestamp
SELECT TIMESTAMP WITH TIME ZONE '1970-01-01 00:00:00 UTC' AS min_ts;
-- Result: 1970-01-01 00:00:00+00:00

-- Test: Maximum TIMESTAMPTZ value
-- Expected: Far future timestamp
SELECT TIMESTAMP WITH TIME ZONE '2100-12-31 23:59:59 UTC' AS max_ts;
-- Result: 2100-12-31 23:59:59+00:00

-- Test: Microsecond precision
-- Expected: Fractional seconds preserved
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00.123456 UTC' AS precise_ts;
-- Result: 2024-01-15 10:00:00.123456+00:00

-- Test: Invalid timezone name error
-- Expected: Error for unknown timezone
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 Invalid/Timezone';
-- ERROR: time zone "Invalid/Timezone" not recognized

-- Test: Invalid timestamp format error
-- Expected: Parse error
SELECT TIMESTAMP WITH TIME ZONE 'not-a-timestamp UTC';
-- ERROR: invalid input syntax for type timestamp with time zone

-- Test: Invalid UTC offset error
-- Expected: Error for out-of-range offset
SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+25:00';
-- ERROR: time zone displacement out of range

-- Test: TIMESTAMPTZ in WHERE clause
-- Expected: Filter by timezone-aware timestamps
DROP TABLE IF EXISTS activity;
CREATE TABLE activity (id INT64, event_time TIMESTAMP WITH TIME ZONE);
INSERT INTO activity VALUES
    (1, TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'),
    (2, TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'),
    (3, TIMESTAMP WITH TIME ZONE '2024-01-15 20:00:00 UTC');

SELECT id FROM activity
WHERE event_time > TIMESTAMP WITH TIME ZONE '2024-01-15 12:00:00 UTC';
-- Result: ids 2, 3

-- Test: EXTRACT parts from TIMESTAMPTZ
-- Expected: Get date/time components
SELECT
    EXTRACT(YEAR FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS year,
    EXTRACT(MONTH FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS month,
    EXTRACT(DAY FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS day,
    EXTRACT(HOUR FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS hour;
-- Result: 2024, 1, 15, 10

-- Test: GROUP BY with DATE_TRUNC
-- Expected: Aggregate by hour
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, amount INT64, tx_time TIMESTAMP WITH TIME ZONE);
INSERT INTO transactions VALUES
    (1, 100, TIMESTAMP WITH TIME ZONE '2024-01-15 10:30:00 UTC'),
    (2, 200, TIMESTAMP WITH TIME ZONE '2024-01-15 10:45:00 UTC'),
    (3, 150, TIMESTAMP WITH TIME ZONE '2024-01-15 11:15:00 UTC');

SELECT DATE_TRUNC('hour', tx_time) AS hour, SUM(amount) AS total
FROM transactions
GROUP BY DATE_TRUNC('hour', tx_time)
ORDER BY hour;
-- Result: 10:00 hour (300), 11:00 hour (150)

-- Test: TIMESTAMPTZ in CASE expression
-- Expected: Conditional logic with timestamps
SELECT
    CASE
        WHEN TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
             > TIMESTAMP WITH TIME ZONE '2024-01-15 08:00:00 UTC'
        THEN 'Later'
        ELSE 'Earlier'
    END AS comparison;
-- Result: 'Later'

-- Test: CAST plain TIMESTAMP to TIMESTAMPTZ
-- Expected: Assume UTC timezone
SELECT CAST(TIMESTAMP '2024-01-15 10:00:00' AS TIMESTAMP WITH TIME ZONE) AS ts;
-- Result: 2024-01-15 10:00:00+00:00

-- Test: CAST TIMESTAMPTZ to plain TIMESTAMP
-- Expected: Strip timezone, convert to UTC
SELECT CAST(TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York' AS TIMESTAMP) AS ts;
-- Result: 2024-01-15 15:00:00 (UTC time, no zone)

-- Test: CAST STRING to TIMESTAMPTZ
-- Expected: Parse string with timezone
SELECT CAST('2024-01-15 10:00:00+05:00' AS TIMESTAMP WITH TIME ZONE) AS ts;
-- Result: 2024-01-15 05:00:00+00:00

-- Test: CAST TIMESTAMPTZ to STRING
-- Expected: Format as string
SELECT CAST(TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS STRING) AS ts_str;
-- Result: '2024-01-15 10:00:00+00:00'

-- Test: CURRENT_TIMESTAMP returns TIMESTAMPTZ
-- Expected: Current time with timezone
SELECT CURRENT_TIMESTAMP AS now;
-- Result: Current UTC time with +00:00

-- Test: EXTRACT timezone components
-- Expected: Get timezone hour and minute offsets
SELECT
    EXTRACT(TIMEZONE_HOUR FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+05:30') AS tz_hour,
    EXTRACT(TIMEZONE_MINUTE FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+05:30') AS tz_min;
-- Result: 5, 30

-- Test: FORMAT_TIMESTAMP with timezone
-- Expected: Format with timezone display
SELECT FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S %Z',
    TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York') AS formatted;
-- Result: Includes EST or EDT abbreviation

-- Test: Multiple timezones in single table
-- Expected: All stored as UTC, displayed based on session timezone
DROP TABLE IF EXISTS global_events;
CREATE TABLE global_events (
    id INT64,
    location STRING,
    event_time TIMESTAMP WITH TIME ZONE
);

INSERT INTO global_events VALUES
    (1, 'New York', TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'),
    (2, 'Tokyo', TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 Asia/Tokyo'),
    (3, 'London', TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 Europe/London');

-- All stored in UTC, compared correctly

-- Test: Performance with indexed TIMESTAMPTZ
-- Expected: Can create and use indexes
DROP TABLE IF EXISTS indexed_events;
CREATE TABLE indexed_events (
    id INT64,
    event_time TIMESTAMP WITH TIME ZONE
);

CREATE INDEX events_time_idx ON indexed_events(event_time);

-- Queries on event_time can use index efficiently
