-- Window Functions Aggregate - SQL:2023
-- Description: Aggregate functions with OVER clause for window operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers ( id INT64, amount NUMERIC(38, 0) );
INSERT INTO big_numbers VALUES (1, 99999999999999999999999999999999999999);
DROP TABLE IF EXISTS precise_values;
CREATE TABLE precise_values ( id INT64, ratio NUMERIC(38, 38) );
INSERT INTO precise_values VALUES (1, 0.99999999999999999999999999999999999999);
DROP TABLE IF EXISTS zeros;
CREATE TABLE zeros ( id INT64, value NUMERIC(10, 2) );
INSERT INTO zeros VALUES (1, 0.00);
INSERT INTO zeros VALUES (2, -0.00);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices ( id INT64, price NUMERIC(10, 4) );
INSERT INTO prices VALUES (1, 1.2);
DROP TABLE IF EXISTS division_test;
CREATE TABLE division_test ( dividend NUMERIC(10, 2), divisor NUMERIC(10, 2) );
INSERT INTO division_test VALUES (10.00, 3.00);
DROP TABLE IF EXISTS multiplication;
CREATE TABLE multiplication ( factor1 NUMERIC(10, 2), factor2 NUMERIC(10, 2) );
INSERT INTO multiplication VALUES (9999.99, 9999.99);
DROP TABLE IF EXISTS modulo_test;
CREATE TABLE modulo_test ( dividend NUMERIC(10, 2), divisor NUMERIC(10, 2) );
INSERT INTO modulo_test VALUES (10.50, 3.20);
DROP TABLE IF EXISTS scale_test;
CREATE TABLE scale_test ( id INT64, value1 NUMERIC(10, 1), value2 NUMERIC(10, 2) );
INSERT INTO scale_test VALUES (1, 1.2, 1.20);
DROP TABLE IF EXISTS big_sums;
CREATE TABLE big_sums ( id INT64, amount NUMERIC(38, 0) );
DROP TABLE IF EXISTS same_scores;
CREATE TABLE same_scores ( id INT64, score INT64 );
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings ( id INT64, score INT64 );
INSERT INTO rankings VALUES (1, 100);
INSERT INTO rankings VALUES (2, 100);
INSERT INTO rankings VALUES (3, 90);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence ( id INT64, value INT64 );
INSERT INTO sequence VALUES (1, 10);
INSERT INTO sequence VALUES (2, 20);
INSERT INTO sequence VALUES (3, 30);
DROP TABLE IF EXISTS small_set;
CREATE TABLE small_set ( id INT64, value INT64 );
INSERT INTO small_set VALUES (1, 100);
INSERT INTO small_set VALUES (2, 200);
INSERT INTO small_set VALUES (3, 300);
DROP TABLE IF EXISTS unique_categories;
CREATE TABLE unique_categories ( id INT64, category STRING, value INT64 );
INSERT INTO unique_categories VALUES (1, 'A', 100);
INSERT INTO unique_categories VALUES (2, 'B', 200);
INSERT INTO unique_categories VALUES (3, 'C', 300);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS nullable_scores;
CREATE TABLE nullable_scores ( id INT64, score INT64 );
INSERT INTO nullable_scores VALUES (1, 100);
INSERT INTO nullable_scores VALUES (2, NULL);
INSERT INTO nullable_scores VALUES (3, 200);
INSERT INTO nullable_scores VALUES (4, NULL);
DROP TABLE IF EXISTS single_value;
CREATE TABLE single_value ( value FLOAT64 );
INSERT INTO single_value VALUES (42.0);
DROP TABLE IF EXISTS two_values;
CREATE TABLE two_values ( value FLOAT64 );
INSERT INTO two_values VALUES (10.0);
INSERT INTO two_values VALUES (20.0);
DROP TABLE IF EXISTS identical;
CREATE TABLE identical ( value FLOAT64 );
INSERT INTO identical VALUES (42.0);
DROP TABLE IF EXISTS even_count;
CREATE TABLE even_count ( value FLOAT64 );
INSERT INTO even_count VALUES (1.0);
INSERT INTO even_count VALUES (2.0);
INSERT INTO even_count VALUES (3.0);
INSERT INTO even_count VALUES (4.0);
DROP TABLE IF EXISTS odd_count;
CREATE TABLE odd_count ( value FLOAT64 );
INSERT INTO odd_count VALUES (1.0);
INSERT INTO odd_count VALUES (2.0);
INSERT INTO odd_count VALUES (3.0);
INSERT INTO odd_count VALUES (4.0);
INSERT INTO odd_count VALUES (5.0);
DROP TABLE IF EXISTS with_nulls;
CREATE TABLE with_nulls ( value FLOAT64 );
INSERT INTO with_nulls VALUES (1.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (2.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (3.0);
DROP TABLE IF EXISTS extreme_values;
CREATE TABLE extreme_values ( value FLOAT64 );
INSERT INTO extreme_values VALUES (1.0);
INSERT INTO extreme_values VALUES (1000000.0);
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_001
SELECT amount FROM big_numbers WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_002
SELECT ratio FROM precise_values;
-- Tag: window_functions_window_functions_aggregate_test_select_003
SELECT COUNT(*) FROM zeros WHERE value = 0.00;
-- Tag: window_functions_window_functions_aggregate_test_select_004
SELECT price FROM prices;
-- Tag: window_functions_window_functions_aggregate_test_select_005
SELECT dividend / divisor AS quotient FROM division_test;
-- Tag: window_functions_window_functions_aggregate_test_select_006
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_aggregate_test_select_007
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_aggregate_test_select_008
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_aggregate_test_select_009
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_aggregate_test_select_010
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_011
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_012
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_013
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_014
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_aggregate_test_select_015
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_aggregate_test_select_016
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_017
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_018
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_aggregate_test_select_019
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_aggregate_test_select_020
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_aggregate_test_select_021
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_aggregate_test_select_022
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_023
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_aggregate_test_select_024
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_aggregate_test_select_025
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_aggregate_test_select_026
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_aggregate_test_select_027
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_aggregate_test_select_028
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_aggregate_test_select_029
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_aggregate_test_select_030
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_031
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS precise_values;
CREATE TABLE precise_values ( id INT64, ratio NUMERIC(38, 38) );
INSERT INTO precise_values VALUES (1, 0.99999999999999999999999999999999999999);
DROP TABLE IF EXISTS zeros;
CREATE TABLE zeros ( id INT64, value NUMERIC(10, 2) );
INSERT INTO zeros VALUES (1, 0.00);
INSERT INTO zeros VALUES (2, -0.00);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices ( id INT64, price NUMERIC(10, 4) );
INSERT INTO prices VALUES (1, 1.2);
DROP TABLE IF EXISTS division_test;
CREATE TABLE division_test ( dividend NUMERIC(10, 2), divisor NUMERIC(10, 2) );
INSERT INTO division_test VALUES (10.00, 3.00);
DROP TABLE IF EXISTS multiplication;
CREATE TABLE multiplication ( factor1 NUMERIC(10, 2), factor2 NUMERIC(10, 2) );
INSERT INTO multiplication VALUES (9999.99, 9999.99);
DROP TABLE IF EXISTS modulo_test;
CREATE TABLE modulo_test ( dividend NUMERIC(10, 2), divisor NUMERIC(10, 2) );
INSERT INTO modulo_test VALUES (10.50, 3.20);
DROP TABLE IF EXISTS scale_test;
CREATE TABLE scale_test ( id INT64, value1 NUMERIC(10, 1), value2 NUMERIC(10, 2) );
INSERT INTO scale_test VALUES (1, 1.2, 1.20);
DROP TABLE IF EXISTS big_sums;
CREATE TABLE big_sums ( id INT64, amount NUMERIC(38, 0) );
DROP TABLE IF EXISTS same_scores;
CREATE TABLE same_scores ( id INT64, score INT64 );
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings ( id INT64, score INT64 );
INSERT INTO rankings VALUES (1, 100);
INSERT INTO rankings VALUES (2, 100);
INSERT INTO rankings VALUES (3, 90);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence ( id INT64, value INT64 );
INSERT INTO sequence VALUES (1, 10);
INSERT INTO sequence VALUES (2, 20);
INSERT INTO sequence VALUES (3, 30);
DROP TABLE IF EXISTS small_set;
CREATE TABLE small_set ( id INT64, value INT64 );
INSERT INTO small_set VALUES (1, 100);
INSERT INTO small_set VALUES (2, 200);
INSERT INTO small_set VALUES (3, 300);
DROP TABLE IF EXISTS unique_categories;
CREATE TABLE unique_categories ( id INT64, category STRING, value INT64 );
INSERT INTO unique_categories VALUES (1, 'A', 100);
INSERT INTO unique_categories VALUES (2, 'B', 200);
INSERT INTO unique_categories VALUES (3, 'C', 300);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS nullable_scores;
CREATE TABLE nullable_scores ( id INT64, score INT64 );
INSERT INTO nullable_scores VALUES (1, 100);
INSERT INTO nullable_scores VALUES (2, NULL);
INSERT INTO nullable_scores VALUES (3, 200);
INSERT INTO nullable_scores VALUES (4, NULL);
DROP TABLE IF EXISTS single_value;
CREATE TABLE single_value ( value FLOAT64 );
INSERT INTO single_value VALUES (42.0);
DROP TABLE IF EXISTS two_values;
CREATE TABLE two_values ( value FLOAT64 );
INSERT INTO two_values VALUES (10.0);
INSERT INTO two_values VALUES (20.0);
DROP TABLE IF EXISTS identical;
CREATE TABLE identical ( value FLOAT64 );
INSERT INTO identical VALUES (42.0);
DROP TABLE IF EXISTS even_count;
CREATE TABLE even_count ( value FLOAT64 );
INSERT INTO even_count VALUES (1.0);
INSERT INTO even_count VALUES (2.0);
INSERT INTO even_count VALUES (3.0);
INSERT INTO even_count VALUES (4.0);
DROP TABLE IF EXISTS odd_count;
CREATE TABLE odd_count ( value FLOAT64 );
INSERT INTO odd_count VALUES (1.0);
INSERT INTO odd_count VALUES (2.0);
INSERT INTO odd_count VALUES (3.0);
INSERT INTO odd_count VALUES (4.0);
INSERT INTO odd_count VALUES (5.0);
DROP TABLE IF EXISTS with_nulls;
CREATE TABLE with_nulls ( value FLOAT64 );
INSERT INTO with_nulls VALUES (1.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (2.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (3.0);
DROP TABLE IF EXISTS extreme_values;
CREATE TABLE extreme_values ( value FLOAT64 );
INSERT INTO extreme_values VALUES (1.0);
INSERT INTO extreme_values VALUES (1000000.0);
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_032
SELECT ratio FROM precise_values;
-- Tag: window_functions_window_functions_aggregate_test_select_033
SELECT COUNT(*) FROM zeros WHERE value = 0.00;
-- Tag: window_functions_window_functions_aggregate_test_select_034
SELECT price FROM prices;
-- Tag: window_functions_window_functions_aggregate_test_select_035
SELECT dividend / divisor AS quotient FROM division_test;
-- Tag: window_functions_window_functions_aggregate_test_select_036
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_aggregate_test_select_037
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_aggregate_test_select_038
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_aggregate_test_select_039
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_aggregate_test_select_040
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_041
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_042
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_043
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_044
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_aggregate_test_select_045
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_aggregate_test_select_046
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_047
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_048
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_aggregate_test_select_049
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_aggregate_test_select_050
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_aggregate_test_select_051
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_aggregate_test_select_052
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_053
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_aggregate_test_select_054
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_aggregate_test_select_055
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_aggregate_test_select_056
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_aggregate_test_select_057
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_aggregate_test_select_058
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_aggregate_test_select_059
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_aggregate_test_select_060
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_061
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS big_sums;
CREATE TABLE big_sums ( id INT64, amount NUMERIC(38, 0) );
DROP TABLE IF EXISTS same_scores;
CREATE TABLE same_scores ( id INT64, score INT64 );
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings ( id INT64, score INT64 );
INSERT INTO rankings VALUES (1, 100);
INSERT INTO rankings VALUES (2, 100);
INSERT INTO rankings VALUES (3, 90);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence ( id INT64, value INT64 );
INSERT INTO sequence VALUES (1, 10);
INSERT INTO sequence VALUES (2, 20);
INSERT INTO sequence VALUES (3, 30);
DROP TABLE IF EXISTS small_set;
CREATE TABLE small_set ( id INT64, value INT64 );
INSERT INTO small_set VALUES (1, 100);
INSERT INTO small_set VALUES (2, 200);
INSERT INTO small_set VALUES (3, 300);
DROP TABLE IF EXISTS unique_categories;
CREATE TABLE unique_categories ( id INT64, category STRING, value INT64 );
INSERT INTO unique_categories VALUES (1, 'A', 100);
INSERT INTO unique_categories VALUES (2, 'B', 200);
INSERT INTO unique_categories VALUES (3, 'C', 300);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS nullable_scores;
CREATE TABLE nullable_scores ( id INT64, score INT64 );
INSERT INTO nullable_scores VALUES (1, 100);
INSERT INTO nullable_scores VALUES (2, NULL);
INSERT INTO nullable_scores VALUES (3, 200);
INSERT INTO nullable_scores VALUES (4, NULL);
DROP TABLE IF EXISTS single_value;
CREATE TABLE single_value ( value FLOAT64 );
INSERT INTO single_value VALUES (42.0);
DROP TABLE IF EXISTS two_values;
CREATE TABLE two_values ( value FLOAT64 );
INSERT INTO two_values VALUES (10.0);
INSERT INTO two_values VALUES (20.0);
DROP TABLE IF EXISTS identical;
CREATE TABLE identical ( value FLOAT64 );
INSERT INTO identical VALUES (42.0);
DROP TABLE IF EXISTS even_count;
CREATE TABLE even_count ( value FLOAT64 );
INSERT INTO even_count VALUES (1.0);
INSERT INTO even_count VALUES (2.0);
INSERT INTO even_count VALUES (3.0);
INSERT INTO even_count VALUES (4.0);
DROP TABLE IF EXISTS odd_count;
CREATE TABLE odd_count ( value FLOAT64 );
INSERT INTO odd_count VALUES (1.0);
INSERT INTO odd_count VALUES (2.0);
INSERT INTO odd_count VALUES (3.0);
INSERT INTO odd_count VALUES (4.0);
INSERT INTO odd_count VALUES (5.0);
DROP TABLE IF EXISTS with_nulls;
CREATE TABLE with_nulls ( value FLOAT64 );
INSERT INTO with_nulls VALUES (1.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (2.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (3.0);
DROP TABLE IF EXISTS extreme_values;
CREATE TABLE extreme_values ( value FLOAT64 );
INSERT INTO extreme_values VALUES (1.0);
INSERT INTO extreme_values VALUES (1000000.0);
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_062
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_aggregate_test_select_063
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_064
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_065
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_066
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_067
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_aggregate_test_select_068
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_aggregate_test_select_069
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_aggregate_test_select_070
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_071
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_aggregate_test_select_072
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_aggregate_test_select_073
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_aggregate_test_select_074
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_aggregate_test_select_075
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_076
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_aggregate_test_select_077
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_aggregate_test_select_078
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_aggregate_test_select_079
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_aggregate_test_select_080
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_aggregate_test_select_081
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_aggregate_test_select_082
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_aggregate_test_select_083
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_084
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS even_count;
CREATE TABLE even_count ( value FLOAT64 );
INSERT INTO even_count VALUES (1.0);
INSERT INTO even_count VALUES (2.0);
INSERT INTO even_count VALUES (3.0);
INSERT INTO even_count VALUES (4.0);
DROP TABLE IF EXISTS odd_count;
CREATE TABLE odd_count ( value FLOAT64 );
INSERT INTO odd_count VALUES (1.0);
INSERT INTO odd_count VALUES (2.0);
INSERT INTO odd_count VALUES (3.0);
INSERT INTO odd_count VALUES (4.0);
INSERT INTO odd_count VALUES (5.0);
DROP TABLE IF EXISTS with_nulls;
CREATE TABLE with_nulls ( value FLOAT64 );
INSERT INTO with_nulls VALUES (1.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (2.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (3.0);
DROP TABLE IF EXISTS extreme_values;
CREATE TABLE extreme_values ( value FLOAT64 );
INSERT INTO extreme_values VALUES (1.0);
INSERT INTO extreme_values VALUES (1000000.0);
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_085
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_aggregate_test_select_086
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_aggregate_test_select_087
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_088
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_aggregate_test_select_089
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_aggregate_test_select_090
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_aggregate_test_select_091
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_aggregate_test_select_092
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_aggregate_test_select_093
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_aggregate_test_select_094
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_aggregate_test_select_095
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_096
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS odd_count;
CREATE TABLE odd_count ( value FLOAT64 );
INSERT INTO odd_count VALUES (1.0);
INSERT INTO odd_count VALUES (2.0);
INSERT INTO odd_count VALUES (3.0);
INSERT INTO odd_count VALUES (4.0);
INSERT INTO odd_count VALUES (5.0);
DROP TABLE IF EXISTS with_nulls;
CREATE TABLE with_nulls ( value FLOAT64 );
INSERT INTO with_nulls VALUES (1.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (2.0);
INSERT INTO with_nulls VALUES (NULL);
INSERT INTO with_nulls VALUES (3.0);
DROP TABLE IF EXISTS extreme_values;
CREATE TABLE extreme_values ( value FLOAT64 );
INSERT INTO extreme_values VALUES (1.0);
INSERT INTO extreme_values VALUES (1000000.0);
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table ( value FLOAT64 );
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( id INT64, account STRING, amount NUMERIC(10, 2), date DATE );
INSERT INTO transactions VALUES (1, 'A', 100.50, '2025-01-01');
INSERT INTO transactions VALUES (2, 'A', 200.25, '2025-01-02');
INSERT INTO transactions VALUES (3, 'B', 150.00, '2025-01-01');
INSERT INTO transactions VALUES (4, 'B', 300.75, '2025-01-02');
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries ( id INT64, department STRING, salary FLOAT64 );
INSERT INTO salaries VALUES (1, 'Engineering', 100000);
INSERT INTO salaries VALUES (2, 'Engineering', 105000);
INSERT INTO salaries VALUES (3, 'Engineering', 102000);
INSERT INTO salaries VALUES (4, 'Sales', 50000);
INSERT INTO salaries VALUES (5, 'Sales', 150000);
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales ( product_id INT64, category STRING, sales FLOAT64 );
INSERT INTO product_sales VALUES (1, 'Electronics', 1000);
INSERT INTO product_sales VALUES (2, 'Electronics', 2000);
INSERT INTO product_sales VALUES (3, 'Electronics', 1500);
INSERT INTO product_sales VALUES (4, 'Clothing', 500);
INSERT INTO product_sales VALUES (5, 'Clothing', 800);
DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_097
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_aggregate_test_select_098
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_099
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_aggregate_test_select_100
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_aggregate_test_select_101
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_aggregate_test_select_102
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_aggregate_test_select_103
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_aggregate_test_select_104
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_aggregate_test_select_105
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_aggregate_test_select_106
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_107
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_aggregate_test_select_108
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_109
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (2), (3), (3), (3), (4), (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (1), (2), (2), (3);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 200), ('B', 150), ('B', 50), ('C', 75);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 8), (3, 6), (4, 4), (5, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 5), (2, 3), (3, 8), (4, 2), (5, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_110
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_111
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_112
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_113
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_114
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_115
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_116
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_117
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_118
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_119
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_120
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_121
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_122
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_123
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_124
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_125
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_126
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_127
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_128
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_129
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_130
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_131
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_001
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_002
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_003
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_132
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_133
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_134
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_135
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_004
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_136
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_137
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_138
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_139
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_140
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (2), (3), (3), (3), (4), (5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (1), (2), (2), (3);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 200), ('B', 150), ('B', 50), ('C', 75);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 8), (3, 6), (4, 4), (5, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 5), (2, 3), (3, 8), (4, 2), (5, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_141
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_142
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_143
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_144
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_145
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_146
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_147
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_148
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_149
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_150
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_151
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_152
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_153
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_154
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_155
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_156
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_157
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_158
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_159
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_160
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_161
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_005
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_006
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_007
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_162
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_163
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_164
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_165
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_008
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_166
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_167
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_168
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_169
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_170
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 200), ('B', 150), ('B', 50), ('C', 75);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 8), (3, 6), (4, 4), (5, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 5), (2, 3), (3, 8), (4, 2), (5, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_171
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_172
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_173
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_174
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_175
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_176
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_177
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_178
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_179
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_180
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_181
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_182
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_183
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_184
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_185
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_186
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_187
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_188
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_009
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_010
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_011
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_189
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_190
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_191
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_192
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_012
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_193
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_194
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_195
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_196
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_197
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 200), ('B', 150), ('B', 50), ('C', 75);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 10), (2, 8), (3, 6), (4, 4), (5, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 5), (2, 3), (3, 8), (4, 2), (5, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (2, 4), (3, 6), (4, 8), (5, 10);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_198
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_199
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_200
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_201
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_202
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_203
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_204
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_205
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_206
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_207
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_208
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_209
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_210
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_211
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_212
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_213
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_214
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_013
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_014
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_015
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_215
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_216
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_217
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_218
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_016
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_219
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_220
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_221
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_222
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_223
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_224
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_225
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_226
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_227
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_228
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_229
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_230
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_231
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_232
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_233
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_234
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_017
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_018
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_019
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_235
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_236
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_237
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_238
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_020
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_239
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_240
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_241
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_242
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_243
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), (NULL), ('B'), (NULL), ('C');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_244
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_245
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_246
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_247
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_248
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_249
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_250
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_251
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_252
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_253
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_021
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_022
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_023
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_254
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_255
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_256
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_257
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_024
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_258
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_259
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_260
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_261
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_262
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_263
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_264
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_265
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_266
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_267
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_268
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_269
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_270
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_271
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_025
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_026
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_027
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_272
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_273
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_274
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_275
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_028
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_276
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_277
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_278
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_279
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_280
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (30), (10), (50), (20), (40);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('A'), ('B'), ('B'), ('C');
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS items;
CREATE TABLE items (value INT64);
INSERT INTO items VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (category STRING, value FLOAT64);
INSERT INTO measurements VALUES ('A', 10), ('A', 20), ('A', 30);
INSERT INTO measurements VALUES ('B', 100), ('B', 200), ('B', 300);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score FLOAT64);
INSERT INTO scores VALUES ('A', 85), ('A', 90), ('A', 95);
INSERT INTO scores VALUES ('B', 70), ('B', 75), ('B', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150), ('B', 200), ('B', 250);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (dept STRING, salary FLOAT64);
INSERT INTO employees VALUES ('Sales', 50000), ('Sales', 60000), ('Sales', 70000);
INSERT INTO employees VALUES ('Eng', 80000), ('Eng', 90000), ('Eng', 100000);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42), (42), (42), (42), (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (10), (20), (30), (30), (30);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x FLOAT64, y FLOAT64);
INSERT INTO data VALUES (1, 2), (NULL, 4), (3, 6), (4, NULL), (5, 10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (x STRING, y FLOAT64);
INSERT INTO data VALUES ('a', 1.0), ('b', 2.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (category STRING);
INSERT INTO items VALUES ('A'), ('B'), ('C');

-- Tag: window_functions_window_functions_aggregate_test_select_281
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_282
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_283
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_284
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_285
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_286
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_287
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_288
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_aggregate_test_select_029
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_030
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_031
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_aggregate_test_select_289
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_290
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_291
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_292
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_032
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_293
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_294
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_295
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_296
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_297
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_aggregate_test_select_298
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (val INT64);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO numbers VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (val STRING);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);
INSERT INTO strings VALUES ('1');
INSERT INTO strings VALUES ('3');
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, val INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (parent_id INT64, amount INT64);
INSERT INTO outer_table VALUES (1, 100);
INSERT INTO outer_table VALUES (2, 200);
INSERT INTO inner_table VALUES (1, 50);
INSERT INTO inner_table VALUES (1, 30);
INSERT INTO inner_table VALUES (2, 20);
DROP TABLE IF EXISTS int_table;
CREATE TABLE int_table (id INT64, data STRING);
DROP TABLE IF EXISTS str_table;
CREATE TABLE str_table (id_str STRING, value INT64);
INSERT INTO int_table VALUES (1, 'A');
INSERT INTO int_table VALUES (2, 'B');
INSERT INTO str_table VALUES ('1', 100);
INSERT INTO str_table VALUES ('3', 300);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64, b FLOAT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (x STRING, y STRING);
INSERT INTO t1 VALUES (1, 2.5);
INSERT INTO t2 VALUES ('1', '2.5');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (1, 20);
INSERT INTO data VALUES (2, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val STRING);
INSERT INTO data VALUES ('not a number');
DROP TABLE IF EXISTS data;
CREATE TABLE data (val STRING);
INSERT INTO data VALUES ('');
DROP TABLE IF EXISTS data;
CREATE TABLE data (val STRING);
INSERT INTO data VALUES (' 42 ');
DROP TABLE IF EXISTS bools;
CREATE TABLE bools (val BOOL);
INSERT INTO bools VALUES (TRUE);
INSERT INTO bools VALUES (FALSE);
INSERT INTO bools VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val STRING);
INSERT INTO data VALUES ('abc123def');
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS int_data;
CREATE TABLE int_data (val INT64);
DROP TABLE IF EXISTS str_data;
CREATE TABLE str_data (val STRING);
INSERT INTO int_data VALUES (42);
INSERT INTO str_data VALUES ('hello');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', NULL);
INSERT INTO data VALUES ('B', 20);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (val INT64);
INSERT INTO bounds VALUES (0);
INSERT INTO bounds VALUES (-1);
INSERT INTO bounds VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_299
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_300
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_aggregate_test_select_301
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_302
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_303
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_aggregate_test_select_304
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_aggregate_test_select_305
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_306
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_aggregate_test_select_307
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_308
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_309
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_310
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_aggregate_test_select_311
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_aggregate_test_select_312
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_aggregate_test_select_313
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_314
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_315
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_aggregate_test_select_316
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_aggregate_test_select_317
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_318
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_319
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_320
SELECT 3.14;
-- Tag: window_functions_window_functions_aggregate_test_select_321
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_322
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_033
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_aggregate_test_select_323
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_324
SELECT category,
CAST(
CASE
WHEN SUM(COALESCE(value, 0)) > 15
THEN CONCAT('high: ', CAST(SUM(COALESCE(value, 0)) AS STRING))
ELSE CONCAT('low: ', CAST(SUM(COALESCE(value, 0)) AS STRING))
END
AS STRING) as status
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_325
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, NULL), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_326
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_327
SELECT COUNT(*) AS total, COUNT(value) AS non_null, COUNT(DISTINCT value) AS unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_328
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_329
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_330
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_331
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_332
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_333
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_334
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_335
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_336
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_337
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_338
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_339
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_340
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_341
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_342
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_343
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_344
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_345
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_346
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_347
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_348
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_349
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_350
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, NULL), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_351
SELECT COUNT(*) AS total, COUNT(value) AS non_null, COUNT(DISTINCT value) AS unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_352
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_353
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_354
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_355
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_356
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_357
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_358
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_359
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_360
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_361
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_362
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_363
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_364
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_365
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_366
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_367
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_368
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_369
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_370
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_371
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_372
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_373
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_374
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, NULL), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_375
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_376
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_377
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_378
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_379
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_380
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_381
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_382
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_383
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_384
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_385
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_386
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_387
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_388
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_389
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_390
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_391
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_392
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_393
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_394
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_395
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_396
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_397
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_398
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_399
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_400
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_401
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_402
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_403
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_404
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_405
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_406
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_407
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_408
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_409
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_410
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_411
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_412
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_413
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_414
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_415
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_416
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_417
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_418
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_419
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_420
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_421
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_422
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_423
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_424
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_425
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_426
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_427
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_428
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_429
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_430
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_431
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_432
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_433
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_434
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_435
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_436
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_437
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_438
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_439
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_440
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30), (5, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_441
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_442
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_443
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_444
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_445
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_446
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_447
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_448
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_449
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_450
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_451
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_452
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_453
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_454
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_455
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_456
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_457
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_458
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_459
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_460
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_461
SELECT SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_462
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_463
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_464
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_465
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_466
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_467
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_468
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_469
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_470
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_471
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_472
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_473
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_474
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_475
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_476
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_477
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_478
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_479
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 10), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_480
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_481
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_482
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_483
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_484
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_485
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_486
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_487
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_488
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_489
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_490
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_491
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_492
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_493
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_494
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_495
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_496
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_497
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.5), (2, 20.5), (3, 10.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_498
SELECT SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_499
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_500
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_501
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_502
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_503
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_504
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_505
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_506
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_507
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_508
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_509
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_510
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_511
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_512
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_513
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_514
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_515
SELECT AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_516
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_517
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_518
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_519
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_520
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_521
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_522
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_523
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_524
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_525
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_526
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_527
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_528
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_529
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_530
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_531
SELECT AVG(value) AS total_avg, AVG(DISTINCT value) AS distinct_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_532
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_533
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_534
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_535
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_536
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_537
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_538
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_539
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_540
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_541
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_542
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_543
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_544
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_545
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 10), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_546
SELECT MIN(DISTINCT value) AS min_val, MAX(DISTINCT value) AS max_val FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_547
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_548
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_549
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_550
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_551
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_552
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_553
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_554
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_555
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_556
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_557
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_558
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_559
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5), (4, 30, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_560
SELECT COUNT(DISTINCT a + b) AS unique_sums FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_561
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_562
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_563
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_564
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_565
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_566
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_567
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_568
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_569
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_570
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_571
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_572
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 5), (2, 20, 10), (3, 10, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_573
SELECT SUM(DISTINCT a * b) AS unique_products FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_574
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_575
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_576
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_577
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_578
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_579
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_580
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_581
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_582
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_583
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_584
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'alice'), (2, 'ALICE'), (3, 'Bob'), (4, 'bob');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_585
SELECT COUNT(DISTINCT UPPER(name)) AS unique_upper FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_586
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_587
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_588
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_589
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_590
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_591
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_592
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_593
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_594
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_595
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30), (5, 'B', 30), (6, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_596
SELECT category, COUNT(DISTINCT value) AS unique_values FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_597
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_598
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_599
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_600
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_601
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_602
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_603
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_604
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_605
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, col1 INT64, col2 INT64);
INSERT INTO test VALUES (1, 10, 100), (2, 10, 200), (3, 20, 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_606
SELECT category, SUM(DISTINCT value) AS distinct_sum FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_607
SELECT COUNT(DISTINCT col1) AS unique_col1, COUNT(DISTINCT col2) AS unique_col2 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_608
SELECT COUNT(*) AS total, COUNT(DISTINCT value) AS unique, SUM(value) AS total_sum, SUM(DISTINCT value) AS distinct_sum FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_609
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_610
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_611
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_612
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_613
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_614
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 10), (3, 'A', 20), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'apple'), (2, 'banana'), (3, 'apple'), (4, 'cherry');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'zebra'), (2, 'apple'), (3, 'zebra'), (4, 'banana');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_615
SELECT id, category, COUNT(DISTINCT value) OVER (PARTITION BY category) AS unique_in_category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_616
SELECT STRING_AGG(DISTINCT value, ', ') AS unique_fruits FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_617
SELECT STRING_AGG(DISTINCT value, ', ' ORDER BY value) AS sorted_unique FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_618
SELECT category FROM test GROUP BY category HAVING COUNT(DISTINCT value) > 1;
-- Tag: window_functions_window_functions_aggregate_test_select_619
SELECT COUNT(DISTINCT value) AS unique_count FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_620
SELECT COUNT(DISTINCT value) AS unique_count, SUM(DISTINCT value) AS unique_sum FROM test;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (9223372036854775807);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (0, 0);
INSERT INTO numbers VALUES (1, 0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-100);
INSERT INTO numbers VALUES (-1);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (id INT64, text STRING);
INSERT INTO unicode VALUES (1, 'Hello 世界');
INSERT INTO unicode VALUES (2, 'Привет мир');
INSERT INTO unicode VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS special;
CREATE TABLE special (id INT64, text STRING);
INSERT INTO special VALUES (1, 'Line1
Line2');
INSERT INTO special VALUES (2, 'Tab\there');
INSERT INTO special VALUES (3, 'Quote''s');
DROP TABLE IF EXISTS spaces;
CREATE TABLE spaces (id INT64, text STRING);
INSERT INTO spaces VALUES (1, ' leading');
INSERT INTO spaces VALUES (2, 'trailing ');
INSERT INTO spaces VALUES (3, ' both ');
DROP TABLE IF EXISTS duplicates;
CREATE TABLE duplicates (value INT64);
INSERT INTO duplicates VALUES (42);
DROP TABLE IF EXISTS single;
CREATE TABLE single (id INT64, value STRING);
INSERT INTO single VALUES (1, 'only');
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 0.0);
INSERT INTO floats VALUES (2, -0.0);
INSERT INTO floats VALUES (3, 1.7976931348623157E308);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (value FLOAT64);
INSERT INTO floats VALUES (2.2250738585072014E-308);
INSERT INTO floats VALUES (1e-300);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (category STRING, value INT64);
DROP TABLE IF EXISTS distinct_vals;
CREATE TABLE distinct_vals (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (id INT64, text STRING);
INSERT INTO whitespace VALUES (1, '  ');
INSERT INTO whitespace VALUES (2, '\t\t');
INSERT INTO whitespace VALUES (3, '
');

-- Tag: window_functions_window_functions_aggregate_test_select_621
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_622
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_623
SELECT * FROM numbers WHERE id = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_624
SELECT * FROM numbers WHERE value = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_625
SELECT SUM(value) FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_626
SELECT * FROM numbers WHERE value < 0;
-- Tag: window_functions_window_functions_aggregate_test_select_627
SELECT * FROM texts;
-- Tag: window_functions_window_functions_aggregate_test_select_628
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_aggregate_test_select_629
SELECT * FROM special;
-- Tag: window_functions_window_functions_aggregate_test_select_630
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_aggregate_test_select_631
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_aggregate_test_select_632
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_aggregate_test_select_633
SELECT * FROM single;
-- Tag: window_functions_window_functions_aggregate_test_select_634
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_aggregate_test_select_635
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_aggregate_test_select_636
SELECT * FROM empty;
-- Tag: window_functions_window_functions_aggregate_test_select_637
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_aggregate_test_select_638
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_aggregate_test_select_639
SELECT * FROM floats;
-- Tag: window_functions_window_functions_aggregate_test_select_640
SELECT * FROM floats;
-- Tag: window_functions_window_functions_aggregate_test_select_641
SELECT * FROM wide;
-- Tag: window_functions_window_functions_aggregate_test_select_642
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_aggregate_test_select_643
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_644
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_aggregate_test_select_645
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_aggregate_test_select_646
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_aggregate_test_select_647
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_aggregate_test_select_648
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_649
SELECT * FROM whitespace;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (0, 0);
INSERT INTO numbers VALUES (1, 0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (-100);
INSERT INTO numbers VALUES (-1);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (1);
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (id INT64, text STRING);
INSERT INTO unicode VALUES (1, 'Hello 世界');
INSERT INTO unicode VALUES (2, 'Привет мир');
INSERT INTO unicode VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS special;
CREATE TABLE special (id INT64, text STRING);
INSERT INTO special VALUES (1, 'Line1
Line2');
INSERT INTO special VALUES (2, 'Tab\there');
INSERT INTO special VALUES (3, 'Quote''s');
DROP TABLE IF EXISTS spaces;
CREATE TABLE spaces (id INT64, text STRING);
INSERT INTO spaces VALUES (1, ' leading');
INSERT INTO spaces VALUES (2, 'trailing ');
INSERT INTO spaces VALUES (3, ' both ');
DROP TABLE IF EXISTS duplicates;
CREATE TABLE duplicates (value INT64);
INSERT INTO duplicates VALUES (42);
DROP TABLE IF EXISTS single;
CREATE TABLE single (id INT64, value STRING);
INSERT INTO single VALUES (1, 'only');
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 0.0);
INSERT INTO floats VALUES (2, -0.0);
INSERT INTO floats VALUES (3, 1.7976931348623157E308);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (value FLOAT64);
INSERT INTO floats VALUES (2.2250738585072014E-308);
INSERT INTO floats VALUES (1e-300);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
INSERT INTO numbers VALUES (15);
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (category STRING, value INT64);
DROP TABLE IF EXISTS distinct_vals;
CREATE TABLE distinct_vals (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (id INT64, text STRING);
INSERT INTO whitespace VALUES (1, '  ');
INSERT INTO whitespace VALUES (2, '\t\t');
INSERT INTO whitespace VALUES (3, '
');

-- Tag: window_functions_window_functions_aggregate_test_select_650
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_651
SELECT * FROM numbers WHERE id = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_652
SELECT * FROM numbers WHERE value = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_653
SELECT SUM(value) FROM numbers;
-- Tag: window_functions_window_functions_aggregate_test_select_654
SELECT * FROM numbers WHERE value < 0;
-- Tag: window_functions_window_functions_aggregate_test_select_655
SELECT * FROM texts;
-- Tag: window_functions_window_functions_aggregate_test_select_656
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_aggregate_test_select_657
SELECT * FROM special;
-- Tag: window_functions_window_functions_aggregate_test_select_658
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_aggregate_test_select_659
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_aggregate_test_select_660
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_aggregate_test_select_661
SELECT * FROM single;
-- Tag: window_functions_window_functions_aggregate_test_select_662
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_aggregate_test_select_663
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_aggregate_test_select_664
SELECT * FROM empty;
-- Tag: window_functions_window_functions_aggregate_test_select_665
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_aggregate_test_select_666
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_aggregate_test_select_667
SELECT * FROM floats;
-- Tag: window_functions_window_functions_aggregate_test_select_668
SELECT * FROM floats;
-- Tag: window_functions_window_functions_aggregate_test_select_669
SELECT * FROM wide;
-- Tag: window_functions_window_functions_aggregate_test_select_670
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_aggregate_test_select_671
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_672
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_aggregate_test_select_673
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_aggregate_test_select_674
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_aggregate_test_select_675
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_aggregate_test_select_676
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_677
SELECT * FROM whitespace;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 'North', 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (amount INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64, value STRING);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64, value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_678
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_aggregate_test_select_679
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_680
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_681
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_682
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_aggregate_test_select_683
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_aggregate_test_select_684
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_685
SELECT *;
-- Tag: window_functions_window_functions_aggregate_test_select_686
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_aggregate_test_select_687
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_aggregate_test_select_688
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_aggregate_test_select_689
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_aggregate_test_select_690
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_691
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_692
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_693
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64, value STRING);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64, value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_694
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_695
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_aggregate_test_select_696
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_aggregate_test_select_697
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_698
SELECT *;
-- Tag: window_functions_window_functions_aggregate_test_select_699
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_aggregate_test_select_700
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_aggregate_test_select_701
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_aggregate_test_select_702
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_aggregate_test_select_703
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_704
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_705
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_706
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_707
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_708
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_709
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING);
INSERT INTO data VALUES ('10', '20');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING);
INSERT INTO data VALUES ('Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ('not a number', 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: window_functions_window_functions_aggregate_test_select_710
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_711
SELECT a * b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_712
SELECT a - b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_713
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_714
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_aggregate_test_select_715
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_716
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_717
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_718
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_719
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_720
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_aggregate_test_select_721
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_722
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_723
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_724
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_aggregate_test_select_725
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_726
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_727
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_728
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_729
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_730
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_731
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_aggregate_test_select_732
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a STRING, b STRING);
INSERT INTO data VALUES ('10', '20');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (name STRING);
INSERT INTO data VALUES ('Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ('not a number', 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: window_functions_window_functions_aggregate_test_select_733
SELECT a * b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_734
SELECT a - b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_735
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_736
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_aggregate_test_select_737
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_738
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_739
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_740
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_741
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_742
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_aggregate_test_select_743
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_744
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_745
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_746
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_aggregate_test_select_747
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_748
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_749
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_750
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_751
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_752
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_753
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_aggregate_test_select_754
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, a_value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, b_value INT64);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, value INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, amount INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ('not a number', 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: window_functions_window_functions_aggregate_test_select_755
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_756
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_757
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_758
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_759
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_aggregate_test_select_760
SELECT * FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_761
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_762
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_763
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_aggregate_test_select_764
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_765
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_766
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_767
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_768
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_769
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_770
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_aggregate_test_select_771
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, value FLOAT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ('not a number', 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INVALID_TYPE);
ALTER TABLE nonexistent ADD COLUMN new_col INT64;
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_772
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_773
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_774
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_775
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_776
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_777
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_aggregate_test_select_778
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (big_float FLOAT64);
INSERT INTO data VALUES (1e100);

-- Tag: window_functions_window_functions_aggregate_test_select_779
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_780
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_781
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_aggregate_test_select_782
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_aggregate_test_select_783
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (str_val STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (amount INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_784
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_785
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_786
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_787
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_aggregate_test_select_788
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_aggregate_test_select_789
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_790
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_791
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_aggregate_test_select_792
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_aggregate_test_select_793
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_aggregate_test_select_794
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_034
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_795
SELECT userid FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_796
SELECT * FROM user;

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (col1 INT64, col2 INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (col1 INT64);
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS invalid;
CREATE TABLE invalid (id INT64, id INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_797
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_798
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_aggregate_test_select_799
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_aggregate_test_select_800
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_aggregate_test_select_801
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_aggregate_test_select_802
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_035
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_803
SELECT userid FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_804
SELECT * FROM user;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, age INT64);
INSERT INTO users VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS events;
CREATE TABLE events (event_date DATE);
INSERT INTO events VALUES (DATE 'invalid-date');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_805
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_aggregate_test_select_806
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_aggregate_test_select_807
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_aggregate_test_select_808
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_036
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_809
SELECT userid FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_810
SELECT * FROM user;

DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
INSERT INTO t VALUES (10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val FLOAT64);
INSERT INTO t VALUES (-1.0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
DROP TABLE nonexistent;
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES ('not_an_int', 'Alice');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
INSERT INTO t VALUES (1), (2), (3);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id STRING);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES ('1');
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (column_name INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_811
SELECT ABS(val, val) FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_812
SELECT val / 0 FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_813
SELECT SQRT(val) FROM t;
UPDATE nonexistent SET col = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_814
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_815
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_816
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_817
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_aggregate_test_select_818
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_aggregate_test_select_819
SELECT * FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_820
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_aggregate_test_select_821
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_822
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_823
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_824
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
INSERT INTO t VALUES (1), (2), (3);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id STRING);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES ('1');
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (column_name INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);

UPDATE nonexistent SET col = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_825
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_826
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_aggregate_test_select_827
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_828
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_aggregate_test_select_829
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_aggregate_test_select_830
SELECT * FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_831
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_aggregate_test_select_832
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_833
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_834
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_835
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (column_name INT64);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);

-- Tag: window_functions_window_functions_aggregate_test_select_836
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_aggregate_test_select_837
SELECT * FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_838
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_aggregate_test_select_839
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_840
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_aggregate_test_select_841
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_842
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_aggregate_test_select_843
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_aggregate_test_select_844
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_845
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_846
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_847
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_848
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_849
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_850
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_851
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_852
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_853
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_854
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_aggregate_test_select_855
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_856
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_857
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_aggregate_test_select_858
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_aggregate_test_select_859
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice'), (2, 'Bob', 'EXTRA');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (name, age, id) VALUES ('Alice', 30, 1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, id) VALUES (1, 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data (id, nonexistent) VALUES (1, 'value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_aggregate_test_select_860
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_aggregate_test_select_861
SELECT age FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_862
SELECT id, name, age FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_863
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_864
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_865
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_866
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_867
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_868
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_869
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_870
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_871
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_aggregate_test_select_872
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_873
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_874
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_aggregate_test_select_875
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_aggregate_test_select_876
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, age INT64);
INSERT INTO data (id, name) VALUES (1, 'Alice', 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING, status STRING DEFAULT 'active');
INSERT INTO data (id, name) VALUES (1, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING DEFAULT 'pending');
INSERT INTO data VALUES (1, DEFAULT);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 DEFAULT 0, name STRING DEFAULT 'unknown');
INSERT INTO data DEFAULT VALUES;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 NOT NULL, name STRING);
INSERT INTO data VALUES (NULL, 'Alice');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (1, 'Bob');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, age INT64, CHECK (age >= 0));
INSERT INTO data VALUES (1, -5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
INSERT INTO users VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, 99);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, user_id INT64, FOREIGN KEY (user_id) REFERENCES users(id));
INSERT INTO orders VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, NULL);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10 + 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, UPPER('alice'));
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
INSERT INTO data VALUES (1, CASE WHEN 1 > 0 THEN 'positive' ELSE 'negative' END);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source;
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0);
INSERT INTO sales VALUES (2, 200.0);
INSERT INTO sales VALUES (3, 150.0);
DROP TABLE IF EXISTS ranked_sales;
CREATE TABLE ranked_sales (id INT64, amount FLOAT64, row_num INT64);
INSERT INTO ranked_sales \
-- Tag: window_functions_window_functions_aggregate_test_select_877
SELECT id, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) \
FROM sales;
DROP TABLE IF EXISTS raw;
CREATE TABLE raw (value STRING);
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('B');
INSERT INTO raw VALUES ('A');
INSERT INTO raw VALUES ('C');
INSERT INTO raw VALUES ('B');
DROP TABLE IF EXISTS unique_values;
CREATE TABLE unique_values (value STRING);
INSERT INTO unique_values SELECT DISTINCT value FROM raw;
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_id INT64);
INSERT INTO config VALUES (100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES ((SELECT max_id FROM config), 'Alice');

-- Tag: window_functions_window_functions_aggregate_test_select_878
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_879
SELECT status FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_880
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_881
SELECT * FROM data WHERE name IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_882
SELECT * FROM dest WHERE value IS NULL;
-- Tag: window_functions_window_functions_aggregate_test_select_883
SELECT value FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_884
SELECT name FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_885
SELECT category FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_886
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_aggregate_test_select_887
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_888
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_889
SELECT COUNT(*) FROM ranked_sales;
-- Tag: window_functions_window_functions_aggregate_test_select_890
SELECT COUNT(*) FROM unique_values;
-- Tag: window_functions_window_functions_aggregate_test_select_891
SELECT id FROM data WHERE name = 'Alice';

DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

-- Tag: window_functions_window_functions_aggregate_test_select_892
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_aggregate_test_select_893
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_894
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_aggregate_test_select_037
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_aggregate_test_select_895
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_896
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_aggregate_test_select_897
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_aggregate_test_select_898
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_899
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_aggregate_test_select_900
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, order_id INT64);
INSERT INTO orders VALUES (1, 101), (1, 102), (2, 201), (3, 301), (3, 302), (3, 303);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, status STRING);
INSERT INTO test VALUES (1, 'active');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, country STRING, active BOOL);
INSERT INTO users VALUES (1, 25, 'US', true), (2, 17, 'UK', true), (3, 30, 'US', false), (4, 40, 'UK', true);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (emp_id INT64, dept_id INT64);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (dept_id INT64, active BOOL);
INSERT INTO employees VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO departments VALUES (10, true), (20, false), (30, true);
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL, expected STRING);
INSERT INTO logic VALUES
(1, TRUE, TRUE, 'TRUE'),
(2, TRUE, FALSE, 'FALSE'),
(3, TRUE, NULL, 'NULL'),
(4, FALSE, TRUE, 'FALSE'),
(5, FALSE, FALSE, 'FALSE'),
(6, FALSE, NULL, 'FALSE'),
(7, NULL, TRUE, 'NULL'),
(8, NULL, FALSE, 'FALSE'),
(9, NULL, NULL, 'NULL');
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL);
INSERT INTO logic VALUES
(1, TRUE, TRUE),
(2, TRUE, FALSE),
(3, TRUE, NULL),
(4, FALSE, TRUE),
(5, FALSE, FALSE),
(6, FALSE, NULL),
(7, NULL, TRUE),
(8, NULL, FALSE),
(9, NULL, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL);
INSERT INTO test VALUES
(1, TRUE, TRUE),  -- (TRUE OR NULL) AND TRUE = TRUE AND TRUE = TRUE
(2, TRUE, FALSE), -- (TRUE OR NULL) AND FALSE = TRUE AND FALSE = FALSE
(3, FALSE, TRUE), -- (FALSE OR NULL) AND TRUE = NULL AND TRUE = NULL
(4, FALSE, FALSE) -- (FALSE OR NULL) AND FALSE = NULL AND FALSE = FALSE;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_aggregate_test_select_901
SELECT customer_id FROM orders GROUP BY customer_id HAVING NOT (COUNT(*) > 2) ORDER BY customer_id;
-- Tag: window_functions_window_functions_aggregate_test_select_902
SELECT id FROM test WHERE NOT value;
-- Tag: window_functions_window_functions_aggregate_test_select_903
SELECT id FROM test WHERE NOT status;
-- Tag: window_functions_window_functions_aggregate_test_select_904
SELECT id FROM users WHERE NOT (age < 18 OR country = 'US' OR NOT active) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_905
SELECT e.emp_id FROM employees e JOIN departments d ON e.dept_id = d.dept_id WHERE NOT d.active ORDER BY e.emp_id;
-- Tag: window_functions_window_functions_aggregate_test_select_906
SELECT id FROM logic WHERE a AND b;
-- Tag: window_functions_window_functions_aggregate_test_select_907
SELECT id FROM logic WHERE a OR b ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_908
SELECT id FROM test WHERE (val + 5) > 20 ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_909
SELECT id FROM test WHERE (a OR NULL) AND b ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_910
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_911
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_912
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_913
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_914
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_aggregate_test_select_915
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_aggregate_test_select_916
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_917
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_918
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_919
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_920
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_921
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_922
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_923
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_aggregate_test_select_924
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_aggregate_test_select_925
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_926
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_aggregate_test_select_927
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_aggregate_test_select_928
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_aggregate_test_select_929
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_930
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_aggregate_test_select_931
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (id INT64, flag INT64);
INSERT INTO nums VALUES (1, 0);
INSERT INTO nums VALUES (2, 1);
INSERT INTO nums VALUES (3, 42);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
INSERT INTO strings VALUES (2, 'true');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, group_id INT64, active BOOL);
INSERT INTO flags VALUES (1, 1, TRUE);
INSERT INTO flags VALUES (2, 1, FALSE);
INSERT INTO flags VALUES (3, 2, FALSE);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING);
INSERT INTO items VALUES (1, 'A');
INSERT INTO items VALUES (2, 'A');
INSERT INTO items VALUES (3, 'B');
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, value INT64, is_max BOOL);
INSERT INTO scores VALUES (1, 10, FALSE);
INSERT INTO scores VALUES (2, 20, TRUE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, active BOOL);
INSERT INTO data VALUES (1, TRUE);
INSERT INTO data VALUES (2, FALSE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, flag BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, flag BOOL);
INSERT INTO t1 VALUES (1, TRUE);
INSERT INTO t2 VALUES (2, FALSE);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64);
INSERT INTO customers VALUES (1);
INSERT INTO customers VALUES (2);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, TRUE);
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, active BOOL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO data VALUES (1, TRUE, NULL, FALSE);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (id INT64, flag BOOL);
INSERT INTO nulls VALUES (1, NULL);
INSERT INTO nulls VALUES (2, NULL);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (id INT64, a INT64, b INT64);
INSERT INTO nums VALUES (1, 5, 10);
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO complex VALUES (1, TRUE, TRUE, FALSE);
INSERT INTO complex VALUES (2, FALSE, TRUE, FALSE);
INSERT INTO complex VALUES (3, TRUE, FALSE, TRUE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'true');
INSERT INTO data VALUES (2, 'false');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);

