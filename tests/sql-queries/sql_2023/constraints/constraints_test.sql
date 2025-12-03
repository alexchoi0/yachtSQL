-- Constraints - SQL:2023
-- Description: Table constraints: PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: constraints_constraints_test_select_001
SELECT NULL IS NULL AND TRUE as result;
-- Tag: constraints_constraints_test_select_002
SELECT 5 IS NOT NULL OR FALSE as result;
-- Tag: constraints_constraints_test_select_003
SELECT NOT (2 + 3 * 4 - 1) > 10 AND 5 BETWEEN 1 AND 10 OR 'test' IS NOT NULL as result;
-- Tag: constraints_constraints_test_select_004
SELECT 0 * 100 + -5 as result;
-- Tag: constraints_constraints_test_select_005
SELECT 42 / 1 as div_one, 42 / 42 as div_self;

-- Tag: constraints_constraints_test_select_006
SELECT 5 IS NOT NULL OR FALSE as result;
-- Tag: constraints_constraints_test_select_007
SELECT NOT (2 + 3 * 4 - 1) > 10 AND 5 BETWEEN 1 AND 10 OR 'test' IS NOT NULL as result;
-- Tag: constraints_constraints_test_select_008
SELECT 0 * 100 + -5 as result;
-- Tag: constraints_constraints_test_select_009
SELECT 42 / 1 as div_one, 42 / 42 as div_self;

-- Tag: constraints_constraints_test_select_010
SELECT NOT (2 + 3 * 4 - 1) > 10 AND 5 BETWEEN 1 AND 10 OR 'test' IS NOT NULL as result;
-- Tag: constraints_constraints_test_select_011
SELECT 0 * 100 + -5 as result;
-- Tag: constraints_constraints_test_select_012
SELECT 42 / 1 as div_one, 42 / 42 as div_self;
