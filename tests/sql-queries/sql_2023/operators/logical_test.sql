-- Logical - SQL:2023
-- Description: Logical operators: AND, OR, NOT
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: operators_logical_test_select_001
SELECT TRUE AND TRUE as result;

-- Tag: operators_logical_test_select_002
SELECT TRUE AND FALSE as result;

-- Tag: operators_logical_test_select_003
SELECT TRUE AND NULL as result;

-- Tag: operators_logical_test_select_004
SELECT FALSE AND TRUE as result;

-- Tag: operators_logical_test_select_005
SELECT FALSE AND FALSE as result;

-- Non-obvious: Result is FALSE, not NULL!
-- Tag: operators_logical_test_select_006
SELECT FALSE AND NULL as result;

-- Tag: operators_logical_test_select_007
SELECT NULL AND TRUE as result;

-- Tag: operators_logical_test_select_008
SELECT NULL AND FALSE as result;

-- Tag: operators_logical_test_select_009
SELECT NULL AND NULL as result;

-- THREE-VALUED LOGIC: OR TRUTH TABLE

-- Tag: operators_logical_test_select_010
SELECT TRUE OR TRUE as result;

-- Tag: operators_logical_test_select_011
SELECT TRUE OR FALSE as result;

-- Non-obvious: Result is TRUE, not NULL!
-- Tag: operators_logical_test_select_012
SELECT TRUE OR NULL as result;

-- Tag: operators_logical_test_select_013
SELECT FALSE OR TRUE as result;

-- Tag: operators_logical_test_select_014
SELECT FALSE OR FALSE as result;

-- Tag: operators_logical_test_select_015
SELECT FALSE OR NULL as result;

-- Tag: operators_logical_test_select_016
SELECT NULL OR TRUE as result;

-- Tag: operators_logical_test_select_017
SELECT NULL OR FALSE as result;

-- Tag: operators_logical_test_select_018
SELECT NULL OR NULL as result;

-- THREE-VALUED LOGIC: NOT TRUTH TABLE

-- Tag: operators_logical_test_select_019
SELECT NOT TRUE as result;

-- Tag: operators_logical_test_select_020
SELECT NOT FALSE as result;

-- Tag: operators_logical_test_select_021
SELECT NOT NULL as result;

DROP TABLE IF EXISTS bool_test;
CREATE TABLE bool_test (id INT64, active BOOL);
INSERT INTO bool_test VALUES (1, TRUE);
INSERT INTO bool_test VALUES (2, FALSE);
INSERT INTO bool_test VALUES (3, TRUE);

-- Tag: operators_logical_test_select_022
SELECT id FROM bool_test WHERE NOT active ORDER BY id;

DROP TABLE IF EXISTS not_cmp;
CREATE TABLE not_cmp (id INT64, value INT64);
INSERT INTO not_cmp VALUES (1, 10);
INSERT INTO not_cmp VALUES (2, 20);
INSERT INTO not_cmp VALUES (3, 30);

-- Tag: operators_logical_test_select_023
SELECT id FROM not_cmp WHERE NOT (value > 20) ORDER BY id;

DROP TABLE IF EXISTS double_not;
CREATE TABLE double_not (id INT64, value INT64);
INSERT INTO double_not VALUES (1, 10);
INSERT INTO double_not VALUES (2, 20);
INSERT INTO double_not VALUES (3, 30);

-- Tag: operators_logical_test_select_024
SELECT id FROM double_not WHERE NOT NOT (value > 15) ORDER BY id;

DROP TABLE IF EXISTS not_null;
CREATE TABLE not_null (id INT64, value BOOL);
INSERT INTO not_null VALUES (1, TRUE);
INSERT INTO not_null VALUES (2, FALSE);
INSERT INTO not_null VALUES (3, NULL);

-- Tag: operators_logical_test_select_025
SELECT id FROM not_null WHERE NOT value ORDER BY id;

DROP TABLE IF EXISTS not_is_null;
CREATE TABLE not_is_null (id INT64, value INT64);
INSERT INTO not_is_null VALUES (1, 10);
INSERT INTO not_is_null VALUES (2, NULL);
INSERT INTO not_is_null VALUES (3, 30);

-- Tag: operators_logical_test_select_026
SELECT id FROM not_is_null WHERE NOT (value IS NULL) ORDER BY id;

DROP TABLE IF EXISTS and_test;
CREATE TABLE and_test (id INT64, a BOOL, b BOOL);
INSERT INTO and_test VALUES (1, TRUE, TRUE);
INSERT INTO and_test VALUES (2, TRUE, FALSE);
INSERT INTO and_test VALUES (3, FALSE, TRUE);
INSERT INTO and_test VALUES (4, FALSE, FALSE);

-- Tag: operators_logical_test_select_027
SELECT id FROM and_test WHERE a AND b ORDER BY id;

DROP TABLE IF EXISTS or_test;
CREATE TABLE or_test (id INT64, a BOOL, b BOOL);
INSERT INTO or_test VALUES (1, TRUE, TRUE);
INSERT INTO or_test VALUES (2, TRUE, FALSE);
INSERT INTO or_test VALUES (3, FALSE, TRUE);
INSERT INTO or_test VALUES (4, FALSE, FALSE);

-- Tag: operators_logical_test_select_028
SELECT id FROM or_test WHERE a OR b ORDER BY id;

DROP TABLE IF EXISTS and_null;
CREATE TABLE and_null (id INT64, a BOOL, b BOOL);
INSERT INTO and_null VALUES (1, TRUE, TRUE);
INSERT INTO and_null VALUES (2, TRUE, NULL);
INSERT INTO and_null VALUES (3, FALSE, NULL);
INSERT INTO and_null VALUES (4, NULL, NULL);