-- Tag: window_functions_window_functions_aggregate_test_select_932
SELECT id FROM nums WHERE NOT flag;
-- Tag: window_functions_window_functions_aggregate_test_select_933
SELECT id FROM strings WHERE NOT value;
-- Tag: window_functions_window_functions_aggregate_test_select_934
SELECT category, SUM(amount) as total FROM sales GROUP BY category HAVING NOT (SUM(amount) < 100);
-- Tag: window_functions_window_functions_aggregate_test_select_935
SELECT group_id, NOT MAX(active) as all_inactive FROM flags GROUP BY group_id ORDER BY group_id;
-- Tag: window_functions_window_functions_aggregate_test_select_936
SELECT category FROM items GROUP BY category HAVING NOT (COUNT(*) = 1);
-- Tag: window_functions_window_functions_aggregate_test_select_937
SELECT id, NOT (value = MAX(value) OVER ()) as not_max FROM scores ORDER BY id;
WITH cte AS (SELECT id, active FROM data) SELECT id FROM cte WHERE NOT active ORDER BY id;
WITH filtered AS (SELECT id FROM data WHERE NOT (value < 15)) SELECT * FROM filtered ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_938
SELECT id FROM (SELECT id, flag FROM t1 UNION SELECT id, flag FROM t2) AS combined WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_939
SELECT id, (NOT EXISTS (SELECT 1 FROM orders WHERE customer_id = customers.id)) as has_no_orders FROM customers ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_940
SELECT NOT (SELECT value FROM flags WHERE id = 1) as inverted;
-- Tag: window_functions_window_functions_aggregate_test_select_941
SELECT COUNT(*) FROM large WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_942
SELECT id FROM data WHERE NOT ((a AND b) OR c);
-- Tag: window_functions_window_functions_aggregate_test_select_943
SELECT id FROM nulls WHERE NOT flag;
-- Tag: window_functions_window_functions_aggregate_test_select_944
SELECT id FROM nums WHERE NOT a < b;
-- Tag: window_functions_window_functions_aggregate_test_select_945
SELECT id FROM complex WHERE NOT a AND b OR c ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_946
SELECT NOT;
-- Tag: window_functions_window_functions_aggregate_test_select_947
SELECT NOT 42;
-- Tag: window_functions_window_functions_aggregate_test_select_948
SELECT NOT 'hello';
-- Tag: window_functions_window_functions_aggregate_test_select_949
SELECT id FROM data WHERE NOT CAST(value AS BOOL) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_950
SELECT id FROM data WHERE NOT (CASE WHEN value > 15 THEN TRUE ELSE FALSE END) ORDER BY id;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING);
INSERT INTO items VALUES (1, 'A');
INSERT INTO items VALUES (2, 'A');
INSERT INTO items VALUES (3, 'B');
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, value INT64, is_max BOOL);
INSERT INTO scores VALUES (1, 10, FALSE);
INSERT INTO scores VALUES (2, 20, TRUE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, active BOOL);
INSERT INTO data VALUES (1, TRUE);
INSERT INTO data VALUES (2, FALSE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, flag BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, flag BOOL);
INSERT INTO t1 VALUES (1, TRUE);
INSERT INTO t2 VALUES (2, FALSE);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64);
INSERT INTO customers VALUES (1);
INSERT INTO customers VALUES (2);
INSERT INTO orders VALUES (1);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, TRUE);
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, active BOOL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO data VALUES (1, TRUE, NULL, FALSE);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (id INT64, flag BOOL);
INSERT INTO nulls VALUES (1, NULL);
INSERT INTO nulls VALUES (2, NULL);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (id INT64, a INT64, b INT64);
INSERT INTO nums VALUES (1, 5, 10);
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO complex VALUES (1, TRUE, TRUE, FALSE);
INSERT INTO complex VALUES (2, FALSE, TRUE, FALSE);
INSERT INTO complex VALUES (3, TRUE, FALSE, TRUE);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'true');
INSERT INTO data VALUES (2, 'false');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);

