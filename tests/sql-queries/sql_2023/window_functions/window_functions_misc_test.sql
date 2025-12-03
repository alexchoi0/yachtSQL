-- Window Functions Misc - SQL:2023
-- Description: Miscellaneous window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_misc_test_select_001
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_misc_test_select_002
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_003
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_misc_test_select_004
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_misc_test_select_005
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_misc_test_select_006
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_misc_test_select_007
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_misc_test_select_008
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_misc_test_select_009
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_misc_test_select_010
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_misc_test_select_011
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_misc_test_select_012
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_misc_test_select_013
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_misc_test_select_014
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_misc_test_select_015
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_misc_test_select_016
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_misc_test_select_017
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_018
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_misc_test_select_019
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_020
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_misc_test_select_021
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_misc_test_select_022
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_misc_test_select_023
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_misc_test_select_024
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_misc_test_select_025
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_misc_test_select_026
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_misc_test_select_027
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_misc_test_select_028
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_misc_test_select_029
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_misc_test_select_030
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_misc_test_select_031
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_misc_test_select_032
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_misc_test_select_033
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_misc_test_select_034
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_035
SELECT category FROM sales WHERE SUM(amount) > 50;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50), (60), (70), (80), (90), (100);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_misc_test_select_036
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_037
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_038
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_039
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_001
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_040
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_041
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_042
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_043
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_044
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_045
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_046
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_047
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_048
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_049
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_050
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_051
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_052
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_053
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_054
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_055
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_056
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_057
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_058
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_059
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_060
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_061
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_062
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_063
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_064
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_002
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_003
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_004
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_065
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_066
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_067
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_068
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_005
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_069
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_070
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_071
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_072
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_073
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50), (60), (70), (80), (90), (100);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_misc_test_select_074
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_075
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_076
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_006
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_077
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_078
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_079
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_080
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_081
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_082
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_083
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_084
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_085
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_086
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_087
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_088
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_089
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_090
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_091
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_092
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_093
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_094
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_095
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_096
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_097
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_098
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_099
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_100
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_101
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_007
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_008
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_009
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_102
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_103
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_104
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_105
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_010
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_106
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_107
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_108
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_109
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_110
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_111
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_112
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_113
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_114
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_115
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_116
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_117
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_118
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_119
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_120
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_121
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_122
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_123
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_124
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_125
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_126
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_127
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_128
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_129
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_130
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_011
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_012
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_013
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_131
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_132
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_133
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_134
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_014
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_135
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_136
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_137
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_138
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_139
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_140
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_141
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_142
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_143
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_144
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_145
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_146
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_147
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_148
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_149
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_150
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_151
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_152
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_153
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_154
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_155
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_156
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_157
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_158
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_015
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_016
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_017
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_159
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_160
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_161
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_162
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_018
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_163
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_164
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_165
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_166
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_167
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_168
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_169
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_170
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_171
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_172
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_173
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_174
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_175
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_176
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_177
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_178
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_179
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_180
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_019
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_020
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_021
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_181
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_182
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_183
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_184
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_022
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_185
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_186
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_187
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_188
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_189
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_190
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_misc_test_select_191
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_192
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_misc_test_select_193
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_194
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_195
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_196
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_197
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_198
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_199
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_200
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_201
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_023
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_024
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_025
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_202
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_203
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_204
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_205
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_026
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_206
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_207
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_208
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_209
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_210
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_211
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_212
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_213
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_214
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_215
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_216
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_027
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_028
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_029
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_217
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_218
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_219
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_220
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_030
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_221
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_222
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_223
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_224
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_225
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_misc_test_select_226
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_misc_test_select_227
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_misc_test_select_228
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_misc_test_select_229
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_230
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_misc_test_select_031
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_032
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_misc_test_select_033
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_misc_test_select_231
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_232
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_233
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_234
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_034
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_235
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_236
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_237
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_238
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_misc_test_select_239
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (true), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_misc_test_select_240
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_241
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_242
SELECT EVERY(value > 0) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_243
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_244
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_misc_test_select_245
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_246
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_247
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_248
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_misc_test_select_249
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_250
SELECT EVERY(value > 0) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_251
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_252
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_misc_test_select_253
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_254
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_255
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_256
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (true), (false), (true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);
INSERT INTO test VALUES (NULL), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1), (0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('true');
DROP TABLE IF EXISTS test;
CREATE TABLE test (flag BOOLEAN);

-- Tag: window_functions_window_functions_misc_test_select_257
SELECT EVERY(value > 0) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_258
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_259
SELECT BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true FROM test;
-- Tag: window_functions_window_functions_misc_test_select_260
SELECT BOOL_AND(flag) as and_result, BOOL_OR(flag) as or_result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_261
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_262
SELECT BOOL_OR(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_263
SELECT EVERY() FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, 10), (3, 8);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 7), (2, 7), (3, 7);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 15), (2, 0), (3, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, NULL), (3, 8);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, -1), (2, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 4), (2, 2), (3, 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 0), (2, 0), (3, 0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 4), (2, NULL), (3, 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, 10), (3, 6);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 5), (2, 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 7), (2, 7), (3, 7);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, NULL), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 12), (2, 10), (3, 14);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, flag BOOL);
INSERT INTO test VALUES
('A', TRUE), ('A', TRUE), ('A', TRUE),
('B', TRUE), ('B', FALSE), ('B', TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (category STRING, value INT64);
INSERT INTO test VALUES
('A', 12), ('A', 10), ('A', 14),
('B', 7), ('B', 3), ('B', 5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 1), (2, 2), (3, 4), (4, 8);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);
INSERT INTO test VALUES (1, 'hello');

-- Tag: window_functions_window_functions_misc_test_select_264
SELECT EVERY(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_265
SELECT BOOL_AND(flag) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_266
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_267
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_268
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_269
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_270
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_271
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_272
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_273
SELECT BIT_OR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_274
SELECT BIT_OR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_275
SELECT BIT_OR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_276
SELECT BIT_OR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_277
SELECT BIT_OR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_278
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_279
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_280
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_281
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_282
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_283
SELECT BIT_XOR(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_284
SELECT BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or,
BIT_XOR(value) as bit_xor
FROM test;
-- Tag: window_functions_window_functions_misc_test_select_285
SELECT category
FROM test
GROUP BY category
HAVING BOOL_AND(flag) = TRUE;
-- Tag: window_functions_window_functions_misc_test_select_286
SELECT category,
BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_287
SELECT BOOL_AND(flag) as bool_and,
BOOL_OR(NOT flag) as or_not
FROM test;
-- Tag: window_functions_window_functions_misc_test_select_288
SELECT BIT_AND(value) as bit_and,
BIT_OR(value) as bit_or
FROM test;
-- Tag: window_functions_window_functions_misc_test_select_289
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_290
SELECT BIT_AND(value) FROM test;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (5), (1), (3), (4), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_misc_test_select_291
SELECT value
FROM numbers
ORDER BY 1
LIMIT 3 OFFSET 1;
-- Tag: window_functions_window_functions_misc_test_select_292
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_misc_test_select_293
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES
('A', 10),
('B', 20),
('A', 10),
('C', 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, year INT64, amount FLOAT64);
INSERT INTO sales VALUES
('A', 2021, 100.0),
('A', 2022, 150.0),
('A', 2023, 200.0);

-- Tag: window_functions_window_functions_misc_test_select_294
SELECT DISTINCT category, value
FROM data
ORDER BY 2 DESC;
-- Tag: window_functions_window_functions_misc_test_select_295
SELECT product, year, amount,
ROW_NUMBER() OVER (PARTITION BY product ORDER BY 2) as row_num
FROM sales;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, department STRING, salary INT64);
INSERT INTO employees VALUES (1, 'Sales', 50000), (2, 'Sales', 60000), (3, 'Engineering', 80000);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'A', 10.0), (2, 'A', 20.0), (3, 'B', 15.0);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (product STRING, date DATE, price FLOAT64);
INSERT INTO prices VALUES ('A', DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES ('A', DATE '2024-01-15', 15.0);
INSERT INTO prices VALUES ('B', DATE '2024-01-01', 20.0);
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

-- Tag: window_functions_window_functions_misc_test_select_296
SELECT * FROM products WHERE price > ANY (SELECT price FROM products WHERE category = 'A');
-- Tag: window_functions_window_functions_misc_test_select_297
SELECT * FROM data WHERE CAST(number AS STRING) LIKE '1%';
-- Tag: window_functions_window_functions_misc_test_select_298
SELECT product, SUM(CAST(amount AS FLOAT64)) as total FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_misc_test_select_299
SELECT * FROM data WHERE CAST(value AS INT64) BETWEEN 15 AND 35;
-- Tag: window_functions_window_functions_misc_test_select_300
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_misc_test_select_301
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_302
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_misc_test_select_303
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_misc_test_select_304
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_misc_test_select_305
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_misc_test_select_306
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_307
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_misc_test_select_308
SELECT DISTINCT product FROM prices p1
WHERE (SELECT price FROM prices p2 WHERE p2.product = p1.product ORDER BY date DESC LIMIT 1) BETWEEN 12.0 AND 18.0;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, price FLOAT64);
INSERT INTO products VALUES (1, 'A', 10.0), (2, 'A', 20.0), (3, 'B', 15.0);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (product STRING, date DATE, price FLOAT64);
INSERT INTO prices VALUES ('A', DATE '2024-01-01', 10.0);
INSERT INTO prices VALUES ('A', DATE '2024-01-15', 15.0);
INSERT INTO prices VALUES ('B', DATE '2024-01-01', 20.0);
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

-- Tag: window_functions_window_functions_misc_test_select_309
SELECT * FROM products WHERE price > ANY (SELECT price FROM products WHERE category = 'A');
-- Tag: window_functions_window_functions_misc_test_select_310
SELECT * FROM data WHERE CAST(number AS STRING) LIKE '1%';
-- Tag: window_functions_window_functions_misc_test_select_311
SELECT product, SUM(CAST(amount AS FLOAT64)) as total FROM sales GROUP BY product ORDER BY product;
-- Tag: window_functions_window_functions_misc_test_select_312
SELECT * FROM data WHERE CAST(value AS INT64) BETWEEN 15 AND 35;
-- Tag: window_functions_window_functions_misc_test_select_313
SELECT COUNT(*) FROM monthly_summary;
-- Tag: window_functions_window_functions_misc_test_select_314
SELECT * FROM computed ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_315
SELECT COUNT(*) FROM dest;
-- Tag: window_functions_window_functions_misc_test_select_316
SELECT * FROM users WHERE status = 'active';
-- Tag: window_functions_window_functions_misc_test_select_317
SELECT * FROM events WHERE JSON_EXTRACT(data, '$.type') = 'click';
-- Tag: window_functions_window_functions_misc_test_select_318
SELECT JSON_ARRAYAGG(name) as products FROM products;
-- Tag: window_functions_window_functions_misc_test_select_319
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_320
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_misc_test_select_321
SELECT DISTINCT product FROM prices p1
WHERE (SELECT price FROM prices p2 WHERE p2.product = p1.product ORDER BY date DESC LIMIT 1) BETWEEN 12.0 AND 18.0;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Widget', 150);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department STRING, salary INT64);
INSERT INTO employees VALUES (1, 'Alice', 'Engineering', 80000);
INSERT INTO employees VALUES (2, 'Bob', 'Sales', 60000);
INSERT INTO employees VALUES (3, 'Charlie', 'Engineering', 90000);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS customers_us;
CREATE TABLE customers_us (name STRING);
DROP TABLE IF EXISTS customers_eu;
CREATE TABLE customers_eu (name STRING);
INSERT INTO customers_us VALUES ('Alice');
INSERT INTO customers_us VALUES ('Bob');
INSERT INTO customers_eu VALUES ('Charlie');
INSERT INTO customers_eu VALUES ('Alice');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

