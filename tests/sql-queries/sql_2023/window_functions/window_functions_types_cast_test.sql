-- Window Functions Types Cast - SQL:2023
-- Description: Type casting in window function expressions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_types_cast_test_select_001
SELECT COUNT(*) FROM zeros WHERE value = 0.00;
-- Tag: window_functions_window_functions_types_cast_test_select_002
SELECT price FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_003
SELECT dividend / divisor AS quotient FROM division_test;
-- Tag: window_functions_window_functions_types_cast_test_select_004
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_types_cast_test_select_005
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_types_cast_test_select_006
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_007
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_008
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_009
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_010
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_011
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_012
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_013
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_014
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_015
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_016
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_017
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_018
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_019
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_020
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_021
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_022
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_023
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_024
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_025
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_026
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_027
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_028
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_029
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_030
SELECT price FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_031
SELECT dividend / divisor AS quotient FROM division_test;
-- Tag: window_functions_window_functions_types_cast_test_select_032
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_types_cast_test_select_033
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_types_cast_test_select_034
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_035
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_036
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_037
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_038
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_039
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_040
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_041
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_042
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_043
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_044
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_045
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_046
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_047
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_048
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_049
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_050
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_051
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_052
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_053
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_054
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_055
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_056
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_057
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_058
SELECT dividend / divisor AS quotient FROM division_test;
-- Tag: window_functions_window_functions_types_cast_test_select_059
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_types_cast_test_select_060
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_types_cast_test_select_061
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_062
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_063
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_064
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_065
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_066
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_067
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_068
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_069
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_070
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_071
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_072
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_073
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_074
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_075
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_076
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_077
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_078
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_079
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_080
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_081
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_082
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_083
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_084
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_085
SELECT factor1 * factor2 AS product FROM multiplication;
-- Tag: window_functions_window_functions_types_cast_test_select_086
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_types_cast_test_select_087
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_088
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_089
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_090
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_091
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_092
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_093
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_094
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_095
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_096
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_097
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_098
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_099
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_100
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_101
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_102
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_103
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_104
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_105
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_106
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_107
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_108
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_109
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_110
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_111
SELECT dividend % divisor AS remainder FROM modulo_test;
-- Tag: window_functions_window_functions_types_cast_test_select_112
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_113
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_114
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_115
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_116
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_117
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_118
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_119
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_120
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_121
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_122
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_123
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_124
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_125
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_126
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_127
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_128
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_129
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_130
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_131
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_132
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_133
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_134
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_135
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_136
SELECT COUNT(*) FROM scale_test WHERE value1 = value2;
-- Tag: window_functions_window_functions_types_cast_test_select_137
SELECT SUM(amount) FROM big_sums;
-- Tag: window_functions_window_functions_types_cast_test_select_138
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_139
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_140
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_141
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_142
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_types_cast_test_select_143
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_types_cast_test_select_144
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_types_cast_test_select_145
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_types_cast_test_select_146
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_types_cast_test_select_147
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_types_cast_test_select_148
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_types_cast_test_select_149
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_types_cast_test_select_150
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_types_cast_test_select_151
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_types_cast_test_select_152
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_types_cast_test_select_153
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_154
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_155
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_156
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_157
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_158
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_159
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_types_cast_test_select_160
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_types_cast_test_select_161
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_types_cast_test_select_162
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_163
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_164
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_165
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_166
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS division;
CREATE TABLE division ( numerator NUMERIC(10, 2), denominator NUMERIC(10, 2) );
INSERT INTO division VALUES (100.00, 0.00);
DROP TABLE IF EXISTS data;
CREATE TABLE data ( id INT64, value INT64 );
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( category STRING, amount FLOAT64 );
INSERT INTO sales VALUES ('A', 100);