-- Tag: window_functions_window_functions_aggregate_test_select_951
SELECT category FROM items GROUP BY category HAVING NOT (COUNT(*) = 1);
-- Tag: window_functions_window_functions_aggregate_test_select_952
SELECT id, NOT (value = MAX(value) OVER ()) as not_max FROM scores ORDER BY id;
WITH cte AS (SELECT id, active FROM data) SELECT id FROM cte WHERE NOT active ORDER BY id;
WITH filtered AS (SELECT id FROM data WHERE NOT (value < 15)) SELECT * FROM filtered ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_953
SELECT id FROM (SELECT id, flag FROM t1 UNION SELECT id, flag FROM t2) AS combined WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_954
SELECT id, (NOT EXISTS (SELECT 1 FROM orders WHERE customer_id = customers.id)) as has_no_orders FROM customers ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_955
SELECT NOT (SELECT value FROM flags WHERE id = 1) as inverted;
-- Tag: window_functions_window_functions_aggregate_test_select_956
SELECT COUNT(*) FROM large WHERE NOT active;
-- Tag: window_functions_window_functions_aggregate_test_select_957
SELECT id FROM data WHERE NOT ((a AND b) OR c);
-- Tag: window_functions_window_functions_aggregate_test_select_958
SELECT id FROM nulls WHERE NOT flag;
-- Tag: window_functions_window_functions_aggregate_test_select_959
SELECT id FROM nums WHERE NOT a < b;
-- Tag: window_functions_window_functions_aggregate_test_select_960
SELECT id FROM complex WHERE NOT a AND b OR c ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_961
SELECT NOT;
-- Tag: window_functions_window_functions_aggregate_test_select_962
SELECT NOT 42;
-- Tag: window_functions_window_functions_aggregate_test_select_963
SELECT NOT 'hello';
-- Tag: window_functions_window_functions_aggregate_test_select_964
SELECT id FROM data WHERE NOT CAST(value AS BOOL) ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_965
SELECT id FROM data WHERE NOT (CASE WHEN value > 15 THEN TRUE ELSE FALSE END) ORDER BY id;

