-- Arithmetic - SQL:2023
-- Description: Arithmetic operators: +, -, *, /, %
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (a INT64, b INT64);
INSERT INTO numbers VALUES (10, 20);

-- Tag: operators_arithmetic_test_select_001
SELECT a + b AS sum FROM numbers;

DROP TABLE IF EXISTS numbers2;
CREATE TABLE numbers2 (a INT64, b INT64);
INSERT INTO numbers2 VALUES (50, 20);

-- Tag: operators_arithmetic_test_select_002
SELECT a - b AS diff FROM numbers2;

DROP TABLE IF EXISTS numbers3;
CREATE TABLE numbers3 (a INT64, b INT64);
INSERT INTO numbers3 VALUES (7, 8);

-- Tag: operators_arithmetic_test_select_003
SELECT a * b AS product FROM numbers3;

DROP TABLE IF EXISTS numbers4;
CREATE TABLE numbers4 (a INT64, b INT64);
INSERT INTO numbers4 VALUES (20, 4);

-- Tag: operators_arithmetic_test_select_004
SELECT a / b AS quotient FROM numbers4;

DROP TABLE IF EXISTS numbers5;
CREATE TABLE numbers5 (a INT64, b INT64);
INSERT INTO numbers5 VALUES (17, 5);

-- Tag: operators_arithmetic_test_select_005
SELECT a % b AS remainder FROM numbers5;

DROP TABLE IF EXISTS floats;
CREATE TABLE floats (a FLOAT64, b FLOAT64);
INSERT INTO floats VALUES (3.14, 2.86);

-- Tag: operators_arithmetic_test_select_006
SELECT a + b AS sum FROM floats;

DROP TABLE IF EXISTS floats2;
CREATE TABLE floats2 (a FLOAT64, b FLOAT64);
INSERT INTO floats2 VALUES (10.5, 3.2);

-- Tag: operators_arithmetic_test_select_007
SELECT a - b AS diff FROM floats2;

DROP TABLE IF EXISTS floats3;
CREATE TABLE floats3 (a FLOAT64, b FLOAT64);
INSERT INTO floats3 VALUES (2.5, 4.0);

-- Tag: operators_arithmetic_test_select_008
SELECT a * b AS product FROM floats3;

DROP TABLE IF EXISTS floats4;
CREATE TABLE floats4 (a FLOAT64, b FLOAT64);
INSERT INTO floats4 VALUES (15.0, 3.0);

-- Tag: operators_arithmetic_test_select_009
SELECT a / b AS quotient FROM floats4;

DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (10, 3.5);

-- Tag: operators_arithmetic_test_select_010
SELECT int_val + float_val AS sum FROM mixed;

DROP TABLE IF EXISTS mixed2;
CREATE TABLE mixed2 (float_val FLOAT64, int_val INT64);
INSERT INTO mixed2 VALUES (20.5, 7);

-- Tag: operators_arithmetic_test_select_011
SELECT float_val - int_val AS diff FROM mixed2;

DROP TABLE IF EXISTS mixed3;
CREATE TABLE mixed3 (int_val INT64, float_val FLOAT64);
INSERT INTO mixed3 VALUES (5, 2.5);

-- Tag: operators_arithmetic_test_select_012
SELECT int_val * float_val AS product FROM mixed3;

DROP TABLE IF EXISTS mixed4;
CREATE TABLE mixed4 (int_val INT64, float_val FLOAT64);
INSERT INTO mixed4 VALUES (10, 4.0);

-- Tag: operators_arithmetic_test_select_013
SELECT int_val / float_val AS quotient FROM mixed4;

DROP TABLE IF EXISTS unary;
CREATE TABLE unary (value INT64);
INSERT INTO unary VALUES (42);

-- Tag: operators_arithmetic_test_select_014
SELECT -value AS negated FROM unary;

