-- Window Functions Ranking - SQL:2023
-- Description: Window ranking functions: ROW_NUMBER, RANK, DENSE_RANK, NTILE
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_ranking_test_select_001
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank FROM same_scores;
-- Tag: window_functions_window_functions_ranking_test_select_002
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_003
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_004
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_005
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_ranking_test_select_006
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_ranking_test_select_007
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_ranking_test_select_008
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_ranking_test_select_009
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_ranking_test_select_010
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_ranking_test_select_011
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_ranking_test_select_012
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_ranking_test_select_013
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_ranking_test_select_014
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_ranking_test_select_015
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_ranking_test_select_016
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_ranking_test_select_017
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_ranking_test_select_018
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_ranking_test_select_019
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_ranking_test_select_020
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_ranking_test_select_021
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_022
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_ranking_test_select_023
SELECT score, RANK() OVER (ORDER BY score DESC) as r,
DENSE_RANK() OVER (ORDER BY score DESC) as dr
FROM rankings
ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_024
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_025
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_026
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_ranking_test_select_027
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_ranking_test_select_028
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_ranking_test_select_029
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_ranking_test_select_030
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_ranking_test_select_031
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_ranking_test_select_032
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_ranking_test_select_033
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_ranking_test_select_034
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_ranking_test_select_035
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_ranking_test_select_036
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_ranking_test_select_037
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_ranking_test_select_038
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_ranking_test_select_039
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_ranking_test_select_040
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_ranking_test_select_041
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_ranking_test_select_042
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_043
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_ranking_test_select_044
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_001
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_045
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_046
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_047
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_048
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_049
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_050
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_051
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_052
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_053
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_054
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_055
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_056
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_057
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_058
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_059
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_060
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_061
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_062
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_063
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_064
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_065
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_066
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_067
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_068
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_069
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_002
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_003
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_004
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_070
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_071
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_072
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_073
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_005
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_074
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_075
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_076
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_077
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_078
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_006
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_079
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_080
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_081
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_082
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_083
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_084
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_085
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_086
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_087
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_088
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_089
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_090
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_091
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_092
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_093
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_094
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_095
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_096
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_097
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_098
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_099
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_100
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_101
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_102
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_103
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_007
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_008
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_009
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_104
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_105
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_106
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_107
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_010
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_108
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_109
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_110
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_111
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_112
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_113
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_114
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_115
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_116
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_117
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_118
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_119
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_120
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_121
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_122
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_123
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_124
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_125
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_126
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_127
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_128
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_129
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_130
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_131
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_132
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_133
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_134
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_135
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_136
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_137
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_011
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_012
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_013
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_138
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_139
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_140
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_141
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_014
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_142
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_143
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_144
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_145
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_146
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_147
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_148
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_149
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_150
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_151
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_152
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_153
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_154
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_155
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_156
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_157
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_158
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_159
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_160
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_161
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_162
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_163
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_164
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_165
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_166
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_167
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_168
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_169
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_170
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_015
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_016
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_017
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_171
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_172
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_173
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_174
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_018
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_175
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_176
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_177
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_178
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_179
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_180
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_181
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_182
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_183
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_184
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_185
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_186
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_187
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_188
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_189
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_190
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_191
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_192
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_193
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_194
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_195
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_196
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_197
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_198
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_199
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_200
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_ranking_test_select_201
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_202
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_019
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_020
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_021
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_203
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_204
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_205
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_206
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_022
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_207
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_208
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_209
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_210
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_211
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_212
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_ranking_test_select_023
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_024
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_ranking_test_select_025
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_213
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_214
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_215
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_216
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_026
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_217
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_218
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_219
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_220
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_221
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_027
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_ranking_test_select_222
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_223
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_224
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_225
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_028
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_226
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_227
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_228
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_ranking_test_select_229
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_230
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_ranking_test_select_231
SELECT *, RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_232
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

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

-- Tag: window_functions_window_functions_ranking_test_select_233
SELECT product, amount, ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_234
SELECT region, product, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_235
SELECT c.name, c.region, o.total
FROM customers c
JOIN (
-- Tag: window_functions_window_functions_ranking_test_select_236
SELECT customer_id, SUM(amount) as total
FROM orders
GROUP BY customer_id
) o ON c.id = o.customer_id
WHERE o.total > 150;
-- Tag: window_functions_window_functions_ranking_test_select_237
SELECT * FROM products WHERE category IN ('Electronics', 'Appliances');
-- Tag: window_functions_window_functions_ranking_test_select_238
SELECT * FROM users WHERE status NOT IN ('inactive', 'banned');
-- Tag: window_functions_window_functions_ranking_test_select_239
SELECT * FROM products WHERE price BETWEEN 20.0 AND 60.0;
-- Tag: window_functions_window_functions_ranking_test_select_240
SELECT * FROM users WHERE name LIKE 'Al%';
-- Tag: window_functions_window_functions_ranking_test_select_241
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: window_functions_window_functions_ranking_test_select_242
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

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