DROP TABLE IF EXISTS limits;
CREATE TABLE limits (val NUMERIC);
INSERT INTO limits VALUES (99999999999999999999999999.99);
INSERT INTO limits VALUES (0.01);
DROP TABLE IF EXISTS overflow;
CREATE TABLE overflow (big NUMERIC);
INSERT INTO overflow VALUES (79228162514264337593543950335);
DROP TABLE IF EXISTS negatives;
CREATE TABLE negatives (val NUMERIC);
INSERT INTO negatives VALUES (1);
DROP TABLE IF EXISTS factors;
CREATE TABLE factors (a NUMERIC, b NUMERIC);
INSERT INTO factors VALUES (99999999999999, 99999999999999);
DROP TABLE IF EXISTS fractions;
CREATE TABLE fractions (numerator NUMERIC, denominator NUMERIC);
INSERT INTO fractions VALUES (1, 3);
DROP TABLE IF EXISTS zeros;
CREATE TABLE zeros (val NUMERIC);
INSERT INTO zeros VALUES (0);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a NUMERIC, b NUMERIC);
INSERT INTO nums VALUES (5.5, 5.5);
DROP TABLE IF EXISTS mod_test;
CREATE TABLE mod_test (val NUMERIC);
INSERT INTO mod_test VALUES (0);
DROP TABLE IF EXISTS zero_test;
CREATE TABLE zero_test (val NUMERIC);
INSERT INTO zero_test VALUES (0.0);
INSERT INTO zero_test VALUES (-0.0);
DROP TABLE IF EXISTS zero_mult;
CREATE TABLE zero_mult (val NUMERIC);
INSERT INTO zero_mult VALUES (0);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (a NUMERIC, b NUMERIC);
INSERT INTO nulls VALUES (10.5, NULL);
DROP TABLE IF EXISTS null_ops;
CREATE TABLE null_ops (val NUMERIC);
INSERT INTO null_ops VALUES (NULL);
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (a NUMERIC, b NUMERIC, c NUMERIC);
INSERT INTO complex VALUES (10, NULL, 20);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (n NUMERIC, i INT64);
INSERT INTO mixed VALUES (0.5, 9223372036854775807);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (n NUMERIC, i INT64);
INSERT INTO mixed VALUES (0.5, -9223372036854775808);
DROP TABLE IF EXISTS special;
CREATE TABLE special (n NUMERIC, f FLOAT64);
INSERT INTO special VALUES (10.5, 1e308 * 2);
DROP TABLE IF EXISTS nan_test;
CREATE TABLE nan_test (n NUMERIC, f FLOAT64);
INSERT INTO nan_test VALUES (10.5, 0.0 / 0.0);
DROP TABLE IF EXISTS scales;
CREATE TABLE scales (a NUMERIC, b NUMERIC);
INSERT INTO scales VALUES (10.5, 10.555);
DROP TABLE IF EXISTS mult_scale;
CREATE TABLE mult_scale (a NUMERIC, b NUMERIC);
INSERT INTO mult_scale VALUES (2.50, 3.125);
DROP TABLE IF EXISTS chain;
CREATE TABLE chain (val NUMERIC);
INSERT INTO chain VALUES (10.5);
DROP TABLE IF EXISTS neg_test;
CREATE TABLE neg_test (val NUMERIC);
INSERT INTO neg_test VALUES (-79228162514264337593543950335);
DROP TABLE IF EXISTS double_neg;
CREATE TABLE double_neg (val NUMERIC);
INSERT INTO double_neg VALUES (-123.456);
DROP TABLE IF EXISTS unary_plus;
CREATE TABLE unary_plus (val NUMERIC);
INSERT INTO unary_plus VALUES (-456.789);
DROP TABLE IF EXISTS close_vals;
CREATE TABLE close_vals (a NUMERIC, b NUMERIC);
INSERT INTO close_vals VALUES (1.00000001, 1.00000002);
DROP TABLE IF EXISTS trailing;
CREATE TABLE trailing (a NUMERIC, b NUMERIC);
INSERT INTO trailing VALUES (10.5000, 10.5);
DROP TABLE IF EXISTS nested;
CREATE TABLE nested (val NUMERIC);
INSERT INTO nested VALUES (2);
DROP TABLE IF EXISTS parallel;
CREATE TABLE parallel (a NUMERIC, b NUMERIC, c NUMERIC);
INSERT INTO parallel VALUES (10, 20, 30);
DROP TABLE IF EXISTS precedence;
CREATE TABLE precedence (val NUMERIC);
INSERT INTO precedence VALUES (10);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val NUMERIC);
DROP TABLE IF EXISTS empty_agg;
CREATE TABLE empty_agg (val NUMERIC);
DROP TABLE IF EXISTS single;
CREATE TABLE single (val NUMERIC);
INSERT INTO single VALUES (42.5);