-- Tag: window_functions_window_functions_types_cast_test_select_167
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_types_cast_test_select_168
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_169
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, flag BOOL);
INSERT INTO mixed VALUES (1, TRUE);
INSERT INTO mixed VALUES (2, FALSE);
INSERT INTO mixed VALUES (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (15);
INSERT INTO data VALUES (25);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 5);
INSERT INTO nums VALUES (NULL, 5);
INSERT INTO nums VALUES (10, NULL);
INSERT INTO nums VALUES (NULL, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_170
SELECT id,
CAST(CASE
WHEN flag = TRUE THEN 42
WHEN flag = FALSE THEN 3.14
ELSE NULL
END AS STRING) as result
FROM mixed ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_171
SELECT val,
CAST(
CASE
WHEN val < 10 THEN
CAST(CASE WHEN val < 5 THEN 'tiny' ELSE 'small' END AS STRING)
WHEN val < 20 THEN 'medium'
ELSE
CAST(val AS STRING)
END
AS STRING) as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_172
SELECT CAST(CASE WHEN id = 1 THEN NULL WHEN id = 2 THEN NULL ELSE NULL END AS STRING) as result FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_001
SELECT
CAST(NULL AS INT64) as int_null,
CAST(NULL AS FLOAT64) as float_null,
CAST(NULL AS STRING) as string_null,
CAST(NULL AS BOOL) as bool_null;
-- Tag: window_functions_window_functions_types_cast_test_select_173
SELECT CAST(a + b AS STRING) as sum_str FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_002
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_003
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_174
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_175
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_004
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_176
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_177
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_178
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_179
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_180
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_181
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_182
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_183
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_184
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_185
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_186
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_187
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_188
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_189
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_190
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_191
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_192
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_193
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_194
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_195
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_196
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_197
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_198
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_199
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_200
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_201
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_005
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_202
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_203
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
-- Tag: window_functions_window_functions_types_cast_test_select_204
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (15);
INSERT INTO data VALUES (25);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 5);
INSERT INTO nums VALUES (NULL, 5);
INSERT INTO nums VALUES (10, NULL);
INSERT INTO nums VALUES (NULL, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_205
SELECT val,
CAST(
CASE
WHEN val < 10 THEN
CAST(CASE WHEN val < 5 THEN 'tiny' ELSE 'small' END AS STRING)
WHEN val < 20 THEN 'medium'
ELSE
CAST(val AS STRING)
END
AS STRING) as category
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_206
SELECT CAST(CASE WHEN id = 1 THEN NULL WHEN id = 2 THEN NULL ELSE NULL END AS STRING) as result FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_006
SELECT
CAST(NULL AS INT64) as int_null,
CAST(NULL AS FLOAT64) as float_null,
CAST(NULL AS STRING) as string_null,
CAST(NULL AS BOOL) as bool_null;
-- Tag: window_functions_window_functions_types_cast_test_select_207
SELECT CAST(a + b AS STRING) as sum_str FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_007
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_008
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_208
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_209
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_009
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_210
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_211
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_212
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_213
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_214
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_215
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_216
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_217
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_218
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_219
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_220
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_221
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_222
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_223
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_224
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_225
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_226
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_227
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_228
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_229
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_230
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_231
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_232
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_233
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_234
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_235
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_010
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_236
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_237
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
-- Tag: window_functions_window_functions_types_cast_test_select_238
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 5);
INSERT INTO nums VALUES (NULL, 5);
INSERT INTO nums VALUES (10, NULL);
INSERT INTO nums VALUES (NULL, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_239
SELECT CAST(CASE WHEN id = 1 THEN NULL WHEN id = 2 THEN NULL ELSE NULL END AS STRING) as result FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_011
SELECT
CAST(NULL AS INT64) as int_null,
CAST(NULL AS FLOAT64) as float_null,
CAST(NULL AS STRING) as string_null,
CAST(NULL AS BOOL) as bool_null;
-- Tag: window_functions_window_functions_types_cast_test_select_240
SELECT CAST(a + b AS STRING) as sum_str FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_012
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_013
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_241
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_242
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_014
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_243
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_244
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_245
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_246
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_247
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_248
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_249
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_250
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_251
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_252
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_253
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_254
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_255
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_256
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_257
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_258
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_259
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_260
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_261
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_262
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_263
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_264
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_265
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_266
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_267
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_268
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_015
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_269
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_270
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
-- Tag: window_functions_window_functions_types_cast_test_select_271
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 5);
INSERT INTO nums VALUES (NULL, 5);
INSERT INTO nums VALUES (10, NULL);
INSERT INTO nums VALUES (NULL, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_016
SELECT
CAST(NULL AS INT64) as int_null,
CAST(NULL AS FLOAT64) as float_null,
CAST(NULL AS STRING) as string_null,
CAST(NULL AS BOOL) as bool_null;
-- Tag: window_functions_window_functions_types_cast_test_select_272
SELECT CAST(a + b AS STRING) as sum_str FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_017
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_018
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_273
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_274
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_019
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_275
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_276
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_277
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_278
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_279
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_280
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_281
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_282
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_283
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_284
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_285
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_286
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_287
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_288
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_289
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_290
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_291
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_292
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_293
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_294
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_295
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_296
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_297
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_298
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_299
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_300
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_020
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_301
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_302
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
-- Tag: window_functions_window_functions_types_cast_test_select_303
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 5);
INSERT INTO nums VALUES (NULL, 5);
INSERT INTO nums VALUES (10, NULL);
INSERT INTO nums VALUES (NULL, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_304
SELECT CAST(a + b AS STRING) as sum_str FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_021
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_022
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_305
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_306
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_023
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_307
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_308
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_309
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_310
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_311
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_312
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_313
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_314
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_315
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_316
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_317
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_318
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_319
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_320
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_321
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_322
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_323
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_324
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_325
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_326
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_327
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_328
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_329
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_330
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_331
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_332
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_024
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_333
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_334
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
-- Tag: window_functions_window_functions_types_cast_test_select_335
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_025
SELECT
CAST(COALESCE(val, 0) AS STRING) as coalesce_first,
COALESCE(CAST(val AS STRING), '0') as cast_first
FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_026
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_336
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_337
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_027
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_338
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_339
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_340
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_341
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_342
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_343
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_344
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_345
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_346
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_347
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_348
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_349
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_350
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_351
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_352
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_353
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_354
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_355
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_356
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_357
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_358
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_359
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_360
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_361
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_362
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_363
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_028
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_364
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_365
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
-- Tag: window_functions_window_functions_types_cast_test_select_366
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_029
SELECT
CAST(3.14 AS INT64) as pi_int,
CAST(2.99 AS INT64) as almost_three,
CAST(-1.7 AS INT64) as negative,
CAST(0.5 AS INT64) as half;
-- Tag: window_functions_window_functions_types_cast_test_select_367
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_368
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_030
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_369
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_370
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_371
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_372
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_373
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_374
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_375
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_376
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_377
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_378
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_379
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_380
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_381
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_382
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_383
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_384
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_385
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_386
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_387
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_388
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_389
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_390
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_391
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_392
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_393
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_394
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_031
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_395
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_396
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
-- Tag: window_functions_window_functions_types_cast_test_select_397
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_398
SELECT CAST(9223372036854775000.0 AS INT64) as large_num;
-- Tag: window_functions_window_functions_types_cast_test_select_399
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_032
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_400
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_401
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_402
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_403
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_404
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_405
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_406
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_407
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_408
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_409
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_410
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_411
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_412
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_413
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_414
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_415
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_416
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_417
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_418
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_419
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_420
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_421
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_422
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_423
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_424
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_425
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_033
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_426
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_427
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
-- Tag: window_functions_window_functions_types_cast_test_select_428
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS nums;
CREATE TABLE nums (val INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_429
SELECT CAST(val AS FLOAT64) as float_val FROM nums;
-- Tag: window_functions_window_functions_types_cast_test_select_034
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_430
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_431
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_432
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_433
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_434
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_435
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_436
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_437
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_438
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_439
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_440
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_441
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_442
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_443
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_444
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_445
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_446
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_447
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_448
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_449
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_450
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_451
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_452
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_453
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_454
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_455
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_035
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_456
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_457
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
-- Tag: window_functions_window_functions_types_cast_test_select_458
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_036
SELECT
CAST(10 / 3 AS INT64) as int_div,
CAST(10 / 3 AS FLOAT64) as float_div,
CAST(10 / 3 AS STRING) as string_div;
-- Tag: window_functions_window_functions_types_cast_test_select_459
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_460
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_461
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_462
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_463
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_464
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_465
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_466
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_467
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_468
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_469
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_470
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_471
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_472
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_473
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_474
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_475
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_476
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_477
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_478
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_479
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_480
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_481
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_482
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_483
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_484
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_037
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_485
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_486
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
-- Tag: window_functions_window_functions_types_cast_test_select_487
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_488
SELECT product,
CAST(SUM(amount) AS STRING) as total_str,
CAST(COUNT(*) AS STRING) as count_str
FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_489
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_490
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_491
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_492
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_493
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_494
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_495
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_496
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_497
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_498
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_499
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_500
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_501
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_502
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_503
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_504
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_505
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_506
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_507
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_508
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_509
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_510
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_511
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_512
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_513
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_038
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_514
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_515
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
-- Tag: window_functions_window_functions_types_cast_test_select_516
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
INSERT INTO data VALUES ('B', 5);
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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_517
SELECT category, SUM(value) as total
FROM data
GROUP BY category
HAVING CAST(SUM(value) AS STRING) > '10'
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_518
SELECT CAST(AVG(val) AS INT64) as avg_int FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_519
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_520
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_521
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_522
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_523
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_524
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_525
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_526
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_527
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_528
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_529
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_530
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_531
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_532
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_533
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_534
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_535
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_536
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_537
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_538
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_539
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_540
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_541
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_039
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_542
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_543
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
-- Tag: window_functions_window_functions_types_cast_test_select_544
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_545
SELECT CAST((SELECT MAX(val) FROM data) AS STRING) as max_str;
-- Tag: window_functions_window_functions_types_cast_test_select_546
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_547
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_548
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_549
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_550
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_551
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_552
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_553
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_554
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_555
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_556
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_557
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_558
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_559
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_560
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_561
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_562
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_563
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_564
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_565
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_566
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_567
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_040
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_568
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_569
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
-- Tag: window_functions_window_functions_types_cast_test_select_570
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_571
SELECT id FROM numbers WHERE CAST(id AS STRING) IN (SELECT val FROM strings) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_572
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_573
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_574
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_575
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_576
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_577
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_578
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_579
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_580
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_581
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_582
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_583
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_584
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_585
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_586
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_587
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_588
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_589
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_590
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_591
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_592
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_041
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_593
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_594
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
-- Tag: window_functions_window_functions_types_cast_test_select_595
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_596
SELECT id,
CAST((SELECT SUM(amount) FROM inner_table WHERE parent_id = outer_table.id) AS STRING) as total_str
FROM outer_table ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_597
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_598
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_599
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_600
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_601
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_602
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_603
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_604
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_605
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_606
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_607
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_608
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_609
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_610
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_611
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_612
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_613
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_614
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_615
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_616
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_042
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_617
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_618
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
-- Tag: window_functions_window_functions_types_cast_test_select_619
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_620
SELECT it.id, it.data, st.value
FROM int_table it
JOIN str_table st ON CAST(it.id AS STRING) = st.id_str
ORDER BY it.id;
-- Tag: window_functions_window_functions_types_cast_test_select_621
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_622
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_623
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_624
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_625
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_626
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_627
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_628
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_629
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_630
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_631
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_632
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_633
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_634
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_635
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_636
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_637
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_638
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_639
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_043
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_640
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_641
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
-- Tag: window_functions_window_functions_types_cast_test_select_642
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_643
SELECT t1.a, t1.b
FROM t1
JOIN t2 ON CAST(t1.a AS STRING) = t2.x AND CAST(t1.b AS STRING) = t2.y;
-- Tag: window_functions_window_functions_types_cast_test_select_644
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_645
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_646
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_647
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_648
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_649
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_650
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_651
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_652
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_653
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_654
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_655
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_656
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_657
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_658
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_659
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_660
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_661
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_044
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_662
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_663
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
-- Tag: window_functions_window_functions_types_cast_test_select_664
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_665
SELECT region, amount,
CAST(SUM(amount) OVER (PARTITION BY region) AS STRING) as region_total_str
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_types_cast_test_select_666
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_667
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_668
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_669
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_670
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_671
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_672
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_673
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_674
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_675
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_676
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_677
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_678
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_679
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_680
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_681
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_682
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_045
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_683
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_684
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
-- Tag: window_functions_window_functions_types_cast_test_select_685
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

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
INSERT INTO data VALUES ('  42  ');
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

-- Tag: window_functions_window_functions_types_cast_test_select_686
SELECT id, value,
SUM(value) OVER (PARTITION BY CAST(id AS STRING) ORDER BY value) as running_total
FROM data ORDER BY id, value;
-- Tag: window_functions_window_functions_types_cast_test_select_687
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_688
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_689
SELECT CAST(val AS INT64) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_690
SELECT CAST(val AS STRING) as str_val FROM bools;
-- Tag: window_functions_window_functions_types_cast_test_select_691
SELECT CAST(CONCAT('12', '34') AS INT64) as num;
-- Tag: window_functions_window_functions_types_cast_test_select_692
SELECT UPPER(CAST(42 AS STRING)) as upper_num;
-- Tag: window_functions_window_functions_types_cast_test_select_693
SELECT CAST(SUBSTR(val, 4, 3) AS INT64) as num FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_694
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_695
SELECT val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_696
SELECT CAST(val AS STRING) as str_val FROM data ORDER BY CAST(val AS STRING);
-- Tag: window_functions_window_functions_types_cast_test_select_697
SELECT CAST(val AS STRING) as val FROM int_data
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_698
SELECT val FROM str_data
ORDER BY val;
-- Tag: window_functions_window_functions_types_cast_test_select_699
SELECT 42 as val
UNION ALL
-- Tag: window_functions_window_functions_types_cast_test_select_700
SELECT 3.14;
-- Tag: window_functions_window_functions_types_cast_test_select_701
SELECT CAST(CAST(CAST(42 AS STRING) AS INT64) AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_702
SELECT CAST(CAST(3.14159 AS INT64) AS FLOAT64) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_046
SELECT
CAST(42 AS INT64) as orig,
CAST(CAST(42 AS FLOAT64) AS INT64) as via_float,
CAST(CAST(CAST(42 AS FLOAT64) AS STRING) AS INT64) as via_float_str;
-- Tag: window_functions_window_functions_types_cast_test_select_703
SELECT CAST(
CASE
WHEN CAST('10' AS INT64) > 5
THEN CAST(CAST('2' AS INT64) + CAST('3' AS INT64) AS STRING)
ELSE 'zero'
END
AS STRING) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_704
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
-- Tag: window_functions_window_functions_types_cast_test_select_705
SELECT CAST(val AS STRING) as str_val FROM bounds ORDER BY val;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, number INT64);
INSERT INTO data VALUES (1, 12345), (2, 67890), (3, 11111);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount STRING);
INSERT INTO sales VALUES ('A', '100.50'), ('B', '200.75'), ('A', '150.25');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30'), (4, '40');
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales (date DATE, product STRING, amount INT64);
DROP TABLE IF EXISTS monthly_summary;
CREATE TABLE monthly_summary (month INT64, product STRING, total INT64);
INSERT INTO daily_sales VALUES (DATE '2024-01-05', 'A', 100);
INSERT INTO daily_sales VALUES (DATE '2024-01-15', 'A', 150);
INSERT INTO daily_sales VALUES (DATE '2024-02-10', 'A', 200);
INSERT INTO monthly_summary SELECT EXTRACT(MONTH FROM date), product, SUM(amount) FROM daily_sales GROUP BY EXTRACT(MONTH FROM date), product;
DROP TABLE IF EXISTS computed;
CREATE TABLE computed (id INT64, value INT64, squared INT64);
INSERT INTO computed VALUES (1, 5, 5 * 5), (2, 10, 10 * 10), (3, 15, 15 * 15);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, manager_id INT64, salary INT64);
INSERT INTO employees VALUES (1, NULL, 100000);
INSERT INTO employees VALUES (2, 1, 80000), (3, 1, 90000);
INSERT INTO employees VALUES (4, 2, 60000), (5, 2, 70000);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data STRING);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Apple', 1.5), (2, 'Banana', 0.5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('West', 'A', 100), ('West', 'B', 200);
INSERT INTO sales VALUES ('East', 'A', 150), ('East', 'B', 250);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date DATE, price FLOAT64);
INSERT INTO prices VALUES (DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES (DATE '2024-01-02', 11.0);
INSERT INTO prices VALUES (DATE '2024-01-03', NULL);
INSERT INTO prices VALUES (DATE '2024-01-04', 12.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, user_id INT64, date DATE, amount FLOAT64, category STRING);
INSERT INTO transactions VALUES (1, 1, DATE '2024-01-05', 100.0, 'Food');
INSERT INTO transactions VALUES (2, 1, DATE '2024-01-15', 50.0, 'Transport');
INSERT INTO transactions VALUES (3, 2, DATE '2024-01-10', 200.0, 'Food');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, product STRING, quantity INT64, price FLOAT64);
INSERT INTO orders VALUES (1, 'A', 5, 10.0), (1, 'B', 3, 20.0);
INSERT INTO orders VALUES (2, 'A', 10, 10.0), (2, 'B', 1, 20.0);
DROP TABLE IF EXISTS sales_2023;
CREATE TABLE sales_2023 (product STRING, amount INT64);
DROP TABLE IF EXISTS sales_2024;
CREATE TABLE sales_2024 (product STRING, amount INT64);
INSERT INTO sales_2023 VALUES ('A', 100), ('B', 200);
INSERT INTO sales_2024 VALUES ('A', 150), ('B', 250);

