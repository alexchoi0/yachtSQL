-- Conditional Functions - SQL:2023
-- Description: Conditional functions: CASE, COALESCE, NULLIF
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_conditional_functions_test_select_001
SELECT COALESCE(NULL, NULL, 'third', 'fourth') AS result;

-- Tag: functions_conditional_functions_test_select_002
SELECT COALESCE(NULL, 'second', 'third') AS result;

-- Tag: functions_conditional_functions_test_select_003
SELECT COALESCE('first', 'second', 'third') AS result;

-- Tag: functions_conditional_functions_test_select_004
SELECT COALESCE(NULL, NULL, NULL) AS result;

-- COALESCE with numbers
-- Tag: functions_conditional_functions_test_select_005
SELECT COALESCE(NULL, NULL, 42, 100) AS result;

-- Tag: functions_conditional_functions_test_select_006
SELECT COALESCE(NULL, 0, 100) AS result;

-- COALESCE with expressions
-- Tag: functions_conditional_functions_test_select_007
SELECT COALESCE(NULL, 10 + 20, 50) AS result;

-- Two-argument COALESCE (common pattern)
-- Tag: functions_conditional_functions_test_select_008
SELECT COALESCE(NULL, 'default') AS result;

-- Tag: functions_conditional_functions_test_select_009
SELECT COALESCE('value', 'default') AS result;

-- ----------------------------------------------------------------------------
-- 4. NULLIF FUNCTION
-- ----------------------------------------------------------------------------

-- Return NULL if two values are equal
-- Tag: functions_conditional_functions_test_select_010
SELECT NULLIF(10, 10) AS result;

-- Tag: functions_conditional_functions_test_select_011
SELECT NULLIF(10, 20) AS result;

-- Tag: functions_conditional_functions_test_select_012
SELECT NULLIF('hello', 'hello') AS result;

-- Tag: functions_conditional_functions_test_select_013
SELECT NULLIF('hello', 'world') AS result;

-- NULLIF with NULL arguments
-- Tag: functions_conditional_functions_test_select_014
SELECT NULLIF(NULL, 10) AS result;

-- Tag: functions_conditional_functions_test_select_015
SELECT NULLIF(10, NULL) AS result;

-- Tag: functions_conditional_functions_test_select_016
SELECT NULLIF(NULL, NULL) AS result;

-- Practical use: avoid division by zero
-- Tag: functions_conditional_functions_test_select_017
SELECT COALESCE(100 / NULLIF(10, 10), 0) AS safe_division;

-- Tag: functions_conditional_functions_test_select_018
SELECT COALESCE(100 / NULLIF(5, 10), 0) AS safe_division;

-- ----------------------------------------------------------------------------
-- 5. IFNULL FUNCTION (Two-argument NULL replacement)
-- ----------------------------------------------------------------------------

-- Return second argument if first is NULL
-- Tag: functions_conditional_functions_test_select_019
SELECT IFNULL(NULL, 'default') AS result;

-- Tag: functions_conditional_functions_test_select_020
SELECT IFNULL('value', 'default') AS result;

-- Tag: functions_conditional_functions_test_select_021
SELECT IFNULL(NULL, 0) AS result;

-- Tag: functions_conditional_functions_test_select_022
SELECT IFNULL(42, 0) AS result;

-- IFNULL vs COALESCE (same for 2 arguments)
-- Tag: functions_conditional_functions_test_select_023
SELECT IFNULL(NULL, 100) AS ifnull_result,
       COALESCE(NULL, 100) AS coalesce_result;

-- ----------------------------------------------------------------------------
-- 6. IF FUNCTION (MySQL-style three-argument conditional)
-- ----------------------------------------------------------------------------

-- IF(condition, true_value, false_value)
-- Tag: functions_conditional_functions_test_select_024
SELECT IF(10 > 5, 'positive', 'non-positive') AS sign;

-- Tag: functions_conditional_functions_test_select_025
SELECT IF(-5 > 0, 'positive', 'non-positive') AS sign;

-- Tag: functions_conditional_functions_test_select_026
SELECT IF(0 > 0, 'positive', 'non-positive') AS sign;

-- IF with NULL condition (evaluates to FALSE)
-- Tag: functions_conditional_functions_test_select_027
SELECT IF(NULL > 5, 'yes', 'no') AS result;

-- Tag: functions_conditional_functions_test_select_028
SELECT IF(10 > 5, 'yes', 'no') AS result;

-- IF with numeric results
-- Tag: functions_conditional_functions_test_select_029
SELECT 100 * IF(100 >= 100, 0.9, 1.0) AS price;

-- Tag: functions_conditional_functions_test_select_030
SELECT 50 * IF(50 >= 100, 0.9, 1.0) AS price;

-- Nested IF for multi-way branching
-- Tag: functions_conditional_functions_test_select_031
SELECT IF(95 >= 90, 'A', IF(95 >= 70, 'B', 'C')) AS grade;

-- Tag: functions_conditional_functions_test_select_032
SELECT IF(75 >= 90, 'A', IF(75 >= 70, 'B', 'C')) AS grade;

-- Tag: functions_conditional_functions_test_select_033
SELECT IF(55 >= 90, 'A', IF(55 >= 70, 'B', 'C')) AS grade;

-- ----------------------------------------------------------------------------
-- 7. IIF FUNCTION (SQL Server-style three-argument conditional)
-- ----------------------------------------------------------------------------