-- Tag: window_functions_window_functions_aggregate_test_select_966
SELECT val FROM limits WHERE val > 1 ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_967
SELECT big + 1 FROM overflow;
-- Tag: window_functions_window_functions_aggregate_test_select_968
SELECT val - 99999999999999999999.99 FROM negatives;
-- Tag: window_functions_window_functions_aggregate_test_select_969
SELECT a * b FROM factors;
-- Tag: window_functions_window_functions_aggregate_test_select_970
SELECT numerator / denominator FROM fractions;
-- Tag: window_functions_window_functions_aggregate_test_select_971
SELECT 10.5 / val FROM zeros;
-- Tag: window_functions_window_functions_aggregate_test_select_972
SELECT 10 / (a - b) FROM nums;
-- Tag: window_functions_window_functions_aggregate_test_select_973
SELECT 10.5 % val FROM mod_test;
-- Tag: window_functions_window_functions_aggregate_test_select_974
SELECT COUNT(*) FROM zero_test WHERE val = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_975
SELECT val * 99999999999999999999999999.99 FROM zero_mult;
-- Tag: window_functions_window_functions_aggregate_test_select_976
SELECT a + b FROM nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_977
SELECT (a + b) * c FROM complex;
-- Tag: window_functions_window_functions_aggregate_test_select_978
SELECT n + i FROM mixed;
-- Tag: window_functions_window_functions_aggregate_test_select_979
SELECT n + i FROM mixed;
-- Tag: window_functions_window_functions_aggregate_test_select_980
SELECT n * f FROM special;
-- Tag: window_functions_window_functions_aggregate_test_select_981
SELECT n + f FROM nan_test;
-- Tag: window_functions_window_functions_aggregate_test_select_982
SELECT a + b FROM scales;
-- Tag: window_functions_window_functions_aggregate_test_select_983
SELECT a * b FROM mult_scale;
-- Tag: window_functions_window_functions_aggregate_test_select_984
SELECT ((val * 1.1) / 2.5) + 0.333 FROM chain;
-- Tag: window_functions_window_functions_aggregate_test_select_985
SELECT -val FROM neg_test;
-- Tag: window_functions_window_functions_aggregate_test_select_986
SELECT -(-val) FROM double_neg;
-- Tag: window_functions_window_functions_aggregate_test_select_987
SELECT +val FROM unary_plus;
-- Tag: window_functions_window_functions_aggregate_test_select_988
SELECT a = b FROM close_vals;
-- Tag: window_functions_window_functions_aggregate_test_select_989
SELECT a = b FROM trailing;
-- Tag: window_functions_window_functions_aggregate_test_select_990
SELECT ((((val + 1) * 2) - 3) / 4) % 5 FROM nested;
-- Tag: window_functions_window_functions_aggregate_test_select_991
SELECT a + b, a * b, a / c, b - c FROM parallel;
-- Tag: window_functions_window_functions_aggregate_test_select_992
SELECT 2 + val * 3 FROM precedence;
-- Tag: window_functions_window_functions_aggregate_test_select_993
SELECT val + 10 FROM empty;
-- Tag: window_functions_window_functions_aggregate_test_select_994
SELECT SUM(val), AVG(val), COUNT(val) FROM empty_agg;
-- Tag: window_functions_window_functions_aggregate_test_select_995
SELECT val * 2, val / 2 FROM single;

DROP TABLE IF EXISTS overflow;
CREATE TABLE overflow (big NUMERIC);
INSERT INTO overflow VALUES (79228162514264337593543950335);
DROP TABLE IF EXISTS negatives;
CREATE TABLE negatives (val NUMERIC);
INSERT INTO negatives VALUES (1);
DROP TABLE IF EXISTS factors;
CREATE TABLE factors (a NUMERIC, b NUMERIC);
INSERT INTO factors VALUES (99999999999999, 99999999999999);
DROP TABLE IF EXISTS fractions;
CREATE TABLE fractions (numerator NUMERIC, denominator NUMERIC);
INSERT INTO fractions VALUES (1, 3);
DROP TABLE IF EXISTS zeros;
CREATE TABLE zeros (val NUMERIC);
INSERT INTO zeros VALUES (0);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a NUMERIC, b NUMERIC);
INSERT INTO nums VALUES (5.5, 5.5);
DROP TABLE IF EXISTS mod_test;
CREATE TABLE mod_test (val NUMERIC);
INSERT INTO mod_test VALUES (0);
DROP TABLE IF EXISTS zero_test;
CREATE TABLE zero_test (val NUMERIC);
INSERT INTO zero_test VALUES (0.0);
INSERT INTO zero_test VALUES (-0.0);
DROP TABLE IF EXISTS zero_mult;
CREATE TABLE zero_mult (val NUMERIC);
INSERT INTO zero_mult VALUES (0);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (a NUMERIC, b NUMERIC);
INSERT INTO nulls VALUES (10.5, NULL);
DROP TABLE IF EXISTS null_ops;
CREATE TABLE null_ops (val NUMERIC);
INSERT INTO null_ops VALUES (NULL);
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (a NUMERIC, b NUMERIC, c NUMERIC);
INSERT INTO complex VALUES (10, NULL, 20);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (n NUMERIC, i INT64);
INSERT INTO mixed VALUES (0.5, 9223372036854775807);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (n NUMERIC, i INT64);
INSERT INTO mixed VALUES (0.5, -9223372036854775808);
DROP TABLE IF EXISTS special;
CREATE TABLE special (n NUMERIC, f FLOAT64);
INSERT INTO special VALUES (10.5, 1e308 * 2);
DROP TABLE IF EXISTS nan_test;
CREATE TABLE nan_test (n NUMERIC, f FLOAT64);
INSERT INTO nan_test VALUES (10.5, 0.0 / 0.0);
DROP TABLE IF EXISTS scales;
CREATE TABLE scales (a NUMERIC, b NUMERIC);
INSERT INTO scales VALUES (10.5, 10.555);
DROP TABLE IF EXISTS mult_scale;
CREATE TABLE mult_scale (a NUMERIC, b NUMERIC);
INSERT INTO mult_scale VALUES (2.50, 3.125);
DROP TABLE IF EXISTS chain;
CREATE TABLE chain (val NUMERIC);
INSERT INTO chain VALUES (10.5);
DROP TABLE IF EXISTS neg_test;
CREATE TABLE neg_test (val NUMERIC);
INSERT INTO neg_test VALUES (-79228162514264337593543950335);
DROP TABLE IF EXISTS double_neg;
CREATE TABLE double_neg (val NUMERIC);
INSERT INTO double_neg VALUES (-123.456);
DROP TABLE IF EXISTS unary_plus;
CREATE TABLE unary_plus (val NUMERIC);
INSERT INTO unary_plus VALUES (-456.789);
DROP TABLE IF EXISTS close_vals;
CREATE TABLE close_vals (a NUMERIC, b NUMERIC);
INSERT INTO close_vals VALUES (1.00000001, 1.00000002);
DROP TABLE IF EXISTS trailing;
CREATE TABLE trailing (a NUMERIC, b NUMERIC);
INSERT INTO trailing VALUES (10.5000, 10.5);
DROP TABLE IF EXISTS nested;
CREATE TABLE nested (val NUMERIC);
INSERT INTO nested VALUES (2);
DROP TABLE IF EXISTS parallel;
CREATE TABLE parallel (a NUMERIC, b NUMERIC, c NUMERIC);
INSERT INTO parallel VALUES (10, 20, 30);
DROP TABLE IF EXISTS precedence;
CREATE TABLE precedence (val NUMERIC);
INSERT INTO precedence VALUES (10);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val NUMERIC);
DROP TABLE IF EXISTS empty_agg;
CREATE TABLE empty_agg (val NUMERIC);
DROP TABLE IF EXISTS single;
CREATE TABLE single (val NUMERIC);
INSERT INTO single VALUES (42.5);

-- Tag: window_functions_window_functions_aggregate_test_select_996
SELECT big + 1 FROM overflow;
-- Tag: window_functions_window_functions_aggregate_test_select_997
SELECT val - 99999999999999999999.99 FROM negatives;
-- Tag: window_functions_window_functions_aggregate_test_select_998
SELECT a * b FROM factors;
-- Tag: window_functions_window_functions_aggregate_test_select_999
SELECT numerator / denominator FROM fractions;
-- Tag: window_functions_window_functions_aggregate_test_select_1000
SELECT 10.5 / val FROM zeros;
-- Tag: window_functions_window_functions_aggregate_test_select_1001
SELECT 10 / (a - b) FROM nums;
-- Tag: window_functions_window_functions_aggregate_test_select_1002
SELECT 10.5 % val FROM mod_test;
-- Tag: window_functions_window_functions_aggregate_test_select_1003
SELECT COUNT(*) FROM zero_test WHERE val = 0;
-- Tag: window_functions_window_functions_aggregate_test_select_1004
SELECT val * 99999999999999999999999999.99 FROM zero_mult;
-- Tag: window_functions_window_functions_aggregate_test_select_1005
SELECT a + b FROM nulls;
-- Tag: window_functions_window_functions_aggregate_test_select_1006
SELECT (a + b) * c FROM complex;
-- Tag: window_functions_window_functions_aggregate_test_select_1007
SELECT n + i FROM mixed;
-- Tag: window_functions_window_functions_aggregate_test_select_1008
SELECT n + i FROM mixed;
-- Tag: window_functions_window_functions_aggregate_test_select_1009
SELECT n * f FROM special;
-- Tag: window_functions_window_functions_aggregate_test_select_1010
SELECT n + f FROM nan_test;
-- Tag: window_functions_window_functions_aggregate_test_select_1011
SELECT a + b FROM scales;
-- Tag: window_functions_window_functions_aggregate_test_select_1012
SELECT a * b FROM mult_scale;
-- Tag: window_functions_window_functions_aggregate_test_select_1013
SELECT ((val * 1.1) / 2.5) + 0.333 FROM chain;
-- Tag: window_functions_window_functions_aggregate_test_select_1014
SELECT -val FROM neg_test;
-- Tag: window_functions_window_functions_aggregate_test_select_1015
SELECT -(-val) FROM double_neg;
-- Tag: window_functions_window_functions_aggregate_test_select_1016
SELECT +val FROM unary_plus;
-- Tag: window_functions_window_functions_aggregate_test_select_1017
SELECT a = b FROM close_vals;
-- Tag: window_functions_window_functions_aggregate_test_select_1018
SELECT a = b FROM trailing;
-- Tag: window_functions_window_functions_aggregate_test_select_1019
SELECT ((((val + 1) * 2) - 3) / 4) % 5 FROM nested;
-- Tag: window_functions_window_functions_aggregate_test_select_1020
SELECT a + b, a * b, a / c, b - c FROM parallel;
-- Tag: window_functions_window_functions_aggregate_test_select_1021
SELECT 2 + val * 3 FROM precedence;
-- Tag: window_functions_window_functions_aggregate_test_select_1022
SELECT val + 10 FROM empty;
-- Tag: window_functions_window_functions_aggregate_test_select_1023
SELECT SUM(val), AVG(val), COUNT(val) FROM empty_agg;
-- Tag: window_functions_window_functions_aggregate_test_select_1024
SELECT val * 2, val / 2 FROM single;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1025
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1026
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1027
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1028
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1029
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1030
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1031
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1032
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1033
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1034
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1035
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1036
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1037
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1038
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1039
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1040
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1041
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1042
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1043
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1044
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1045
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1046
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1047
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1048
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1049
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1050
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1051
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1052
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1053
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1054
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1055
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1056
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1057
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1058
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1059
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1060
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1061
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1062
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1063
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1064
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1065
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1066
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1067
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1068
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1069
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1070
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1071
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1072
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1073
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1074
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1075
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1076
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1077
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1078
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1079
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1080
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1081
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1082
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1083
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1084
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1085
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1086
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1087
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1088
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1089
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1090
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1091
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1092
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1093
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1094
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1095
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1096
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1097
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1098
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1099
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1100
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1101
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1102
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1103
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1104
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1105
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1106
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1107
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1108
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1109
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1110
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1111
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1112
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1113
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1114
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1115
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1116
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1117
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1118
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1119
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1120
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1121
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1122
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
DROP TABLE IF EXISTS test;
CREATE TABLE test (text STRING);
INSERT INTO test VALUES ('aaaaaaaaaaaaaaaaaaaaac');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: window_functions_window_functions_aggregate_test_select_1123
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1124
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_aggregate_test_select_1125
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1126
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1127
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1128
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1129
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1130
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1131
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_aggregate_test_select_1132
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_aggregate_test_select_1133
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1134
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_aggregate_test_select_1135
SELECT * FROM test;

