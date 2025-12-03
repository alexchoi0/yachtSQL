-- Null Functions - SQL:2023
-- Description: NULL handling functions: COALESCE, NULLIF, IS NULL
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_null_functions_test_select_001
SELECT COALESCE(NULL, NULL, 'third', 'fourth') AS result;

-- Tag: functions_null_functions_test_select_002
SELECT COALESCE(NULL, 'second', 'third') AS result;

-- Tag: functions_null_functions_test_select_003
SELECT COALESCE('first', 'second', 'third') AS result;

-- All NULL returns NULL
-- Tag: functions_null_functions_test_select_004
SELECT COALESCE(NULL, NULL, NULL) AS result;

-- COALESCE with numbers
-- Tag: functions_null_functions_test_select_005
SELECT COALESCE(NULL, NULL, 42, 100) AS result;

-- Tag: functions_null_functions_test_select_006
SELECT COALESCE(NULL, 0, 100) AS result;

-- Tag: functions_null_functions_test_select_007
SELECT COALESCE(NULL, -1, 100) AS result;

-- COALESCE with expressions
-- Tag: functions_null_functions_test_select_008
SELECT COALESCE(NULL, 10 + 20, 50) AS result;

-- Tag: functions_null_functions_test_select_009
SELECT COALESCE(NULL * 2, 5 * 3, 0) AS result;

-- Two-argument COALESCE (common pattern for default values)
-- Tag: functions_null_functions_test_select_010
SELECT COALESCE(NULL, 'default') AS result;

-- Tag: functions_null_functions_test_select_011
SELECT COALESCE('value', 'default') AS result;

-- Tag: functions_null_functions_test_select_012
SELECT COALESCE(NULL, 0) AS result;

-- Tag: functions_null_functions_test_select_013
SELECT COALESCE(42, 0) AS result;

-- COALESCE with strings
-- Tag: functions_null_functions_test_select_014
SELECT COALESCE('Alice', 'Bob', 'Unknown') AS result;

-- Tag: functions_null_functions_test_select_015
SELECT COALESCE(NULL, 'Bob', 'Unknown') AS result;

-- Tag: functions_null_functions_test_select_016
SELECT COALESCE(NULL, NULL, 'Unknown') AS result;

-- Empty string is not NULL
-- Tag: functions_null_functions_test_select_017
SELECT COALESCE('', 'default') AS result;

-- ----------------------------------------------------------------------------
-- 2. NULLIF - Return NULL if two values are equal
-- ----------------------------------------------------------------------------

-- Basic NULLIF
-- Tag: functions_null_functions_test_select_018
SELECT NULLIF(10, 10) AS result;

-- Tag: functions_null_functions_test_select_019
SELECT NULLIF(10, 20) AS result;

-- Tag: functions_null_functions_test_select_020
SELECT NULLIF(5, 5) AS result;

-- Tag: functions_null_functions_test_select_021
SELECT NULLIF(100, 200) AS result;

-- NULLIF with strings
-- Tag: functions_null_functions_test_select_022
SELECT NULLIF('hello', 'hello') AS result;

-- Tag: functions_null_functions_test_select_023
SELECT NULLIF('hello', 'world') AS result;

-- NULLIF is case-sensitive
-- Tag: functions_null_functions_test_select_024
SELECT NULLIF('hello', 'HELLO') AS result;

-- NULLIF with empty strings
-- Tag: functions_null_functions_test_select_025
SELECT NULLIF('', '') AS result;

-- Tag: functions_null_functions_test_select_026
SELECT NULLIF('value', '') AS result;

-- NULLIF with NULL arguments
-- Tag: functions_null_functions_test_select_027
SELECT NULLIF(NULL, 10) AS result;

-- Tag: functions_null_functions_test_select_028
SELECT NULLIF(10, NULL) AS result;

-- Tag: functions_null_functions_test_select_029
SELECT NULLIF(NULL, NULL) AS result;

-- NULLIF with expressions
-- Tag: functions_null_functions_test_select_030
SELECT NULLIF(5 + 3, 8) AS result;

-- Tag: functions_null_functions_test_select_031
SELECT NULLIF(10 + 5, 8) AS result;

-- Practical use: avoid division by zero
-- Tag: functions_null_functions_test_select_032
SELECT COALESCE(100.0 / NULLIF(0, 0), 0) AS safe_division;

-- Tag: functions_null_functions_test_select_033
SELECT COALESCE(100.0 / NULLIF(5, 0), 0) AS safe_division;

-- Tag: functions_null_functions_test_select_034
SELECT COALESCE(100.0 / NULLIF(10, 10), 0) AS safe_division;

-- ----------------------------------------------------------------------------
-- 3. IFNULL - Two-argument NULL replacement
-- ----------------------------------------------------------------------------

-- Basic IFNULL
-- Tag: functions_null_functions_test_select_035
SELECT IFNULL(NULL, 'default') AS result;

-- Tag: functions_null_functions_test_select_036
SELECT IFNULL('value', 'default') AS result;

-- Tag: functions_null_functions_test_select_037
SELECT IFNULL(NULL, 0) AS result;

-- Tag: functions_null_functions_test_select_038
SELECT IFNULL(42, 0) AS result;

-- IFNULL with numbers
-- Tag: functions_null_functions_test_select_039
SELECT IFNULL(NULL, 99) AS result;

-- Tag: functions_null_functions_test_select_040
SELECT IFNULL(42, 99) AS result;

-- Tag: functions_null_functions_test_select_041
SELECT IFNULL(0, 99) AS result;