WITH product_totals AS (
-- Tag: window_functions_window_functions_misc_test_select_322
SELECT product, SUM(amount) as total
FROM sales
GROUP BY product
)
-- Tag: window_functions_window_functions_misc_test_select_323
SELECT * FROM product_totals;
WITH
eng_emps AS (SELECT * FROM employees WHERE department = 'Engineering'),
high_earners AS (SELECT * FROM eng_emps WHERE salary > 75000)
-- Tag: window_functions_window_functions_misc_test_select_324
SELECT * FROM high_earners;
-- Tag: window_functions_window_functions_misc_test_select_325
SELECT DISTINCT customer FROM orders;
-- Tag: window_functions_window_functions_misc_test_select_326
SELECT DISTINCT customer, product FROM orders;
-- Tag: window_functions_window_functions_misc_test_select_327
SELECT name FROM customers_us UNION SELECT name FROM customers_eu;
-- Tag: window_functions_window_functions_misc_test_select_328
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_329
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_330
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_331
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_332
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_333
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_334
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_335
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_336
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_337
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_338
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_339
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_340
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_341
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer STRING, product STRING);
INSERT INTO orders VALUES ('Alice', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Gadget');
INSERT INTO orders VALUES ('Bob', 'Widget');
INSERT INTO orders VALUES ('Alice', 'Widget');
DROP TABLE IF EXISTS customers_us;
CREATE TABLE customers_us (name STRING);
DROP TABLE IF EXISTS customers_eu;
CREATE TABLE customers_eu (name STRING);
INSERT INTO customers_us VALUES ('Alice');
INSERT INTO customers_us VALUES ('Bob');
INSERT INTO customers_eu VALUES ('Charlie');
INSERT INTO customers_eu VALUES ('Alice');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_342
SELECT DISTINCT customer FROM orders;
-- Tag: window_functions_window_functions_misc_test_select_343
SELECT DISTINCT customer, product FROM orders;
-- Tag: window_functions_window_functions_misc_test_select_344
SELECT name FROM customers_us UNION SELECT name FROM customers_eu;
-- Tag: window_functions_window_functions_misc_test_select_345
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_346
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_347
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_348
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_349
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_350
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_351
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_352
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_353
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_354
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_355
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_356
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_357
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_358
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS customers_us;
CREATE TABLE customers_us (name STRING);
DROP TABLE IF EXISTS customers_eu;
CREATE TABLE customers_eu (name STRING);
INSERT INTO customers_us VALUES ('Alice');
INSERT INTO customers_us VALUES ('Bob');
INSERT INTO customers_eu VALUES ('Charlie');
INSERT INTO customers_eu VALUES ('Alice');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_359
SELECT name FROM customers_us UNION SELECT name FROM customers_eu;
-- Tag: window_functions_window_functions_misc_test_select_360
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_361
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_362
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_363
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_364
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_365
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_366
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_367
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_368
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_369
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_370
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_371
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_372
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_373
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (value INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (value INT64);
INSERT INTO table1 VALUES (1);
INSERT INTO table1 VALUES (2);
INSERT INTO table2 VALUES (2);
INSERT INTO table2 VALUES (3);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_374
SELECT value FROM table1 UNION ALL SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_375
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_376
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_377
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_378
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_379
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_380
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_381
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_382
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_383
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_384
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_385
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_386
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_387
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (3);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_388
SELECT value FROM set1 INTERSECT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_389
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_390
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_391
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_392
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_393
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_394
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_395
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_396
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_397
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_398
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_399
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_400
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO set1 VALUES (1);
INSERT INTO set1 VALUES (2);
INSERT INTO set1 VALUES (3);
INSERT INTO set2 VALUES (2);
INSERT INTO set2 VALUES (4);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 95);
INSERT INTO scores VALUES ('Bob', 75);
INSERT INTO scores VALUES ('Charlie', 55);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount INT64);
INSERT INTO sales VALUES ('Widget', 100);
INSERT INTO sales VALUES ('Gadget', 200);
INSERT INTO sales VALUES ('Gizmo', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_401
SELECT value FROM set1 EXCEPT SELECT value FROM set2;
-- Tag: window_functions_window_functions_misc_test_select_402
SELECT name,
CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
ELSE 'C'
END as grade
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_403
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_404
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_405
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_406
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_407
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_408
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_409
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_410
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_411
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_412
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('North', 'Widget', 100);
INSERT INTO sales VALUES ('North', 'Gadget', 200);
INSERT INTO sales VALUES ('South', 'Widget', 150);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, amount INT64);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, region STRING);
INSERT INTO orders VALUES (1, 1, 100);
INSERT INTO orders VALUES (2, 1, 200);
INSERT INTO orders VALUES (3, 2, 150);
INSERT INTO customers VALUES (1, 'Alice', 'North');
INSERT INTO customers VALUES (2, 'Bob', 'South');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, category STRING);
INSERT INTO products VALUES (1, 'Laptop', 'Electronics');
INSERT INTO products VALUES (2, 'Desk', 'Furniture');
INSERT INTO products VALUES (3, 'Phone', 'Electronics');
INSERT INTO products VALUES (4, 'Chair', 'Furniture');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, status STRING);
INSERT INTO users VALUES (1, 'Alice', 'active');
INSERT INTO users VALUES (2, 'Bob', 'inactive');
INSERT INTO users VALUES (3, 'Charlie', 'pending');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64);
INSERT INTO products VALUES (1, 10.0);
INSERT INTO products VALUES (2, 25.0);
INSERT INTO products VALUES (3, 50.0);
INSERT INTO products VALUES (4, 75.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (name STRING);
INSERT INTO users VALUES ('Alice');
INSERT INTO users VALUES ('Bob');
INSERT INTO users VALUES ('Alicia');
INSERT INTO users VALUES ('Albert');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO customers VALUES (3, 'Charlie');
INSERT INTO orders VALUES (1, 100);
INSERT INTO orders VALUES (1, 200);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: window_functions_window_functions_misc_test_select_413
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_414
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_misc_test_select_415
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_misc_test_select_416
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_misc_test_select_417
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_misc_test_select_418
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_misc_test_select_419
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_misc_test_select_420
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_misc_test_select_421
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
ALTER TABLE data ADD COLUMN new_col STRING DEFAULT 'test';
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (20), (NULL), (30);
DROP TABLE IF EXISTS indexed_data;
CREATE TABLE indexed_data (id INT64, value INT64);
CREATE INDEX idx_value ON indexed_data(value);
INSERT INTO indexed_data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
CREATE INDEX idx_value ON data(value);
DROP INDEX idx_value;
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
INSERT INTO evolving VALUES (1);
ALTER TABLE evolving ADD COLUMN value INT64 DEFAULT 100;
INSERT INTO evolving VALUES (2, 200);
ALTER TABLE evolving ADD COLUMN name STRING DEFAULT 'test';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (session_id INT64, status STRING);
INSERT INTO sessions VALUES (1, 'active');
INSERT INTO sessions VALUES (1, 'new');
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
INSERT INTO outer_table VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS recovery_test;
CREATE TABLE recovery_test (id INT64);
INSERT INTO recovery_test VALUES (1);

-- Tag: window_functions_window_functions_misc_test_select_422
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_423
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_424
SELECT * FROM (SELECT value * 2 as doubled FROM numbers) WHERE doubled > 10;
UPDATE data SET value = NULL WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_425
SELECT * FROM data WHERE value IS NULL;
-- Tag: window_functions_window_functions_misc_test_select_426
SELECT * FROM data WHERE value IS NOT NULL;
-- Tag: window_functions_window_functions_misc_test_select_427
SELECT COUNT(*), COUNT(value), SUM(value), AVG(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_428
SELECT * FROM indexed_data WHERE value = 100;
-- Tag: window_functions_window_functions_misc_test_select_429
SELECT * FROM data WHERE value = 100;
-- Tag: window_functions_window_functions_misc_test_select_430
SELECT * FROM large;
-- Tag: window_functions_window_functions_misc_test_select_431
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_432
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_misc_test_select_433
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_434
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_435
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_misc_test_select_436
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_misc_test_select_437
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_misc_test_select_438
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
INSERT INTO evolving VALUES (1);
ALTER TABLE evolving ADD COLUMN value INT64 DEFAULT 100;
INSERT INTO evolving VALUES (2, 200);
ALTER TABLE evolving ADD COLUMN name STRING DEFAULT 'test';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (session_id INT64, status STRING);
INSERT INTO sessions VALUES (1, 'active');
INSERT INTO sessions VALUES (1, 'new');
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
INSERT INTO outer_table VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS recovery_test;
CREATE TABLE recovery_test (id INT64);
INSERT INTO recovery_test VALUES (1);

-- Tag: window_functions_window_functions_misc_test_select_439
SELECT * FROM large;
-- Tag: window_functions_window_functions_misc_test_select_440
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_441
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_misc_test_select_442
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_443
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_444
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_misc_test_select_445
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_misc_test_select_446
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_misc_test_select_447
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS evolving;
CREATE TABLE evolving (id INT64);
INSERT INTO evolving VALUES (1);
ALTER TABLE evolving ADD COLUMN value INT64 DEFAULT 100;
INSERT INTO evolving VALUES (2, 200);
ALTER TABLE evolving ADD COLUMN name STRING DEFAULT 'test';
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (session_id INT64, status STRING);
INSERT INTO sessions VALUES (1, 'active');
INSERT INTO sessions VALUES (1, 'new');
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64);
INSERT INTO outer_table VALUES (1), (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO nonexistent VALUES (1);
DROP TABLE IF EXISTS recovery_test;
CREATE TABLE recovery_test (id INT64);
INSERT INTO recovery_test VALUES (1);

-- Tag: window_functions_window_functions_misc_test_select_448
SELECT COUNT(*) FROM data;
UPDATE evolving SET value = 150 WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_449
SELECT * FROM evolving ORDER BY id;
UPDATE data SET value = value * 2;
-- Tag: window_functions_window_functions_misc_test_select_450
SELECT SUM(value) FROM data;
DELETE FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_451
SELECT status FROM sessions WHERE session_id = 1;
-- Tag: window_functions_window_functions_misc_test_select_452
SELECT * FROM outer_table WHERE id IN (SELECT nonexistent FROM outer_table);
WITH bad AS (SELECT nonexistent FROM data) SELECT * FROM bad;
-- Tag: window_functions_window_functions_misc_test_select_453
SELECT * FROM t1 INNER JOIN t2 ON t1.nonexistent = t2.id;
-- Tag: window_functions_window_functions_misc_test_select_454
SELECT * FROM nonexistent_table;
UPDATE nonexistent SET x = 1;
-- Tag: window_functions_window_functions_misc_test_select_455
SELECT * FROM recovery_test;

DROP TABLE IF EXISTS strings;
CREATE TABLE strings (value STRING);
INSERT INTO strings VALUES ('');
INSERT INTO strings VALUES ('test');
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

-- Tag: window_functions_window_functions_misc_test_select_456
SELECT * FROM strings WHERE value = '';
-- Tag: window_functions_window_functions_misc_test_select_457
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_458
SELECT * FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_459
SELECT * FROM numbers WHERE id = 0;
-- Tag: window_functions_window_functions_misc_test_select_460
SELECT * FROM numbers WHERE value = 0;
-- Tag: window_functions_window_functions_misc_test_select_461
SELECT SUM(value) FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_462
SELECT * FROM numbers WHERE value < 0;
-- Tag: window_functions_window_functions_misc_test_select_463
SELECT * FROM texts;
-- Tag: window_functions_window_functions_misc_test_select_464
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_misc_test_select_465
SELECT * FROM special;
-- Tag: window_functions_window_functions_misc_test_select_466
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_misc_test_select_467
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_468
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_469
SELECT * FROM single;
-- Tag: window_functions_window_functions_misc_test_select_470
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_misc_test_select_471
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_misc_test_select_472
SELECT * FROM empty;
-- Tag: window_functions_window_functions_misc_test_select_473
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_474
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_misc_test_select_475
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_476
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_477
SELECT * FROM wide;
-- Tag: window_functions_window_functions_misc_test_select_478
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_misc_test_select_479
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_480
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_misc_test_select_481
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_misc_test_select_482
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_misc_test_select_483
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_misc_test_select_484
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_misc_test_select_485
SELECT * FROM whitespace;

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

-- Tag: window_functions_window_functions_misc_test_select_486
SELECT * FROM numbers WHERE value < 0;
-- Tag: window_functions_window_functions_misc_test_select_487
SELECT * FROM texts;
-- Tag: window_functions_window_functions_misc_test_select_488
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_misc_test_select_489
SELECT * FROM special;
-- Tag: window_functions_window_functions_misc_test_select_490
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_misc_test_select_491
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_492
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_493
SELECT * FROM single;
-- Tag: window_functions_window_functions_misc_test_select_494
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_misc_test_select_495
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_misc_test_select_496
SELECT * FROM empty;
-- Tag: window_functions_window_functions_misc_test_select_497
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_498
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_misc_test_select_499
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_500
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_501
SELECT * FROM wide;
-- Tag: window_functions_window_functions_misc_test_select_502
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_misc_test_select_503
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_504
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_misc_test_select_505
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_misc_test_select_506
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_misc_test_select_507
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_misc_test_select_508
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_misc_test_select_509
SELECT * FROM whitespace;

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

-- Tag: window_functions_window_functions_misc_test_select_510
SELECT * FROM texts;
-- Tag: window_functions_window_functions_misc_test_select_511
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_misc_test_select_512
SELECT * FROM special;
-- Tag: window_functions_window_functions_misc_test_select_513
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_misc_test_select_514
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_515
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_516
SELECT * FROM single;
-- Tag: window_functions_window_functions_misc_test_select_517
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_misc_test_select_518
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_misc_test_select_519
SELECT * FROM empty;
-- Tag: window_functions_window_functions_misc_test_select_520
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_521
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_misc_test_select_522
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_523
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_524
SELECT * FROM wide;
-- Tag: window_functions_window_functions_misc_test_select_525
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_misc_test_select_526
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_527
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_misc_test_select_528
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_misc_test_select_529
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_misc_test_select_530
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_misc_test_select_531
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_misc_test_select_532
SELECT * FROM whitespace;

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

-- Tag: window_functions_window_functions_misc_test_select_533
SELECT * FROM unicode;
-- Tag: window_functions_window_functions_misc_test_select_534
SELECT * FROM special;
-- Tag: window_functions_window_functions_misc_test_select_535
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_misc_test_select_536
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_537
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_misc_test_select_538
SELECT * FROM single;
-- Tag: window_functions_window_functions_misc_test_select_539
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_misc_test_select_540
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_misc_test_select_541
SELECT * FROM empty;
-- Tag: window_functions_window_functions_misc_test_select_542
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_misc_test_select_543
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_misc_test_select_544
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_545
SELECT * FROM floats;
-- Tag: window_functions_window_functions_misc_test_select_546
SELECT * FROM wide;
-- Tag: window_functions_window_functions_misc_test_select_547
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_misc_test_select_548
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_549
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_misc_test_select_550
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_misc_test_select_551
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_misc_test_select_552
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_misc_test_select_553
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_misc_test_select_554
SELECT * FROM whitespace;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS typed;
CREATE TABLE typed (id INT64, value INT64);
INSERT INTO typed VALUES (1, 'string');
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

-- Tag: window_functions_window_functions_misc_test_select_555
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_556
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_557
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_558
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_559
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_560
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_misc_test_select_561
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_misc_test_select_562
SELECT value + 10 FROM data;
-- Tag: window_functions_window_functions_misc_test_select_563
SELECT *;
-- Tag: window_functions_window_functions_misc_test_select_564
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_misc_test_select_565
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_566
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_567
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_misc_test_select_568
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_569
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_570
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_571
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_misc_test_select_572
SELECT *;
-- Tag: window_functions_window_functions_misc_test_select_573
SELECT col1 FROM data ORDER BY col2;
-- Tag: window_functions_window_functions_misc_test_select_574
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_575
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_576
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_misc_test_select_577
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_578
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_579
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_580
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_misc_test_select_581
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_582
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_583
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_misc_test_select_584
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_585
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_586
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_587
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_misc_test_select_588
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_589
SELECT * FROM (SELECT * FROM data);
-- Tag: window_functions_window_functions_misc_test_select_590
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_591
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_592
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_593
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

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

-- Tag: window_functions_window_functions_misc_test_select_594
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_595
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_596
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_597
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;

DROP TABLE IF EXISTS a;
CREATE TABLE a (id INT64, value INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (10, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64);
INSERT INTO data VALUES (10, 0);
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

-- Tag: window_functions_window_functions_misc_test_select_598
SELECT id FROM a JOIN b ON a.id = b.id;
-- Tag: window_functions_window_functions_misc_test_select_599
SELECT category, value, COUNT(*) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_600
SELECT value FROM data HAVING value > 10;
-- Tag: window_functions_window_functions_misc_test_select_601
SELECT a / b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_602
SELECT a % b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_603
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_604
SELECT a * b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_605
SELECT a - b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_606
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_607
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_misc_test_select_608
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_609
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_610
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_611
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_612
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_613
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_614
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_615
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_616
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_617
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_618
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_619
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_620
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_621
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_622
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_623
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_624
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_625
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_626
SELECT a - b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_627
SELECT a + b FROM data;
-- Tag: window_functions_window_functions_misc_test_select_628
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_misc_test_select_629
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_630
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_631
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_632
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_633
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_634
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_635
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_636
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_637
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_638
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_639
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_640
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_641
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_642
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_643
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_644
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_645
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_646
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_647
SELECT * FROM data WHERE a = b;
-- Tag: window_functions_window_functions_misc_test_select_648
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_649
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_650
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_651
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_652
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_653
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_654
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_655
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_656
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_657
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_658
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_659
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_660
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_661
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_662
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_663
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_664
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_665
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_666
SELECT SUM(name) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_667
SELECT AVG(text) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_668
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_669
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_670
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_671
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_672
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_673
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_674
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_675
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_676
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_677
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_678
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_679
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_680
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_681
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_682
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_683
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_684
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_685
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_686
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_687
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_688
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_689
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_690
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_691
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_692
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_693
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_694
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_695
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_696
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_697
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_698
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_699
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_700
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_701
SELECT COUNT(*) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_702
SELECT SUM(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_703
SELECT * FROM data WHERE id > 0;
-- Tag: window_functions_window_functions_misc_test_select_704
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_705
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_706
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_707
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_708
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_709
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_710
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_711
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_712
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_713
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_714
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_715
SELECT CAST(big_float AS INT64) FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_716
SELECT * FROM data;
-- Tag: window_functions_window_functions_misc_test_select_717
SELECT MAX(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_718
SELECT t.id FROM data;
-- Tag: window_functions_window_functions_misc_test_select_719
SELECT a.id, a.b_value FROM a;
-- Tag: window_functions_window_functions_misc_test_select_720
SELECT (SELECT amount FROM inner_table WHERE id = outer_table.id) FROM outer_table;
UPDATE data SET age = 25;
DELETE FROM data WHERE nonexistent > 10;
-- Tag: window_functions_window_functions_misc_test_select_721
SELECT SUM(COUNT(value)) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_722
SELECT category FROM data WHERE SUM(value) > 100 GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_723
SELECT ROW_NUMBER() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_724
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY id) = 1;
-- Tag: window_functions_window_functions_misc_test_select_725
SELECT (SELECT value FROM data) as single_value;
-- Tag: window_functions_window_functions_misc_test_select_726
SELECT (SELECT a, b FROM data) as multi_col;
-- Tag: window_functions_window_functions_misc_test_select_727
SELECT CAST(big_float AS INT64) FROM data;

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64, value STRING);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64, value STRING);
DROP TABLE IF EXISTS typed;
CREATE TABLE typed (id INT64, value INT64);
INSERT INTO typed VALUES (1, 'string');
DROP TABLE IF EXISTS data;
CREATE TABLE data (int_val INT64, str_val STRING);
INSERT INTO data VALUES (42, 'test');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
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

-- Tag: window_functions_window_functions_misc_test_select_728
SELECT id FROM table1 INNER JOIN table2 ON table1.id = table2.id;
-- Tag: window_functions_window_functions_misc_test_select_729
SELECT * FROM data WHERE int_val = str_val;
-- Tag: window_functions_window_functions_misc_test_select_730
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_misc_test_select_731
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_732
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_733
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_734
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_735
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_736
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_737
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_738
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_739
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_740
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_741
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_742
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_743
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_744
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_035
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_745
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_746
SELECT * FROM user;

DROP TABLE IF EXISTS data;
CREATE TABLE data (int_val INT64, str_val STRING);
INSERT INTO data VALUES (42, 'test');
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (name STRING);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
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

-- Tag: window_functions_window_functions_misc_test_select_747
SELECT * FROM data WHERE int_val = str_val;
-- Tag: window_functions_window_functions_misc_test_select_748
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.name;
-- Tag: window_functions_window_functions_misc_test_select_749
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_750
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_751
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_752
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_753
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_754
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_755
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_756
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_757
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_758
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_759
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_760
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_761
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_762
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_036
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_763
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_764
SELECT * FROM user;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
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

-- Tag: window_functions_window_functions_misc_test_select_765
SELECT value / 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_766
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_767
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_768
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_769
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_770
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_771
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_772
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_773
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_774
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_775
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_776
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_777
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_778
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_037
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_779
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_780
SELECT * FROM user;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
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

-- Tag: window_functions_window_functions_misc_test_select_781
SELECT value % 0 FROM numbers;
-- Tag: window_functions_window_functions_misc_test_select_782
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_783
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_784
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_785
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_786
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_787
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_788
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_789
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_790
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_791
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_792
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_793
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_038
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_794
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_795
SELECT * FROM user;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
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

-- Tag: window_functions_window_functions_misc_test_select_796
SELECT NONEXISTENT_FUNCTION(value) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_797
SELECT COALESCE() FROM data;
-- Tag: window_functions_window_functions_misc_test_select_798
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_799
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_800
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_801
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_802
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_803
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_804
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_805
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_806
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_807
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_039
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_808
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_809
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_misc_test_select_810
SELECT ABS(str_val) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_811
SELECT * FROM data WHERE SUM(value) > 100;
-- Tag: window_functions_window_functions_misc_test_select_812
SELECT product, region, SUM(amount) FROM sales GROUP BY product;
-- Tag: window_functions_window_functions_misc_test_select_813
SELECT amount FROM sales HAVING amount > 100;
-- Tag: window_functions_window_functions_misc_test_select_814
SELECT * FROM table1 UNION SELECT * FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_815
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_816
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_817
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_818
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_819
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_040
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_820
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_821
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_misc_test_select_822
SELECT value FROM table1 UNION SELECT value FROM table2;
-- Tag: window_functions_window_functions_misc_test_select_823
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_824
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_825
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_826
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_041
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_827
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_828
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_misc_test_select_829
SELECT * FROM (SELECT * FROM data);
WITH cte AS (SELECT * FROM data) SELECT * FROM nonexistent_cte;
-- Tag: window_functions_window_functions_misc_test_select_830
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_831
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_832
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_042
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_833
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_834
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_misc_test_select_835
SELECT * FROM data LIMIT -1;
-- Tag: window_functions_window_functions_misc_test_select_836
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_837
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_043
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_838
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_839
SELECT * FROM user;

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

-- Tag: window_functions_window_functions_misc_test_select_840
SELECT * FROM data OFFSET -1;
-- Tag: window_functions_window_functions_misc_test_select_841
SELECT * FROM data WHERE ROW_NUMBER() OVER (ORDER BY value) = 1;
-- Tag: window_functions_window_functions_misc_test_select_044
SELECT
id,
nonexistent_column,
name
FROM users;
-- Tag: window_functions_window_functions_misc_test_select_842
SELECT userid FROM users;
-- Tag: window_functions_window_functions_misc_test_select_843
SELECT * FROM user;

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
-- Tag: window_functions_window_functions_misc_test_select_844
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

-- Tag: window_functions_window_functions_misc_test_select_845
SELECT category, avg_value
FROM (
-- Tag: window_functions_window_functions_misc_test_select_846
SELECT category, AVG(value) as avg_value
FROM (
-- Tag: window_functions_window_functions_misc_test_select_847
SELECT category, value
FROM data
WHERE value > 100
) as filtered
GROUP BY category
) as averaged
WHERE avg_value > 150
ORDER BY avg_value DESC;
-- Tag: window_functions_window_functions_misc_test_select_848
SELECT user_id, total_amount
FROM (
-- Tag: window_functions_window_functions_misc_test_select_849
SELECT user_id, SUM(CAST(amount_str AS INT64)) as total_amount
FROM transactions
GROUP BY user_id
) as user_totals
WHERE total_amount > 300
ORDER BY total_amount DESC;
-- Tag: window_functions_window_functions_misc_test_select_850
SELECT name, age, score, grade FROM target ORDER BY score DESC;
-- Tag: window_functions_window_functions_misc_test_select_851
SELECT id,
CAST(year_str AS INT64) as year,
amount,
ROW_NUMBER() OVER (PARTITION BY CAST(year_str AS INT64) ORDER BY amount DESC) as rank
FROM sales
ORDER BY year, rank;
-- Tag: window_functions_window_functions_misc_test_select_852
SELECT name, dept, salary,
ROW_NUMBER() OVER (
PARTITION BY dept
ORDER BY CASE WHEN salary > 75000 THEN salary ELSE 0 END DESC
) as priority_rank
FROM employees
ORDER BY dept, priority_rank;
-- Tag: window_functions_window_functions_misc_test_select_853
SELECT category, SUM(CAST(value AS INT64)) as total
FROM data
GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_854
SELECT CASE WHEN flag THEN 'yes' ELSE 42 END as mixed FROM data;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (order_id INT64, item_name STRING, price FLOAT64);
INSERT INTO orders VALUES (1, 100), (2, 100), (3, 101);
INSERT INTO order_items VALUES
(1, 'Widget', 10.0),
(1, 'Gadget', 20.0),
(2, 'Gizmo', 15.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64);
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (order_id INT64, item_name STRING);
INSERT INTO orders VALUES (1), (2), (3);
INSERT INTO order_items VALUES (1, 'Widget'), (2, 'Gadget');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value STRING);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, related STRING);
INSERT INTO t1 VALUES (1, 'test');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (a INT64, b INT64, c INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 10), (2, 20);
INSERT INTO t3 VALUES (1, 10, 100), (2, 20, 200);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, ref_id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (ref_id INT64, data STRING);
INSERT INTO outer_table VALUES (1, 100), (2, NULL), (3, 200);
INSERT INTO inner_table VALUES (100, 'A'), (200, 'B');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_misc_test_select_855
SELECT o.order_id, items.item_name, items.price
FROM orders o
CROSS APPLY (
-- Tag: window_functions_window_functions_misc_test_select_856
SELECT item_name, price
FROM order_items
WHERE order_id = o.order_id
) items
ORDER BY o.order_id, items.item_name;
-- Tag: window_functions_window_functions_misc_test_select_857
SELECT o.order_id, items.item_name
FROM orders o
OUTER APPLY (
-- Tag: window_functions_window_functions_misc_test_select_858
SELECT item_name
FROM order_items
WHERE order_id = o.order_id
) items
ORDER BY o.order_id;
-- Tag: window_functions_window_functions_misc_test_select_859
SELECT t1.value, t2.related
FROM t1
CROSS JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2;
-- Tag: window_functions_window_functions_misc_test_select_860
SELECT t1.value, t2.related
FROM t1
LEFT JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2 ON true;
-- Tag: window_functions_window_functions_misc_test_select_861
SELECT t1.a, x.b, y.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_862
SELECT b FROM t2 WHERE t2.a = t1.a
) x
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_863
SELECT c FROM t3 WHERE t3.a = t1.a AND t3.b = x.b
) y
ORDER BY t1.a;
-- Tag: window_functions_window_functions_misc_test_select_864
SELECT o.id, i.data
FROM outer_table o
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_865
SELECT data FROM inner_table WHERE ref_id = o.ref_id
) i
ORDER BY o.id;
-- Tag: window_functions_window_functions_misc_test_select_866
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_867
SELECT * FROM t2 WHERE id = t1.nonexistent_col
) x;
-- Tag: window_functions_window_functions_misc_test_select_868
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_869
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_misc_test_select_870
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_871
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_misc_test_select_872
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_misc_test_select_873
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_874
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_misc_test_select_875
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_045
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_misc_test_select_876
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_877
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_878
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_misc_test_select_879
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_880
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64);
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (order_id INT64, item_name STRING);
INSERT INTO orders VALUES (1), (2), (3);
INSERT INTO order_items VALUES (1, 'Widget'), (2, 'Gadget');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value STRING);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, related STRING);
INSERT INTO t1 VALUES (1, 'test');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (a INT64, b INT64, c INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 10), (2, 20);
INSERT INTO t3 VALUES (1, 10, 100), (2, 20, 200);
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, ref_id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (ref_id INT64, data STRING);
INSERT INTO outer_table VALUES (1, 100), (2, NULL), (3, 200);
INSERT INTO inner_table VALUES (100, 'A'), (200, 'B');
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, value INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (b INT64);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (10), (20);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO orders VALUES (1, 100), (1, 200), (2, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
('A', 'Widget', 100),
('A', 'Gadget', 150),
('B', 'Widget', 200);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (b INT64, c INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1, 10);
INSERT INTO t3 VALUES (10, 100);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (customer_id INT64, amount FLOAT64, date DATE);

-- Tag: window_functions_window_functions_misc_test_select_881
SELECT o.order_id, items.item_name
FROM orders o
OUTER APPLY (
-- Tag: window_functions_window_functions_misc_test_select_882
SELECT item_name
FROM order_items
WHERE order_id = o.order_id
) items
ORDER BY o.order_id;
-- Tag: window_functions_window_functions_misc_test_select_883
SELECT t1.value, t2.related
FROM t1
CROSS JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2;
-- Tag: window_functions_window_functions_misc_test_select_884
SELECT t1.value, t2.related
FROM t1
LEFT JOIN LATERAL (SELECT related FROM t2 WHERE id = t1.id) t2 ON true;
-- Tag: window_functions_window_functions_misc_test_select_885
SELECT t1.a, x.b, y.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_886
SELECT b FROM t2 WHERE t2.a = t1.a
) x
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_887
SELECT c FROM t3 WHERE t3.a = t1.a AND t3.b = x.b
) y
ORDER BY t1.a;
-- Tag: window_functions_window_functions_misc_test_select_888
SELECT o.id, i.data
FROM outer_table o
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_889
SELECT data FROM inner_table WHERE ref_id = o.ref_id
) i
ORDER BY o.id;
-- Tag: window_functions_window_functions_misc_test_select_890
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_891
SELECT * FROM t2 WHERE id = t1.nonexistent_col
) x;
-- Tag: window_functions_window_functions_misc_test_select_892
SELECT t1.id
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_893
SELECT * FROM t2 WHERE id = value
) x;
-- Tag: window_functions_window_functions_misc_test_select_894
SELECT t1.a, x.b
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_895
SELECT b FROM t2
) x
ORDER BY t1.a, x.b;
WITH customer_totals AS (
-- Tag: window_functions_window_functions_misc_test_select_896
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
)
-- Tag: window_functions_window_functions_misc_test_select_897
SELECT ct.customer_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_898
SELECT amount
FROM orders
WHERE customer_id = ct.customer_id
ORDER BY amount DESC
LIMIT 1
) recent
ORDER BY ct.customer_id;
-- Tag: window_functions_window_functions_misc_test_select_899
SELECT DISTINCT dept, top_products.product, top_products.rank
FROM sales s
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_046
SELECT
product,
ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales
WHERE dept = s.dept
LIMIT 1
) top_products
ORDER BY dept;
-- Tag: window_functions_window_functions_misc_test_select_900
SELECT t1.a, x.b, x.c
FROM t1
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_901
SELECT t2.b, y.c
FROM t2
WHERE t2.a = t1.a
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_902
SELECT c FROM t3 WHERE t3.b = t2.b
) y
) x;
-- Tag: window_functions_window_functions_misc_test_select_903
SELECT c.id, t.amount, t.date
FROM customers c
CROSS JOIN LATERAL (
-- Tag: window_functions_window_functions_misc_test_select_904
SELECT amount, date
FROM transactions
WHERE customer_id = c.id
ORDER BY date DESC
LIMIT 1
) t;