-- Tag: window_functions_window_functions_ranking_test_select_243
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_244
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_245
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_ranking_test_select_246
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_ranking_test_select_247
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_ranking_test_select_248
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_249
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_ranking_test_select_250
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_251
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_252
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_253
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_254
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_255
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_256
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_257
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_258
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_259
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_ranking_test_select_260
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_ranking_test_select_261
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_262
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_263
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_ranking_test_select_264
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_265
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_ranking_test_select_266
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_ranking_test_select_267
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_ranking_test_select_268
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_269
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_ranking_test_select_270
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_271
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_272
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_273
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_274
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_275
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_276
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_277
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_278
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_279
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_ranking_test_select_280
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_ranking_test_select_281
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_282
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_283
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_ranking_test_select_284
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_ranking_test_select_285
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_286
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_ranking_test_select_287
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_288
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_289
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_290
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_291
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_292
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_ranking_test_select_293
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_294
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_295
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_296
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_ranking_test_select_297
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_ranking_test_select_298
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_299
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_300
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_ranking_test_select_301
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_302
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_303
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_304
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_305
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_306
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_307
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_308
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_309
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_310
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_311
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_312
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_313
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_314
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_315
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_316
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_317
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_318
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_ranking_test_select_319
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_ranking_test_select_320
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_321
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_322
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_323
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_324
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_325
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_326
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_327
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_328
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_329
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_330
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_331
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_332
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_333
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_334
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_335
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_336
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_ranking_test_select_337
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_ranking_test_select_338
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_339
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_340
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_341
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_342
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_343
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_344
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_345
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_346
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_347
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_348
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_349
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_350
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_351
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_352
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_353
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_ranking_test_select_354
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_ranking_test_select_355
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_356
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_357
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_358
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_359
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_360
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_361
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_362
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_363
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_364
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_365
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_366
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_367
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_368
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_369
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_ranking_test_select_370
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_ranking_test_select_371
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_372
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_373
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_374
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_375
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_376
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_377
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_378
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_379
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_380
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_381
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_ranking_test_select_382
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_383
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_384
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_ranking_test_select_385
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, salary INT64);
INSERT INTO employees VALUES (1, 'Alice', 50000);
INSERT INTO employees VALUES (2, 'Bob', 60000);
INSERT INTO employees VALUES (3, 'Charlie', 55000);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
INSERT INTO sales VALUES ('South', 250);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
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

-- Tag: window_functions_window_functions_ranking_test_select_386
SELECT name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) as rank
FROM employees;
-- Tag: window_functions_window_functions_ranking_test_select_387
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_388
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_389
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_390
SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_391
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_392
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_393
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_394
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_395
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_396
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_397
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_398
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_ranking_test_select_399
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_400
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_401
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_402
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_403
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_404
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_405
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_406
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_407
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
INSERT INTO sales VALUES ('South', 250);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
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

-- Tag: window_functions_window_functions_ranking_test_select_408
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) as rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_409
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_410
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_411
SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_412
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_413
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_414
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_415
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_416
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_417
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_418
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_419
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_ranking_test_select_420
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_421
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_422
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_423
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_424
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_425
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_426
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_427
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_428
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
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