DROP TABLE IF EXISTS circular_deps;
CREATE TABLE circular_deps ( id INT64, depends_on INT64 );
INSERT INTO circular_deps VALUES
(1, 2),
(2, 3),
(3, 1);
DROP TABLE IF EXISTS tree_nodes;
CREATE TABLE tree_nodes ( id INT64, parent_id INT64, level INT64 );
INSERT INTO tree_nodes VALUES
(1, NULL, 0),
(2, 1, 1), (3, 1, 1),
(4, 2, 2), (5, 2, 2), (6, 3, 2), (7, 3, 2),
(8, 4, 3), (9, 4, 3), (10, 5, 3), (11, 5, 3);
DROP TABLE IF EXISTS nullable_hierarchy;
CREATE TABLE nullable_hierarchy ( id INT64, parent_id INT64 );
INSERT INTO nullable_hierarchy VALUES
(1, NULL),
(2, 1),
(3, NULL), -- Another root
(4, 3);
DROP TABLE IF EXISTS edges;
CREATE TABLE edges ( from_node INT64, to_node INT64 );
INSERT INTO edges VALUES
(1, 2), (1, 3),
(2, 4), (3, 4), -- Two paths to node 4
(4, 5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( day INT64, amount INT64 );
INSERT INTO sales VALUES
(1, 100), (2, 150), (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);

WITH RECURSIVE infinite AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1136
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1137
SELECT n + 1 FROM infinite -- No WHERE clause to stop!
)
-- Tag: window_functions_window_functions_aggregate_test_select_1138
SELECT * FROM infinite LIMIT 10;
WITH RECURSIVE big_numbers AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1139
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1140
SELECT n + 1 FROM big_numbers WHERE n < 10000
)
-- Tag: window_functions_window_functions_aggregate_test_select_1141
SELECT COUNT(*) FROM big_numbers;
WITH RECURSIVE dependencies AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1142
SELECT id, depends_on, 1 AS depth
FROM circular_deps
WHERE id = 1
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1143
SELECT cd.id, cd.depends_on, d.depth + 1
FROM circular_deps cd
JOIN dependencies d ON cd.id = d.depends_on
WHERE d.depth < 10 -- Safety limit
)
-- Tag: window_functions_window_functions_aggregate_test_select_1144
SELECT * FROM dependencies;
WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1145
SELECT id, parent_id, level, 1 AS iteration
FROM tree_nodes
WHERE parent_id IS NULL
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1146
SELECT tn.id, tn.parent_id, tn.level, t.iteration + 1
FROM tree_nodes tn
JOIN tree t ON tn.parent_id = t.id
WHERE t.iteration < 4 -- Limit iterations
)
-- Tag: window_functions_window_functions_aggregate_test_select_1147
SELECT COUNT(*), MAX(level) FROM tree;
WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1148
SELECT id, parent_id, 0 AS level
FROM nullable_hierarchy
WHERE id = 1
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1149
SELECT nh.id, nh.parent_id, t.level + 1
FROM nullable_hierarchy nh
JOIN tree t ON nh.parent_id = t.id
)
-- Tag: window_functions_window_functions_aggregate_test_select_1150
SELECT COUNT(*) FROM tree;
WITH RECURSIVE
numbers AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1151
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1152
SELECT n + 1 FROM numbers WHERE n < 3
),
letters AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1153
SELECT 'A' AS letter, 1 AS ord
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_038
SELECT
CASE ord
WHEN 1 THEN 'B'
WHEN 2 THEN 'C'
END,
ord + 1
FROM letters
WHERE ord < 3
)
-- Tag: window_functions_window_functions_aggregate_test_select_1154
SELECT n, letter FROM numbers CROSS JOIN letters ORDER BY n, ord;
WITH RECURSIVE paths AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1155
SELECT DISTINCT from_node AS node, 0 AS hops
FROM edges
WHERE from_node = 1
UNION DISTINCT
-- Tag: window_functions_window_functions_aggregate_test_select_1156
SELECT DISTINCT e.to_node, p.hops + 1
FROM edges e
JOIN paths p ON e.from_node = p.node
WHERE p.hops < 3
)
-- Tag: window_functions_window_functions_aggregate_test_select_1157
SELECT * FROM paths ORDER BY node;
WITH RECURSIVE running_total AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1158
SELECT day, amount, amount AS total
FROM sales
WHERE day = 1
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1159
SELECT s.day, s.amount, rt.total + s.amount
FROM sales s
JOIN running_total rt ON s.day = rt.day + 1
)
-- Tag: window_functions_window_functions_aggregate_test_select_1160
SELECT * FROM running_total ORDER BY day;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1161
SELECT 1 AS n, 'A' AS letter
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1162
SELECT n + 1 FROM broken WHERE n < 5 -- Missing 'letter' column!
)
-- Tag: window_functions_window_functions_aggregate_test_select_1163
SELECT * FROM broken;
WITH RECURSIVE type_broken AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1164
SELECT 1 AS value
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1165
SELECT 'not a number' FROM type_broken WHERE value < 5 -- Type mismatch!
)
-- Tag: window_functions_window_functions_aggregate_test_select_1166
SELECT * FROM type_broken;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1167
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1168
SELECT n + 1
FROM non_existent_table -- Table doesn't exist!
WHERE n < 5
)
-- Tag: window_functions_window_functions_aggregate_test_select_1169
SELECT * FROM broken;
WITH numbers AS ( -- Missing RECURSIVE!
-- Tag: window_functions_window_functions_aggregate_test_select_1170
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1171
SELECT n + 1 FROM numbers WHERE n < 5
)
-- Tag: window_functions_window_functions_aggregate_test_select_1172
SELECT * FROM numbers;
WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1173
SELECT id FROM data WHERE id = 999 -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1174
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_aggregate_test_select_1175
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1176
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1177
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_aggregate_test_select_1178
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1179
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1180
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_aggregate_test_select_1181
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1182
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1183
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1184
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_aggregate_test_select_1185
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1186
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_aggregate_test_select_1187
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_aggregate_test_select_039
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64);
INSERT INTO orders VALUES
(1, 100),
(2, 100),
(3, 200),
(4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (value STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES ('123');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (discount_pct INT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS config;
CREATE TABLE config (prefix STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO config VALUES ('User: ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (text STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO messages VALUES ('Hello World');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64, in_stock BOOL);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (min_price FLOAT64);
INSERT INTO products VALUES
(1, 50.0, true),
(2, 150.0, true),
(3, 75.0, false);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (special_value INT64);
INSERT INTO items VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO config VALUES (20);
DROP TABLE IF EXISTS values;
CREATE TABLE values (id INT64, num INT64);
DROP TABLE IF EXISTS range;
CREATE TABLE range (min INT64, max INT64);
INSERT INTO values VALUES (1, 5), (2, 15), (3, 25);
INSERT INTO range VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (id INT64, name STRING);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, cat_id INT64, price FLOAT64);
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Clothing');
INSERT INTO items VALUES
(1, 1, 100.0),
(2, 1, 200.0),
(3, 2, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1188
SELECT (SELECT COUNT(DISTINCT customer_id) FROM orders) as unique_customers;
-- Tag: window_functions_window_functions_aggregate_test_select_1189
SELECT id, (SELECT CAST(value AS INT64) FROM config) as int_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1190
SELECT id, price, price * (SELECT discount_pct FROM config) / 100.0 as discount
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1191
SELECT id, CONCAT((SELECT prefix FROM config), name) as formatted_name
FROM users
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1192
SELECT id,
(SELECT UPPER(text) FROM messages) as upper_msg,
(SELECT LOWER(text) FROM messages) as lower_msg
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1193
SELECT id, price
FROM products
WHERE in_stock = true AND price > (SELECT min_price FROM thresholds)
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1194
SELECT id
FROM items
WHERE value < 15 OR value = (SELECT special_value FROM config)
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1195
SELECT id
FROM values
WHERE num BETWEEN (SELECT min FROM range) AND (SELECT max FROM range)
ORDER BY id;
WITH stats AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1196
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_aggregate_test_select_1197
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_aggregate_test_select_1198
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_aggregate_test_select_1199
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_aggregate_test_select_1200
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_aggregate_test_select_1201
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1202
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_aggregate_test_select_1203
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1204
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1205
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1206
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1207
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1208
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1209
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1210
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1211
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1212
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1213
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1214
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1215
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1216
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1217
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1218
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1219
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 'Alice'),
(2, 1, 'Bob'),
(3, 2, 'Charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_aggregate_test_select_1220
SELECT d.name,
(SELECT COUNT(*) FROM employees e WHERE e.dept_id = d.id) as emp_count
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_aggregate_test_select_1221
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1222
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1223
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_1224
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1225
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1226
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1227
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1228
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1229
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_aggregate_test_select_1230
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_aggregate_test_select_1231
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_aggregate_test_select_1232
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1233
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1234
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1235
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1236
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1237
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1238
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1239
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1240
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1241
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_aggregate_test_select_1242
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1243
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'Electronics', 100.0),
(2, 'Electronics', 200.0),
(3, 'Clothing', 50.0),
(4, 'Clothing', 75.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product_id INT64, quantity INT64);
INSERT INTO sales VALUES
(1, 100, 5),
(2, 100, 10),
(3, 200, 8);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (value INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, category STRING);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (id INT64, category STRING, value INT64);
INSERT INTO outer_table VALUES (1, 'A'), (2, 'B');
INSERT INTO inner_table VALUES (1, 'A', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20), (30);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (emp_id INT64, amount FLOAT64, year INT64);
INSERT INTO employees VALUES (1, 'Alice');
INSERT INTO salaries VALUES
(1, 50000.0, 2021),
(1, 55000.0, 2022),
(1, 60000.0, 2023);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary FLOAT64);
INSERT INTO employees VALUES
(1, 'Alice', 50000.0),
(2, 'Bob', 60000.0),
(3, 'Charlie', 55000.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 50.0);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES
(1, 'A', 100.0),
(2, 'B', 50.0),
(3, 'C', 150.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (tax_rate FLOAT64);
INSERT INTO items VALUES (1, 100.0), (2, 200.0);
INSERT INTO config VALUES (0.1);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (expensive_threshold FLOAT64);
INSERT INTO products VALUES (1, 50.0), (2, 150.0);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS level1;
CREATE TABLE level1 (value INT64);
DROP TABLE IF EXISTS level2;
CREATE TABLE level2 (multiplier INT64);
INSERT INTO data VALUES (1);
INSERT INTO level1 VALUES (10);
INSERT INTO level2 VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS values;
CREATE TABLE values (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO values VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS dual_cols;
CREATE TABLE dual_cols (a INT64, b INT64);
INSERT INTO data VALUES (1);
INSERT INTO dual_cols VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO orders VALUES (1, 100, 50.0), (2, 100, 75.0), (3, 200, 60.0);
INSERT INTO customers VALUES (100, 'Alice'), (200, 'Bob');
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept_id INT64, salary FLOAT64);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO employees VALUES
(1, 1, 50000.0),
(2, 1, 60000.0),
(3, 2, 55000.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category INT64, price FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (min INT64, max INT64, avg FLOAT64);
INSERT INTO data VALUES (1), (2), (3);
INSERT INTO stats VALUES (1, 100, 50.5);

-- Tag: window_functions_window_functions_aggregate_test_select_1244
SELECT p1.id, p1.category, p1.price,
(SELECT MAX(p2.price)
FROM products p2
WHERE p2.category = p1.category) as max_price
FROM products p1
ORDER BY p1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1245
SELECT s1.id, s1.quantity,
(SELECT SUM(s2.quantity)
FROM sales s2
WHERE s2.product_id = s1.product_id) as total_qty
FROM sales s1
ORDER BY s1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1246
SELECT id, (SELECT value FROM data WHERE id = 2) as null_val FROM data WHERE id = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_1247
SELECT id, (SELECT id FROM data WHERE id = 999) as missing FROM data ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1248
SELECT id, (SELECT value FROM empty) as empty_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1249
SELECT id, (SELECT COUNT(*) FROM empty) as count FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1250
SELECT o.id, o.category,
(SELECT SUM(i.value) FROM inner_table i WHERE i.category = o.category) as total
FROM outer_table o
ORDER BY o.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1251
SELECT id, (SELECT value FROM values ORDER BY value DESC LIMIT 1) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1252
SELECT e.name,
(SELECT s.amount FROM salaries s WHERE s.emp_id = e.id ORDER BY s.year DESC LIMIT 1) as latest_salary
FROM employees e;
-- Tag: window_functions_window_functions_aggregate_test_select_1253
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY name;
-- Tag: window_functions_window_functions_aggregate_test_select_1254
SELECT product, SUM(amount) as total,
(SELECT SUM(amount) FROM sales) as grand_total
FROM sales
GROUP BY product
ORDER BY product;
-- Tag: window_functions_window_functions_aggregate_test_select_1255
SELECT category, SUM(amount) as total
FROM sales
GROUP BY category
HAVING SUM(amount) > (SELECT AVG(amount) FROM sales)
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1256
SELECT name, price
FROM products
ORDER BY price - (SELECT AVG(price) FROM products) DESC;
-- Tag: window_functions_window_functions_aggregate_test_select_1257
SELECT id, price, price * (1 + (SELECT tax_rate FROM config)) as total
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1258
SELECT id,
CASE
WHEN price > (SELECT expensive_threshold FROM thresholds) THEN 'Expensive'
ELSE 'Affordable'
END as category
FROM products
ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1259
SELECT id,
(SELECT value * (SELECT multiplier FROM level2) FROM level1) as result
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1260
SELECT id, (SELECT value FROM values) as val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1261
SELECT id, (SELECT a, b FROM dual_cols) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1262
SELECT id, (SELECT undefined_col FROM data) as val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1263
SELECT c.name, o.amount,
(SELECT AVG(amount) FROM orders) as overall_avg
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name, o.amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1264
SELECT d.name,
(SELECT MAX(e.salary) FROM employees e WHERE e.dept_id = d.id) as max_salary
FROM departments d
ORDER BY d.name;
-- Tag: window_functions_window_functions_aggregate_test_select_1265
SELECT i1.id, i1.price,
(SELECT AVG(i2.price) FROM items i2 WHERE i2.category = i1.category) as category_avg
FROM items i1
WHERE i1.id < 10
ORDER BY i1.id;
-- Tag: window_functions_window_functions_aggregate_test_select_1266
SELECT id,
(SELECT min FROM stats) as min_val,
(SELECT max FROM stats) as max_val,
(SELECT avg FROM stats) as avg_val
FROM data
ORDER BY id;

CREATE SEQUENCE seq_range START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 10 NO CYCLE;
CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test;
CREATE SEQUENCE seq_test;
CREATE SEQUENCE seq_cache CACHE 20;
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;
DROP SEQUENCE IF EXISTS nonexistent;
DROP SEQUENCE nonexistent;
CREATE SEQUENCE seq_alter INCREMENT BY 1;
ALTER SEQUENCE seq_alter INCREMENT BY 10;
CREATE SEQUENCE seq_restart;
ALTER SEQUENCE seq_restart RESTART WITH 100;
CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
CREATE SEQUENCE seq_multi;
CREATE SEQUENCE seq_insert;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item2');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item3');
CREATE SEQUENCE seq_curr;
CREATE SEQUENCE seq_curr_err;
CREATE SEQUENCE seq_noadvance;
CREATE SEQUENCE seq_set;
CREATE SEQUENCE seq_setcall;
CREATE SEQUENCE seq_setmax MAXVALUE 100 NO CYCLE;
CREATE SEQUENCE seq_last;
CREATE SEQUENCE seq1;
CREATE SEQUENCE seq2 START WITH 100;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
INSERT INTO items (name) VALUES ('Item3');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (id, name) VALUES (10, 'Item10');
INSERT INTO items (name) VALUES ('Item11');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id BIGSERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(1, 1), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(100, 5), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (10, 'Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_aggregate_test_select_1267
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1268
SELECT NEXTVAL('seq_range') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1269
SELECT NEXTVAL('seq_cycle') as v1, NEXTVAL('seq_cycle') as v2, NEXTVAL('seq_cycle') as v3, NEXTVAL('seq_cycle') as v4;
-- Tag: window_functions_window_functions_aggregate_test_select_1270
SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Tag: window_functions_window_functions_aggregate_test_select_1271
SELECT NEXTVAL('seq_cache') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1272
SELECT NEXTVAL('seq_drop');
-- Tag: window_functions_window_functions_aggregate_test_select_1273
SELECT NEXTVAL('seq_alter');
-- Tag: window_functions_window_functions_aggregate_test_select_1274
SELECT NEXTVAL('seq_alter') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1275
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_aggregate_test_select_1276
SELECT NEXTVAL('seq_restart');
-- Tag: window_functions_window_functions_aggregate_test_select_1277
SELECT NEXTVAL('seq_restart') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1278
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_aggregate_test_select_1279
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_aggregate_test_select_1280
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1281
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1282
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1283
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_aggregate_test_select_1284
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_aggregate_test_select_1285
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1286
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_aggregate_test_select_1287
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1288
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_aggregate_test_select_1289
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1290
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1291
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1292
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1293
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_aggregate_test_select_1294
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1295
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_aggregate_test_select_1296
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1297
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_aggregate_test_select_1298
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1299
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_aggregate_test_select_1300
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_aggregate_test_select_1301
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_aggregate_test_select_1302
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1303
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_aggregate_test_select_1304
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_aggregate_test_select_1305
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1306
SELECT LASTVAL();
-- Tag: window_functions_window_functions_aggregate_test_select_1307
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1308
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1309
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1310
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1311
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_aggregate_test_select_1312
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1313
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1314
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1315
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1316
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1317
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_aggregate_test_select_1318
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1319
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_aggregate_test_select_1320
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1321
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1322
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1323
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_max INCREMENT BY 1 MAXVALUE 1000 NO CYCLE;
ALTER SEQUENCE seq_max MAXVALUE 5 NO CYCLE;
CREATE SEQUENCE seq_next;
CREATE SEQUENCE seq_multi;
CREATE SEQUENCE seq_insert;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item2');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item3');
CREATE SEQUENCE seq_curr;
CREATE SEQUENCE seq_curr_err;
CREATE SEQUENCE seq_noadvance;
CREATE SEQUENCE seq_set;
CREATE SEQUENCE seq_setcall;
CREATE SEQUENCE seq_setmax MAXVALUE 100 NO CYCLE;
CREATE SEQUENCE seq_last;
CREATE SEQUENCE seq1;
CREATE SEQUENCE seq2 START WITH 100;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
INSERT INTO items (name) VALUES ('Item3');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (id, name) VALUES (10, 'Item10');
INSERT INTO items (name) VALUES ('Item11');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id BIGSERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(1, 1), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(100, 5), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (10, 'Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_aggregate_test_select_1324
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_aggregate_test_select_1325
SELECT NEXTVAL('seq_max');
-- Tag: window_functions_window_functions_aggregate_test_select_1326
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1327
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1328
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1329
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_aggregate_test_select_1330
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_aggregate_test_select_1331
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1332
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_aggregate_test_select_1333
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1334
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_aggregate_test_select_1335
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1336
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1337
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_aggregate_test_select_1338
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1339
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_aggregate_test_select_1340
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1341
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_aggregate_test_select_1342
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1343
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_aggregate_test_select_1344
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1345
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_aggregate_test_select_1346
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_aggregate_test_select_1347
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_aggregate_test_select_1348
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1349
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_aggregate_test_select_1350
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_aggregate_test_select_1351
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1352
SELECT LASTVAL();
-- Tag: window_functions_window_functions_aggregate_test_select_1353
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1354
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1355
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1356
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1357
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_aggregate_test_select_1358
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1359
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1360
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1361
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1362
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1363
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_aggregate_test_select_1364
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1365
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_aggregate_test_select_1366
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1367
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1368
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1369
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_setmax MAXVALUE 100 NO CYCLE;
CREATE SEQUENCE seq_last;
CREATE SEQUENCE seq1;
CREATE SEQUENCE seq2 START WITH 100;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
INSERT INTO items (name) VALUES ('Item3');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (id, name) VALUES (10, 'Item10');
INSERT INTO items (name) VALUES ('Item11');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING, PRIMARY KEY (id));
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id BIGSERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id SERIAL, name STRING);
INSERT INTO items (name) VALUES ('Item1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(1, 1), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 IDENTITY(100, 5), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (10, 'Item2');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_aggregate_test_select_1370
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_aggregate_test_select_1371
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_aggregate_test_select_1372
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_aggregate_test_select_1373
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1374
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_aggregate_test_select_1375
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_aggregate_test_select_1376
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1377
SELECT LASTVAL();
-- Tag: window_functions_window_functions_aggregate_test_select_1378
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1379
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1380
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1381
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1382
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_aggregate_test_select_1383
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_aggregate_test_select_1384
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1385
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1386
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1387
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1388
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_aggregate_test_select_1389
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1390
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_aggregate_test_select_1391
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1392
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1393
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1394
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 , name STRING);
INSERT INTO items (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (id, name) VALUES (100, 'Item100');
INSERT INTO items (name) VALUES ('Item101');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_gap'), 'Item2');
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_aggregate_test_select_1395
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1396
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_aggregate_test_select_1397
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_aggregate_test_select_1398
SELECT id FROM items;
-- Tag: window_functions_window_functions_aggregate_test_select_1399
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_aggregate_test_select_1400
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1401
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1402
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1403
SELECT id FROM items ORDER BY id;

CREATE SEQUENCE seq_overflow START WITH 9223372036854775806 INCREMENT BY 1 NO CYCLE;
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);
INSERT INTO items (name) VALUES ('Item1');
INSERT INTO items (name) VALUES ('Item2');

-- Tag: window_functions_window_functions_aggregate_test_select_1404
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1405
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1406
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_aggregate_test_select_1407
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( amount NUMERIC(10, 2) );
INSERT INTO transactions VALUES (0.10);
INSERT INTO transactions VALUES (0.20);
INSERT INTO transactions VALUES (0.30);
DROP TABLE IF EXISTS values;
CREATE TABLE values (val NUMERIC(10, 2));
INSERT INTO values VALUES (10.00);
INSERT INTO values VALUES (20.00);
INSERT INTO values VALUES (30.00);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (price NUMERIC(10, 4));
INSERT INTO prices VALUES (1.5000);
INSERT INTO prices VALUES (1.50);
INSERT INTO prices VALUES (1.5);
INSERT INTO prices VALUES (2.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount NUMERIC(10, 2) );
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('B', 200.50);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (val NUMERIC(10, 2));
INSERT INTO amounts VALUES (100.00);
INSERT INTO amounts VALUES (-50.25);
INSERT INTO amounts VALUES (0.00);
INSERT INTO amounts VALUES (25.50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val NUMERIC(10, 2));
INSERT INTO data VALUES (100.00);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (50.00);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales ( day INT64, amount INT64 );
INSERT INTO daily_sales VALUES (1, 100);
INSERT INTO daily_sales VALUES (2, 150);
INSERT INTO daily_sales VALUES (3, 120);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( seq INT64, event STRING );
INSERT INTO events VALUES (1, 'start');
INSERT INTO events VALUES (2, 'process');
INSERT INTO events VALUES (3, 'end');
DROP TABLE IF EXISTS items;
CREATE TABLE items ( name STRING, value INT64 );
INSERT INTO items VALUES ('A', 10);
INSERT INTO items VALUES ('B', 10);
INSERT INTO items VALUES ('C', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (10.0);
INSERT INTO data VALUES (20.0);
INSERT INTO data VALUES (30.0);
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (val FLOAT64);
INSERT INTO samples VALUES (10.0);
INSERT INTO samples VALUES (20.0);
INSERT INTO samples VALUES (30.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1408
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_aggregate_test_select_1409
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_aggregate_test_select_1410
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_aggregate_test_select_1411
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1412
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1413
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1414
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1415
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1416
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_aggregate_test_select_1417
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_aggregate_test_select_1418
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_aggregate_test_select_1419
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1420
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_aggregate_test_select_1421
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1422
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1423
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1424
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1425
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1426
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1427
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1428
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1429
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1430
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1431
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_aggregate_test_select_1432
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1433
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1434
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS values;
CREATE TABLE values (val NUMERIC(10, 2));
INSERT INTO values VALUES (10.00);
INSERT INTO values VALUES (20.00);
INSERT INTO values VALUES (30.00);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (price NUMERIC(10, 4));
INSERT INTO prices VALUES (1.5000);
INSERT INTO prices VALUES (1.50);
INSERT INTO prices VALUES (1.5);
INSERT INTO prices VALUES (2.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount NUMERIC(10, 2) );
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('B', 200.50);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (val NUMERIC(10, 2));
INSERT INTO amounts VALUES (100.00);
INSERT INTO amounts VALUES (-50.25);
INSERT INTO amounts VALUES (0.00);
INSERT INTO amounts VALUES (25.50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val NUMERIC(10, 2));
INSERT INTO data VALUES (100.00);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (50.00);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales ( day INT64, amount INT64 );
INSERT INTO daily_sales VALUES (1, 100);
INSERT INTO daily_sales VALUES (2, 150);
INSERT INTO daily_sales VALUES (3, 120);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( seq INT64, event STRING );
INSERT INTO events VALUES (1, 'start');
INSERT INTO events VALUES (2, 'process');
INSERT INTO events VALUES (3, 'end');
DROP TABLE IF EXISTS items;
CREATE TABLE items ( name STRING, value INT64 );
INSERT INTO items VALUES ('A', 10);
INSERT INTO items VALUES ('B', 10);
INSERT INTO items VALUES ('C', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (10.0);
INSERT INTO data VALUES (20.0);
INSERT INTO data VALUES (30.0);
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (val FLOAT64);
INSERT INTO samples VALUES (10.0);
INSERT INTO samples VALUES (20.0);
INSERT INTO samples VALUES (30.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1435
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_aggregate_test_select_1436
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_aggregate_test_select_1437
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1438
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1439
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1440
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1441
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1442
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_aggregate_test_select_1443
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_aggregate_test_select_1444
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_aggregate_test_select_1445
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1446
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_aggregate_test_select_1447
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1448
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1449
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1450
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1451
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1452
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1453
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1454
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1455
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1456
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1457
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_aggregate_test_select_1458
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1459
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1460
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS prices;
CREATE TABLE prices (price NUMERIC(10, 4));
INSERT INTO prices VALUES (1.5000);
INSERT INTO prices VALUES (1.50);
INSERT INTO prices VALUES (1.5);
INSERT INTO prices VALUES (2.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount NUMERIC(10, 2) );
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('A', 100.00);
INSERT INTO sales VALUES ('B', 200.50);
DROP TABLE IF EXISTS amounts;
CREATE TABLE amounts (val NUMERIC(10, 2));
INSERT INTO amounts VALUES (100.00);
INSERT INTO amounts VALUES (-50.25);
INSERT INTO amounts VALUES (0.00);
INSERT INTO amounts VALUES (25.50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val NUMERIC(10, 2));
INSERT INTO data VALUES (100.00);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (50.00);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores ( name STRING, score INT64 );
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 87);
INSERT INTO scores VALUES ('Carol', 87);
INSERT INTO scores VALUES ('Dave', 82);
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales ( day INT64, amount INT64 );
INSERT INTO daily_sales VALUES (1, 100);
INSERT INTO daily_sales VALUES (2, 150);
INSERT INTO daily_sales VALUES (3, 120);
DROP TABLE IF EXISTS events;
CREATE TABLE events ( seq INT64, event STRING );
INSERT INTO events VALUES (1, 'start');
INSERT INTO events VALUES (2, 'process');
INSERT INTO events VALUES (3, 'end');
DROP TABLE IF EXISTS items;
CREATE TABLE items ( name STRING, value INT64 );
INSERT INTO items VALUES ('A', 10);
INSERT INTO items VALUES ('B', 10);
INSERT INTO items VALUES ('C', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (10.0);
INSERT INTO data VALUES (20.0);
INSERT INTO data VALUES (30.0);
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (val FLOAT64);
INSERT INTO samples VALUES (10.0);
INSERT INTO samples VALUES (20.0);
INSERT INTO samples VALUES (30.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val FLOAT64);
INSERT INTO data VALUES (2.0);
INSERT INTO data VALUES (4.0);
INSERT INTO data VALUES (6.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1461
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_aggregate_test_select_1462
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1463
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1464
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_aggregate_test_select_1465
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1466
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_aggregate_test_select_1467
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_aggregate_test_select_1468
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_aggregate_test_select_1469
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_aggregate_test_select_1470
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1471
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_aggregate_test_select_1472
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1473
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1474
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1475
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1476
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1477
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1478
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1479
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1480
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1481
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1482
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_aggregate_test_select_1483
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1484
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1485
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1486
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1487
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1488
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1489
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1490
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1491
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1492
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1493
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1494
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_aggregate_test_select_1495
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1496
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1497
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1498
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1499
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1500
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_aggregate_test_select_1501
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1502
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1503
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1504
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1505
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_aggregate_test_select_1506
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1507
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1508
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1509
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1510
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1511
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_aggregate_test_select_1512
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1513
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 3.0), (3, 5.0), (4, 7.0), (5, 9.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0), (4, 8.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 42.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, NULL), (3, 5.0), (4, NULL), (5, 9.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 5), (2, 3), (3, 5), (4, 7), (5, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 3), (2, 3), (3, 5), (4, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 1), (2, 2), (3, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0), (4, 4.0, 8.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 8.0), (2, 2.0, 6.0), (3, 3.0, 4.0), (4, 4.0, 2.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 3.0), (2, 2.0, 1.0), (3, 3.0, 4.0), (4, 4.0, 2.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'A', 3.0), (4, 'B', 10.0), (5, 'B', 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 5.0), (3, 'A', 9.0), (4, 'B', 2.0), (5, 'B', 4.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 5.0), (2, 5.0), (3, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'A', 3.0), (4, 'B', 10.0), (5, 'B', 10.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'B', 10.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1514
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1515
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1516
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1517
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1518
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1519
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1520
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1521
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1522
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1523
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1524
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1525
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1526
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1527
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1528
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1529
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1530
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1531
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1532
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1533
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1534
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1535
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_aggregate_test_select_1536
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0), (4, 8.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 42.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, NULL), (3, 5.0), (4, NULL), (5, 9.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 5), (2, 3), (3, 5), (4, 7), (5, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 3), (2, 3), (3, 5), (4, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 1), (2, 2), (3, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0), (4, 4.0, 8.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 8.0), (2, 2.0, 6.0), (3, 3.0, 4.0), (4, 4.0, 2.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 3.0), (2, 2.0, 1.0), (3, 3.0, 4.0), (4, 4.0, 2.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, x FLOAT64, y FLOAT64);
INSERT INTO test VALUES (1, 1.0, 2.0), (2, 2.0, 4.0), (3, 3.0, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'A', 3.0), (4, 'B', 10.0), (5, 'B', 20.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 5.0), (3, 'A', 9.0), (4, 'B', 2.0), (5, 'B', 4.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 5.0), (2, 5.0), (3, 5.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'A', 3.0), (4, 'B', 10.0), (5, 'B', 10.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'B', 10.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1537
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1538
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1539
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1540
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1541
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1542
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1543
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1544
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1545
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1546
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1547
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1548
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1549
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1550
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1551
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1552
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1553
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1554
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1555
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1556
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_aggregate_test_select_1557
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_aggregate_test_select_1558
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS settings;
CREATE TABLE settings (key STRING PRIMARY KEY, value STRING DEFAULT 'default');
INSERT INTO settings VALUES ('key1', 'custom');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, message STRING, error STRING DEFAULT NULL);
INSERT INTO logs (id, message) VALUES (1, 'Info');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, name STRING, discount FLOAT64 DEFAULT 0.0);
INSERT INTO products (id, name) VALUES (1, 'Widget');
DROP TABLE IF EXISTS features;
CREATE TABLE features (id INT64 PRIMARY KEY, name STRING, enabled BOOL DEFAULT true);
INSERT INTO features (id, name) VALUES (1, 'Feature A');
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64 PRIMARY KEY, status STRING DEFAULT 'pending', priority INT64 DEFAULT 1, archived BOOL DEFAULT false);
INSERT INTO records (id) VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64 PRIMARY KEY, name STRING, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
INSERT INTO events (id, name) VALUES (1, 'Event A');
DROP TABLE IF EXISTS daily_logs;
CREATE TABLE daily_logs (id INT64 PRIMARY KEY, message STRING, log_date DATE DEFAULT CURRENT_DATE);
INSERT INTO daily_logs (id, message) VALUES (1, 'Log entry');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE, name STRING);
INSERT INTO users VALUES (1, 'alice@example.com', 'Alice');
INSERT INTO users VALUES (2, 'bob@example.com', 'Bob');
INSERT INTO users VALUES (3, 'alice@example.com', 'Alice2');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE);
INSERT INTO users VALUES (1, NULL);
INSERT INTO users VALUES (2, NULL);
INSERT INTO users VALUES (3, NULL);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64 PRIMARY KEY, username STRING UNIQUE);
INSERT INTO accounts VALUES (1, 'alice');
INSERT INTO accounts VALUES (2, 'ALICE');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING UNIQUE);
INSERT INTO items VALUES (1, '');
INSERT INTO items VALUES (2, '');
DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations (id INT64 PRIMARY KEY, room_number INT64, date DATE, UNIQUE (room_number, date));
INSERT INTO reservations VALUES (1, 101, DATE '2024-01-15');
INSERT INTO reservations VALUES (2, 101, DATE '2024-01-16');
INSERT INTO reservations VALUES (3, 102, DATE '2024-01-15');
INSERT INTO reservations VALUES (4, 101, DATE '2024-01-15');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE, username STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com', 'alice123');
INSERT INTO users VALUES (2, 'alice@example.com', 'bob456');
INSERT INTO users VALUES (3, 'carol@example.com', 'alice123');
INSERT INTO users VALUES (4, 'dave@example.com', 'dave789');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 0);
INSERT INTO products VALUES (3, -5.00);
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (id INT64 PRIMARY KEY, score INT64 CHECK (score >= 1 AND score <= 5));
INSERT INTO ratings VALUES (1, 1);
INSERT INTO ratings VALUES (2, 3);
INSERT INTO ratings VALUES (3, 5);
INSERT INTO ratings VALUES (4, 0);
INSERT INTO ratings VALUES (5, 6);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, username STRING CHECK (LENGTH(username) >= 3));
INSERT INTO users VALUES (1, 'alice');
INSERT INTO users VALUES (2, 'ab');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, price FLOAT64 CHECK (price > 0));
INSERT INTO products VALUES (1, NULL);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64 PRIMARY KEY, quantity INT64, discount FLOAT64, CHECK (quantity > 0 AND discount >= 0 AND discount <= 1.0));
INSERT INTO orders VALUES (1, 5, 0.1);
INSERT INTO orders VALUES (2, 0, 0.5);
INSERT INTO orders VALUES (3, 10, -0.1);
INSERT INTO orders VALUES (4, 10, 1.5);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING NOT NULL);
INSERT INTO users VALUES (1, 'alice@example.com');
INSERT INTO users VALUES (NULL, 'bob@example.com');
INSERT INTO users VALUES (2, NULL);
INSERT INTO users VALUES (1, 'charlie@example.com');
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL, username STRING NOT NULL);
INSERT INTO accounts VALUES (1, 'alice@example.com', 'alice');
INSERT INTO accounts VALUES (2, 'alice@example.com', 'bob');
INSERT INTO accounts VALUES (3, NULL, 'charlie');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64 PRIMARY KEY, sku STRING UNIQUE NOT NULL, name STRING NOT NULL, price FLOAT64 DEFAULT 0.0 CHECK (price >= 0), stock INT64 DEFAULT 0 CHECK (stock >= 0) );
INSERT INTO products VALUES (1, 'SKU001', 'Widget', 9.99, 100);
INSERT INTO products (id, sku, name) VALUES (2, 'SKU002', 'Gadget');
INSERT INTO products (id, sku, name) VALUES (1, 'SKU003', 'Test');
INSERT INTO products VALUES (3, 'SKU001', 'Test', 5.0, 10);
INSERT INTO products VALUES (4, 'SKU004', 'Test', -5.0, 10);
INSERT INTO products VALUES (5, 'SKU005', NULL, 5.0, 10);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL);
INSERT INTO users VALUES (1, 'alice@example.com');
INSERT INTO users VALUES (2, 'bob@example.com');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE);
INSERT INTO users VALUES (1, 'alice@example.com'), (2, 'bob@example.com'), (3, 'charlie@example.com');
INSERT INTO users VALUES (10, 'dave@example.com'), (10, 'eve@example.com');
INSERT INTO users VALUES (20, 'frank@example.com'), (21, 'frank@example.com');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64 PRIMARY KEY);
INSERT INTO numbers VALUES (500);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING UNIQUE);
INSERT INTO items VALUES (1, 'test@#$%^&*()');
INSERT INTO items VALUES (2, '中文字符');
INSERT INTO items VALUES (3, '🚀🎉');
INSERT INTO items VALUES (4, 'test@#$%^&*()');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING NOT NULL UNIQUE);
INSERT INTO test VALUES (1, 'first');
INSERT INTO test VALUES (1, 'second');
INSERT INTO test VALUES (2, 'first');
INSERT INTO test VALUES (3, NULL);