DROP TABLE IF EXISTS bools;
CREATE TABLE bools (id INT64, val BOOL);
INSERT INTO bools VALUES (1, TRUE);
DROP TABLE IF EXISTS bools;
CREATE TABLE bools (id INT64, val BOOL);
INSERT INTO bools VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE);
INSERT INTO t VALUES (2, TRUE, TRUE);
INSERT INTO t VALUES (3, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE);
INSERT INTO t VALUES (2, TRUE, TRUE);
INSERT INTO t VALUES (3, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, NULL);
INSERT INTO t VALUES (2, FALSE, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE, TRUE, TRUE);
INSERT INTO t VALUES (2, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL, e BOOL, f BOOL);
INSERT INTO t VALUES (1, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
INSERT INTO t VALUES (2);
INSERT INTO t VALUES (3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS t;
CREATE TABLE t (category STRING, value INT64);
INSERT INTO t VALUES ('A', NULL);
INSERT INTO t VALUES ('B', 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: window_functions_window_functions_misc_test_select_905
SELECT NOT NOT val as result FROM bools WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_906
SELECT NOT NOT NOT val as result FROM bools WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_907
SELECT (TRUE AND TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_908
SELECT (TRUE AND FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_909
SELECT (TRUE AND val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_910
SELECT (FALSE AND val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_911
SELECT (val AND FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_912
SELECT (a AND b) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_913
SELECT (TRUE OR TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_914
SELECT (TRUE OR FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_915
SELECT (TRUE OR val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_916
SELECT (FALSE OR val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_917
SELECT (val OR TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_918
SELECT (a OR b) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_919
SELECT id, NOT (a AND b) as left_side, (NOT a) OR (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_920
SELECT id, NOT (a OR b) as left_side, (NOT a) AND (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_921
SELECT id, NOT (a AND b) as left_side, (NOT a) OR (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_922
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_923
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_924
SELECT a OR b AND c as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_925
SELECT a OR (b AND c) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_926
SELECT NOT a AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_927
SELECT (NOT a) AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_928
SELECT ((a AND b) OR (c AND d)) AND NOT (e OR f) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_929
SELECT id FROM t WHERE FALSE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_930
SELECT id FROM t WHERE TRUE OR (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_931
SELECT id FROM t WHERE TRUE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_932
SELECT id FROM t WHERE NULL;
-- Tag: window_functions_window_functions_misc_test_select_933
SELECT id FROM t WHERE flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_934
SELECT id FROM t WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_935
SELECT region, SUM(amount) FROM sales GROUP BY region HAVING NULL;
-- Tag: window_functions_window_functions_misc_test_select_936
SELECT category, MAX(value) as max_val FROM t GROUP BY category HAVING MAX(value) > 5;
-- Tag: window_functions_window_functions_misc_test_select_937
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
-- Tag: window_functions_window_functions_misc_test_select_938
SELECT id, CASE WHEN flag THEN 'yes' ELSE 'no' END as result FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_939
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE TRUE);
-- Tag: window_functions_window_functions_misc_test_select_940
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: window_functions_window_functions_misc_test_select_941
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS bools;
CREATE TABLE bools (id INT64, val BOOL);
INSERT INTO bools VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val BOOL);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE);
INSERT INTO t VALUES (2, TRUE, TRUE);
INSERT INTO t VALUES (3, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE);
INSERT INTO t VALUES (2, TRUE, TRUE);
INSERT INTO t VALUES (3, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, TRUE, NULL);
INSERT INTO t VALUES (2, FALSE, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE, TRUE, TRUE);
INSERT INTO t VALUES (2, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL, e BOOL, f BOOL);
INSERT INTO t VALUES (1, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
INSERT INTO t VALUES (2);
INSERT INTO t VALUES (3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS t;
CREATE TABLE t (category STRING, value INT64);
INSERT INTO t VALUES ('A', NULL);
INSERT INTO t VALUES ('B', 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: window_functions_window_functions_misc_test_select_942
SELECT NOT NOT NOT val as result FROM bools WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_943
SELECT (TRUE AND TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_944
SELECT (TRUE AND FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_945
SELECT (TRUE AND val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_946
SELECT (FALSE AND val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_947
SELECT (val AND FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_948
SELECT (a AND b) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_949
SELECT (TRUE OR TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_950
SELECT (TRUE OR FALSE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_951
SELECT (TRUE OR val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_952
SELECT (FALSE OR val) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_953
SELECT (val OR TRUE) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_954
SELECT (a OR b) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_955
SELECT id, NOT (a AND b) as left_side, (NOT a) OR (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_956
SELECT id, NOT (a OR b) as left_side, (NOT a) AND (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_957
SELECT id, NOT (a AND b) as left_side, (NOT a) OR (NOT b) as right_side FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_958
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_959
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_960
SELECT a OR b AND c as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_961
SELECT a OR (b AND c) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_962
SELECT NOT a AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_963
SELECT (NOT a) AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_964
SELECT ((a AND b) OR (c AND d)) AND NOT (e OR f) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_965
SELECT id FROM t WHERE FALSE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_966
SELECT id FROM t WHERE TRUE OR (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_967
SELECT id FROM t WHERE TRUE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_968
SELECT id FROM t WHERE NULL;
-- Tag: window_functions_window_functions_misc_test_select_969
SELECT id FROM t WHERE flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_970
SELECT id FROM t WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_971
SELECT region, SUM(amount) FROM sales GROUP BY region HAVING NULL;
-- Tag: window_functions_window_functions_misc_test_select_972
SELECT category, MAX(value) as max_val FROM t GROUP BY category HAVING MAX(value) > 5;
-- Tag: window_functions_window_functions_misc_test_select_973
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
-- Tag: window_functions_window_functions_misc_test_select_974
SELECT id, CASE WHEN flag THEN 'yes' ELSE 'no' END as result FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_975
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE TRUE);
-- Tag: window_functions_window_functions_misc_test_select_976
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: window_functions_window_functions_misc_test_select_977
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL);
INSERT INTO t VALUES (1, TRUE, FALSE, TRUE, TRUE);
INSERT INTO t VALUES (2, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, FALSE, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL, e BOOL, f BOOL);
INSERT INTO t VALUES (1, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
INSERT INTO t VALUES (2);
INSERT INTO t VALUES (3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS t;
CREATE TABLE t (category STRING, value INT64);
INSERT INTO t VALUES ('A', NULL);
INSERT INTO t VALUES ('B', 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: window_functions_window_functions_misc_test_select_978
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_979
SELECT (a AND b) OR (c AND d) as result FROM t WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_980
SELECT a OR b AND c as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_981
SELECT a OR (b AND c) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_982
SELECT NOT a AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_983
SELECT (NOT a) AND b as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_984
SELECT ((a AND b) OR (c AND d)) AND NOT (e OR f) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_985
SELECT id FROM t WHERE FALSE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_986
SELECT id FROM t WHERE TRUE OR (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_987
SELECT id FROM t WHERE TRUE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_988
SELECT id FROM t WHERE NULL;
-- Tag: window_functions_window_functions_misc_test_select_989
SELECT id FROM t WHERE flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_990
SELECT id FROM t WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_991
SELECT region, SUM(amount) FROM sales GROUP BY region HAVING NULL;
-- Tag: window_functions_window_functions_misc_test_select_992
SELECT category, MAX(value) as max_val FROM t GROUP BY category HAVING MAX(value) > 5;
-- Tag: window_functions_window_functions_misc_test_select_993
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
-- Tag: window_functions_window_functions_misc_test_select_994
SELECT id, CASE WHEN flag THEN 'yes' ELSE 'no' END as result FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_995
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE TRUE);
-- Tag: window_functions_window_functions_misc_test_select_996
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: window_functions_window_functions_misc_test_select_997
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL, c BOOL, d BOOL, e BOOL, f BOOL);
INSERT INTO t VALUES (1, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
INSERT INTO t VALUES (2, 1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
INSERT INTO t VALUES (2);
INSERT INTO t VALUES (3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS t;
CREATE TABLE t (category STRING, value INT64);
INSERT INTO t VALUES ('A', NULL);
INSERT INTO t VALUES ('B', 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
INSERT INTO t VALUES (3, NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64);
INSERT INTO t1 VALUES (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64);
INSERT INTO t2 VALUES (99);

-- Tag: window_functions_window_functions_misc_test_select_998
SELECT ((a AND b) OR (c AND d)) AND NOT (e OR f) as result FROM t WHERE id = 1;
-- Tag: window_functions_window_functions_misc_test_select_999
SELECT id FROM t WHERE FALSE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_1000
SELECT id FROM t WHERE TRUE OR (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_1001
SELECT id FROM t WHERE TRUE AND (10 / denominator = 10);
-- Tag: window_functions_window_functions_misc_test_select_1002
SELECT id FROM t WHERE NULL;
-- Tag: window_functions_window_functions_misc_test_select_1003
SELECT id FROM t WHERE flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1004
SELECT id FROM t WHERE NOT flag ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1005
SELECT region, SUM(amount) FROM sales GROUP BY region HAVING NULL;
-- Tag: window_functions_window_functions_misc_test_select_1006
SELECT category, MAX(value) as max_val FROM t GROUP BY category HAVING MAX(value) > 5;
-- Tag: window_functions_window_functions_misc_test_select_1007
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
-- Tag: window_functions_window_functions_misc_test_select_1008
SELECT id, CASE WHEN flag THEN 'yes' ELSE 'no' END as result FROM t ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1009
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE TRUE);
-- Tag: window_functions_window_functions_misc_test_select_1010
SELECT id FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE FALSE);
-- Tag: window_functions_window_functions_misc_test_select_1011
SELECT id FROM t1 WHERE NOT EXISTS (SELECT 1 FROM t2 WHERE NULL);

DROP TABLE IF EXISTS words;
CREATE TABLE words (word STRING);
INSERT INTO words VALUES ('zebra');
INSERT INTO words VALUES ('äpple');
INSERT INTO words VALUES ('orange');
DROP TABLE IF EXISTS test;
CREATE TABLE test (name STRING);
INSERT INTO test VALUES ('Bob');
INSERT INTO test VALUES (NULL);
INSERT INTO test VALUES ('alice');
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('Bob');
INSERT INTO names VALUES ('alice');
INSERT INTO names VALUES ('Charlie');
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (player STRING, score INT64, time INT64);
INSERT INTO scores VALUES ('Alice', 100, 50);
INSERT INTO scores VALUES ('Bob', 100, 45);
INSERT INTO scores VALUES ('Charlie', 90, 55);
DROP TABLE IF EXISTS rankings;
CREATE TABLE rankings ( category STRING, score INT64, bonus INT64, name STRING );
INSERT INTO rankings VALUES ('A', 100, 5, 'Alice');
INSERT INTO rankings VALUES ('A', 100, 10, 'Bob');
INSERT INTO rankings VALUES ('B', 90, 15, 'Charlie');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, NULL);
INSERT INTO test VALUES (2, NULL);
INSERT INTO test VALUES (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (42);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 10);
INSERT INTO test VALUES (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (col1 INT64);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, value INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, data STRING);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (player STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 110);
INSERT INTO scores VALUES ('David', 95);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, amount FLOAT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
INSERT INTO orders VALUES (1, 100.0);
INSERT INTO orders VALUES (2, 50.0);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES ('West', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 5);

-- Tag: window_functions_window_functions_misc_test_select_1012
SELECT word FROM words ORDER BY word COLLATE 'sv_SE';
-- Tag: window_functions_window_functions_misc_test_select_1013
SELECT name FROM test ORDER BY name COLLATE NOCASE NULLS LAST;
-- Tag: window_functions_window_functions_misc_test_select_1014
SELECT name FROM names ORDER BY UPPER(name);
-- Tag: window_functions_window_functions_misc_test_select_1015
SELECT player, score, time FROM scores
ORDER BY score DESC, time ASC;
-- Tag: window_functions_window_functions_misc_test_select_1016
SELECT * FROM rankings
ORDER BY category ASC, score DESC, bonus DESC;
-- Tag: window_functions_window_functions_misc_test_select_1017
SELECT id FROM test ORDER BY value NULLS LAST;
-- Tag: window_functions_window_functions_misc_test_select_1018
SELECT value FROM test ORDER BY value ASC;
-- Tag: window_functions_window_functions_misc_test_select_1019
SELECT value FROM test ORDER BY value DESC;
-- Tag: window_functions_window_functions_misc_test_select_1020
SELECT id FROM test ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1021
SELECT col1 FROM test ORDER BY nonexistent;
-- Tag: window_functions_window_functions_misc_test_select_1022
SELECT t1.value, t2.data FROM t1 JOIN t2 ON t1.id = t2.id ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1023
SELECT player, score FROM scores ORDER BY score DESC LIMIT 3;
-- Tag: window_functions_window_functions_misc_test_select_1024
SELECT c.name, o.amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
ORDER BY o.amount DESC;
-- Tag: window_functions_window_functions_misc_test_select_1025
SELECT region, SUM(amount) as total
FROM sales
GROUP BY region
ORDER BY total DESC;
-- Tag: window_functions_window_functions_misc_test_select_1026
SELECT * FROM (
-- Tag: window_functions_window_functions_misc_test_select_1027
SELECT id, value FROM test ORDER BY value ASC LIMIT 2
) AS subq
ORDER BY id DESC;

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

-- Tag: window_functions_window_functions_misc_test_select_1028
SELECT id, COUNT(*) FROM test GROUP BY id;
-- Tag: window_functions_window_functions_misc_test_select_1029
SELECT id, AVG(value) OVER (ORDER BY id ROWS BETWEEN 1000 PRECEDING AND CURRENT ROW) as moving_avg FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1030
SELECT * FROM test WHERE text LIKE '%a%a%a%a%a%a%a%a%a%a%b';
-- Tag: window_functions_window_functions_misc_test_select_1031
SELECT * FROM test WHERE REGEXP_CONTAINS(text, '(a+)+b');
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_misc_test_select_1032
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1033
SELECT n + 1 FROM cte WHERE n < 10000
)
-- Tag: window_functions_window_functions_misc_test_select_1034
SELECT MAX(n) FROM cte;
WITH RECURSIVE cte AS (
-- Tag: window_functions_window_functions_misc_test_select_1035
SELECT 1 as n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1036
SELECT n FROM cte
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1037
SELECT n FROM cte
)
-- Tag: window_functions_window_functions_misc_test_select_1038
SELECT COUNT(*) FROM cte;
-- Tag: window_functions_window_functions_misc_test_select_1039
SELECT * FROM test ORDER BY id DESC;
-- Tag: window_functions_window_functions_misc_test_select_1040
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: window_functions_window_functions_misc_test_select_1041
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

WITH RECURSIVE dependencies AS (
-- Tag: window_functions_window_functions_misc_test_select_1042
SELECT id, depends_on, 1 AS depth
FROM circular_deps
WHERE id = 1
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1043
SELECT cd.id, cd.depends_on, d.depth + 1
FROM circular_deps cd
JOIN dependencies d ON cd.id = d.depends_on
WHERE d.depth < 10 -- Safety limit
)
-- Tag: window_functions_window_functions_misc_test_select_1044
SELECT * FROM dependencies;
WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_misc_test_select_1045
SELECT id, parent_id, level, 1 AS iteration
FROM tree_nodes
WHERE parent_id IS NULL
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1046
SELECT tn.id, tn.parent_id, tn.level, t.iteration + 1
FROM tree_nodes tn
JOIN tree t ON tn.parent_id = t.id
WHERE t.iteration < 4 -- Limit iterations
)
-- Tag: window_functions_window_functions_misc_test_select_1047
SELECT COUNT(*), MAX(level) FROM tree;
WITH RECURSIVE tree AS (
-- Tag: window_functions_window_functions_misc_test_select_1048
SELECT id, parent_id, 0 AS level
FROM nullable_hierarchy
WHERE id = 1
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1049
SELECT nh.id, nh.parent_id, t.level + 1
FROM nullable_hierarchy nh
JOIN tree t ON nh.parent_id = t.id
)
-- Tag: window_functions_window_functions_misc_test_select_1050
SELECT COUNT(*) FROM tree;
WITH RECURSIVE
numbers AS (
-- Tag: window_functions_window_functions_misc_test_select_1051
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1052
SELECT n + 1 FROM numbers WHERE n < 3
),
letters AS (
-- Tag: window_functions_window_functions_misc_test_select_1053
SELECT 'A' AS letter, 1 AS ord
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_047
SELECT
CASE ord
WHEN 1 THEN 'B'
WHEN 2 THEN 'C'
END,
ord + 1
FROM letters
WHERE ord < 3
)
-- Tag: window_functions_window_functions_misc_test_select_1054
SELECT n, letter FROM numbers CROSS JOIN letters ORDER BY n, ord;
WITH RECURSIVE paths AS (
-- Tag: window_functions_window_functions_misc_test_select_1055
SELECT DISTINCT from_node AS node, 0 AS hops
FROM edges
WHERE from_node = 1
UNION DISTINCT
-- Tag: window_functions_window_functions_misc_test_select_1056
SELECT DISTINCT e.to_node, p.hops + 1
FROM edges e
JOIN paths p ON e.from_node = p.node
WHERE p.hops < 3
)
-- Tag: window_functions_window_functions_misc_test_select_1057
SELECT * FROM paths ORDER BY node;
WITH RECURSIVE running_total AS (
-- Tag: window_functions_window_functions_misc_test_select_1058
SELECT day, amount, amount AS total
FROM sales
WHERE day = 1
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1059
SELECT s.day, s.amount, rt.total + s.amount
FROM sales s
JOIN running_total rt ON s.day = rt.day + 1
)
-- Tag: window_functions_window_functions_misc_test_select_1060
SELECT * FROM running_total ORDER BY day;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_misc_test_select_1061
SELECT 1 AS n, 'A' AS letter
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1062
SELECT n + 1 FROM broken WHERE n < 5 -- Missing 'letter' column!
)
-- Tag: window_functions_window_functions_misc_test_select_1063
SELECT * FROM broken;
WITH RECURSIVE type_broken AS (
-- Tag: window_functions_window_functions_misc_test_select_1064
SELECT 1 AS value
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1065
SELECT 'not a number' FROM type_broken WHERE value < 5 -- Type mismatch!
)
-- Tag: window_functions_window_functions_misc_test_select_1066
SELECT * FROM type_broken;
WITH RECURSIVE broken AS (
-- Tag: window_functions_window_functions_misc_test_select_1067
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1068
SELECT n + 1
FROM non_existent_table -- Table doesn't exist!
WHERE n < 5
)
-- Tag: window_functions_window_functions_misc_test_select_1069
SELECT * FROM broken;
WITH numbers AS ( -- Missing RECURSIVE!
-- Tag: window_functions_window_functions_misc_test_select_1070
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1071
SELECT n + 1 FROM numbers WHERE n < 5
)
-- Tag: window_functions_window_functions_misc_test_select_1072
SELECT * FROM numbers;
WITH RECURSIVE empty_start AS (
-- Tag: window_functions_window_functions_misc_test_select_1073
SELECT id FROM data WHERE id = 999 -- No matching rows
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1074
SELECT id + 1 FROM empty_start WHERE id < 5
)
-- Tag: window_functions_window_functions_misc_test_select_1075
SELECT COUNT(*) FROM empty_start;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_misc_test_select_1076
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1077
SELECT n + 1 FROM nums WHERE n < 100
)
-- Tag: window_functions_window_functions_misc_test_select_1078
SELECT * FROM nums LIMIT 5;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_misc_test_select_1079
SELECT 5 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1080
SELECT n - 1 FROM nums WHERE n > 1
)
-- Tag: window_functions_window_functions_misc_test_select_1081
SELECT * FROM nums ORDER BY n ASC;
-- Tag: window_functions_window_functions_misc_test_select_1082
SELECT *
FROM (
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_misc_test_select_1083
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1084
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_misc_test_select_1085
SELECT n * 2 AS doubled FROM nums
) AS doubled_nums
WHERE doubled >= 4;
WITH RECURSIVE nums AS (
-- Tag: window_functions_window_functions_misc_test_select_1086
SELECT 1 AS n
UNION ALL
-- Tag: window_functions_window_functions_misc_test_select_1087
SELECT n + 1 FROM nums WHERE n < 5
)
-- Tag: window_functions_window_functions_misc_test_select_048
SELECT
n,
ROW_NUMBER() OVER (ORDER BY n DESC) AS rev_rank
FROM nums;

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

-- Tag: window_functions_window_functions_misc_test_select_1088
SELECT NEXTVAL('seq_next') as val;
-- Tag: window_functions_window_functions_misc_test_select_1089
SELECT NEXTVAL('seq_multi') as val;
-- Tag: window_functions_window_functions_misc_test_select_1090
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1091
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_misc_test_select_1092
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1093
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1094
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1095
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1096
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_misc_test_select_1097
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1098
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1099
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1100
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_misc_test_select_1101
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_misc_test_select_1102
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_misc_test_select_1103
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_misc_test_select_1104
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1105
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_misc_test_select_1106
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1107
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_misc_test_select_1108
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_misc_test_select_1109
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1110
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1111
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1112
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1113
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1114
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1115
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1116
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1117
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1118
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1119
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1120
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1121
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1122
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1123
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1124
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1125
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1126
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1127
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1128
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1129
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1130
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1131
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1132
SELECT NEXTVAL('nonexistent');
-- Tag: window_functions_window_functions_misc_test_select_1133
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1134
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1135
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1136
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1137
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_misc_test_select_1138
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1139
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1140
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1141
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_misc_test_select_1142
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_misc_test_select_1143
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_misc_test_select_1144
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_misc_test_select_1145
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1146
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_misc_test_select_1147
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1148
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_misc_test_select_1149
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_misc_test_select_1150
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1151
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1152
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1153
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1154
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1155
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1156
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1157
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1158
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1159
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1160
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1161
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1162
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1163
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1164
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1165
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1166
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1167
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1168
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1169
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1170
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1171
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1172
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1173
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1174
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1175
SELECT NEXTVAL('seq_curr');
-- Tag: window_functions_window_functions_misc_test_select_1176
SELECT CURRVAL('seq_curr') as val;
-- Tag: window_functions_window_functions_misc_test_select_1177
SELECT CURRVAL('seq_curr_err');
-- Tag: window_functions_window_functions_misc_test_select_1178
SELECT NEXTVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1179
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1180
SELECT CURRVAL('seq_noadvance');
-- Tag: window_functions_window_functions_misc_test_select_1181
SELECT NEXTVAL('seq_noadvance') as val;
-- Tag: window_functions_window_functions_misc_test_select_1182
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_misc_test_select_1183
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_misc_test_select_1184
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_misc_test_select_1185
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1186
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_misc_test_select_1187
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1188
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_misc_test_select_1189
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_misc_test_select_1190
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1191
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1192
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1193
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1194
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1195
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1196
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1197
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1198
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1199
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1200
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1201
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1202
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1203
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1204
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1205
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1206
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1207
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1208
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1209
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1210
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1211
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1212
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1213
SELECT SETVAL('seq_set', 100);
-- Tag: window_functions_window_functions_misc_test_select_1214
SELECT NEXTVAL('seq_set') as val;
-- Tag: window_functions_window_functions_misc_test_select_1215
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_misc_test_select_1216
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1217
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_misc_test_select_1218
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1219
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_misc_test_select_1220
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_misc_test_select_1221
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1222
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1223
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1224
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1225
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1226
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1227
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1228
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1229
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1230
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1231
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1232
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1233
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1234
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1235
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1236
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1237
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1238
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1239
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1240
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1241
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1242
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1243
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1244
SELECT SETVAL('seq_setcall', 50, true);
-- Tag: window_functions_window_functions_misc_test_select_1245
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1246
SELECT SETVAL('seq_setcall', 100, false);
-- Tag: window_functions_window_functions_misc_test_select_1247
SELECT NEXTVAL('seq_setcall') as val;
-- Tag: window_functions_window_functions_misc_test_select_1248
SELECT SETVAL('seq_setmax', 150);
-- Tag: window_functions_window_functions_misc_test_select_1249
SELECT NEXTVAL('seq_setmax');
-- Tag: window_functions_window_functions_misc_test_select_1250
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1251
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1252
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1253
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1254
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1255
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1256
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1257
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1258
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1259
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1260
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1261
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1262
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1263
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1264
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1265
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1266
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1267
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1268
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1269
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1270
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1271
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1272
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1273
SELECT NEXTVAL('seq_last');
-- Tag: window_functions_window_functions_misc_test_select_1274
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1275
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1276
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1277
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1278
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1279
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1280
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1281
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1282
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1283
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1284
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1285
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1286
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1287
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1288
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1289
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1290
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1291
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1292
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1293
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1294
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1295
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1296
SELECT NEXTVAL('seq1');
-- Tag: window_functions_window_functions_misc_test_select_1297
SELECT NEXTVAL('seq2');
-- Tag: window_functions_window_functions_misc_test_select_1298
SELECT LASTVAL() as val;
-- Tag: window_functions_window_functions_misc_test_select_1299
SELECT LASTVAL();
-- Tag: window_functions_window_functions_misc_test_select_1300
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1301
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1302
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1303
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1304
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1305
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1306
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1307
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1308
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1309
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1310
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1311
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1312
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1313
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1314
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1315
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1316
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1317
SELECT id, name FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1318
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1319
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1320
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1321
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1322
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1323
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1324
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1325
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1326
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1327
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1328
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1329
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1330
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1331
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1332
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1333
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1334
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1335
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1336
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1337
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1338
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1339
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1340
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1341
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1342
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1343
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1344
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1345
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1346
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1347
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1348
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1349
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1350
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1351
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1352
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1353
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1354
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1355
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1356
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1357
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1358
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1359
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1360
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1361
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1362
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1363
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1364
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1365
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1366
SELECT CURRVAL('items_id_seq');
-- Tag: window_functions_window_functions_misc_test_select_1367
SELECT CURRVAL('items_id_seq') as val;
-- Tag: window_functions_window_functions_misc_test_select_1368
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1369
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1370
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1371
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1372
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1373
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1374
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1375
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1376
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1377
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1378
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1379
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1380
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1381
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1382
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1383
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1384
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1385
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1386
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1387
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1388
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1389
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1390
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1391
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1392
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1393
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1394
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1395
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1396
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1397
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1398
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1399
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1400
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1401
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1402
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1403
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1404
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1405
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1406
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1407
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1408
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1409
SELECT id FROM items ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1410
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1411
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1412
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1413
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1414
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1415
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1416
SELECT id FROM items ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1417
SELECT id FROM items ORDER BY id;
BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1418
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1419
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1420
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1421
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1422
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1423
SELECT id FROM items ORDER BY id;

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

BEGIN;
ROLLBACK;
-- Tag: window_functions_window_functions_misc_test_select_1424
SELECT id FROM items;
-- Tag: window_functions_window_functions_misc_test_select_1425
SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Tag: window_functions_window_functions_misc_test_select_1426
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1427
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1428
SELECT NEXTVAL('seq_overflow');
-- Tag: window_functions_window_functions_misc_test_select_1429
SELECT id FROM items ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test ( group_id INT64, value INT64 );
INSERT INTO test VALUES (1, 7), (1, 3), (3, 15);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( category STRING, flag BOOL );
INSERT INTO test VALUES
('A', NULL),
('A', NULL),
('B', true),
('B', NULL);
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64, name STRING, manager_id INT64 );
INSERT INTO users VALUES
(1, 'Alice', NULL),  -- Top-level manager
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value STRING);
INSERT INTO test VALUES ('hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales ( region STRING, product STRING, revenue INT64 );
INSERT INTO sales VALUES
('North', 'Widget', 1000),
('North', 'Gadget', 500),
('South', 'Widget', 2000),
('South', 'Gadget', 3000);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( group_id INT64, permissions INT64, is_active BOOL );
INSERT INTO test VALUES
(1, 15, true),
(1, 7, true),
(1, 3, false),
(2, 1, true),
(2, 1, true);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (42), (NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test ( val1 INT64, val2 INT64, val3 INT64 );
INSERT INTO test VALUES
(NULL, NULL, 100),
(NULL, 200, 100),
(300, 200, 100);

-- Tag: window_functions_window_functions_misc_test_select_1430
SELECT group_id, BIT_AND(value) as bit_and_result
FROM test
WHERE group_id <= 5
GROUP BY group_id
ORDER BY group_id;
-- Tag: window_functions_window_functions_misc_test_select_1431
SELECT category, BOOL_AND(flag) as all_true, BOOL_OR(flag) as any_true
FROM test
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_049
SELECT
u1.name as employee,
(SELECT name FROM users WHERE id = u1.manager_id),
'CEO') as reports_to
FROM users u1
ORDER BY u1.id;
-- Tag: window_functions_window_functions_misc_test_select_1432
SELECT BIT_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1433
SELECT BOOL_AND(value) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1434
SELECT BIT_AND(value) as result FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1435
SELECT region, product
FROM sales
GROUP BY region, product
HAVING SUM(revenue) > 1000
ORDER BY region, product;
-- Tag: window_functions_window_functions_misc_test_select_1436
SELECT group_id, COUNT(*) as member_count
FROM test
GROUP BY group_id
HAVING (BIT_AND(permissions) & 1) = 1
AND BOOL_OR(is_active) = true
AND BOOL_AND(is_active) = false
ORDER BY group_id;
-- Tag: window_functions_window_functions_misc_test_select_1437
SELECT value, NVL(value, value) as nvl_result FROM test ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1438
SELECT NVL(val1, NVL(val2, val3)) as result FROM test ORDER BY result;

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

-- Tag: window_functions_window_functions_misc_test_select_1439
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1440
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1441
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1442
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1443
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_misc_test_select_1444
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1445
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1446
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_misc_test_select_1447
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1448
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1449
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1450
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_misc_test_select_1451
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1452
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1453
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_misc_test_select_1454
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1455
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1456
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_misc_test_select_1457
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1458
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1459
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 4.0), (4, 4.0), (5, 5.0), (6, 5.0), (7, 7.0), (8, 9.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
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

-- Tag: window_functions_window_functions_misc_test_select_1460
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1461
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1462
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1463
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1464
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1465
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1466
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1467
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1468
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1469
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1470
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1471
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1472
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1473
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1474
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1475
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1476
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1477
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1478
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1479
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1480
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1481
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1482
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1483
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1484
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1485
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
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

-- Tag: window_functions_window_functions_misc_test_select_1486
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1487
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1488
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1489
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1490
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1491
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1492
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1493
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1494
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1495
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1496
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1497
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1498
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1499
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1500
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1501
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1502
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1503
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1504
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1505
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1506
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1507
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1508
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1509
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1510
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1511
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1512
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1513
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1514
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1515
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1516
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1517
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1518
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1519
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1520
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1521
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1522
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1523
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1524
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1525
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1526
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1527
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1528
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1529
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1530
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1531
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1532
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1533
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1534
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1535
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1536
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1537
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1538
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1539
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1540
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1541
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1542
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1543
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1544
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1545
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1546
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1547
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1548
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1549
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1550
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1551
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1552
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1553
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1554
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1555
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1556
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1557
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_misc_test_select_1558
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1559
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1560
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1561
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1562
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1563
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_misc_test_select_1564
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64 DEFAULT 0);
INSERT INTO counters (id) VALUES (1);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_misc_test_select_1565
SELECT id, count FROM counters;
-- Tag: window_functions_window_functions_misc_test_select_1566
SELECT status FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1567
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_misc_test_select_1568
SELECT error FROM logs;
-- Tag: window_functions_window_functions_misc_test_select_1569
SELECT discount FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1570
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_misc_test_select_1571
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_misc_test_select_1572
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_misc_test_select_1573
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_misc_test_select_1574
SELECT * FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1575
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_misc_test_select_1576
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1577
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1578
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, status STRING DEFAULT 'active');
INSERT INTO users (id, name) VALUES (1, 'Alice');
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

-- Tag: window_functions_window_functions_misc_test_select_1579
SELECT status FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1580
SELECT value FROM settings WHERE key = 'key1';
-- Tag: window_functions_window_functions_misc_test_select_1581
SELECT error FROM logs;
-- Tag: window_functions_window_functions_misc_test_select_1582
SELECT discount FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1583
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_misc_test_select_1584
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_misc_test_select_1585
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_misc_test_select_1586
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_misc_test_select_1587
SELECT * FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1588
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_misc_test_select_1589
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1590
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1591
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_misc_test_select_1592
SELECT discount FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1593
SELECT enabled FROM features;
-- Tag: window_functions_window_functions_misc_test_select_1594
SELECT status, priority, archived FROM records;
-- Tag: window_functions_window_functions_misc_test_select_1595
SELECT created_at FROM events;
-- Tag: window_functions_window_functions_misc_test_select_1596
SELECT log_date FROM daily_logs;
-- Tag: window_functions_window_functions_misc_test_select_1597
SELECT * FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1598
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_misc_test_select_1599
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1600
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1601
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_misc_test_select_1602
SELECT * FROM users;
-- Tag: window_functions_window_functions_misc_test_select_1603
SELECT * FROM accounts;
-- Tag: window_functions_window_functions_misc_test_select_1604
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1605
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1606
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_misc_test_select_1607
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1608
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1609
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_misc_test_select_1610
SELECT price FROM products;
-- Tag: window_functions_window_functions_misc_test_select_1611
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1612
SELECT COUNT(*) FROM numbers;

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

-- Tag: window_functions_window_functions_misc_test_select_1613
SELECT price, stock FROM products WHERE id = 2;
UPDATE users SET email = 'alice@example.com' WHERE id = 2;
UPDATE users SET email = NULL WHERE id = 1;
UPDATE users SET email = 'robert@example.com' WHERE id = 2;
-- Tag: window_functions_window_functions_misc_test_select_1614
SELECT COUNT(*) FROM numbers;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
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

-- Tag: window_functions_window_functions_misc_test_select_1615
SELECT i + f as sum FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1616
SELECT id FROM data WHERE i = f ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1617
SELECT i * f as product FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1618
SELECT a + CAST(b AS INT64) as sum FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1619
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1620
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1621
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1622
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1623
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1624
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1625
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1626
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1627
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1628
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
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

-- Tag: window_functions_window_functions_misc_test_select_1629
SELECT i * f as product FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1630
SELECT a + CAST(b AS INT64) as sum FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1631
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1632
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1633
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1634
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
-- Tag: window_functions_window_functions_misc_test_select_1635
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1636
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1637
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1638
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1639
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1640
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_misc_test_select_1641
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1642
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1643
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1644
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_misc_test_select_1645
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1646
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1647
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1648
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1649
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1650
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1651
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_misc_test_select_1652
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1653
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_1654
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1655
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1656
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_misc_test_select_1657
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1658
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_1659
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_misc_test_select_1660
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1661
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 80), ('D', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 75), ('C', 80), ('D', 85), ('E', 90), ('F', 95), ('G', 97), ('H', 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, month INT64, revenue INT64);
INSERT INTO sales VALUES ('A', 1, 100), ('A', 2, 150), ('B', 1, 200), ('B', 2, 250);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, month INT64, revenue INT64);
INSERT INTO sales VALUES ('A', 1, 100), ('A', 2, 150), ('B', 1, 200), ('B', 2, 250);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, month INT64, revenue INT64);
INSERT INTO sales VALUES ('A', 1, 100), ('A', 2, 150), ('B', 1, 200), ('B', 2, 250);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 95), ('Dave', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180), (5, 200);
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

-- Tag: window_functions_window_functions_misc_test_select_1662
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_misc_test_select_1663
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_misc_test_select_1664
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_misc_test_select_1665
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1666
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1667
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1668
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1669
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_misc_test_select_1670
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1671
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1672
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1673
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1674
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1675
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_misc_test_select_1676
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_misc_test_select_1677
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1678
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1679
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1680
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1681
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1682
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1683
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1684
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_misc_test_select_050
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1685
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_misc_test_select_051
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_052
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_misc_test_select_1686
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1687
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1688
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1689
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1690
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1691
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1692
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1693
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1694
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64, amount INT64);
INSERT INTO data VALUES (10, 100), (20, 200), (20, 300), (30, 400);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 95), ('Dave', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180), (5, 200);
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

-- Tag: window_functions_window_functions_misc_test_select_1695
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1696
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1697
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1698
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1699
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1700
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1701
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1702
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_misc_test_select_053
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_1703
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_misc_test_select_054
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_055
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_misc_test_select_1704
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1705
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1706
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1707
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1708
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1709
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1710
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1711
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1712
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180), (5, 200);
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

-- Tag: window_functions_window_functions_misc_test_select_056
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_misc_test_select_057
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_misc_test_select_1713
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1714
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1715
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1716
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1717
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1718
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1719
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1720
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1721
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_1722
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1723
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1724
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1725
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1726
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1727
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1728
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1729
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1730
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_misc_test_select_1731
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_misc_test_select_1732
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1733
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1734
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_misc_test_select_1735
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1736
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1737
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1738
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES
(1, 10), (2, 20), (3, 30), (4, 40), (5, 50), (6, 60), (7, 70), (8, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5), (6), (7);
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

-- Tag: window_functions_window_functions_misc_test_select_1739
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1740
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1741
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1742
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1743
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1744
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1745
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_misc_test_select_1746
SELECT * FROM (
-- Tag: window_functions_window_functions_misc_test_select_1747
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_misc_test_select_1748
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_misc_test_select_1749
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_misc_test_select_1750
SELECT * FROM (
-- Tag: window_functions_window_functions_misc_test_select_1751
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_misc_test_select_1752
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
INSERT INTO data VALUES (40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES (NULL, 1);
INSERT INTO data VALUES (NULL, 2);
INSERT INTO data VALUES ('A', 3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (region STRING, dept STRING, value INT64);
INSERT INTO data VALUES ('East', 'Sales', 100);
INSERT INTO data VALUES ('East', 'Sales', 200);
INSERT INTO data VALUES ('East', 'Eng', 150);
INSERT INTO data VALUES ('West', 'Sales', 120);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
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

-- Tag: window_functions_window_functions_misc_test_select_1753
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1754
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1755
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1756
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1757
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1758
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1759
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1760
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1761
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1762
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1763
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1764
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1765
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_1766
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1767
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1768
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_misc_test_select_1769
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_misc_test_select_1770
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (10);
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

-- Tag: window_functions_window_functions_misc_test_select_1771
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1772
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1773
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1774
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_misc_test_select_1775
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1776
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1777
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_misc_test_select_1778
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_misc_test_select_1779
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_misc_test_select_1780
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1781
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_misc_test_select_1782
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_misc_test_select_1783
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_misc_test_select_1784
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_misc_test_select_1785
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_misc_test_select_1786
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_misc_test_select_1787
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_misc_test_select_1788
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50), (6, 60);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300), (4, 400);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_misc_test_select_1789
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1790
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1791
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1792
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1793
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1794
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1795
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1796
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1797
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1798
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1799
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1800
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1801
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1802
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1803
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1804
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1805
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1806
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1807
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1808
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_misc_test_select_1809
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1810
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50), (6, 60);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30), (4, 'B', 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300), (4, 400);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_misc_test_select_1811
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1812
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_misc_test_select_1813
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1814
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1815
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1816
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1817
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1818
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1819
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1820
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1821
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1822
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1823
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1824
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1825
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1826
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1827
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1828
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1829
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_misc_test_select_1830
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1831
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 100), (2, 200), (3, 300), (4, 400);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, score INT64, value INT64);
INSERT INTO test VALUES (1, 10, 1), (2, 10, 2), (3, 20, 3);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_misc_test_select_1832
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1833
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1834
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1835
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1836
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1837
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1838
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_misc_test_select_1839
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1840
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value INT64);
INSERT INTO test VALUES (1, 'A', 100);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);

-- Tag: window_functions_window_functions_misc_test_select_1841
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_misc_test_select_1842
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1843
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_misc_test_select_1844
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_misc_test_select_1845
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES \
(1, 'East', 100), (2, 'East', 150), \
(3, 'West', 120), (4, 'West', 180);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);

-- Tag: window_functions_window_functions_misc_test_select_1846
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_misc_test_select_1847
SELECT * FROM ( \
-- Tag: window_functions_window_functions_misc_test_select_1848
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_misc_test_select_1849
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1850
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1851
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1852
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1853
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);

-- Tag: window_functions_window_functions_misc_test_select_1854
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1855
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_misc_test_select_1856
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);

-- Tag: window_functions_window_functions_misc_test_select_1857
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
