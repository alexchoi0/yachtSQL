-- ============================================================================
-- Data Types - PostgreSQL 18
-- ============================================================================
-- Source: Migrated from date_functions_comprehensive_tdd.rs, date_time_functions_advanced.rs
-- Description: SQL data types and type operations
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

SELECT DATE_ADD('2024-01-15', INTERVAL 5 INVALID_UNIT) as result;
SELECT DATE_DIFF('2024-01-20', '2024-01-15', INVALID_UNIT) as result;
SELECT EXTRACT(INVALID_FIELD FROM DATE '2024-01-15') as result;
SELECT DATE_ADD('2024-01-15', INTERVAL 999999 YEAR) as result;
SELECT DATE_SUB('2024-01-15', INTERVAL 999999 YEAR) as result;

-- ============================================================================
-- Test: test_date_diff_invalid_unit
-- Source: date_functions_comprehensive_tdd.rs:1262
-- ============================================================================
SELECT DATE_DIFF('2024-01-20', '2024-01-15', INVALID_UNIT) as result;
SELECT EXTRACT(INVALID_FIELD FROM DATE '2024-01-15') as result;
SELECT DATE_ADD('2024-01-15', INTERVAL 999999 YEAR) as result;
SELECT DATE_SUB('2024-01-15', INTERVAL 999999 YEAR) as result;

-- ============================================================================
-- Test: test_extract_invalid_field
-- Source: date_functions_comprehensive_tdd.rs:1271
-- ============================================================================
SELECT EXTRACT(INVALID_FIELD FROM DATE '2024-01-15') as result;
SELECT DATE_ADD('2024-01-15', INTERVAL 999999 YEAR) as result;
SELECT DATE_SUB('2024-01-15', INTERVAL 999999 YEAR) as result;

-- ============================================================================
-- Test: test_date_overflow
-- Source: date_functions_comprehensive_tdd.rs:1280
-- ============================================================================
SELECT DATE_ADD('2024-01-15', INTERVAL 999999 YEAR) as result;
SELECT DATE_SUB('2024-01-15', INTERVAL 999999 YEAR) as result;

-- ============================================================================
-- Test: test_date_underflow
-- Source: date_functions_comprehensive_tdd.rs:1290
-- ============================================================================
SELECT DATE_SUB('2024-01-15', INTERVAL 999999 YEAR) as result;

-- ============================================================================
-- Test: test_invalid_date_literal
-- Source: date_time_functions_advanced.rs:789
-- ============================================================================
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_invalid_timestamp_literal
-- Source: date_time_functions_advanced.rs:799
-- ============================================================================
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_parse_date_invalid_string
-- Source: date_time_functions_advanced.rs:809
-- ============================================================================
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_invalid_interval_unit
-- Source: date_time_functions_advanced.rs:819
-- ============================================================================
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;