-- Tag: window_functions_window_functions_types_cast_test_select_706
SELECT * FROM data WHERE CAST(number AS STRING) LIKE '1%';
-- Tag: window_functions_window_functions_types_cast_test_select_707
SELECT product, SUM(CAST(amount AS FLOAT64)) as total FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_708
SELECT * FROM data WHERE CAST(value AS INT64) BETWEEN 15 AND 35;
-- Tag: window_functions_window_functions_types_cast_test_select_709
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_types_cast_test_select_710
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_711
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_types_cast_test_select_712
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_types_cast_test_select_713
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_types_cast_test_select_714
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_715
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_types_cast_test_select_716
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount STRING);
INSERT INTO sales VALUES ('A', '100.50'), ('B', '200.75'), ('A', '150.25');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30'), (4, '40');
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales (date DATE, product STRING, amount INT64);
DROP TABLE IF EXISTS monthly_summary;
CREATE TABLE monthly_summary (month INT64, product STRING, total INT64);
INSERT INTO daily_sales VALUES (DATE '2024-01-05', 'A', 100);
INSERT INTO daily_sales VALUES (DATE '2024-01-15', 'A', 150);
INSERT INTO daily_sales VALUES (DATE '2024-02-10', 'A', 200);
INSERT INTO monthly_summary SELECT EXTRACT(MONTH FROM date), product, SUM(amount) FROM daily_sales GROUP BY EXTRACT(MONTH FROM date), product;
DROP TABLE IF EXISTS computed;
CREATE TABLE computed (id INT64, value INT64, squared INT64);
INSERT INTO computed VALUES (1, 5, 5 * 5), (2, 10, 10 * 10), (3, 15, 15 * 15);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, manager_id INT64, salary INT64);
INSERT INTO employees VALUES (1, NULL, 100000);
INSERT INTO employees VALUES (2, 1, 80000), (3, 1, 90000);
INSERT INTO employees VALUES (4, 2, 60000), (5, 2, 70000);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data STRING);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Apple', 1.5), (2, 'Banana', 0.5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('West', 'A', 100), ('West', 'B', 200);
INSERT INTO sales VALUES ('East', 'A', 150), ('East', 'B', 250);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date DATE, price FLOAT64);
INSERT INTO prices VALUES (DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES (DATE '2024-01-02', 11.0);
INSERT INTO prices VALUES (DATE '2024-01-03', NULL);
INSERT INTO prices VALUES (DATE '2024-01-04', 12.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, user_id INT64, date DATE, amount FLOAT64, category STRING);
INSERT INTO transactions VALUES (1, 1, DATE '2024-01-05', 100.0, 'Food');
INSERT INTO transactions VALUES (2, 1, DATE '2024-01-15', 50.0, 'Transport');
INSERT INTO transactions VALUES (3, 2, DATE '2024-01-10', 200.0, 'Food');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, product STRING, quantity INT64, price FLOAT64);
INSERT INTO orders VALUES (1, 'A', 5, 10.0), (1, 'B', 3, 20.0);
INSERT INTO orders VALUES (2, 'A', 10, 10.0), (2, 'B', 1, 20.0);
DROP TABLE IF EXISTS sales_2023;
CREATE TABLE sales_2023 (product STRING, amount INT64);
DROP TABLE IF EXISTS sales_2024;
CREATE TABLE sales_2024 (product STRING, amount INT64);
INSERT INTO sales_2023 VALUES ('A', 100), ('B', 200);
INSERT INTO sales_2024 VALUES ('A', 150), ('B', 250);

-- Tag: window_functions_window_functions_types_cast_test_select_717
SELECT product, SUM(CAST(amount AS FLOAT64)) as total FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_types_cast_test_select_718
SELECT * FROM data WHERE CAST(value AS INT64) BETWEEN 15 AND 35;
-- Tag: window_functions_window_functions_types_cast_test_select_719
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_types_cast_test_select_720
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_721
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_types_cast_test_select_722
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_types_cast_test_select_723
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_types_cast_test_select_724
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_725
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_types_cast_test_select_726
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30'), (4, '40');
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales (date DATE, product STRING, amount INT64);
DROP TABLE IF EXISTS monthly_summary;
CREATE TABLE monthly_summary (month INT64, product STRING, total INT64);
INSERT INTO daily_sales VALUES (DATE '2024-01-05', 'A', 100);
INSERT INTO daily_sales VALUES (DATE '2024-01-15', 'A', 150);
INSERT INTO daily_sales VALUES (DATE '2024-02-10', 'A', 200);
INSERT INTO monthly_summary SELECT EXTRACT(MONTH FROM date), product, SUM(amount) FROM daily_sales GROUP BY EXTRACT(MONTH FROM date), product;
DROP TABLE IF EXISTS computed;
CREATE TABLE computed (id INT64, value INT64, squared INT64);
INSERT INTO computed VALUES (1, 5, 5 * 5), (2, 10, 10 * 10), (3, 15, 15 * 15);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS dest;
CREATE TABLE dest (id INT64, value INT64);
INSERT INTO dest SELECT * FROM source WHERE value > 500 ORDER BY value DESC LIMIT 10;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
ALTER TABLE users ADD COLUMN status STRING DEFAULT 'active';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 30);
ALTER TABLE data ALTER COLUMN value SET NOT NULL;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
ALTER TABLE orders ADD CONSTRAINT check_customer CHECK (customer_id > 0);
ALTER TABLE orders DROP COLUMN customer_id;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, manager_id INT64, salary INT64);
INSERT INTO employees VALUES (1, NULL, 100000);
INSERT INTO employees VALUES (2, 1, 80000), (3, 1, 90000);
INSERT INTO employees VALUES (4, 2, 60000), (5, 2, 70000);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data STRING);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'Apple', 1.5), (2, 'Banana', 0.5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('West', 'A', 100), ('West', 'B', 200);
INSERT INTO sales VALUES ('East', 'A', 150), ('East', 'B', 250);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date DATE, price FLOAT64);
INSERT INTO prices VALUES (DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES (DATE '2024-01-02', 11.0);
INSERT INTO prices VALUES (DATE '2024-01-03', NULL);
INSERT INTO prices VALUES (DATE '2024-01-04', 12.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, user_id INT64, date DATE, amount FLOAT64, category STRING);
INSERT INTO transactions VALUES (1, 1, DATE '2024-01-05', 100.0, 'Food');
INSERT INTO transactions VALUES (2, 1, DATE '2024-01-15', 50.0, 'Transport');
INSERT INTO transactions VALUES (3, 2, DATE '2024-01-10', 200.0, 'Food');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, product STRING, quantity INT64, price FLOAT64);
INSERT INTO orders VALUES (1, 'A', 5, 10.0), (1, 'B', 3, 20.0);
INSERT INTO orders VALUES (2, 'A', 10, 10.0), (2, 'B', 1, 20.0);
DROP TABLE IF EXISTS sales_2023;
CREATE TABLE sales_2023 (product STRING, amount INT64);
DROP TABLE IF EXISTS sales_2024;
CREATE TABLE sales_2024 (product STRING, amount INT64);
INSERT INTO sales_2023 VALUES ('A', 100), ('B', 200);
INSERT INTO sales_2024 VALUES ('A', 150), ('B', 250);