DROP TABLE IF EXISTS unary2;
CREATE TABLE unary2 (value FLOAT64);
INSERT INTO unary2 VALUES (3.14);

-- Tag: operators_arithmetic_test_select_015
SELECT -value AS negated FROM unary2;

DROP TABLE IF EXISTS unary3;
CREATE TABLE unary3 (value INT64);
INSERT INTO unary3 VALUES (42);

-- Tag: operators_arithmetic_test_select_016
SELECT +value AS positive FROM unary3;

DROP TABLE IF EXISTS unary4;
CREATE TABLE unary4 (value INT64);
INSERT INTO unary4 VALUES (42);

-- Tag: operators_arithmetic_test_select_017
SELECT -(-value) AS double_neg FROM unary4;

-- CREATE TABLE div_zero (value INT64);
-- INSERT INTO div_zero VALUES (10);
-- SELECT value / 0 FROM div_zero;

-- CREATE TABLE mod_zero (value INT64);
-- INSERT INTO mod_zero VALUES (10);
-- SELECT value % 0 FROM mod_zero;

DROP TABLE IF EXISTS null_arith;
CREATE TABLE null_arith (value INT64);
INSERT INTO null_arith VALUES (NULL);

-- Tag: operators_arithmetic_test_select_018
SELECT value + 10 FROM null_arith;

DROP TABLE IF EXISTS null_arith2;
CREATE TABLE null_arith2 (a INT64, b INT64);
INSERT INTO null_arith2 VALUES (10, NULL);

-- Tag: operators_arithmetic_test_select_019
SELECT a + b FROM null_arith2;

DROP TABLE IF EXISTS null_arith3;
CREATE TABLE null_arith3 (a INT64, b INT64);
INSERT INTO null_arith3 VALUES (NULL, 5);

-- Tag: operators_arithmetic_test_select_020
SELECT a * b FROM null_arith3;

DROP TABLE IF EXISTS null_arith4;
CREATE TABLE null_arith4 (a INT64, b INT64);
INSERT INTO null_arith4 VALUES (10, NULL);

-- Tag: operators_arithmetic_test_select_021
SELECT a / b FROM null_arith4;

DROP TABLE IF EXISTS null_unary;
CREATE TABLE null_unary (value INT64);
INSERT INTO null_unary VALUES (NULL);

-- Tag: operators_arithmetic_test_select_022
SELECT -value FROM null_unary;

DROP TABLE IF EXISTS precedence;
CREATE TABLE precedence (a INT64, b INT64, c INT64);
INSERT INTO precedence VALUES (2, 3, 4);

-- Tag: operators_arithmetic_test_select_023
SELECT a + b * c AS result FROM precedence;

DROP TABLE IF EXISTS precedence2;
CREATE TABLE precedence2 (a INT64, b INT64, c INT64);
INSERT INTO precedence2 VALUES (20, 10, 2);

-- Tag: operators_arithmetic_test_select_024
SELECT a - b / c AS result FROM precedence2;

DROP TABLE IF EXISTS precedence3;
CREATE TABLE precedence3 (a INT64, b INT64, c INT64);
INSERT INTO precedence3 VALUES (2, 3, 4);

-- Tag: operators_arithmetic_test_select_025
SELECT (a + b) * c AS result FROM precedence3;

DROP TABLE IF EXISTS precedence4;
CREATE TABLE precedence4 (a INT64, b INT64, c INT64);
INSERT INTO precedence4 VALUES (10, 5, 2);

-- Tag: operators_arithmetic_test_select_026
SELECT ((a - b) * c) + a AS result FROM precedence4;

DROP TABLE IF EXISTS all_ops;
CREATE TABLE all_ops (a INT64, b INT64, c INT64, d INT64);
INSERT INTO all_ops VALUES (10, 5, 3, 2);

-- Tag: operators_arithmetic_test_select_027
SELECT a + b * c - d / 2 AS result FROM all_ops;

