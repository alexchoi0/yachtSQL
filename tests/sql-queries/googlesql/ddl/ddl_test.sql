-- ============================================================================
-- Ddl - GoogleSQL/BigQuery
-- ============================================================================
-- Source: Migrated from safe_functions_comprehensive_tdd.rs
-- Description: Data Definition Language: CREATE, ALTER, DROP operations
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;