-- Tag: window_functions_window_functions_types_cast_test_select_727
SELECT * FROM data WHERE CAST(value AS INT64) BETWEEN 15 AND 35;
-- Tag: window_functions_window_functions_types_cast_test_select_728
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_types_cast_test_select_729
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_730
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_types_cast_test_select_731
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_types_cast_test_select_732
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_types_cast_test_select_733
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_734
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_types_cast_test_select_735
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

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

-- Tag: window_functions_window_functions_types_cast_test_select_736
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_737
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_738
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_types_cast_test_select_739
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_types_cast_test_select_740
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_741
SELECT *;
-- Tag: window_functions_window_functions_types_cast_test_select_742
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_types_cast_test_select_743
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_types_cast_test_select_744
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_types_cast_test_select_745
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_types_cast_test_select_746
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_types_cast_test_select_747
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_types_cast_test_select_748
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_types_cast_test_select_749
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_types_cast_test_select_750
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_types_cast_test_select_751
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_types_cast_test_select_752
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_types_cast_test_select_047
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_types_cast_test_select_753
SELECT userid FROM users;
-- Tag: window_functions_window_functions_types_cast_test_select_754
SELECT * FROM user;

DROP TABLE IF EXISTS t;
CREATE TABLE t (val STRING);
INSERT INTO t VALUES ('not_a_number');
DROP TABLE IF EXISTS t;
CREATE TABLE t (col1 INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, val STRING);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, val STRING);
INSERT INTO t1 VALUES (1, 'a');
INSERT INTO t2 VALUES (1, 'b');
DROP TABLE IF EXISTS t;
CREATE TABLE t (val INT64);
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