-- Tag: operators_logical_test_select_029
SELECT id FROM and_null WHERE a AND b ORDER BY id;

DROP TABLE IF EXISTS or_null;
CREATE TABLE or_null (id INT64, a BOOL, b BOOL);
INSERT INTO or_null VALUES (1, TRUE, NULL);
INSERT INTO or_null VALUES (2, FALSE, NULL);
INSERT INTO or_null VALUES (3, NULL, NULL);
INSERT INTO or_null VALUES (4, FALSE, FALSE);

-- Tag: operators_logical_test_select_030
SELECT id FROM or_null WHERE a OR b ORDER BY id;

DROP TABLE IF EXISTS demorgan_and;
CREATE TABLE demorgan_and (id INT64, a BOOL, b BOOL);
INSERT INTO demorgan_and VALUES (1, TRUE, TRUE);
INSERT INTO demorgan_and VALUES (2, TRUE, FALSE);
INSERT INTO demorgan_and VALUES (3, FALSE, TRUE);
INSERT INTO demorgan_and VALUES (4, FALSE, FALSE);

-- Tag: operators_logical_test_select_031
SELECT id FROM demorgan_and WHERE NOT (a AND b) ORDER BY id;

DROP TABLE IF EXISTS demorgan_or;
CREATE TABLE demorgan_or (id INT64, a BOOL, b BOOL);
INSERT INTO demorgan_or VALUES (1, TRUE, TRUE);
INSERT INTO demorgan_or VALUES (2, TRUE, FALSE);
INSERT INTO demorgan_or VALUES (3, FALSE, TRUE);
INSERT INTO demorgan_or VALUES (4, FALSE, FALSE);

-- Tag: operators_logical_test_select_032
SELECT id FROM demorgan_or WHERE NOT (a OR b) ORDER BY id;

DROP TABLE IF EXISTS complex_bool;
CREATE TABLE complex_bool (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO complex_bool VALUES (1, TRUE, FALSE, TRUE);
INSERT INTO complex_bool VALUES (2, FALSE, TRUE, FALSE);
INSERT INTO complex_bool VALUES (3, TRUE, TRUE, TRUE);

-- Tag: operators_logical_test_select_033
SELECT id FROM complex_bool WHERE (a OR b) AND c ORDER BY id;

-- Note: Should not error even if division by zero would occur
DROP TABLE IF EXISTS short_circuit;
CREATE TABLE short_circuit (id INT64, value INT64);
INSERT INTO short_circuit VALUES (1, 0);
INSERT INTO short_circuit VALUES (2, 10);

-- Tag: operators_logical_test_select_034
SELECT id FROM short_circuit WHERE value = 0 AND (100 / value) > 0;

DROP TABLE IF EXISTS multi_and;
CREATE TABLE multi_and (id INT64, age INT64, salary INT64, active BOOL);
INSERT INTO multi_and VALUES (1, 30, 60000, TRUE);
INSERT INTO multi_and VALUES (2, 25, 50000, TRUE);
INSERT INTO multi_and VALUES (3, 30, 55000, FALSE);

-- Tag: operators_logical_test_select_035
SELECT id FROM multi_and WHERE age = 30 AND salary > 55000 AND active ORDER BY id;

DROP TABLE IF EXISTS multi_or;
CREATE TABLE multi_or (id INT64, status STRING);
INSERT INTO multi_or VALUES (1, 'active');
INSERT INTO multi_or VALUES (2, 'pending');
INSERT INTO multi_or VALUES (3, 'inactive');
INSERT INTO multi_or VALUES (4, 'archived');

-- Tag: operators_logical_test_select_036
SELECT id FROM multi_or WHERE status = 'active' OR status = 'pending' OR status = 'archived' ORDER BY id;

-- a OR b AND c means a OR (b AND c) due to precedence
DROP TABLE IF EXISTS precedence;
CREATE TABLE precedence (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO precedence VALUES (1, TRUE, FALSE, TRUE);
INSERT INTO precedence VALUES (2, FALSE, TRUE, FALSE);
INSERT INTO precedence VALUES (3, TRUE, TRUE, FALSE);

-- Tag: operators_logical_test_select_037
SELECT id FROM precedence WHERE a OR b AND c ORDER BY id;

-- (a OR b) AND c
DROP TABLE IF EXISTS paren_prec;
CREATE TABLE paren_prec (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO paren_prec VALUES (1, TRUE, FALSE, TRUE);
INSERT INTO paren_prec VALUES (2, FALSE, TRUE, FALSE);

-- Tag: operators_logical_test_select_038
SELECT id FROM paren_prec WHERE (a OR b) AND c ORDER BY id;

DROP TABLE IF EXISTS select_logical;
CREATE TABLE select_logical (a BOOL, b BOOL);
INSERT INTO select_logical VALUES (TRUE, FALSE);

-- Tag: operators_logical_test_select_039
SELECT a AND b AS and_result, a OR b AS or_result, NOT a AS not_result FROM select_logical;

-- Only rows where expression evaluates to TRUE are returned
DROP TABLE IF EXISTS null_prop;
CREATE TABLE null_prop (id INT64, a BOOL, b BOOL);
INSERT INTO null_prop VALUES (1, TRUE, NULL);
INSERT INTO null_prop VALUES (2, FALSE, NULL);
INSERT INTO null_prop VALUES (3, NULL, TRUE);

-- Tag: operators_logical_test_select_040
SELECT id FROM null_prop WHERE (a OR b) AND NOT (a AND b) ORDER BY id;