-- Tag: window_functions_window_functions_ranking_test_select_429
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_430
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_431
SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_432
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_433
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_434
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_435
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_436
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_437
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_438
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_439
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_ranking_test_select_440
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_441
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_442
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_443
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_444
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_445
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_446
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_447
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_448
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, revenue INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);
INSERT INTO sales VALUES (3, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
INSERT INTO sales VALUES ('South', 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('North', 100);
INSERT INTO sales VALUES ('North', 200);
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

-- Tag: window_functions_window_functions_ranking_test_select_449
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_450
SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_451
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_452
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_453
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_454
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_455
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_456
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_457
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_458
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_ranking_test_select_459
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_460
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_461
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_462
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_463
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_464
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_465
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_466
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_467
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_468
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_469
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_470
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_471
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_472
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_473
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_474
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_475
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_476
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_477
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_478
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_ranking_test_select_479
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_480
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85);
INSERT INTO scores VALUES ('Eng', 'Carol', 95), ('Eng', 'Dave', 95);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 90), ('Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 100), ('B', 90), ('C', 90), ('D', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_481
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_482
SELECT dept, name, score, RANK() OVER (PARTITION BY dept ORDER BY score DESC) AS rank
FROM scores
ORDER BY dept, rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_483
SELECT name, RANK() OVER (ORDER BY score DESC) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_484
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_029
SELECT
name,
RANK() OVER (ORDER BY score DESC) AS rank,
DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
FROM scores
ORDER BY score DESC, name;
-- Tag: window_functions_window_functions_ranking_test_select_485
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_486
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_487
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_488
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_489
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_490
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_491
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_492
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_493
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_494
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_495
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_496
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_497
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_498
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_499
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_500
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_501
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_502
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_503
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_504
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_505
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_506
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_507
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_508
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_509
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_510
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_511
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_030
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_512
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_031
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_032
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_513
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_514
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_515
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_516
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_517
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_518
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_519
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_520
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_521
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85);
INSERT INTO scores VALUES ('Eng', 'Carol', 95), ('Eng', 'Dave', 95);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 90), ('Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 100), ('B', 90), ('C', 90), ('D', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_522
SELECT dept, name, score, RANK() OVER (PARTITION BY dept ORDER BY score DESC) AS rank
FROM scores
ORDER BY dept, rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_523
SELECT name, RANK() OVER (ORDER BY score DESC) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_524
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_033
SELECT
name,
RANK() OVER (ORDER BY score DESC) AS rank,
DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
FROM scores
ORDER BY score DESC, name;
-- Tag: window_functions_window_functions_ranking_test_select_525
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_526
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_527
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_528
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_529
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_530
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_531
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_532
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_533
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_534
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_535
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_536
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_537
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_538
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_539
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_540
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_541
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_542
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_543
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_544
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_545
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_546
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_547
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_548
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_549
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_550
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_551
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_034
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_552
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_035
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_036
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_553
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_554
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_555
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_556
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_557
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_558
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_559
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_560
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_561
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 90), ('Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 100), ('B', 90), ('C', 90), ('D', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_562
SELECT name, RANK() OVER (ORDER BY score DESC) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_563
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_037
SELECT
name,
RANK() OVER (ORDER BY score DESC) AS rank,
DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
FROM scores
ORDER BY score DESC, name;
-- Tag: window_functions_window_functions_ranking_test_select_564
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_565
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_566
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_567
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_568
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_569
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_570
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_571
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_572
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_573
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_574
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_575
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_576
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_577
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_578
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_579
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_580
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_581
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_582
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_583
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_584
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_585
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_586
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_587
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_588
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_589
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_590
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_038
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_591
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_039
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_040
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_592
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_593
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_594
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_595
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_596
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_597
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_598
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_599
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_600
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 100), ('B', 90), ('C', 90), ('D', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_601
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_041
SELECT
name,
RANK() OVER (ORDER BY score DESC) AS rank,
DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
FROM scores
ORDER BY score DESC, name;
-- Tag: window_functions_window_functions_ranking_test_select_602
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_603
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_604
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_605
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_606
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_607
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_608
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_609
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_610
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_611
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_612
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_613
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_614
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_615
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_616
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_617
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_618
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_619
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_620
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_621
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_622
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_623
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_624
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_625
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_626
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_627
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_628
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_042
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_629
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_043
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_044
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_630
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_631
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_632
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_633
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_634
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_635
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_636
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_637
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_638
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 100), ('B', 90), ('C', 90), ('D', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_045
SELECT
name,
RANK() OVER (ORDER BY score DESC) AS rank,
DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
FROM scores
ORDER BY score DESC, name;
-- Tag: window_functions_window_functions_ranking_test_select_639
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_640
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_641
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_642
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_643
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_644
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_645
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_646
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_647
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_648
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_649
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_650
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_651
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_652
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_653
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_654
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_655
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_656
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_657
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_658
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_659
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_660
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_661
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_662
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_663
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_664
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_665
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_046
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_666
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_047
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_048
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_667
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_668
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_669
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_670
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_671
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_672
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_673
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_674
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_675
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 90), ('Bob', 85), ('Carol', 90), ('Dave', 80);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_676
SELECT name, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_677
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_678
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_679
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_680
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_681
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_682
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_683
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_684
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_685
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_686
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_687
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_688
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_689
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_690
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_691
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_692
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_693
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_694
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_695
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_696
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_697
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_698
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_699
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_700
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_701
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_702
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_049
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_703
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_050
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_051
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_704
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_705
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_706
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_707
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_708
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_709
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_710
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_711
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_712
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (dept STRING, name STRING, score INT64);
INSERT INTO scores VALUES ('Sales', 'Alice', 90), ('Sales', 'Bob', 85), ('Sales', 'Carol', 95);
INSERT INTO scores VALUES ('Eng', 'Dave', 80), ('Eng', 'Eve', 85);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_713
SELECT dept, name, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY score DESC) AS row_num
FROM scores
ORDER BY dept, row_num;
-- Tag: window_functions_window_functions_ranking_test_select_714
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_715
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_716
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_717
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_718
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_719
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_720
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_721
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_722
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_723
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_724
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_725
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_726
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_727
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_728
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_729
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_730
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_731
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_732
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_733
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_734
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_735
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_736
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_737
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_738
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_052
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_739
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_053
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_054
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_740
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_741
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_742
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_743
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_744
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_745
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_746
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_747
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_748
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_749
SELECT value, ROW_NUMBER() OVER () AS row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_750
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_751
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_752
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_753
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_754
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_755
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_756
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_757
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_758
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_759
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_760
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_761
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_762
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_763
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_764
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_765
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_766
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_767
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_768
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_769
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_770
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_771
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_772
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_773
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_055
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_774
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_056
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_057
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_775
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_776
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_777
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_778
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_779
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_780
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_781
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_782
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_783
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('A', 70), ('B', 80), ('C', 90), ('D', 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_784
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_785
SELECT name, score, CUME_DIST() OVER (ORDER BY score) AS cume_dist FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_786
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_787
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_788
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_789
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_790
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_791
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_792
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_793
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_794
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_795
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_796
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_797
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_798
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_799
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_800
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_801
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_802
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_803
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_804
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_805
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_806
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_807
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_058
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_808
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_059
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_060
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_809
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_810
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_811
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_812
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_813
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_814
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_815
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_816
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_817
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_818
SELECT name, score, PERCENT_RANK() OVER (ORDER BY score) AS pct_rank FROM scores ORDER BY score, name;
-- Tag: window_functions_window_functions_ranking_test_select_819
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_820
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_821
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_822
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_823
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_824
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_825
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_826
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_827
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_828
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_829
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_830
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_831
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_832
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_833
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_834
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_835
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_836
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_837
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_838
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_839
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_061
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_840
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_062
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_063
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_841
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_842
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_843
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_844
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_845
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_846
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_847
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_848
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_849
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_850
SELECT name, score, NTILE(4) OVER (ORDER BY score) AS quartile FROM scores ORDER BY score;
-- Tag: window_functions_window_functions_ranking_test_select_851
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_852
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_853
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_854
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_855
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_856
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_857
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_858
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_859
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_860
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_861
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_862
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_863
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_864
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_865
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_866
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_867
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_868
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_869
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_870
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_064
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_871
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_065
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_066
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_872
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_873
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_874
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_875
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_876
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_877
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_878
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_879
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_880
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_881
SELECT value, NTILE(3) OVER (ORDER BY value) AS bucket FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_882
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_883
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_884
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_885
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_886
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_887
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_888
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_889
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_890
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_891
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_892
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_ranking_test_select_893
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_894
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_895
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_896
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_897
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_898
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_899
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_900
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_ranking_test_select_067
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_901
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_068
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_ranking_test_select_069
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_902
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_903
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_904
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_905
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_906
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_907
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_908
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_909
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_910
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_911
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_912
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_913
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_914
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_915
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);