-- Tag: window_functions_window_functions_types_cast_test_select_755
SELECT CAST(val AS INT64) FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_756
SELECT * FROM nonexistent_table;
-- Tag: window_functions_window_functions_types_cast_test_select_757
SELECT nonexistent_column FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_758
SELECT id FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_types_cast_test_select_759
SELECT NONEXISTENT_FUNCTION(val) FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_760
SELECT ABS(val, val) FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_761
SELECT val / 0 FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_762
SELECT SQRT(val) FROM t;
UPDATE nonexistent SET col = 1;
-- Tag: window_functions_window_functions_types_cast_test_select_763
SELECT id, SUM(val) FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_764
SELECT val FROM t HAVING val > 10;
-- Tag: window_functions_window_functions_types_cast_test_select_765
SELECT (SELECT val FROM t) as result;
-- Tag: window_functions_window_functions_types_cast_test_select_766
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id;
-- Tag: window_functions_window_functions_types_cast_test_select_767
SELECT ROW_NUMBER() FROM t;
WITH cte AS (SELECT * FROM cte)
-- Tag: window_functions_window_functions_types_cast_test_select_768
SELECT * FROM cte;
-- Tag: window_functions_window_functions_types_cast_test_select_769
SELECT val as v FROM t ORDER BY nonexistent;
-- Tag: window_functions_window_functions_types_cast_test_select_770
SELECT nonexistent_column FROM users;
-- Tag: window_functions_window_functions_types_cast_test_select_771
SELECT colum_name FROM t;
-- Tag: window_functions_window_functions_types_cast_test_select_772
SELECT * FROM t LIMIT 999999999999999;
-- Tag: window_functions_window_functions_types_cast_test_select_773
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, year STRING, amount STRING);
INSERT INTO sales VALUES
('North', '2023', '100.50'),
('North', '2023', '200.75'),
('South', '2023', '150.25'),
('North', '2024', '300.00'),
('South', '2024', '250.50');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES
('A', '10'), ('A', '20'), ('A', '30'),
('B', '5'), ('B', '15'),
('C', '100');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary INT64);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO employees VALUES
(1, 'Alice', 1, 80000),
(2, 'Bob', 1, 90000),
(3, 'Charlie', 2, 70000),
(4, 'David', 2, 85000);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES
(1, 1, 100.0), (2, 1, 200.0),
(3, 2, 150.0),
(4, 3, 300.0), (5, 3, 400.0), (6, 3, 250.0);
INSERT INTO customers VALUES
(1, 'Alice', 'North'),
(2, 'Bob', 'South'),
(3, 'Charlie', 'North');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount FLOAT64);
INSERT INTO sales VALUES
('Widget', 'North', 100.0),
('Widget', 'South', 150.0),
('Widget', 'East', 120.0),
('Gadget', 'North', 200.0),
('Gadget', 'South', 180.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, amount FLOAT64, type STRING);
INSERT INTO transactions VALUES
(1, 100.0, 'credit'), (2, 50.0, 'debit'),
(3, 200.0, 'credit'), (4, 75.0, 'debit'),
(5, 150.0, 'credit');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, status STRING, amount FLOAT64);
INSERT INTO orders VALUES
('Alice', 'completed', 100.0),
('Alice', 'cancelled', 50.0),
('Alice', 'completed', 200.0),
('Bob', 'completed', 150.0),
('Bob', 'cancelled', 200.0),
('Charlie', 'completed', 300.0);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, subject STRING, score INT64);
INSERT INTO scores VALUES
('Alice', 'Math', 90), ('Alice', 'English', 85),
('Bob', 'Math', 75), ('Bob', 'English', 95),
('Charlie', 'Math', 60), ('Charlie', 'English', 70);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b INT64, c STRING);
INSERT INTO data VALUES
(1, 10, 20, '5'),
(2, NULL, 30, '10'),
(3, 40, NULL, '15'),
(4, 50, 60, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10), ('A', 20),
(NULL, 30), (NULL, 40),
('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, int_val INT64, float_val FLOAT64, str_val STRING);
INSERT INTO data VALUES (1, 10, 2.5, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL, int_val INT64, float_val FLOAT64);
INSERT INTO data VALUES (1, true, 10, 3.5), (2, false, 20, 4.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES
(1, 'A', 100), (2, 'A', 200), (3, 'B', 150),
(4, 'B', 250), (5, 'C', 300);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (user_id INT64, amount_str STRING);
INSERT INTO transactions VALUES
(1, '100'), (1, '200'), (2, '150'), (2, '250'), (2, '100');
DROP TABLE IF EXISTS source;
CREATE TABLE source (name STRING, age_str STRING, score_str STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (name STRING, age INT64, score FLOAT64, grade STRING);
INSERT INTO source VALUES
('Alice', '25', '85.5'),
('Bob', '30', '92.0'),
('Charlie', '22', '78.5');
INSERT INTO target (name, age, score, grade)
-- Tag: window_functions_window_functions_types_cast_test_select_774
SELECT name,
CAST(age_str AS INT64),
CAST(score_str AS FLOAT64),
CASE
WHEN CAST(score_str AS FLOAT64) >= 90 THEN 'A'
WHEN CAST(score_str AS FLOAT64) >= 80 THEN 'B'
ELSE 'C'
END
FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, year_str STRING, amount FLOAT64);
INSERT INTO sales VALUES
(1, '2023', 100.0), (2, '2023', 200.0),
(3, '2024', 150.0), (4, '2024', 250.0), (5, '2024', 300.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Alice', 'Eng', 80000),
(2, 'Bob', 'Sales', 70000),
(3, 'Charlie', 'Eng', 90000),
(4, 'David', 'Sales', 75000);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_types_cast_test_select_775
SELECT region,
CAST(year AS INT64) as year_int,
SUM(CAST(amount AS FLOAT64)) as total_amount,
COUNT(*) as sale_count
FROM sales
GROUP BY region, CAST(year AS INT64)
ORDER BY region, year_int;
-- Tag: window_functions_window_functions_types_cast_test_select_776
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category
HAVING SUM(CAST(value AS INT64)) > 20
ORDER BY total DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_777
SELECT e.name, d.name as dept, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
ORDER BY e.salary DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_778
SELECT c.name,
(SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) as order_count,
(SELECT SUM(amount) FROM orders o WHERE o.customer_id = c.id) as total_spent
FROM customers c
WHERE c.region = 'North'
ORDER BY c.name;
WITH ranked_sales AS (
-- Tag: window_functions_window_functions_types_cast_test_select_779
SELECT product, region, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount DESC) as rank
FROM sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_780
SELECT product, region, amount
FROM ranked_sales
WHERE rank <= 2
ORDER BY product, rank;
WITH credits AS (
-- Tag: window_functions_window_functions_types_cast_test_select_781
SELECT SUM(amount) as total_credits
FROM transactions
WHERE type = 'credit'
),
debits AS (
-- Tag: window_functions_window_functions_types_cast_test_select_782
SELECT SUM(amount) as total_debits
FROM transactions
WHERE type = 'debit'
),
summary AS (
-- Tag: window_functions_window_functions_types_cast_test_select_048
SELECT
(SELECT total_credits FROM credits) as credits,
(SELECT total_debits FROM debits) as debits
)
-- Tag: window_functions_window_functions_types_cast_test_select_783
SELECT credits, debits, credits - debits as net
FROM summary;
-- Tag: window_functions_window_functions_types_cast_test_select_784
SELECT customer,
SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total,
SUM(CASE WHEN status = 'cancelled' THEN amount ELSE 0 END) as cancelled_total,
COUNT(*) as order_count
FROM orders
GROUP BY customer
HAVING SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) > 100
ORDER BY completed_total DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_785
SELECT student,
AVG(score) as avg_score,
CASE
WHEN AVG(score) >= 85 THEN 'A'
WHEN AVG(score) >= 75 THEN 'B'
WHEN AVG(score) >= 65 THEN 'C'
ELSE 'F'
END as grade
FROM scores
GROUP BY student
ORDER BY avg_score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_786
SELECT id,
a + b as sum,
a * b as product,
CAST(c AS INT64) as c_int,
COALESCE(a, 0) + COALESCE(b, 0) as coalesced_sum
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_787
SELECT category, COUNT(*) as count, SUM(value) as total
FROM data
GROUP BY category
ORDER BY category NULLS FIRST;
-- Tag: window_functions_window_functions_types_cast_test_select_788
SELECT (int_val + float_val) * CAST(str_val AS FLOAT64) as complex_result
FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_789
SELECT id,
CASE WHEN flag THEN int_val ELSE float_val END as mixed_result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_790
SELECT category, avg_value
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_791
SELECT category, AVG(value) as avg_value
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_792
SELECT category, value
FROM data
WHERE value > 100
) as filtered
GROUP BY category
) as averaged
WHERE avg_value > 150
ORDER BY avg_value DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_793
SELECT user_id, total_amount
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_794
SELECT user_id, SUM(CAST(amount_str AS INT64)) as total_amount
FROM transactions
GROUP BY user_id
) as user_totals
WHERE total_amount > 300
ORDER BY total_amount DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_795
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_796
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_797
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_types_cast_test_select_798
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_799
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES
('A', '10'), ('A', '20'), ('A', '30'),
('B', '5'), ('B', '15'),
('C', '100');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64, salary INT64);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO employees VALUES
(1, 'Alice', 1, 80000),
(2, 'Bob', 1, 90000),
(3, 'Charlie', 2, 70000),
(4, 'David', 2, 85000);
INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES
(1, 1, 100.0), (2, 1, 200.0),
(3, 2, 150.0),
(4, 3, 300.0), (5, 3, 400.0), (6, 3, 250.0);
INSERT INTO customers VALUES
(1, 'Alice', 'North'),
(2, 'Bob', 'South'),
(3, 'Charlie', 'North');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, region STRING, amount FLOAT64);
INSERT INTO sales VALUES
('Widget', 'North', 100.0),
('Widget', 'South', 150.0),
('Widget', 'East', 120.0),
('Gadget', 'North', 200.0),
('Gadget', 'South', 180.0);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (id INT64, amount FLOAT64, type STRING);
INSERT INTO transactions VALUES
(1, 100.0, 'credit'), (2, 50.0, 'debit'),
(3, 200.0, 'credit'), (4, 75.0, 'debit'),
(5, 150.0, 'credit');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, status STRING, amount FLOAT64);
INSERT INTO orders VALUES
('Alice', 'completed', 100.0),
('Alice', 'cancelled', 50.0),
('Alice', 'completed', 200.0),
('Bob', 'completed', 150.0),
('Bob', 'cancelled', 200.0),
('Charlie', 'completed', 300.0);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, subject STRING, score INT64);
INSERT INTO scores VALUES
('Alice', 'Math', 90), ('Alice', 'English', 85),
('Bob', 'Math', 75), ('Bob', 'English', 95),
('Charlie', 'Math', 60), ('Charlie', 'English', 70);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b INT64, c STRING);
INSERT INTO data VALUES
(1, 10, 20, '5'),
(2, NULL, 30, '10'),
(3, 40, NULL, '15'),
(4, 50, 60, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10), ('A', 20),
(NULL, 30), (NULL, 40),
('B', 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, int_val INT64, float_val FLOAT64, str_val STRING);
INSERT INTO data VALUES (1, 10, 2.5, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL, int_val INT64, float_val FLOAT64);
INSERT INTO data VALUES (1, true, 10, 3.5), (2, false, 20, 4.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES
(1, 'A', 100), (2, 'A', 200), (3, 'B', 150),
(4, 'B', 250), (5, 'C', 300);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (user_id INT64, amount_str STRING);
INSERT INTO transactions VALUES
(1, '100'), (1, '200'), (2, '150'), (2, '250'), (2, '100');
DROP TABLE IF EXISTS source;
CREATE TABLE source (name STRING, age_str STRING, score_str STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (name STRING, age INT64, score FLOAT64, grade STRING);
INSERT INTO source VALUES
('Alice', '25', '85.5'),
('Bob', '30', '92.0'),
('Charlie', '22', '78.5');
INSERT INTO target (name, age, score, grade)
-- Tag: window_functions_window_functions_types_cast_test_select_800
SELECT name,
CAST(age_str AS INT64),
CAST(score_str AS FLOAT64),
CASE
WHEN CAST(score_str AS FLOAT64) >= 90 THEN 'A'
WHEN CAST(score_str AS FLOAT64) >= 80 THEN 'B'
ELSE 'C'
END
FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, year_str STRING, amount FLOAT64);
INSERT INTO sales VALUES
(1, '2023', 100.0), (2, '2023', 200.0),
(3, '2024', 150.0), (4, '2024', 250.0), (5, '2024', 300.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Alice', 'Eng', 80000),
(2, 'Bob', 'Sales', 70000),
(3, 'Charlie', 'Eng', 90000),
(4, 'David', 'Sales', 75000);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_types_cast_test_select_801
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category
HAVING SUM(CAST(value AS INT64)) > 20
ORDER BY total DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_802
SELECT e.name, d.name as dept, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
ORDER BY e.salary DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_803
SELECT c.name,
(SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) as order_count,
(SELECT SUM(amount) FROM orders o WHERE o.customer_id = c.id) as total_spent
FROM customers c
WHERE c.region = 'North'
ORDER BY c.name;
WITH ranked_sales AS (
-- Tag: window_functions_window_functions_types_cast_test_select_804
SELECT product, region, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount DESC) as rank
FROM sales
)
-- Tag: window_functions_window_functions_types_cast_test_select_805
SELECT product, region, amount
FROM ranked_sales
WHERE rank <= 2
ORDER BY product, rank;
WITH credits AS (
-- Tag: window_functions_window_functions_types_cast_test_select_806
SELECT SUM(amount) as total_credits
FROM transactions
WHERE type = 'credit'
),
debits AS (
-- Tag: window_functions_window_functions_types_cast_test_select_807
SELECT SUM(amount) as total_debits
FROM transactions
WHERE type = 'debit'
),
summary AS (
-- Tag: window_functions_window_functions_types_cast_test_select_049
SELECT
(SELECT total_credits FROM credits) as credits,
(SELECT total_debits FROM debits) as debits
)
-- Tag: window_functions_window_functions_types_cast_test_select_808
SELECT credits, debits, credits - debits as net
FROM summary;
-- Tag: window_functions_window_functions_types_cast_test_select_809
SELECT customer,
SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total,
SUM(CASE WHEN status = 'cancelled' THEN amount ELSE 0 END) as cancelled_total,
COUNT(*) as order_count
FROM orders
GROUP BY customer
HAVING SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) > 100
ORDER BY completed_total DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_810
SELECT student,
AVG(score) as avg_score,
CASE
WHEN AVG(score) >= 85 THEN 'A'
WHEN AVG(score) >= 75 THEN 'B'
WHEN AVG(score) >= 65 THEN 'C'
ELSE 'F'
END as grade
FROM scores
GROUP BY student
ORDER BY avg_score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_811
SELECT id,
a + b as sum,
a * b as product,
CAST(c AS INT64) as c_int,
COALESCE(a, 0) + COALESCE(b, 0) as coalesced_sum
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_812
SELECT category, COUNT(*) as count, SUM(value) as total
FROM data
GROUP BY category
ORDER BY category NULLS FIRST;
-- Tag: window_functions_window_functions_types_cast_test_select_813
SELECT (int_val + float_val) * CAST(str_val AS FLOAT64) as complex_result
FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_814
SELECT id,
CASE WHEN flag THEN int_val ELSE float_val END as mixed_result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_815
SELECT category, avg_value
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_816
SELECT category, AVG(value) as avg_value
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_817
SELECT category, value
FROM data
WHERE value > 100
) as filtered
GROUP BY category
) as averaged
WHERE avg_value > 150
ORDER BY avg_value DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_818
SELECT user_id, total_amount
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_819
SELECT user_id, SUM(CAST(amount_str AS INT64)) as total_amount
FROM transactions
GROUP BY user_id
) as user_totals
WHERE total_amount > 300
ORDER BY total_amount DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_820
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_821
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_822
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_types_cast_test_select_823
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_824
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (user_id INT64, amount_str STRING);
INSERT INTO transactions VALUES
(1, '100'), (1, '200'), (2, '150'), (2, '250'), (2, '100');
DROP TABLE IF EXISTS source;
CREATE TABLE source (name STRING, age_str STRING, score_str STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (name STRING, age INT64, score FLOAT64, grade STRING);
INSERT INTO source VALUES
('Alice', '25', '85.5'),
('Bob', '30', '92.0'),
('Charlie', '22', '78.5');
INSERT INTO target (name, age, score, grade)
-- Tag: window_functions_window_functions_types_cast_test_select_825
SELECT name,
CAST(age_str AS INT64),
CAST(score_str AS FLOAT64),
CASE
WHEN CAST(score_str AS FLOAT64) >= 90 THEN 'A'
WHEN CAST(score_str AS FLOAT64) >= 80 THEN 'B'
ELSE 'C'
END
FROM source;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, year_str STRING, amount FLOAT64);
INSERT INTO sales VALUES
(1, '2023', 100.0), (2, '2023', 200.0),
(3, '2024', 150.0), (4, '2024', 250.0), (5, '2024', 300.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Alice', 'Eng', 80000),
(2, 'Bob', 'Sales', 70000),
(3, 'Charlie', 'Eng', 90000),
(4, 'David', 'Sales', 75000);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_types_cast_test_select_826
SELECT user_id, total_amount
FROM (
-- Tag: window_functions_window_functions_types_cast_test_select_827
SELECT user_id, SUM(CAST(amount_str AS INT64)) as total_amount
FROM transactions
GROUP BY user_id
) as user_totals
WHERE total_amount > 300
ORDER BY total_amount DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_828
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_types_cast_test_select_829
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_830
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_types_cast_test_select_831
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_832
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, year_str STRING, amount FLOAT64);
INSERT INTO sales VALUES
(1, '2023', 100.0), (2, '2023', 200.0),
(3, '2024', 150.0), (4, '2024', 250.0), (5, '2024', 300.0);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept STRING, salary INT64);
INSERT INTO employees VALUES
(1, 'Alice', 'Eng', 80000),
(2, 'Bob', 'Sales', 70000),
(3, 'Charlie', 'Eng', 90000),
(4, 'David', 'Sales', 75000);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_types_cast_test_select_833
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_types_cast_test_select_834
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_types_cast_test_select_835
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_836
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value STRING);
INSERT INTO data VALUES ('A', 'abc'), ('B', '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false);

-- Tag: window_functions_window_functions_types_cast_test_select_837
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_838
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

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

-- Tag: window_functions_window_functions_types_cast_test_select_839
SELECT id FROM nums WHERE NOT flag;
-- Tag: window_functions_window_functions_types_cast_test_select_840
SELECT id FROM strings WHERE NOT value;
-- Tag: window_functions_window_functions_types_cast_test_select_841
SELECT category, SUM(amount) as total FROM sales GROUP BY category HAVING NOT (SUM(amount) < 100);
-- Tag: window_functions_window_functions_types_cast_test_select_842
SELECT group_id, NOT MAX(active) as all_inactive FROM flags GROUP BY group_id ORDER BY group_id;
-- Tag: window_functions_window_functions_types_cast_test_select_843
SELECT category FROM items GROUP BY category HAVING NOT (COUNT(*) = 1);
-- Tag: window_functions_window_functions_types_cast_test_select_844
SELECT id, NOT (value = MAX(value) OVER ()) as not_max FROM scores ORDER BY id;
WITH cte AS (SELECT id, active FROM data) SELECT id FROM cte WHERE NOT active ORDER BY id;
WITH filtered AS (SELECT id FROM data WHERE NOT (value < 15)) SELECT * FROM filtered ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_845
SELECT id FROM (SELECT id, flag FROM t1 UNION SELECT id, flag FROM t2) AS combined WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_846
SELECT id, (NOT EXISTS (SELECT 1 FROM orders WHERE customer_id = customers.id)) as has_no_orders FROM customers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_847
SELECT NOT (SELECT value FROM flags WHERE id = 1) as inverted;
-- Tag: window_functions_window_functions_types_cast_test_select_848
SELECT COUNT(*) FROM large WHERE NOT active;
-- Tag: window_functions_window_functions_types_cast_test_select_849
SELECT id FROM data WHERE NOT ((a AND b) OR c);
-- Tag: window_functions_window_functions_types_cast_test_select_850
SELECT id FROM nulls WHERE NOT flag;
-- Tag: window_functions_window_functions_types_cast_test_select_851
SELECT id FROM nums WHERE NOT a < b;
-- Tag: window_functions_window_functions_types_cast_test_select_852
SELECT id FROM complex WHERE NOT a AND b OR c ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_853
SELECT NOT;
-- Tag: window_functions_window_functions_types_cast_test_select_854
SELECT NOT 42;
-- Tag: window_functions_window_functions_types_cast_test_select_855
SELECT NOT 'hello';
-- Tag: window_functions_window_functions_types_cast_test_select_856
SELECT id FROM data WHERE NOT CAST(value AS BOOL) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_857
SELECT id FROM data WHERE NOT (CASE WHEN value > 15 THEN TRUE ELSE FALSE END) ORDER BY id;

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

-- Tag: window_functions_window_functions_types_cast_test_select_858
SELECT id, (SELECT CAST(value AS INT64) FROM config) as int_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_859
SELECT id, price, price * (SELECT discount_pct FROM config) / 100.0 as discount
FROM items
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_860
SELECT id, CONCAT((SELECT prefix FROM config), name) as formatted_name
FROM users
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_861
SELECT id,
(SELECT UPPER(text) FROM messages) as upper_msg,
(SELECT LOWER(text) FROM messages) as lower_msg
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_862
SELECT id, price
FROM products
WHERE in_stock = true AND price > (SELECT min_price FROM thresholds)
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_863
SELECT id
FROM items
WHERE value < 15 OR value = (SELECT special_value FROM config)
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_864
SELECT id
FROM values
WHERE num BETWEEN (SELECT min FROM range) AND (SELECT max FROM range)
ORDER BY id;
WITH stats AS (
-- Tag: window_functions_window_functions_types_cast_test_select_865
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_types_cast_test_select_866
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_types_cast_test_select_867
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_types_cast_test_select_868
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_869
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_types_cast_test_select_870
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_871
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_types_cast_test_select_872
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_873
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_874
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_875
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_876
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_877
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_878
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_879
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price NUMERIC(10, 2), tax_rate NUMERIC(5, 4) );
INSERT INTO products VALUES (1, 100.00, 0.0825);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( amount NUMERIC(10, 2), discount NUMERIC(5, 4), tax NUMERIC(5, 4) );
INSERT INTO sales VALUES (100.00, 0.1000, 0.0825);
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price NUMERIC(10, 2) );
INSERT INTO items VALUES (1, 19.99);
INSERT INTO items VALUES (2, 20.00);
INSERT INTO items VALUES (3, 20.01);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price NUMERIC(10, 2) );
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 10.00);
INSERT INTO products VALUES (3, 15.50);
INSERT INTO products VALUES (4, 20.00);
INSERT INTO products VALUES (5, 20.01);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT64, balance NUMERIC(15, 2) );
INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, NULL);
INSERT INTO accounts VALUES (3, 0.00);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_880
SELECT price, tax_rate, price * tax_rate AS tax FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_881
SELECT (amount - amount * discount) * (1 + tax) AS final FROM sales;
-- Tag: window_functions_window_functions_types_cast_test_select_882
SELECT id FROM items WHERE price = 20.00;
-- Tag: window_functions_window_functions_types_cast_test_select_883
SELECT id FROM products WHERE price BETWEEN 10.00 AND 20.00 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_884
SELECT id FROM accounts WHERE balance > 0;
-- Tag: window_functions_window_functions_types_cast_test_select_885
SELECT id FROM accounts WHERE balance IS NULL;
-- Tag: window_functions_window_functions_types_cast_test_select_886
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_types_cast_test_select_887
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_888
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_889
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_890
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_891
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_892
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_893
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_894
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_895
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_896
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_897
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_898
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_899
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_900
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_901
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_902
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_903
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_904
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_905
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_906
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_907
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_908
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_909
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_910
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_911
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_912
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_913
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_914
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( amount NUMERIC(10, 2), discount NUMERIC(5, 4), tax NUMERIC(5, 4) );
INSERT INTO sales VALUES (100.00, 0.1000, 0.0825);
DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price NUMERIC(10, 2) );
INSERT INTO items VALUES (1, 19.99);
INSERT INTO items VALUES (2, 20.00);
INSERT INTO items VALUES (3, 20.01);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price NUMERIC(10, 2) );
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 10.00);
INSERT INTO products VALUES (3, 15.50);
INSERT INTO products VALUES (4, 20.00);
INSERT INTO products VALUES (5, 20.01);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT64, balance NUMERIC(15, 2) );
INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, NULL);
INSERT INTO accounts VALUES (3, 0.00);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_915
SELECT (amount - amount * discount) * (1 + tax) AS final FROM sales;
-- Tag: window_functions_window_functions_types_cast_test_select_916
SELECT id FROM items WHERE price = 20.00;
-- Tag: window_functions_window_functions_types_cast_test_select_917
SELECT id FROM products WHERE price BETWEEN 10.00 AND 20.00 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_918
SELECT id FROM accounts WHERE balance > 0;
-- Tag: window_functions_window_functions_types_cast_test_select_919
SELECT id FROM accounts WHERE balance IS NULL;
-- Tag: window_functions_window_functions_types_cast_test_select_920
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_types_cast_test_select_921
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_922
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_923
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_924
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_925
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_926
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_927
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_928
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_929
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_930
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_931
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_932
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_933
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_934
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_935
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_936
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_937
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_938
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_939
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_940
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_941
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_942
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_943
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_944
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_945
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_946
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_947
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_948
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS items;
CREATE TABLE items ( id INT64, price NUMERIC(10, 2) );
INSERT INTO items VALUES (1, 19.99);
INSERT INTO items VALUES (2, 20.00);
INSERT INTO items VALUES (3, 20.01);
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT64, price NUMERIC(10, 2) );
INSERT INTO products VALUES (1, 9.99);
INSERT INTO products VALUES (2, 10.00);
INSERT INTO products VALUES (3, 15.50);
INSERT INTO products VALUES (4, 20.00);
INSERT INTO products VALUES (5, 20.01);
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT64, balance NUMERIC(15, 2) );
INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, NULL);
INSERT INTO accounts VALUES (3, 0.00);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_949
SELECT id FROM items WHERE price = 20.00;
-- Tag: window_functions_window_functions_types_cast_test_select_950
SELECT id FROM products WHERE price BETWEEN 10.00 AND 20.00 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_951
SELECT id FROM accounts WHERE balance > 0;
-- Tag: window_functions_window_functions_types_cast_test_select_952
SELECT id FROM accounts WHERE balance IS NULL;
-- Tag: window_functions_window_functions_types_cast_test_select_953
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_types_cast_test_select_954
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_955
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_956
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_957
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_958
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_959
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_960
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_961
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_962
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_963
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_964
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_965
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_966
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_967
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_968
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_969
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_970
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_971
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_972
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_973
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_974
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_975
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_976
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_977
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_978
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_979
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_980
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_981
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT64, balance NUMERIC(15, 2) );
INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, NULL);
INSERT INTO accounts VALUES (3, 0.00);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_982
SELECT id FROM accounts WHERE balance > 0;
-- Tag: window_functions_window_functions_types_cast_test_select_983
SELECT id FROM accounts WHERE balance IS NULL;
-- Tag: window_functions_window_functions_types_cast_test_select_984
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_types_cast_test_select_985
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_986
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_987
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_988
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_989
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_990
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_991
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_992
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_993
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_994
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_995
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_996
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_997
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_998
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_999
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1000
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1001
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1002
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1003
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1004
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1005
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1006
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1007
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1008
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1009
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1010
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1011
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1012
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( id INT64, total NUMERIC(10, 2) );
DROP TABLE IF EXISTS payments;
CREATE TABLE payments ( order_id INT64, amount NUMERIC(10, 2) );
INSERT INTO orders VALUES (1, 100.50);
INSERT INTO orders VALUES (2, 200.75);
INSERT INTO payments VALUES (1, 100.50);
INSERT INTO payments VALUES (3, 300.00);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_1013
SELECT o.id FROM orders o
INNER JOIN payments p ON o.total = p.amount;
-- Tag: window_functions_window_functions_types_cast_test_select_1014
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_1015
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_1016
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_1017
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_1018
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1019
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1020
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1021
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1022
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1023
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_1024
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_1025
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_1026
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1027
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_1028
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1029
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1030
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1031
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1032
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1033
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1034
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1035
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1036
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1037
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1038
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1039
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1040
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1041
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT64, name STRING );
DROP TABLE IF EXISTS orders;
CREATE TABLE orders ( customer_id INT64, amount NUMERIC(10, 2) );
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 50.25);
INSERT INTO orders VALUES (1, 75.50);
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

