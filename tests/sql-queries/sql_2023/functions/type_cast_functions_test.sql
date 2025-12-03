-- Type Cast Functions - SQL:2023
-- Description: Type casting and conversion functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_type_cast_functions_test_select_001
SELECT CAST(42 AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_002
SELECT CAST(-100 AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_003
SELECT CAST(0 AS FLOAT64) AS result;

-- FLOAT64 to INT64 (truncates toward zero)
-- Tag: functions_type_cast_functions_test_select_004
SELECT CAST(42.9 AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_005
SELECT CAST(42.1 AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_006
SELECT CAST(-42.9 AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_007
SELECT CAST(-42.1 AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_008
SELECT CAST(0.0 AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_009
SELECT CAST(99.999 AS INT64) AS result;

-- INT64 to INT64 (no-op)
-- Tag: functions_type_cast_functions_test_select_010
SELECT CAST(42 AS INT64) AS result;

-- FLOAT64 to FLOAT64 (no-op)
-- Tag: functions_type_cast_functions_test_select_011
SELECT CAST(3.14159 AS FLOAT64) AS result;

-- ----------------------------------------------------------------------------
-- 2. STRING TO NUMERIC CONVERSIONS
-- ----------------------------------------------------------------------------

-- STRING to INT64
-- Tag: functions_type_cast_functions_test_select_012
SELECT CAST('123' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_013
SELECT CAST('-456' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_014
SELECT CAST('0' AS INT64) AS result;

-- STRING to INT64 with whitespace (should trim)
-- Tag: functions_type_cast_functions_test_select_015
SELECT CAST('  123  ' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_016
SELECT CAST('  -456  ' AS INT64) AS result;

-- STRING to FLOAT64
-- Tag: functions_type_cast_functions_test_select_017
SELECT CAST('123.45' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_018
SELECT CAST('-678.90' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_019
SELECT CAST('0.0' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_020
SELECT CAST('3.14159' AS FLOAT64) AS result;

-- Scientific notation
-- Tag: functions_type_cast_functions_test_select_021
SELECT CAST('1.23e10' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_022
SELECT CAST('1.5E-3' AS FLOAT64) AS result;

-- STRING to FLOAT64 with whitespace
-- Tag: functions_type_cast_functions_test_select_023
SELECT CAST('  3.14  ' AS FLOAT64) AS result;

-- Invalid STRING to INT64 (should error)
-- SELECT CAST('not a number' AS INT64) AS result;

-- SELECT CAST('123.45' AS INT64) AS result;

-- SELECT CAST('abc' AS FLOAT64) AS result;

-- SELECT CAST('' AS INT64) AS result;

-- ----------------------------------------------------------------------------
-- 3. NUMERIC TO STRING CONVERSIONS
-- ----------------------------------------------------------------------------

-- INT64 to STRING
-- Tag: functions_type_cast_functions_test_select_024
SELECT CAST(42 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_025
SELECT CAST(-100 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_026
SELECT CAST(0 AS STRING) AS result;

-- FLOAT64 to STRING
-- Tag: functions_type_cast_functions_test_select_027
SELECT CAST(3.14159 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_028
SELECT CAST(-2.71828 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_029
SELECT CAST(0.0 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_030
SELECT CAST(1.0 AS STRING) AS result;

-- Large numbers
-- Tag: functions_type_cast_functions_test_select_031
SELECT CAST(9223372036854775807 AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_032
SELECT CAST(1.7976931348623157e308 AS STRING) AS result;

-- ----------------------------------------------------------------------------
-- 4. BOOLEAN CONVERSIONS
-- ----------------------------------------------------------------------------

-- BOOL to INT64
-- Tag: functions_type_cast_functions_test_select_033
SELECT CAST(TRUE AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_034
SELECT CAST(FALSE AS INT64) AS result;

-- INT64 to BOOL
-- Tag: functions_type_cast_functions_test_select_035
SELECT CAST(0 AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_036
SELECT CAST(1 AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_037
SELECT CAST(42 AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_038
SELECT CAST(-1 AS BOOL) AS result;

-- BOOL to STRING
-- Tag: functions_type_cast_functions_test_select_039
SELECT CAST(TRUE AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_040
SELECT CAST(FALSE AS STRING) AS result;

-- STRING to BOOL
-- Tag: functions_type_cast_functions_test_select_041
SELECT CAST('true' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_042
SELECT CAST('TRUE' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_043
SELECT CAST('false' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_044
SELECT CAST('FALSE' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_045
SELECT CAST('t' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_046
SELECT CAST('f' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_047
SELECT CAST('1' AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_048
SELECT CAST('0' AS BOOL) AS result;

-- Invalid STRING to BOOL
-- SELECT CAST('yes' AS BOOL) AS result;

-- ----------------------------------------------------------------------------
-- 5. DATE/TIME CONVERSIONS
-- ----------------------------------------------------------------------------

-- STRING to DATE
-- Tag: functions_type_cast_functions_test_select_049
SELECT CAST('2024-01-15' AS DATE) AS result;

-- Tag: functions_type_cast_functions_test_select_050
SELECT CAST('2024-12-31' AS DATE) AS result;

-- DATE to STRING
-- Tag: functions_type_cast_functions_test_select_051
SELECT CAST(DATE '2024-01-15' AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_052
SELECT CAST(DATE '2024-12-31' AS STRING) AS result;

-- STRING to TIMESTAMP
-- Tag: functions_type_cast_functions_test_select_053
SELECT CAST('2024-01-15 14:30:45' AS TIMESTAMP) AS result;

-- Tag: functions_type_cast_functions_test_select_054
SELECT CAST('2024-01-15T14:30:45' AS TIMESTAMP) AS result;

-- TIMESTAMP to STRING
-- Tag: functions_type_cast_functions_test_select_055
SELECT CAST(TIMESTAMP '2024-01-15 14:30:45' AS STRING) AS result;

-- DATE to TIMESTAMP
-- Tag: functions_type_cast_functions_test_select_056
SELECT CAST(DATE '2024-01-15' AS TIMESTAMP) AS result;

-- TIMESTAMP to DATE
-- Tag: functions_type_cast_functions_test_select_057
SELECT CAST(TIMESTAMP '2024-01-15 14:30:45' AS DATE) AS result;

-- Invalid DATE format
-- SELECT CAST('2024/01/15' AS DATE) AS result;

-- SELECT CAST('not a date' AS DATE) AS result;

-- ----------------------------------------------------------------------------
-- 6. NULL HANDLING
-- ----------------------------------------------------------------------------

-- CAST NULL to any type returns NULL
-- Tag: functions_type_cast_functions_test_select_058
SELECT CAST(NULL AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_059
SELECT CAST(NULL AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_060
SELECT CAST(NULL AS STRING) AS result;

-- Tag: functions_type_cast_functions_test_select_061
SELECT CAST(NULL AS BOOL) AS result;

-- Tag: functions_type_cast_functions_test_select_062
SELECT CAST(NULL AS DATE) AS result;

-- Tag: functions_type_cast_functions_test_select_063
SELECT CAST(NULL AS TIMESTAMP) AS result;

-- ----------------------------------------------------------------------------
-- 7. TRY_CAST - Safe casting (returns NULL on error instead of error)
-- ----------------------------------------------------------------------------

-- TRY_CAST valid conversions (same as CAST)
-- Tag: functions_type_cast_functions_test_select_064
SELECT TRY_CAST('123' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_065
SELECT TRY_CAST('123.45' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_066
SELECT TRY_CAST(42 AS STRING) AS result;

-- TRY_CAST invalid conversions (returns NULL instead of error)
-- Tag: functions_type_cast_functions_test_select_067
SELECT TRY_CAST('not a number' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_068
SELECT TRY_CAST('abc' AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_069
SELECT TRY_CAST('123.45' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_070
SELECT TRY_CAST('' AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_071
SELECT TRY_CAST('not a date' AS DATE) AS result;

-- TRY_CAST with NULL (returns NULL)
-- Tag: functions_type_cast_functions_test_select_072
SELECT TRY_CAST(NULL AS INT64) AS result;

-- TRY_CAST with overflow
-- Tag: functions_type_cast_functions_test_select_073
SELECT TRY_CAST(1.7976931348623157e308 AS INT64) AS result;

-- ----------------------------------------------------------------------------
-- 8. CAST WITH EXPRESSIONS
-- ----------------------------------------------------------------------------

-- CAST in arithmetic
-- Tag: functions_type_cast_functions_test_select_074
SELECT CAST(10 AS FLOAT64) / 3 AS result;

-- Tag: functions_type_cast_functions_test_select_075
SELECT CAST(10 / 3 AS FLOAT64) AS result;

-- CAST in comparisons
-- Tag: functions_type_cast_functions_test_select_076
SELECT CAST('123' AS INT64) > 100 AS result;

-- Tag: functions_type_cast_functions_test_select_077
SELECT CAST(3.14 AS INT64) = 3 AS result;

-- Nested CAST
-- Tag: functions_type_cast_functions_test_select_078
SELECT CAST(CAST('123.45' AS FLOAT64) AS INT64) AS result;

-- Tag: functions_type_cast_functions_test_select_079
SELECT CAST(CAST(42 AS STRING) AS INT64) AS result;

-- CAST in CASE
-- Tag: functions_type_cast_functions_test_select_001
SELECT
    CASE
        WHEN CAST('100' AS INT64) > 50 THEN 'high'
        ELSE 'low'
    END AS result;

-- ----------------------------------------------------------------------------
-- 9. TYPE COERCION RULES (Implicit casting)
-- ----------------------------------------------------------------------------

-- INT64 + FLOAT64 → FLOAT64
-- Tag: functions_type_cast_functions_test_select_080
SELECT 10 + 3.14 AS result;

-- Tag: functions_type_cast_functions_test_select_081
SELECT 3.14 + 10 AS result;

-- INT64 * FLOAT64 → FLOAT64
-- Tag: functions_type_cast_functions_test_select_082
SELECT 5 * 2.5 AS result;

-- Comparison coercion
-- Tag: functions_type_cast_functions_test_select_083
SELECT 10 = 10.0 AS result;

-- Tag: functions_type_cast_functions_test_select_084
SELECT 10 > 9.5 AS result;

-- STRING concatenation (no automatic number to string)
-- SELECT 'value: ' || 42 AS result;

-- ----------------------------------------------------------------------------
-- 10. EDGE CASES AND SPECIAL VALUES
-- ----------------------------------------------------------------------------

-- Large numbers
-- Tag: functions_type_cast_functions_test_select_085
SELECT CAST(9223372036854775807 AS FLOAT64) AS result;

-- Tag: functions_type_cast_functions_test_select_086
SELECT CAST(-9223372036854775808 AS FLOAT64) AS result;

-- Very small FLOAT64
-- Tag: functions_type_cast_functions_test_select_087
SELECT CAST(0.000000000000001 AS STRING) AS result;

-- Precision loss INT64 to FLOAT64
-- Tag: functions_type_cast_functions_test_select_088
SELECT CAST(9007199254740993 AS FLOAT64) AS result;

-- Zero values
-- Tag: functions_type_cast_functions_test_select_089
SELECT CAST(0 AS STRING) AS result,
       CAST(0.0 AS STRING) AS result2,
       CAST(FALSE AS STRING) AS result3;

-- Negative zero
-- Tag: functions_type_cast_functions_test_select_090
SELECT CAST(-0.0 AS INT64) AS result;

-- End of Type Cast Functions Tests
