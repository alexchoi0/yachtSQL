-- ============================================================================
-- Comprehensive - GoogleSQL/BigQuery
-- ============================================================================
-- Source: tests/safe_functions_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

-- Test: Basic division
-- Expected: Normal division result (10 / 2 = 5)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: Division by zero returns NULL
-- Expected: NULL instead of error
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 0);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: SAFE_DIVIDE with FLOAT64
-- Expected: 10.0 / 4.0 = 2.5
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a FLOAT64, b FLOAT64);
INSERT INTO nums VALUES (10.0, 4.0);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: FLOAT64 division by zero
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a FLOAT64, b FLOAT64);
INSERT INTO nums VALUES (10.0, 0.0);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: NULL inputs
-- Expected: NULL for any NULL input
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5), (10, NULL);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: Zero divided by non-zero
-- Expected: 0 (not NULL)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (0, 5);
SELECT SAFE_DIVIDE(a, b) as result FROM nums;

-- Test: Mixed valid and invalid divisions
-- Expected: 5, NULL, 5, NULL
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, numerator INT64, denominator INT64);
INSERT INTO data VALUES (1, 10, 2), (2, 10, 0), (3, 15, 3), (4, 7, 0);
SELECT id, SAFE_DIVIDE(numerator, denominator) as result FROM data ORDER BY id;

-- ============================================================================
-- SAFE_MULTIPLY Tests
-- ============================================================================

-- Test: Normal multiplication
-- Expected: 5 * 10 = 50
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10);
SELECT SAFE_MULTIPLY(a, b) as result FROM nums;

-- Test: Multiplication overflow (INT64_MAX * 2)
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, 2);
SELECT SAFE_MULTIPLY(a, b) as result FROM nums;

-- Test: Negative multiplication overflow (INT64_MIN * 2)
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (-9223372036854775808, 2);
SELECT SAFE_MULTIPLY(a, b) as result FROM nums;

-- Test: NULL inputs
-- Expected: NULL for any NULL input
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5), (10, NULL);
SELECT SAFE_MULTIPLY(a, b) as result FROM nums;

-- ============================================================================
-- SAFE_ADD Tests
-- ============================================================================

-- Test: Normal addition
-- Expected: 10 + 20 = 30
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 20);
SELECT SAFE_ADD(a, b) as result FROM nums;

-- Test: Addition overflow (INT64_MAX + 1)
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, 1);
SELECT SAFE_ADD(a, b) as result FROM nums;

-- Test: Addition with large values that don't overflow
-- Expected: INT64_MAX (9223372036854775807)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775806, 1);
SELECT SAFE_ADD(a, b) as result FROM nums;

-- ============================================================================
-- SAFE_SUBTRACT Tests
-- ============================================================================

-- Test: Normal subtraction
-- Expected: 30 - 10 = 20
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (30, 10);
SELECT SAFE_SUBTRACT(a, b) as result FROM nums;

-- Test: Subtraction underflow (INT64_MIN - 1)
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (-9223372036854775808, 1);
SELECT SAFE_SUBTRACT(a, b) as result FROM nums;

-- Test: Subtracting large negative causes overflow
-- Expected: NULL (9223372036854775807 - (-1) = overflow)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, -1);
SELECT SAFE_SUBTRACT(a, b) as result FROM nums;

-- ============================================================================
-- SAFE_NEGATE Tests
-- ============================================================================

-- Test: Normal negation
-- Expected: -42
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (value INT64);
INSERT INTO nums VALUES (42);
SELECT SAFE_NEGATE(value) as result FROM nums;

-- Test: Negating INT64_MIN causes overflow
-- Expected: NULL (because -INT64_MIN > INT64_MAX)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (value INT64);
INSERT INTO nums VALUES (-9223372036854775808);
SELECT SAFE_NEGATE(value) as result FROM nums;

-- Test: NULL input
-- Expected: NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (value INT64);
INSERT INTO nums VALUES (NULL);
SELECT SAFE_NEGATE(value) as result FROM nums;

-- ============================================================================
-- Integration Tests
-- ============================================================================

-- Test: SAFE_DIVIDE in WHERE clause
-- Expected: Only rows where division succeeds
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (10, 2), (10, 0), (15, 3);
SELECT a, b FROM data WHERE SAFE_DIVIDE(a, b) IS NOT NULL ORDER BY b;

-- Test: SAFE_DIVIDE in aggregate functions
-- Expected: AVG excludes NULL values
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, numerator INT64, denominator INT64);
INSERT INTO data VALUES ('A', 10, 2), ('A', 10, 0), ('B', 15, 3), ('B', 20, 4);
SELECT category, AVG(SAFE_DIVIDE(numerator, denominator)) as avg_result
FROM data
GROUP BY category
ORDER BY category;

-- Test: Nested SAFE functions
-- Expected: (10 + 2) * (10 - 2) = 12 * 8 = 96
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2);
SELECT SAFE_MULTIPLY(SAFE_ADD(a, b), SAFE_SUBTRACT(a, b)) as result FROM nums;

-- Test: Overflow in nested functions
-- Expected: NULL (inner SAFE_ADD overflows, outer SAFE_MULTIPLY gets NULL)
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, 1);
SELECT SAFE_MULTIPLY(SAFE_ADD(a, b), 2) as result FROM nums;

-- Test: All SAFE functions preserve NULL
-- Expected: All results are NULL
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5);
SELECT
    SAFE_ADD(a, b) as add_result,
    SAFE_MULTIPLY(a, b) as mul_result,
    SAFE_DIVIDE(a, b) as div_result
FROM nums;

-- ============================================================================
-- Comparison with Regular Operations
-- ============================================================================

-- Test: SAFE_DIVIDE vs regular division (valid data)
-- Expected: Both give same results for valid operations
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2), (10, 5);
SELECT a / b as regular_result FROM nums ORDER BY b;
SELECT SAFE_DIVIDE(a, b) as safe_result FROM nums ORDER BY b;

-- Test: SAFE_MULTIPLY vs regular multiplication (valid data)
-- Expected: Both give same results for valid operations
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
SELECT a * b as regular_result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as safe_result FROM nums ORDER BY a;

-- ============================================================================
-- TRY_CAST Tests (Related Feature)
-- ============================================================================

-- Test: TRY_CAST valid string to INT64
-- Expected: 123
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
SELECT TRY_CAST(text AS INT64) as result FROM data;

-- Test: TRY_CAST invalid string to INT64
-- Expected: NULL
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
SELECT TRY_CAST(text AS INT64) as result FROM data;

-- Test: TRY_CAST with mixed valid and invalid
-- Expected: 100, NULL, 200, NULL
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;

-- ============================================================================
-- Performance Tests
-- ============================================================================

-- Test: SAFE functions with large dataset
-- Expected: Handles mix of valid and error cases efficiently
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
-- Insert 100 rows with every 10th row having denominator = 0
-- id=0, value=0; id=1, value=1; ...; id=10, value=0; ...
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;