-- Tag: window_functions_window_functions_ranking_test_select_916
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_917
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_918
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, salesperson STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'Alice', 1000),
('East', 'Bob', 1200),
('West', 'Carol', 900),
('West', 'Dave', 1100),
('East', 'Eve', 1200);
DROP TABLE IF EXISTS uniform;
CREATE TABLE uniform (id INT64, value INT64);
INSERT INTO uniform VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, NULL), (3, 200), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_919
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_920
SELECT region, salesperson, amount,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank
FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_921
SELECT id, value, RANK() OVER (ORDER BY value) as rank FROM uniform;
-- Tag: window_functions_window_functions_ranking_test_select_922
SELECT id, value, RANK() OVER (ORDER BY value DESC) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_923
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_924
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_925
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_926
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_927
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_928
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_929
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_930
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_931
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_932
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_933
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_934
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_935
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_936
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_937
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_938
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_939
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_940
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_941
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_942
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_943
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_944
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_945
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_946
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, salesperson STRING, amount INT64);
INSERT INTO sales VALUES
('East', 'Alice', 1000),
('East', 'Bob', 1200),
('West', 'Carol', 900),
('West', 'Dave', 1100),
('East', 'Eve', 1200);
DROP TABLE IF EXISTS uniform;
CREATE TABLE uniform (id INT64, value INT64);
INSERT INTO uniform VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, NULL), (3, 200), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_947
SELECT region, salesperson, amount,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank
FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_948
SELECT id, value, RANK() OVER (ORDER BY value) as rank FROM uniform;
-- Tag: window_functions_window_functions_ranking_test_select_949
SELECT id, value, RANK() OVER (ORDER BY value DESC) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_950
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_951
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_952
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_953
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_954
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_955
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_956
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_957
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_958
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_959
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_960
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_961
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_962
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_963
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_964
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_965
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_966
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_967
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_968
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_969
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_970
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_971
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_972
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_973
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS uniform;
CREATE TABLE uniform (id INT64, value INT64);
INSERT INTO uniform VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, NULL), (3, 200), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_974
SELECT id, value, RANK() OVER (ORDER BY value) as rank FROM uniform;
-- Tag: window_functions_window_functions_ranking_test_select_975
SELECT id, value, RANK() OVER (ORDER BY value DESC) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_976
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_977
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_978
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_979
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_980
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_981
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_982
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_983
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_984
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_985
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_986
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_987
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_988
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_989
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_990
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_991
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_992
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_993
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_994
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_995
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_996
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_997
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_998
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_999
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, NULL), (3, 200), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_1000
SELECT id, value, RANK() OVER (ORDER BY value DESC) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1001
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1002
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1003
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1004
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1005
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1006
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1007
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_1008
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1009
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1010
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_1011
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1012
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1013
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1014
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1015
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1016
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1017
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1018
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1019
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1020
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1021
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1022
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1023
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1024
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES
(1, 'Alice', 95),
(2, 'Bob', 90),
(3, 'Carol', 90),
(4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_1025
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1026
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1027
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1028
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1029
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1030
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1031
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_1032
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1033
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1034
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_1035
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1036
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1037
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1038
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1039
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1040
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1041
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1042
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1043
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1044
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1045
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1046
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1047
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1048
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (score INT64);
INSERT INTO scores VALUES (100), (90), (90), (80), (80), (80), (70);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300), (4, 400), (5, 500);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (month INT64, region STRING, amount INT64);
INSERT INTO sales VALUES
(1, 'East', 1000), (2, 'East', 1100), (3, 'East', 1200),
(1, 'West', 900), (2, 'West', 950), (3, 'West', 1000);
DROP TABLE IF EXISTS small;
CREATE TABLE small (id INT64, value INT64);
INSERT INTO small VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sequence;
CREATE TABLE sequence (id INT64, value INT64);
INSERT INTO sequence VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 300);
DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (id INT64, event STRING, timestamp INT64);
INSERT INTO timeline VALUES
(1, 'Login', 100), (2, 'View', 110), (3, 'Purchase', 120), (4, 'Logout', 130);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (quarter INT64, revenue INT64);
INSERT INTO sales VALUES (1, 1000), (2, 1100), (3, 1200), (4, 1300);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, quarter INT64, revenue INT64);
INSERT INTO sales VALUES
('East', 1, 1000), ('East', 2, 1100),
('West', 1, 900), ('West', 2, 950);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_1049
SELECT score,
RANK() OVER (ORDER BY score DESC) as rank,
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1050
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1051
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1052
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1053
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1054
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_ranking_test_select_1055
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1056
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1057
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_ranking_test_select_1058
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1059
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1060
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_ranking_test_select_1061
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1062
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1063
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1064
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1065
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1066
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1067
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1068
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1069
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1070
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1071
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 80), (2, 90), (3, 90), (4, 100);
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