-- Tag: window_functions_window_functions_types_cast_test_select_1042
SELECT c.name, COALESCE(SUM(o.amount), 0) AS total
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
-- Tag: window_functions_window_functions_types_cast_test_select_1043
SELECT SUM(amount) FROM transactions;
-- Tag: window_functions_window_functions_types_cast_test_select_1044
SELECT AVG(val) FROM values;
-- Tag: window_functions_window_functions_types_cast_test_select_1045
SELECT MIN(price), MAX(price) FROM prices;
-- Tag: window_functions_window_functions_types_cast_test_select_1046
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1047
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1048
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1049
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1050
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1051
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_1052
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_1053
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_1054
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1055
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_1056
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1057
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1058
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1059
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1060
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1061
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1062
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1063
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1064
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1065
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1066
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1067
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1068
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1069
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_types_cast_test_select_1070
SELECT category, SUM(amount) AS total
FROM sales
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1071
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1072
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1073
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1074
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1075
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_1076
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_1077
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_1078
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1079
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_1080
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1081
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1082
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1083
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1084
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1085
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1086
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1087
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1088
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1089
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1090
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1091
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1092
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1093
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_types_cast_test_select_1094
SELECT val FROM amounts ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1095
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1096
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1097
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1098
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_1099
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_1100
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_1101
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1102
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_1103
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1104
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1105
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1106
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1107
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1108
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1109
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1110
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1111
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1112
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1113
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1114
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1115
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1116
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_types_cast_test_select_1117
SELECT val FROM data ORDER BY val ASC;
-- Tag: window_functions_window_functions_types_cast_test_select_1118
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1119
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_types_cast_test_select_1120
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_types_cast_test_select_1121
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_types_cast_test_select_1122
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_types_cast_test_select_1123
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1124
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_types_cast_test_select_1125
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1126
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1127
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1128
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1129
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1130
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_types_cast_test_select_1131
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1132
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1133
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1134
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1135
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1136
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1137
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1138
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_types_cast_test_select_1139
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_types_cast_test_select_1140
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1141
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1142
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1143
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_types_cast_test_select_1144
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_types_cast_test_select_1145
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1146
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1147
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_types_cast_test_select_1148
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1149
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1150
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 3.14159);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING, age INT64, score FLOAT64);
INSERT INTO test VALUES ('Bob', 30, 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1151
SELECT FORMAT('Hello, %s!', 'World') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1152
SELECT FORMAT('The answer is %d', value) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1153
SELECT FORMAT('Pi is approximately %.2f', value) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1154
SELECT FORMAT('%s has %d apples', 'Alice', 5) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1155
SELECT FORMAT('%s is %d years old with a score of %.1f', name, age, score) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1156
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1157
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1158
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1159
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1160
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1161
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1162
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1163
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1164
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1165
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 3.14159);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING, age INT64, score FLOAT64);
INSERT INTO test VALUES ('Bob', 30, 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1166
SELECT FORMAT('The answer is %d', value) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1167
SELECT FORMAT('Pi is approximately %.2f', value) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1168
SELECT FORMAT('%s has %d apples', 'Alice', 5) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1169
SELECT FORMAT('%s is %d years old with a score of %.1f', name, age, score) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1170
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1171
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1172
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1173
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1174
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1175
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1176
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1177
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1178
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1179
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 3.14159);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING, age INT64, score FLOAT64);
INSERT INTO test VALUES ('Bob', 30, 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1180
SELECT FORMAT('Pi is approximately %.2f', value) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1181
SELECT FORMAT('%s has %d apples', 'Alice', 5) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1182
SELECT FORMAT('%s is %d years old with a score of %.1f', name, age, score) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1183
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1184
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1185
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1186
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1187
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1188
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1189
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1190
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1191
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1192
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING, age INT64, score FLOAT64);
INSERT INTO test VALUES ('Bob', 30, 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1193
SELECT FORMAT('%s has %d apples', 'Alice', 5) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1194
SELECT FORMAT('%s is %d years old with a score of %.1f', name, age, score) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1195
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1196
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1197
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1198
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1199
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1200
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1201
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1202
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1203
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1204
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING, age INT64, score FLOAT64);
INSERT INTO test VALUES ('Bob', 30, 95.5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1205
SELECT FORMAT('%s is %d years old with a score of %.1f', name, age, score) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1206
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1207
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1208
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1209
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1210
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1211
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1212
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1213
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1214
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1215
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (fmt STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1216
SELECT FORMAT(fmt, 'value') as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1217
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1218
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1219
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1220
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1221
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1222
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1223
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1224
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1225
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1226
SELECT FORMAT('Hello, %s!', name) as formatted FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1227
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1228
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1229
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1230
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1231
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1232
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1233
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1234
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1235
SELECT FORMAT('Just a plain string') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1236
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1237
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1238
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1239
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1240
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1241
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1242
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1243
SELECT FORMAT('100%% complete') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1244
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1245
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1246
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1247
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1248
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1249
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1250
SELECT FORMAT('') as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1251
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1252
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1253
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1254
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1255
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1256
SELECT FORMAT();
-- Tag: window_functions_window_functions_types_cast_test_select_1257
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1258
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1259
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1260
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (num INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1261
SELECT FORMAT(num, 'value') FROM test;
-- Tag: window_functions_window_functions_types_cast_test_select_1262
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1263
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1264
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1265
SELECT FORMAT('%s has %d apples', 'Alice');
-- Tag: window_functions_window_functions_types_cast_test_select_1266
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1267
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1268
SELECT FORMAT('Value: %10.3f', 123.456789) as formatted;
-- Tag: window_functions_window_functions_types_cast_test_select_1269
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true);

-- Tag: window_functions_window_functions_types_cast_test_select_1270
SELECT FORMAT('Flag is %s', flag) as formatted FROM test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1271
SELECT a + CAST(b AS INT64) as sum FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1272
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1273
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1274
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1275
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1276
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1277
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1278
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1279
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1280
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1281
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1282
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1283
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1284
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1285
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1286
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1287
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1288
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1289
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1290
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1291
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1292
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1293
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1294
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1295
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1296
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1297
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1298
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1299
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1300
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1301
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1302
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1303
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1304
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1305
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1306
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1307
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1308
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1309
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_types_cast_test_select_1310
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1311
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1312
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1313
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1314
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1315
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1316
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1317
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1318
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1319
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1320
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1321
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1322
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1323
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1324
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1325
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1326
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1327
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1328
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1329
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1330
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

-- Tag: window_functions_window_functions_types_cast_test_select_1331
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1332
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1333
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, 100);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.7), (2, 99.2), (3, -15.9);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, '-100'), (3, '0');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '3.14'), (2, '-2.5'), (3, '100.0');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, -100), (3, 0);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1334
SELECT id, CAST(value AS FLOAT64) as float_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1335
SELECT id, CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1336
SELECT id, CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1337
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1338
SELECT id, CAST(value AS STRING) as str_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1339
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1340
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1341
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1342
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1343
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1344
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1345
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1346
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1347
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1348
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1349
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1350
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1351
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1352
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1353
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1354
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1355
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1356
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1357
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1358
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1359
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1360
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1361
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1362
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1363
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1364
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1365
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1366
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1367
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1368
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1369
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1370
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1371
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1372
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1373
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1374
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1375
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1376
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1377
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.7), (2, 99.2), (3, -15.9);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, '-100'), (3, '0');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '3.14'), (2, '-2.5'), (3, '100.0');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, -100), (3, 0);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1378
SELECT id, CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1379
SELECT id, CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1380
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1381
SELECT id, CAST(value AS STRING) as str_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1382
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1383
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1384
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1385
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1386
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1387
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1388
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1389
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1390
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1391
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1392
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1393
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1394
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1395
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1396
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1397
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1398
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1399
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1400
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1401
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1402
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1403
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1404
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1405
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1406
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1407
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1408
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1409
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1410
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1411
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1412
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1413
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1414
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1415
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1416
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1417
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1418
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1419
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1420
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, '-100'), (3, '0');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '3.14'), (2, '-2.5'), (3, '100.0');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, -100), (3, 0);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1421
SELECT id, CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1422
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1423
SELECT id, CAST(value AS STRING) as str_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1424
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1425
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1426
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1427
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1428
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1429
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1430
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1431
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1432
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1433
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1434
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1435
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1436
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1437
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1438
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1439
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1440
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1441
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1442
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1443
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1444
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1445
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1446
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1447
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1448
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1449
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1450
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1451
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1452
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1453
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1454
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1455
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1456
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1457
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1458
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1459
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1460
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1461
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1462
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '3.14'), (2, '-2.5'), (3, '100.0');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, -100), (3, 0);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1463
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1464
SELECT id, CAST(value AS STRING) as str_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1465
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1466
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1467
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1468
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1469
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1470
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1471
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1472
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1473
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1474
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1475
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1476
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1477
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1478
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1479
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1480
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1481
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1482
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1483
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1484
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1485
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1486
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1487
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1488
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1489
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1490
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1491
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1492
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1493
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1494
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1495
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1496
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1497
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1498
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1499
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1500
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1501
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1502
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1503
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42), (2, -100), (3, 0);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1504
SELECT id, CAST(value AS STRING) as str_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1505
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1506
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1507
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1508
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1509
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1510
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1511
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1512
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1513
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1514
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1515
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1516
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1517
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1518
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1519
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1520
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1521
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1522
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1523
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1524
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1525
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1526
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1527
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1528
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1529
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1530
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1531
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1532
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1533
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1534
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1535
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1536
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1537
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1538
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1539
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1540
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1541
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1542
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1543
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 3.14), (2, -2.5), (3, 0.0);
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1544
SELECT id, CAST(value AS STRING) as str_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1545
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1546
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1547
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1548
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1549
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1550
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1551
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1552
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1553
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1554
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1555
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1556
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1557
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1558
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1559
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1560
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1561
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1562
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1563
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1564
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1565
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1566
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1567
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1568
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1569
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1570
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1571
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1572
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1573
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1574
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1575
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1576
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1577
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1578
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1579
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1580
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1581
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1582
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, value BOOL);
INSERT INTO flags VALUES (1, true), (2, false);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 0), (2, 1), (3, -5), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_str STRING);
INSERT INTO dates VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_str STRING);
INSERT INTO timestamps VALUES (1, '2024-01-15 10:30:00'), (2, '2024-12-31 23:59:59');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15'), (2, DATE '2024-12-31');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS timestamps;
CREATE TABLE timestamps (id INT64, ts_val TIMESTAMP);
INSERT INTO timestamps VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a number');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a float');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'not a date');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 9223372036854775808.0);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42'), (2, 'invalid'), (3, '100');
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
INSERT INTO floats VALUES (1, 42.0), (2, 9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42), (2, NULL);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '42.5'), (2, '-100.75');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1,234.56'), (2, '$9,999.99');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15'), (2, '2024-12-31');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, date_str STRING);
INSERT INTO strings VALUES (1, '01/15/2024'), (2, '12/31/2024');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, ts_str STRING);
INSERT INTO strings VALUES (1, '2024-01-15 10:30:00');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value FLOAT64);
INSERT INTO numbers VALUES (1, 1234.56);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 5.5);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, int_val INT64, float_val FLOAT64);
INSERT INTO mixed VALUES (1, 10, 10.0), (2, 5, 5.5);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '  42  ');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '1.5e3'), (2, '2.5E-2');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, '0xFF'), (2, '0x10');
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (id INT64, value STRING);
INSERT INTO strings VALUES (1, 'Infinity'), (2, '-Infinity'), (3, 'NaN');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '100'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.2), (2, 1.8), (3, 2.1), (4, 2.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, str_val STRING);
INSERT INTO data VALUES (1, '10'), (2, '20');

