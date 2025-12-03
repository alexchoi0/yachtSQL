-- ============================================================================
-- Core Operations - PostgreSQL 18
-- ============================================================================
-- Source: Migrated from interval_data_type_comprehensive_tdd.rs
-- Description: Core SQL operations including SELECT, WHERE, ORDER BY, and basic queries
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

SELECT MAKE_INTERVAL(years => 1, months => 2, days => 3, hours => 4) AS made_interval;