-- Tag: window_functions_window_functions_aggregate_test_select_1559
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_aggregate_test_select_1560
SELECT error FROM logs;
-- Tag: window_functions_window_functions_aggregate_test_select_1561
SELECT discount FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1562
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_aggregate_test_select_1563
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_aggregate_test_select_1564
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_aggregate_test_select_1565
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_aggregate_test_select_1566
SELECT * FROM users;
-- Tag: window_functions_window_functions_aggregate_test_select_1567
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_aggregate_test_select_1568
SELECT price FROM products;
-- Tag: window_functions_window_functions_aggregate_test_select_1569
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_aggregate_test_select_1570
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1571
SELECT COUNT(*) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1572
SELECT COUNT(val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1573
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1574
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1575
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1576
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1577
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1578
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1579
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1580
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1581
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1582
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1583
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1584
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1585
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_040
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1586
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1587
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1588
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1589
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1590
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1591
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1592
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1593
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1594
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1595
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1596
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1597
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1598
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1599
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1600
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1601
SELECT COUNT(val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1602
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1603
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1604
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1605
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1606
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1607
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1608
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1609
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1610
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1611
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1612
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1613
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1614
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_041
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1615
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1616
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1617
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1618
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1619
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1620
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1621
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1622
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1623
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1624
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1625
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1626
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1627
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1628
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1629
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1630
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1631
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1632
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1633
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1634
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1635
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1636
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1637
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1638
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1639
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1640
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1641
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1642
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_042
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1643
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1644
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1645
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1646
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1647
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1648
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1649
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1650
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1651
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1652
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1653
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1654
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1655
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1656
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1657
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1658
SELECT SUM(val) as total FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1659
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1660
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1661
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1662
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1663
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1664
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1665
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1666
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1667
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1668
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1669
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_043
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1670
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1671
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1672
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1673
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1674
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1675
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1676
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1677
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1678
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1679
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1680
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1681
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1682
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1683
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1684
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1685
SELECT AVG(val) as average FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1686
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1687
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1688
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1689
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1690
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1691
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1692
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1693
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1694
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1695
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_044
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1696
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1697
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1698
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1699
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1700
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1701
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1702
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1703
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1704
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1705
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1706
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1707
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1708
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1709
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1710
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1711
SELECT MIN(val) as min_val, MAX(val) as max_val FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1712
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1713
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1714
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1715
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1716
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1717
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1718
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1719
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1720
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_045
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1721
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1722
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1723
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1724
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1725
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1726
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1727
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1728
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1729
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1730
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1731
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1732
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1733
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1734
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1735
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (99);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (val INT64);
INSERT INTO outer_table VALUES (1);
INSERT INTO inner_table VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_aggregate_test_select_1736
SELECT COUNT(DISTINCT val) as cnt FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1737
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1738
SELECT CASE WHEN NULL = NULL THEN 'match' ELSE 'no match' END as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1739
SELECT val,
CASE WHEN val = 1 THEN 'one' ELSE NULL END as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1740
SELECT CASE WHEN val = 1 THEN 'one' WHEN val = 2 THEN 'two' END as category FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1741
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1742
SELECT val FROM data WHERE val IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1743
SELECT val FROM data WHERE val NOT IN (1, 2, NULL);
-- Tag: window_functions_window_functions_aggregate_test_select_1744
SELECT id FROM outer_table WHERE EXISTS (SELECT val FROM inner_table);
-- Tag: window_functions_window_functions_aggregate_test_select_046
SELECT
NULL + 5 as add_result,
10 - NULL as sub_result,
NULL * 3 as mul_result,
20 / NULL as div_result;
-- Tag: window_functions_window_functions_aggregate_test_select_1745
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1746
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1747
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1748
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1749
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1750
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1751
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1752
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1753
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_aggregate_test_select_1754
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_aggregate_test_select_1755
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_aggregate_test_select_1756
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1757
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_aggregate_test_select_1758
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_aggregate_test_select_1759
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 300);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, category STRING);
INSERT INTO events VALUES (1, 'A');
INSERT INTO events VALUES (2, 'A');
INSERT INTO events VALUES (3, 'B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
INSERT INTO scores VALUES (40);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);