-- Tag: window_functions_window_functions_types_cast_test_select_1583
SELECT id, CAST(value AS STRING) as str_val FROM flags ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1584
SELECT id, CAST(value AS BOOL) as bool_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1585
SELECT id, CAST(value AS BOOL) as bool_val FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1586
SELECT id, CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1587
SELECT id, CAST(date_str AS DATE) as date_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1588
SELECT id, CAST(ts_str AS TIMESTAMP) as ts_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1589
SELECT id, CAST(date_val AS STRING) as date_str FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1590
SELECT id, CAST(ts_val AS STRING) as ts_str FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1591
SELECT id, CAST(date_val AS TIMESTAMP) as ts_val FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1592
SELECT id, CAST(ts_val AS DATE) as date_val FROM timestamps ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1593
SELECT CAST(value AS INT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1594
SELECT CAST(value AS FLOAT64) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1595
SELECT CAST(value AS DATE) FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1596
SELECT CAST(value AS INT64) FROM floats;
-- Tag: window_functions_window_functions_types_cast_test_select_1597
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1598
SELECT id, TRY_CAST(value AS INT64) as int_val FROM floats ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1599
SELECT id, TRY_CAST(value AS STRING) as str_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1600
SELECT id, TO_NUMBER(value) as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1601
SELECT id, TO_NUMBER(value, '999,999.99') as num_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1602
SELECT id, PARSE_DATE('%Y-%m-%d', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1603
SELECT id, PARSE_DATE('%m/%d/%Y', date_str) as date_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1604
SELECT id, PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ts_str) as ts_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1605
SELECT id, FORMAT_DATE('%Y-%m-%d', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1606
SELECT id, FORMAT_DATE('%B %d, %Y', date_val) as formatted FROM dates ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1607
SELECT id, TO_CHAR(value, '999,999.99') as formatted FROM numbers ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1608
SELECT id, int_val + float_val as sum FROM mixed;
-- Tag: window_functions_window_functions_types_cast_test_select_1609
SELECT id FROM mixed WHERE int_val = float_val ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1610
SELECT id, POWER(value, 2.0) as squared FROM numbers;
-- Tag: window_functions_window_functions_types_cast_test_select_1611
SELECT TRY_CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1612
SELECT CAST(value AS INT64) as int_val FROM strings;
-- Tag: window_functions_window_functions_types_cast_test_select_1613
SELECT id, CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1614
SELECT id, TRY_CAST(value AS INT64) as int_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1615
SELECT id, TRY_CAST(value AS FLOAT64) as float_val FROM strings ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1616
SELECT id FROM data WHERE CAST(str_val AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_types_cast_test_select_1617
SELECT id, str_val FROM data ORDER BY CAST(str_val AS INT64);
-- Tag: window_functions_window_functions_types_cast_test_select_1618
SELECT CAST(value AS INT64) as int_val, COUNT(*) as cnt FROM data GROUP BY CAST(value AS INT64) ORDER BY int_val;
-- Tag: window_functions_window_functions_types_cast_test_select_1619
SELECT CAST(CAST(CAST(value AS STRING) AS FLOAT64) AS INT64) as final_val FROM data;
-- Tag: window_functions_window_functions_types_cast_test_select_1620
SELECT id, CAST(str_val AS INT64) * 2 as doubled FROM data ORDER BY id;

