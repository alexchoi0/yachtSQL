-- Comparison - SQL:2023
-- Description: Comparison operators: =, <>, <, >, <=, >=
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS eq_test;
CREATE TABLE eq_test (id INT64, value INT64);
INSERT INTO eq_test VALUES (1, 10);
INSERT INTO eq_test VALUES (2, 20);
INSERT INTO eq_test VALUES (3, 10);

-- Tag: operators_comparison_test_select_001
SELECT * FROM eq_test WHERE value = 10;

DROP TABLE IF EXISTS neq_test;
CREATE TABLE neq_test (id INT64, status STRING);
INSERT INTO neq_test VALUES (1, 'active');
INSERT INTO neq_test VALUES (2, 'inactive');

-- Tag: operators_comparison_test_select_002
SELECT id FROM neq_test WHERE status <> 'active';

DROP TABLE IF EXISTS neq_test2;
CREATE TABLE neq_test2 (id INT64, status STRING);
INSERT INTO neq_test2 VALUES (1, 'active');
INSERT INTO neq_test2 VALUES (2, 'inactive');

-- Tag: operators_comparison_test_select_003
SELECT id FROM neq_test2 WHERE status != 'active';

DROP TABLE IF EXISTS lt_test;
CREATE TABLE lt_test (id INT64, age INT64);
INSERT INTO lt_test VALUES (1, 20);
INSERT INTO lt_test VALUES (2, 30);
INSERT INTO lt_test VALUES (3, 25);

-- Tag: operators_comparison_test_select_004
SELECT * FROM lt_test WHERE age < 25;

DROP TABLE IF EXISTS gt_test;
CREATE TABLE gt_test (id INT64, price FLOAT64);
INSERT INTO gt_test VALUES (1, 9.99);
INSERT INTO gt_test VALUES (2, 19.99);
INSERT INTO gt_test VALUES (3, 14.99);

-- Tag: operators_comparison_test_select_005
SELECT * FROM gt_test WHERE price > 15.0;

DROP TABLE IF EXISTS lte_test;
CREATE TABLE lte_test (id INT64, score INT64);
INSERT INTO lte_test VALUES (1, 85);
INSERT INTO lte_test VALUES (2, 90);
INSERT INTO lte_test VALUES (3, 80);

-- Tag: operators_comparison_test_select_006
SELECT * FROM lte_test WHERE score <= 85;

DROP TABLE IF EXISTS gte_test;
CREATE TABLE gte_test (id INT64, score INT64);
INSERT INTO gte_test VALUES (1, 85);
INSERT INTO gte_test VALUES (2, 90);
INSERT INTO gte_test VALUES (3, 80);

-- Tag: operators_comparison_test_select_007
SELECT * FROM gte_test WHERE score >= 85;

DROP TABLE IF EXISTS str_cmp;
CREATE TABLE str_cmp (id INT64, name STRING);
INSERT INTO str_cmp VALUES (1, 'Alice');
INSERT INTO str_cmp VALUES (2, 'Bob');
INSERT INTO str_cmp VALUES (3, 'Charlie');

-- Tag: operators_comparison_test_select_008
SELECT * FROM str_cmp WHERE name > 'Bob';

DROP TABLE IF EXISTS float_cmp;
CREATE TABLE float_cmp (id INT64, value FLOAT64);
INSERT INTO float_cmp VALUES (1, 3.14);
INSERT INTO float_cmp VALUES (2, 2.71);
INSERT INTO float_cmp VALUES (3, 1.41);

-- Tag: operators_comparison_test_select_009
SELECT * FROM float_cmp WHERE value < 3.0;

DROP TABLE IF EXISTS null_cmp;
CREATE TABLE null_cmp (id INT64, value INT64);
INSERT INTO null_cmp VALUES (1, 10);
INSERT INTO null_cmp VALUES (2, NULL);
INSERT INTO null_cmp VALUES (3, 10);

-- Tag: operators_comparison_test_select_010
SELECT * FROM null_cmp WHERE value = 10;

DROP TABLE IF EXISTS null_cmp2;
CREATE TABLE null_cmp2 (id INT64, value INT64);
INSERT INTO null_cmp2 VALUES (1, 10);
INSERT INTO null_cmp2 VALUES (2, NULL);
INSERT INTO null_cmp2 VALUES (3, 20);

-- Tag: operators_comparison_test_select_011
SELECT * FROM null_cmp2 WHERE value <> 10;

DROP TABLE IF EXISTS null_test;
CREATE TABLE null_test (id INT64, value INT64);
INSERT INTO null_test VALUES (1, 10);
INSERT INTO null_test VALUES (2, NULL);
INSERT INTO null_test VALUES (3, 20);

-- Tag: operators_comparison_test_select_012
SELECT * FROM null_test WHERE value IS NULL;

DROP TABLE IF EXISTS null_test2;
CREATE TABLE null_test2 (id INT64, value INT64);
INSERT INTO null_test2 VALUES (1, 10);
INSERT INTO null_test2 VALUES (2, NULL);
INSERT INTO null_test2 VALUES (3, 20);

