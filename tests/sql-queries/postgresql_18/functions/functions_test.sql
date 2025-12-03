-- ============================================================================
-- Functions - PostgreSQL 18
-- ============================================================================
-- Source: Migrated from interval_data_type_comprehensive_tdd.rs
-- Description: SQL functions: string, numeric, date, conditional
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

SELECT CAST('2 hours' AS INTERVAL) AS casted_interval;
SELECT CAST(INTERVAL '3' HOUR AS STRING) AS interval_string;
SELECT MAKE_INTERVAL(years => 1, months => 2, days => 3, hours => 4) AS made_interval;

-- ============================================================================
-- Test: test_cast_interval_to_string
-- Source: interval_data_type_comprehensive_tdd.rs:692
-- ============================================================================
SELECT CAST(INTERVAL '3' HOUR AS STRING) AS interval_string;
SELECT MAKE_INTERVAL(years => 1, months => 2, days => 3, hours => 4) AS made_interval;