-- Tag: window_functions_window_functions_aggregate_test_select_1760
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1761
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1762
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_aggregate_test_select_1763
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1764
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1765
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1766
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1767
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1768
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1769
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_aggregate_test_select_1770
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1771
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 300);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, category STRING);
INSERT INTO events VALUES (1, 'A');
INSERT INTO events VALUES (2, 'A');
INSERT INTO events VALUES (3, 'B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
INSERT INTO scores VALUES (40);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);

-- Tag: window_functions_window_functions_aggregate_test_select_1772
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1773
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_aggregate_test_select_1774
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1775
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1776
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1777
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1778
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1779
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1780
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_aggregate_test_select_1781
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1782
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, category STRING);
INSERT INTO events VALUES (1, 'A');
INSERT INTO events VALUES (2, 'A');
INSERT INTO events VALUES (3, 'B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
INSERT INTO scores VALUES (40);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (value INT64);
INSERT INTO scores VALUES (10);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (20);
INSERT INTO scores VALUES (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);

-- Tag: window_functions_window_functions_aggregate_test_select_1783
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_aggregate_test_select_1784
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1785
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1786
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1787
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1788
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1789
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1790
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_aggregate_test_select_1791
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1792
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);

-- Tag: window_functions_window_functions_aggregate_test_select_1793
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (year INT64, quarter INT64, revenue INT64);
INSERT INTO sales VALUES (2023, 1, 100), (2023, 2, 120), (2024, 1, 150), (2024, 2, 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, revenue INT64);
INSERT INTO sales VALUES ('A', 100), ('A', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, revenue INT64);
INSERT INTO sales VALUES ('A', 100), ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (30), (NULL), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', NULL), ('Carol', 85), ('Dave', NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);

-- Tag: window_functions_window_functions_aggregate_test_select_047
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_aggregate_test_select_1794
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1795
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_aggregate_test_select_1796
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1797
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_aggregate_test_select_1798
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_aggregate_test_select_1799
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1800
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1801
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1802
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100), ('East', 3, 1200),
('West', 1, 900), ('West', 2, 950), ('West', 3, 1000);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Eng', 100000), (2, 'Eng', 120000), (3, 'Sales', 80000), (4, 'Sales', 90000);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1200), (3, 'West', 900), (4, 'West', 1100);

-- Tag: window_functions_window_functions_aggregate_test_select_1803
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1804
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1805
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1806
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_aggregate_test_select_1807
SELECT * FROM (
-- Tag: window_functions_window_functions_aggregate_test_select_1808
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_1809
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('A', 100.0);
INSERT INTO sales VALUES ('A', 200.0);
INSERT INTO sales VALUES ('B', 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 'A', 100.0);
INSERT INTO sales VALUES ('East', 'B', 200.0);
INSERT INTO sales VALUES ('West', 'A', 150.0);

-- Tag: window_functions_window_functions_aggregate_test_select_1810
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_aggregate_test_select_1811
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1812
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_aggregate_test_select_1813
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_aggregate_test_select_1814
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_aggregate_test_select_1815
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