-- Tag: operators_comparison_test_select_013
SELECT * FROM null_test2 WHERE value IS NOT NULL;

DROP TABLE IF EXISTS bool_cmp;
CREATE TABLE bool_cmp (a INT64, b INT64);
INSERT INTO bool_cmp VALUES (10, 20);

-- Tag: operators_comparison_test_select_014
SELECT a < b AS less_than, a = b AS equal, a > b AS greater_than FROM bool_cmp;

DROP TABLE IF EXISTS range_test;
CREATE TABLE range_test (id INT64, value INT64);
INSERT INTO range_test VALUES (1, 5);
INSERT INTO range_test VALUES (2, 15);
INSERT INTO range_test VALUES (3, 25);

-- Tag: operators_comparison_test_select_015
SELECT * FROM range_test WHERE value >= 10 AND value <= 20;

DROP TABLE IF EXISTS multi_cmp;
CREATE TABLE multi_cmp (id INT64, status STRING);
INSERT INTO multi_cmp VALUES (1, 'active');
INSERT INTO multi_cmp VALUES (2, 'pending');
INSERT INTO multi_cmp VALUES (3, 'inactive');

-- Tag: operators_comparison_test_select_016
SELECT * FROM multi_cmp WHERE status = 'active' OR status = 'pending';

DROP TABLE IF EXISTS expr_cmp;
CREATE TABLE expr_cmp (id INT64, price INT64, quantity INT64);
INSERT INTO expr_cmp VALUES (1, 10, 5);
INSERT INTO expr_cmp VALUES (2, 20, 3);
INSERT INTO expr_cmp VALUES (3, 15, 4);

-- Tag: operators_comparison_test_select_017
SELECT * FROM expr_cmp WHERE price * quantity > 55;

DROP TABLE IF EXISTS case_test;
CREATE TABLE case_test (id INT64, name STRING);
INSERT INTO case_test VALUES (1, 'Alice');
INSERT INTO case_test VALUES (2, 'alice');
INSERT INTO case_test VALUES (3, 'ALICE');

-- Tag: operators_comparison_test_select_018
SELECT * FROM case_test WHERE name = 'Alice';

DROP TABLE IF EXISTS zero_cmp;
CREATE TABLE zero_cmp (id INT64, value INT64);
INSERT INTO zero_cmp VALUES (1, -5);
INSERT INTO zero_cmp VALUES (2, 0);
INSERT INTO zero_cmp VALUES (3, 5);

-- Tag: operators_comparison_test_select_019
SELECT * FROM zero_cmp WHERE value > 0;
-- Tag: operators_comparison_test_select_020
SELECT * FROM zero_cmp WHERE value = 0;
-- Tag: operators_comparison_test_select_021
SELECT * FROM zero_cmp WHERE value < 0;

DROP TABLE IF EXISTS neg_cmp;
CREATE TABLE neg_cmp (id INT64, value INT64);
INSERT INTO neg_cmp VALUES (1, -10);
INSERT INTO neg_cmp VALUES (2, -5);
INSERT INTO neg_cmp VALUES (3, -15);

-- Tag: operators_comparison_test_select_022
SELECT * FROM neg_cmp WHERE value > -10;

-- Note: Float equality may have precision issues
DROP TABLE IF EXISTS float_eq;
CREATE TABLE float_eq (id INT64, value FLOAT64);
INSERT INTO float_eq VALUES (1, 0.1 + 0.2);
INSERT INTO float_eq VALUES (2, 0.3);

-- Tag: operators_comparison_test_select_023
SELECT * FROM float_eq WHERE value = 0.3;

DROP TABLE IF EXISTS empty_str;
CREATE TABLE empty_str (id INT64, value STRING);
INSERT INTO empty_str VALUES (1, '');
INSERT INTO empty_str VALUES (2, 'text');

-- Tag: operators_comparison_test_select_024
SELECT * FROM empty_str WHERE value = '';

DROP TABLE IF EXISTS order_cmp;
CREATE TABLE order_cmp (id INT64, priority INT64);
INSERT INTO order_cmp VALUES (1, 3);
INSERT INTO order_cmp VALUES (2, 1);
INSERT INTO order_cmp VALUES (3, 2);

-- Tag: operators_comparison_test_select_025
SELECT * FROM order_cmp ORDER BY priority < 2 DESC, priority;

-- CREATE TABLE date_cmp (id INT64, event_date DATE);
-- INSERT INTO date_cmp VALUES (1, DATE '2024-01-15');
-- INSERT INTO date_cmp VALUES (2, DATE '2024-03-20');
-- INSERT INTO date_cmp VALUES (3, DATE '2024-02-10');
-- SELECT * FROM date_cmp WHERE event_date > DATE '2024-02-01';

DROP TABLE IF EXISTS all_cmp;
CREATE TABLE all_cmp (id INT64, value INT64);
INSERT INTO all_cmp VALUES (1, 10);
INSERT INTO all_cmp VALUES (2, 20);
INSERT INTO all_cmp VALUES (3, 10);

