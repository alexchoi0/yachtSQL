-- ============================================================================
-- Overflow Handling - GoogleSQL/BigQuery
-- ============================================================================
-- Source: tests/int64_overflow_comprehensive_tdd.rs
-- Description: Numeric overflow detection and handling
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

-- Test: CAST FLOAT64 to INT64 with positive overflow
-- Expected: Error - value exceeds INT64_MAX
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775808.0);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST FLOAT64 to INT64 with negative overflow
-- Expected: Error - value below INT64_MIN
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775809.0);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST FLOAT64 to INT64 with very large value
-- Expected: Error - value much larger than INT64_MAX
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST FLOAT64 to INT64 with very small value
-- Expected: Error - value much smaller than INT64_MIN
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e20);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- ============================================================================
-- CAST - Boundary Values (Should Succeed)
-- ============================================================================

-- Test: CAST exact INT64_MAX value
-- Expected: Success - 9223372036854775807
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST exact INT64_MIN value
-- Expected: Success - -9223372036854775808
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST near INT64_MAX
-- Expected: Success - 9223372036854775806
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST near INT64_MIN
-- Expected: Success - -9223372036854775807
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);

SELECT CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- CAST - String to INT64 Overflow
-- ============================================================================

-- Test: CAST STRING to INT64 with positive overflow
-- Expected: Error - value exceeds INT64_MAX
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST STRING to INT64 with negative overflow
-- Expected: Error - value below INT64_MIN
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST STRING to INT64 with very large number
-- Expected: Error - way too large
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST STRING to INT64 with max valid value
-- Expected: Success - 9223372036854775807
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST STRING to INT64 with min valid value
-- Expected: Success - -9223372036854775808
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');

SELECT CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- TRY_CAST - Overflow Returns NULL
-- ============================================================================

-- Test: TRY_CAST FLOAT64 overflow returns NULL
-- Expected: Row 1: NULL (overflow), Row 2: 42
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;

-- Test: TRY_CAST STRING overflow returns NULL
-- Expected: Row 1: NULL (overflow), Row 2: 42
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;

-- Test: TRY_CAST negative overflow returns NULL
-- Expected: Row 1: NULL (overflow), Row 2: -42
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;

-- Test: TRY_CAST multiple overflow mixed results
-- Expected: Row 1: NULL, Row 2: 100, Row 3: NULL, Row 4: -50
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;

-- Test: TRY_CAST boundary success
-- Expected: Success with INT64_MAX value
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Arithmetic Operations - Overflow Detection
-- ============================================================================

-- Test: Addition overflow
-- Expected: Error - INT64_MAX + 1
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);

SELECT value + 1 FROM data;
-- Expected error: overflow

-- Test: Subtraction overflow
-- Expected: Error - INT64_MIN - 1
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);

SELECT value - 1 FROM data;
-- Expected error: overflow

-- Test: Multiplication overflow
-- Expected: Error - INT64_MAX * 2
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);

SELECT value * 2 FROM data;
-- Expected error: overflow

-- Test: Negation overflow
-- Expected: Error - negating INT64_MIN causes overflow
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);

SELECT -value FROM data;
-- Expected error: overflow (because -INT64_MIN > INT64_MAX)

-- ============================================================================
-- Special Float Values
-- ============================================================================

-- Test: CAST Infinity to INT64
-- Expected: Error - cannot cast infinity
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST -Infinity to INT64
-- Expected: Error - cannot cast negative infinity
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- Test: CAST NaN to INT64
-- Expected: Error - cannot cast NaN
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: NaN

-- Test: TRY_CAST Infinity returns NULL
-- Expected: NULL
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- Test: TRY_CAST NaN returns NULL
-- Expected: NULL
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Integration Scenarios
-- ============================================================================

-- Test: Overflow in WHERE clause
-- Expected: Only row 1 passes (row 2 overflows to NULL)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);

SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;

-- Test: Overflow in aggregation
-- Expected: COUNT returns 2 (row 2 is NULL and not counted)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);

SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;

-- Test: Overflow in CASE expression
-- Expected: Row 1: 'ok', Row 2: 'overflow'
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);

SELECT id,
    CASE
        WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow'
        ELSE 'ok'
    END as status
FROM data ORDER BY id;

-- Test: Overflow in JOIN condition
-- Expected: Only row 1 joins (row 2 overflows to NULL)
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);

SELECT f.id
FROM floats f
JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;

-- Test: Overflow in ORDER BY
-- Expected: Order: 3 (50), 1 (100), 2 (NULL from overflow)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);

SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;

-- Test: Overflow with COALESCE
-- Expected: 0 (overflow returns NULL, COALESCE replaces with 0)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);

SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;

-- ============================================================================
-- NULL Handling with Overflow
-- ============================================================================

-- Test: CAST NULL does not cause overflow
-- Expected: NULL (not overflow error)
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: TRY_CAST NULL does not cause overflow
-- Expected: NULL (input NULL, not overflow NULL)
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Precision Loss (FLOAT64 to INT64)
-- ============================================================================

-- Test: CAST with decimal truncation
-- Expected: Truncates decimal part, result is valid INT64
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST near boundary with float precision
-- Expected: Success - within range despite precision
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);

SELECT CAST(value AS INT64) as int_val FROM data;

-- Test: CAST float precision just over max
-- Expected: Error - slightly over INT64_MAX
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);

SELECT CAST(value AS INT64) FROM data;
-- Expected error: overflow

-- ============================================================================
-- Stress Tests
-- ============================================================================

-- Test: Many overflows with TRY_CAST
-- Expected: Total: 100, Valid: 50 (every other row)
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
-- Insert 100 rows: even ids have value 42.0, odd ids have value 1e20

SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;

-- ============================================================================
-- Real-World Use Cases
-- ============================================================================

-- Use Case 1: Safe data import with overflow handling
-- Import external data and handle overflow gracefully
SELECT
    id,
    TRY_CAST(external_value AS INT64) as safe_int,
    CASE
        WHEN TRY_CAST(external_value AS INT64) IS NULL
        THEN 'Overflow detected'
        ELSE 'OK'
    END as status
FROM import_table;

-- Use Case 2: Data validation with overflow detection
-- Identify rows that would overflow before processing
SELECT id, value
FROM source_data
WHERE TRY_CAST(value AS INT64) IS NULL;

-- Use Case 3: Safe aggregation with overflow protection
-- Calculate statistics while handling overflow
SELECT
    category,
    COUNT(TRY_CAST(value AS INT64)) as valid_count,
    COUNT(*) - COUNT(TRY_CAST(value AS INT64)) as overflow_count
FROM measurements
GROUP BY category;