-- Tag: window_functions_window_functions_ranking_test_select_1072
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1073
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1074
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1075
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1076
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1077
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1078
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1079
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1080
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1081
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1082
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_ranking_test_select_1083
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1084
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1085
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1086
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1087
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1088
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1089
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1090
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1091
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_ranking_test_select_1092
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1093
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1094
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1095
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1096
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1097
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1098
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1099
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_ranking_test_select_1100
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1101
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_ranking_test_select_1102
SELECT * FROM (
-- Tag: window_functions_window_functions_ranking_test_select_1103
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1104
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'A');
INSERT INTO data VALUES (2, 'B');
INSERT INTO data VALUES (3, 'C');
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (8);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 100.0);
INSERT INTO sales VALUES ('East', 200.0);
INSERT INTO sales VALUES ('West', 150.0);
INSERT INTO sales VALUES ('West', 250.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1105
SELECT id, ROW_NUMBER() OVER (ORDER BY id) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1106
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1107
SELECT value, ROW_NUMBER() OVER () as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1108
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1109
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1110
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1111
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1112
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1113
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1114
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1115
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1116
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1117
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1118
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1119
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1120
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1121
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1122
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1123
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1124
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1125
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1126
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1127
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1128
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1129
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1130
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1131
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1132
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1133
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1134
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1135
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1136
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1137
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1138
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1139
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1140
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1141
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1142
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1143
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1144
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1145
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1146
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 10);
INSERT INTO data VALUES ('A', 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (8);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 100.0);
INSERT INTO sales VALUES ('East', 200.0);
INSERT INTO sales VALUES ('West', 150.0);
INSERT INTO sales VALUES ('West', 250.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1147
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1148
SELECT value, ROW_NUMBER() OVER () as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1149
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1150
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1151
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1152
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1153
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1154
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1155
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1156
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1157
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1158
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1159
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1160
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1161
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1162
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1163
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1164
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1165
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1166
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1167
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1168
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1169
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1170
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1171
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1172
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1173
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1174
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1175
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1176
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1177
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1178
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1179
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1180
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1181
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1182
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1183
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1184
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1185
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1186
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1187
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (8);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 100.0);
INSERT INTO sales VALUES ('East', 200.0);
INSERT INTO sales VALUES ('West', 150.0);
INSERT INTO sales VALUES ('West', 250.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1188
SELECT value, ROW_NUMBER() OVER () as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1189
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1190
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1191
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1192
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1193
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1194
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1195
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1196
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1197
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1198
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1199
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1200
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1201
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1202
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1203
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1204
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1205
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1206
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1207
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1208
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1209
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1210
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1211
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1212
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1213
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1214
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1215
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1216
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1217
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1218
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1219
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1220
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1221
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1222
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1223
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1224
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1225
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1226
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1227
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount FLOAT64);
INSERT INTO sales VALUES ('East', 100.0);
INSERT INTO sales VALUES ('East', 200.0);
INSERT INTO sales VALUES ('West', 150.0);
INSERT INTO sales VALUES ('West', 250.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1228
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1229
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1230
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1231
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1232
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1233
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1234
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1235
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1236
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1237
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1238
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1239
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1240
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1241
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1242
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1243
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1244
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1245
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1246
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1247
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1248
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1249
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1250
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1251
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1252
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1253
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1254
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1255
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1256
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1257
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1258
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1259
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1260
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1261
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1262
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1263
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1264
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1265
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1266
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1267
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1268
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1269
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1270
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1271
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1272
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1273
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1274
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1275
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1276
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1277
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1278
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1279
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1280
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1281
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1282
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1283
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1284
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1285
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1286
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1287
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1288
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1289
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1290
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1291
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1292
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1293
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1294
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1295
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1296
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1297
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1298
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1299
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1300
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1301
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1302
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1303
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1304
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (name STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 100);
INSERT INTO scores VALUES ('Bob', 90);
INSERT INTO scores VALUES ('Charlie', 90);
INSERT INTO scores VALUES ('David', 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1305
SELECT name, score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1306
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1307
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1308
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1309
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1310
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1311
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1312
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1313
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1314
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1315
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1316
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1317
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1318
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1319
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1320
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1321
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1322
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1323
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1324
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1325
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1326
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1327
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1328
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1329
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1330
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1331
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1332
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1333
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1334
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1335
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1336
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1337
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1338
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1339
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1340
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1341
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1342
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1343
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1344
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1345
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1346
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1347
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1348
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1349
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1350
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1351
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1352
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1353
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1354
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1355
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1356
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1357
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1358
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1359
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1360
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1361
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1362
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1363
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1364
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1365
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1366
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1367
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1368
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1369
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1370
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1371
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1372
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1373
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1374
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1375
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1376
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1377
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1378
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1379
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1380
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1381
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1382
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1383
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1384
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1385
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1386
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1387
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1388
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1389
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1390
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1391
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1392
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1393
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1394
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1395
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1396
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1397
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1398
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1399
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1400
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1401
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1402
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1403
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1404
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1405
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1406
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1407
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1408
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1409
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1410
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1411
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1412
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1413
SELECT value, DENSE_RANK() OVER (ORDER BY value) as drank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1414
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1415
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1416
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1417
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1418
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1419
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1420
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1421
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1422
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1423
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1424
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1425
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1426
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1427
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1428
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1429
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1430
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1431
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1432
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1433
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1434
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1435
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1436
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1437
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1438
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1439
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1440
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1441
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1442
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1443
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1444
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1445
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1446
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1447
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1448
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1449
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1450
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1451
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1452
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1453
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1454
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1455
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1456
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1457
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1458
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1459
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1460
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1461
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1462
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1463
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1464
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1465
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1466
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1467
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1468
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1469
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1470
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1471
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1472
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1473
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1474
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1475
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1476
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1477
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1478
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1479
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1480
SELECT value, NTILE(3) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1481
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1482
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1483
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1484
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1485
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1486
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1487
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1488
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1489
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1490
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1491
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1492
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1493
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1494
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1495
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1496
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1497
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1498
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1499
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1500
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1501
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1502
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1503
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1504
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1505
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1506
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1507
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1508
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1509
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1510
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1511
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
INSERT INTO data VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1512
SELECT value, NTILE(5) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1513
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1514
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1515
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1516
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1517
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1518
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1519
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1520
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1521
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1522
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1523
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1524
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1525
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1526
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1527
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1528
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1529
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1530
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1531
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1532
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1533
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1534
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1535
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1536
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1537
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1538
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1539
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1540
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1541
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1542
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (category STRING, value INT64);
INSERT INTO data VALUES ('A', 1);
INSERT INTO data VALUES ('A', 2);
INSERT INTO data VALUES ('B', 3);
INSERT INTO data VALUES ('B', 4);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10);
INSERT INTO data VALUES (20);
INSERT INTO data VALUES (30);
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

-- Tag: window_functions_window_functions_ranking_test_select_1543
SELECT value, NTILE(4) OVER (ORDER BY value) as bucket FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1544
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1545
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1546
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1547
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1548
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1549
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1550
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_ranking_test_select_1551
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1552
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1553
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1554
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1555
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1556
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1557
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1558
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1559
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1560
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1561
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1562
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1563
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1564
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1565
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1566
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1567
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_ranking_test_select_1568
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1569
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1570
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_ranking_test_select_1571
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_ranking_test_select_1572
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 87), (3, 'Charlie', 95), (4, 'David', 82);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES (1, 'East', 100), (2, 'East', 150), (3, 'West', 200), (4, 'West', 180);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 20), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 95), (2, 87), (3, 95), (4, 82);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1573
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores ORDER BY rank, name;
-- Tag: window_functions_window_functions_ranking_test_select_1574
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_1575
SELECT RANK() OVER (ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1576
SELECT value, RANK() OVER (ORDER BY value NULLS LAST) AS rank FROM test ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1577
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank;
-- Tag: window_functions_window_functions_ranking_test_select_1578
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1579
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1580
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1581
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1582
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1583
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1584
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1585
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1586
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1587
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1588
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1589
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1590
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1591
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1592
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1593
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1594
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1595
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1596
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1597
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1598
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1599
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1600
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1601
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1602
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES (1, 'East', 100), (2, 'East', 150), (3, 'West', 200), (4, 'West', 180);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 20), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 95), (2, 87), (3, 95), (4, 82);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1603
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_1604
SELECT RANK() OVER (ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1605
SELECT value, RANK() OVER (ORDER BY value NULLS LAST) AS rank FROM test ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1606
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank;
-- Tag: window_functions_window_functions_ranking_test_select_1607
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1608
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1609
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1610
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1611
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1612
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1613
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1614
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1615
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1616
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1617
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1618
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1619
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1620
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1621
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1622
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1623
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1624
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1625
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1626
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1627
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1628
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1629
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1630
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1631
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 20), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 95), (2, 87), (3, 95), (4, 82);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1632
SELECT RANK() OVER (ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1633
SELECT value, RANK() OVER (ORDER BY value NULLS LAST) AS rank FROM test ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1634
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank;
-- Tag: window_functions_window_functions_ranking_test_select_1635
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1636
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1637
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1638
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1639
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1640
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1641
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1642
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1643
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1644
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1645
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1646
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1647
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1648
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1649
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1650
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1651
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1652
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1653
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1654
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1655
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1656
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1657
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1658
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1659
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 20), (4, NULL);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 95), (2, 87), (3, 95), (4, 82);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1660
SELECT value, RANK() OVER (ORDER BY value NULLS LAST) AS rank FROM test ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1661
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank;
-- Tag: window_functions_window_functions_ranking_test_select_1662
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1663
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1664
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1665
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1666
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1667
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1668
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1669
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1670
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1671
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1672
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1673
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1674
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1675
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1676
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1677
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1678
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1679
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1680
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1681
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1682
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1683
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1684
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1685
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1686
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 95), (2, 87), (3, 95), (4, 82);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1687
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank FROM scores ORDER BY dense_rank;
-- Tag: window_functions_window_functions_ranking_test_select_1688
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1689
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1690
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1691
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1692
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1693
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1694
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1695
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1696
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1697
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1698
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1699
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1700
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1701
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1702
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1703
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1704
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1705
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1706
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1707
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1708
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1709
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1710
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1711
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1712
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 10), (3, 20), (4, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1713
SELECT value, RANK() OVER (ORDER BY value) AS rank, DENSE_RANK() OVER (ORDER BY value) AS dense_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1714
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1715
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1716
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1717
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1718
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1719
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1720
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1721
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1722
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1723
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1724
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1725
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1726
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1727
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1728
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1729
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1730
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1731
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1732
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1733
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1734
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1735
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1736
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1737
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1738
SELECT value, PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1739
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1740
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1741
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1742
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1743
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1744
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1745
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1746
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1747
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1748
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1749
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1750
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1751
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1752
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1753
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1754
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1755
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1756
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1757
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1758
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1759
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1760
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1761
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
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

-- Tag: window_functions_window_functions_ranking_test_select_1762
SELECT PERCENT_RANK() OVER (ORDER BY value) AS pct_rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1763
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1764
SELECT value, CUME_DIST() OVER (ORDER BY value) AS cume_dist FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1765
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1766
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1767
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1768
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1769
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1770
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1771
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1772
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1773
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1774
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1775
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1776
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1777
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1778
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1779
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1780
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1781
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1782
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1783
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1784
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_ranking_test_select_1785
SELECT value, NTILE(3) OVER (ORDER BY value) AS quartile FROM test ORDER BY value;
-- Tag: window_functions_window_functions_ranking_test_select_1786
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1787
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1788
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1789
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1790
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1791
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1792
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1793
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1794
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1795
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1796
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1797
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1798
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1799
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1800
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1801
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1802
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1803
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1804
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_ranking_test_select_1805
SELECT NTILE(3) OVER (ORDER BY id) AS bucket FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1806
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1807
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1808
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1809
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1810
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1811
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1812
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1813
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1814
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1815
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1816
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1817
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1818
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1819
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_ranking_test_select_1820
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1821
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_ranking_test_select_1822
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1823
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 87), (3, 'Carol', 92);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, salesperson STRING, amount INT64);
INSERT INTO sales VALUES \
('East', 'Alice', 1000), ('East', 'Bob', 1200), \
('West', 'Carol', 900), ('West', 'Dave', 1100);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', NULL), (3, 'Carol', 90);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 1000);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1824
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1825
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1826
SELECT region, salesperson, amount, \
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank \
FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_1827
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) as rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1828
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1829
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1830
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1831
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1832
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1833
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1834
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1835
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1836
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1837
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1838
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1839
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1840
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1841
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1842
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1843
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1844
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1845
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1846
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1847
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1848
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1849
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1850
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1851
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1852
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_1853
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1854
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1855
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1856
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1857
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1858
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, salesperson STRING, amount INT64);
INSERT INTO sales VALUES \
('East', 'Alice', 1000), ('East', 'Bob', 1200), \
('West', 'Carol', 900), ('West', 'Dave', 1100);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', NULL), (3, 'Carol', 90);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 1000);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1859
SELECT name, score, RANK() OVER (ORDER BY score DESC) as rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1860
SELECT region, salesperson, amount, \
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank \
FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_1861
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) as rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1862
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1863
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1864
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1865
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1866
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1867
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1868
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1869
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1870
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1871
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1872
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1873
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1874
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1875
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1876
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1877
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1878
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1879
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1880
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1881
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1882
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1883
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1884
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1885
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1886
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_1887
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1888
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1889
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1890
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1891
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1892
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, salesperson STRING, amount INT64);
INSERT INTO sales VALUES \
('East', 'Alice', 1000), ('East', 'Bob', 1200), \
('West', 'Carol', 900), ('West', 'Dave', 1100);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', NULL), (3, 'Carol', 90);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 1000);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1893
SELECT region, salesperson, amount, \
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as rank \
FROM sales ORDER BY region, rank;
-- Tag: window_functions_window_functions_ranking_test_select_1894
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) as rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1895
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1896
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1897
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1898
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1899
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1900
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1901
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1902
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1903
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1904
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1905
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1906
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1907
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1908
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1909
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1910
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1911
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1912
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1913
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1914
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1915
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1916
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1917
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1918
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1919
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_1920
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1921
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1922
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1923
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1924
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1925
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', NULL), (3, 'Carol', 90);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 1000);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1926
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) as rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1927
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1928
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1929
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1930
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1931
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1932
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1933
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1934
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1935
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1936
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1937
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1938
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1939
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1940
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1941
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1942
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1943
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1944
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1945
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1946
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1947
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1948
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1949
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1950
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1951
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_1952
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1953
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1954
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1955
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1956
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1957
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 1000);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1958
SELECT region, amount, RANK() OVER (PARTITION BY region ORDER BY amount) as rank FROM sales;
-- Tag: window_functions_window_functions_ranking_test_select_1959
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1960
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1961
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1962
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1963
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1964
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1965
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1966
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1967
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1968
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1969
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1970
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1971
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1972
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1973
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1974
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1975
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1976
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1977
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1978
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1979
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1980
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1981
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1982
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_1983
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_1984
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1985
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1986
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1987
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1988
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 95), (2, 'Bob', 90), (3, 'Carol', 90), (4, 'Dave', 85);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_1989
SELECT name, score, DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1990
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_1991
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_1992
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1993
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_1994
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_1995
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_1996
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1997
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_1998
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_1999
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2000
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2001
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2002
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2003
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2004
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2005
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2006
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2007
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2008
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2009
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2010
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2011
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2012
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2013
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2014
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2015
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2016
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2017
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2018
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, name STRING, score INT64);
INSERT INTO scores VALUES (1, 'Alice', 90), (2, 'Bob', 90), (3, 'Carol', 90);
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_2019
SELECT name, DENSE_RANK() OVER (ORDER BY score) as dense_rank FROM scores;
-- Tag: window_functions_window_functions_ranking_test_select_2020
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2021
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2022
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2023
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_2024
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2025
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2026
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2027
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2028
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2029
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2030
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2031
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2032
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2033
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2034
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2035
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2036
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2037
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2038
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2039
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2040
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2041
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2042
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2043
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2044
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2045
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2046
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2047
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (id INT64, score INT64);
INSERT INTO scores VALUES (1, 100), (2, 90), (3, 90), (4, 80);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_2048
SELECT score, \
RANK() OVER (ORDER BY score DESC) as rank, \
DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank \
FROM scores ORDER BY score DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2049
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2050
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2051
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_2052
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2053
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2054
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2055
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2056
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2057
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2058
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2059
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2060
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2061
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2062
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2063
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2064
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2065
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2066
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2067
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2068
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2069
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2070
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2071
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2072
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2073
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2074
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2075
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_2076
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2077
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2078
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_2079
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2080
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2081
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2082
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2083
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2084
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2085
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2086
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2087
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2088
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2089
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2090
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2091
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2092
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2093
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2094
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2095
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2096
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2097
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2098
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2099
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2100
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2101
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2102
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 10), (3, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_2103
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as row_num FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2104
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_2105
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2106
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2107
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2108
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2109
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2110
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2111
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2112
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2113
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2114
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2115
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2116
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2117
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2118
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2119
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2120
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2121
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2122
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2123
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2124
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2125
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2126
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2127
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2128
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100), ('East', 200), ('West', 150);
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, status STRING);
INSERT INTO events VALUES (1, 'start'), (2, 'running'), (3, 'complete');
DROP TABLE IF EXISTS timeseries;
CREATE TABLE timeseries (id INT64, date STRING, value INT64);
INSERT INTO timeseries VALUES \
(1, '2024-01-01', 100), \
(2, '2024-01-02', 110), \
(3, '2024-01-03', 105);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (date STRING, price FLOAT64);
INSERT INTO prices VALUES \
('2024-01-01', 100.0), \
('2024-01-02', 105.0), \
('2024-01-03', 102.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200), (3, 150);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, month INT64, amount INT64);
INSERT INTO sales VALUES \
('East', 1, 100), ('East', 2, 110), ('East', 3, 105), \
('West', 1, 90), ('West', 2, 95);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100), (2, 150), (3, 120), (4, 180);
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

-- Tag: window_functions_window_functions_ranking_test_select_2129
SELECT region, amount, ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num \
FROM sales ORDER BY region, amount;
-- Tag: window_functions_window_functions_ranking_test_select_2130
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2131
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2132
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2133
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2134
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2135
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2136
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2137
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2138
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_ranking_test_select_2139
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2140
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2141
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_ranking_test_select_2142
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2143
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2144
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_ranking_test_select_2145
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2146
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_ranking_test_select_2147
SELECT * FROM ( \
-- Tag: window_functions_window_functions_ranking_test_select_2148
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_ranking_test_select_2149
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2150
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2151
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2152
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2153
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_ranking_test_select_2154
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2155
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2156
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2157
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_ranking_test_select_2158
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