-- IIF(condition, true_value, false_value) - same as IF
-- Tag: functions_conditional_functions_test_select_034
SELECT IIF(3 < 5, 'small', 'large') AS size;

-- Tag: functions_conditional_functions_test_select_035
SELECT IIF(10 < 5, 'small', 'large') AS size;

-- IIF with NULL condition
-- Tag: functions_conditional_functions_test_select_036
SELECT IIF(NULL = 5, 'equal', 'not equal') AS result;

-- IIF with boolean expressions
-- Tag: functions_conditional_functions_test_select_037
SELECT IIF(1 = 1 AND 2 = 2, 'both true', 'at least one false') AS result;

-- Tag: functions_conditional_functions_test_select_038
SELECT IIF(1 = 1 OR 2 = 3, 'at least one true', 'both false') AS result;

-- ----------------------------------------------------------------------------
-- 8. DECODE FUNCTION (Oracle-style multi-way conditional)
-- ----------------------------------------------------------------------------

-- DECODE(expr, search1, result1, search2, result2, ..., default)
-- Tag: functions_conditional_functions_test_select_039
SELECT DECODE('active', 'active', 'A', 'inactive', 'I', 'U') AS code;

-- Tag: functions_conditional_functions_test_select_040
SELECT DECODE('inactive', 'active', 'A', 'inactive', 'I', 'U') AS code;

-- Tag: functions_conditional_functions_test_select_041
SELECT DECODE('unknown', 'active', 'A', 'inactive', 'I', 'U') AS code;

-- DECODE with numbers
-- Tag: functions_conditional_functions_test_select_042
SELECT DECODE(1, 1, 'one', 2, 'two', 3, 'three', 'other') AS number_name;

-- Tag: functions_conditional_functions_test_select_043
SELECT DECODE(5, 1, 'one', 2, 'two', 3, 'three', 'other') AS number_name;

-- DECODE special NULL handling (NULL = NULL is TRUE, unlike CASE!)
-- Tag: functions_conditional_functions_test_select_044
SELECT DECODE(NULL, 'active', 'A', NULL, 'N', 'U') AS code;

-- Tag: functions_conditional_functions_test_select_045
SELECT DECODE('value', NULL, 'matched null', 'value', 'matched value', 'default') AS result;

-- DECODE without default (returns NULL if no match)
-- Tag: functions_conditional_functions_test_select_046
SELECT DECODE('xyz', 'active', 'A', 'inactive', 'I') AS code;

-- ----------------------------------------------------------------------------
-- 9. NESTED AND COMBINED CONDITIONALS
-- ----------------------------------------------------------------------------

-- Nested CASE
-- Tag: functions_conditional_functions_test_select_001
SELECT
    CASE
        WHEN 100 >= 90 THEN
            CASE
                WHEN 100 = 100 THEN 'Perfect A'
                ELSE 'Regular A'
            END
        WHEN 100 >= 80 THEN 'B'
        ELSE 'C or below'
    END AS grade;

-- CASE with COALESCE
-- Tag: functions_conditional_functions_test_select_002
SELECT
    CASE
        WHEN COALESCE(NULL, 10) > 5 THEN 'High'
        ELSE 'Low'
    END AS result;

-- IF with NULLIF
-- Tag: functions_conditional_functions_test_select_047
SELECT IF(NULLIF(10, 10) IS NULL, 'equal', 'not equal') AS result;

-- Tag: functions_conditional_functions_test_select_048
SELECT IF(NULLIF(10, 5) IS NULL, 'equal', 'not equal') AS result;

-- COALESCE with CASE
-- Tag: functions_conditional_functions_test_select_049
SELECT COALESCE(
    CASE WHEN NULL > 5 THEN 'high' END,
    CASE WHEN 10 > 5 THEN 'medium' END,
    'low'
) AS result;

-- ----------------------------------------------------------------------------
-- 10. NULL HANDLING COMPARISONS
-- ----------------------------------------------------------------------------

-- CASE searched vs CASE simple with NULL
-- Tag: functions_conditional_functions_test_select_003
SELECT
    CASE WHEN NULL IS NULL THEN 'searched matches' ELSE 'no match' END AS searched_case,
    CASE NULL WHEN NULL THEN 'simple matches' ELSE 'no match' END AS simple_case;

-- DECODE vs CASE with NULL
-- Tag: functions_conditional_functions_test_select_004
SELECT
    DECODE(NULL, NULL, 'decode matches', 'no match') AS decode_result,
    CASE NULL WHEN NULL THEN 'case matches' ELSE 'no match' END AS case_result;

-- ----------------------------------------------------------------------------
-- 11. TYPE COERCION IN CONDITIONALS
-- ----------------------------------------------------------------------------

-- CASE with mixed numeric types
-- Tag: functions_conditional_functions_test_select_005
SELECT
    CASE
        WHEN 5 > 3.14 THEN 'integer greater'
        ELSE 'not greater'
    END AS result;

-- COALESCE with mixed types (should return compatible type)
-- Tag: functions_conditional_functions_test_select_050
SELECT COALESCE(NULL, 42, 3.14) AS result;

-- IF with different result types
-- Tag: functions_conditional_functions_test_select_051
SELECT IF(true, 100, 'string') AS result;

-- End of Conditional Functions Tests