-- Tag: functions_null_functions_test_select_042
SELECT IFNULL(-1, 99) AS result;

-- IFNULL with strings
-- Tag: functions_null_functions_test_select_043
SELECT IFNULL(NULL, 'N/A') AS result;

-- Tag: functions_null_functions_test_select_044
SELECT IFNULL('Alice', 'N/A') AS result;

-- Empty string is not NULL
-- Tag: functions_null_functions_test_select_045
SELECT IFNULL('', 'default') AS result;

-- IFNULL with expressions
-- Tag: functions_null_functions_test_select_046
SELECT IFNULL(NULL, 10 + 20) AS result;

-- Tag: functions_null_functions_test_select_047
SELECT IFNULL(5, 10 + 20) AS result;

-- ----------------------------------------------------------------------------
-- 5. IS NULL / IS NOT NULL - NULL testing predicates
-- ----------------------------------------------------------------------------

-- IS NULL
-- Tag: functions_null_functions_test_select_048
SELECT NULL IS NULL AS result;

-- Tag: functions_null_functions_test_select_049
SELECT 0 IS NULL AS result;

-- Tag: functions_null_functions_test_select_050
SELECT '' IS NULL AS result;

-- Tag: functions_null_functions_test_select_051
SELECT 'value' IS NULL AS result;

-- IS NOT NULL
-- Tag: functions_null_functions_test_select_052
SELECT NULL IS NOT NULL AS result;

-- Tag: functions_null_functions_test_select_053
SELECT 0 IS NOT NULL AS result;

-- Tag: functions_null_functions_test_select_054
SELECT '' IS NOT NULL AS result;

-- Tag: functions_null_functions_test_select_055
SELECT 'value' IS NOT NULL AS result;

-- ISNULL function (returns boolean, different from IS NULL predicate)
-- Note: Some databases use ISNULL as a function
-- Tag: functions_null_functions_test_select_056
SELECT ISNULL(NULL) AS result;

-- Tag: functions_null_functions_test_select_057
SELECT ISNULL(42) AS result;

-- ----------------------------------------------------------------------------
-- 7. COMBINED NULL FUNCTIONS
-- ----------------------------------------------------------------------------

-- COALESCE with NULLIF
-- Tag: functions_null_functions_test_select_058
SELECT COALESCE(NULLIF(10, 10), 999) AS result;

-- Tag: functions_null_functions_test_select_059
SELECT COALESCE(NULLIF(10, 5), 999) AS result;

-- Nested COALESCE
-- Tag: functions_null_functions_test_select_060
SELECT COALESCE(NULL, COALESCE(NULL, 'inner', 'outer')) AS result;

-- Tag: functions_null_functions_test_select_061
SELECT COALESCE(COALESCE(NULL, NULL), 'fallback') AS result;



-- NULLIF chain
-- Tag: functions_null_functions_test_select_062
SELECT COALESCE(NULLIF(NULLIF(5, 5), 10), 'all null') AS result;

-- ----------------------------------------------------------------------------
-- 8. NULL PROPAGATION IN ARITHMETIC
-- ----------------------------------------------------------------------------

-- NULL in addition
-- Tag: functions_null_functions_test_select_063
SELECT 10 + NULL AS result;

-- Tag: functions_null_functions_test_select_064
SELECT NULL + 20 AS result;

-- NULL in multiplication
-- Tag: functions_null_functions_test_select_065
SELECT 10 * NULL AS result;

-- NULL in division
-- Tag: functions_null_functions_test_select_066
SELECT 100 / NULL AS result;

-- Tag: functions_null_functions_test_select_067
SELECT NULL / 100 AS result;

-- COALESCE to handle NULL in arithmetic
-- Tag: functions_null_functions_test_select_068
SELECT COALESCE(10 + NULL, 0) AS result;

-- Tag: functions_null_functions_test_select_069
SELECT COALESCE(10 * NULL, -1) AS result;

-- ----------------------------------------------------------------------------
-- 9. NULL COMPARISONS
-- ----------------------------------------------------------------------------

-- NULL equals NULL is UNKNOWN (not TRUE)
-- Tag: functions_null_functions_test_select_070
SELECT (NULL = NULL) AS result;

-- Tag: functions_null_functions_test_select_071
SELECT (NULL <> NULL) AS result;

-- IS NULL is the correct way to test for NULL
-- Tag: functions_null_functions_test_select_072
SELECT (NULL IS NULL) AS result;

-- NULLIF and equality
-- Tag: functions_null_functions_test_select_073
SELECT NULLIF(NULL, NULL) AS result;

-- ----------------------------------------------------------------------------
-- 10. PRACTICAL PATTERNS
-- ----------------------------------------------------------------------------

-- Default value pattern
-- Tag: functions_null_functions_test_select_074
SELECT COALESCE(NULL, 'default') AS with_default;

-- Safe division pattern
-- Tag: functions_null_functions_test_select_075
SELECT COALESCE(100.0 / NULLIF(0, 0), 0.0) AS safe_div;

-- Tag: functions_null_functions_test_select_076
SELECT COALESCE(100.0 / NULLIF(5, 0), 0.0) AS safe_div;

-- Fallback chain
-- Tag: functions_null_functions_test_select_077
SELECT COALESCE(NULL, NULL, NULL, 'last resort') AS fallback;

-- Conditional NULL

-- Multiple NULL checks
-- Tag: functions_null_functions_test_select_001
SELECT
    COALESCE(NULL, NULL, 'third') AS result1,
    IFNULL(NULL, 'second') AS result2,
    NULLIF(10, 10) AS result3,

-- End of NULL Functions Tests