DROP TABLE IF EXISTS where_arith;
CREATE TABLE where_arith (a INT64, b INT64);
INSERT INTO where_arith VALUES (10, 5);
INSERT INTO where_arith VALUES (20, 10);
INSERT INTO where_arith VALUES (30, 15);

-- Tag: operators_arithmetic_test_select_028
SELECT * FROM where_arith WHERE a * 2 > b + 25;

DROP TABLE IF EXISTS order_arith;
CREATE TABLE order_arith (a INT64, b INT64);
INSERT INTO order_arith VALUES (10, 5);
INSERT INTO order_arith VALUES (5, 10);
INSERT INTO order_arith VALUES (8, 7);

-- Tag: operators_arithmetic_test_select_029
SELECT a, b FROM order_arith ORDER BY a + b DESC;

DROP TABLE IF EXISTS lit_arith;
CREATE TABLE lit_arith (value INT64);
INSERT INTO lit_arith VALUES (100);

-- Tag: operators_arithmetic_test_select_030
SELECT value + 50 AS result FROM lit_arith;

DROP TABLE IF EXISTS lit_arith2;
CREATE TABLE lit_arith2 (value INT64);
INSERT INTO lit_arith2 VALUES (30);

-- Tag: operators_arithmetic_test_select_031
SELECT 100 - value AS result FROM lit_arith2;

DROP TABLE IF EXISTS int_div;
CREATE TABLE int_div (a INT64, b INT64);
INSERT INTO int_div VALUES (10, 3);

-- Tag: operators_arithmetic_test_select_032
SELECT a / b AS result FROM int_div;

DROP TABLE IF EXISTS neg_div;
CREATE TABLE neg_div (a INT64, b INT64);
INSERT INTO neg_div VALUES (-10, 3);

-- Tag: operators_arithmetic_test_select_033
SELECT a / b AS result FROM neg_div;

DROP TABLE IF EXISTS neg_add;
CREATE TABLE neg_add (a INT64, b INT64);
INSERT INTO neg_add VALUES (-10, -20);

-- Tag: operators_arithmetic_test_select_034
SELECT a + b AS result FROM neg_add;

DROP TABLE IF EXISTS neg_mult;
CREATE TABLE neg_mult (a INT64, b INT64);
INSERT INTO neg_mult VALUES (-5, -4);

-- Tag: operators_arithmetic_test_select_035
SELECT a * b AS result FROM neg_mult;

DROP TABLE IF EXISTS zero_ops;
CREATE TABLE zero_ops (a INT64, b INT64);
INSERT INTO zero_ops VALUES (0, 0);

-- Tag: operators_arithmetic_test_select_036
SELECT a + b AS result FROM zero_ops;

DROP TABLE IF EXISTS zero_mult;
CREATE TABLE zero_mult (value INT64);
INSERT INTO zero_mult VALUES (12345);

-- Tag: operators_arithmetic_test_select_037
SELECT value * 0 AS result FROM zero_mult;

DROP TABLE IF EXISTS zero_div;
CREATE TABLE zero_div (value INT64);
INSERT INTO zero_div VALUES (5);

-- Tag: operators_arithmetic_test_select_038
SELECT 0 / value AS result FROM zero_div;

DROP TABLE IF EXISTS agg_arith;
CREATE TABLE agg_arith (price INT64, quantity INT64);
INSERT INTO agg_arith VALUES (10, 3);
INSERT INTO agg_arith VALUES (20, 2);

-- Tag: operators_arithmetic_test_select_039
SELECT SUM(price * quantity) AS total FROM agg_arith;

DROP TABLE IF EXISTS agg_avg;
CREATE TABLE agg_avg (score1 INT64, score2 INT64);
INSERT INTO agg_avg VALUES (80, 90);
INSERT INTO agg_avg VALUES (70, 80);

-- Tag: operators_arithmetic_test_select_040
SELECT AVG(score1 + score2) AS avg_total FROM agg_avg;
