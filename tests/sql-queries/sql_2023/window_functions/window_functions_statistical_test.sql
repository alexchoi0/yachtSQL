-- Window Functions Statistical - SQL:2023
-- Description: Statistical window functions: STDDEV, VARIANCE over windows
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_statistical_test_select_001
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_statistical_test_select_002
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_statistical_test_select_003
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_statistical_test_select_004
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_statistical_test_select_005
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_statistical_test_select_006
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_statistical_test_select_007
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_statistical_test_select_008
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_statistical_test_select_009
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_statistical_test_select_010
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_statistical_test_select_011
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_statistical_test_select_012
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_statistical_test_select_013
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_statistical_test_select_014
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_015
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_statistical_test_select_016
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_statistical_test_select_017
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_statistical_test_select_018
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_statistical_test_select_019
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_statistical_test_select_020
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_statistical_test_select_021
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_statistical_test_select_022
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_statistical_test_select_023
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_statistical_test_select_024
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_statistical_test_select_025
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_statistical_test_select_026
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_statistical_test_select_027
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_statistical_test_select_028
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_029
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_statistical_test_select_030
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_statistical_test_select_031
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_statistical_test_select_032
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_statistical_test_select_033
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_statistical_test_select_034
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_statistical_test_select_035
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_statistical_test_select_036
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_statistical_test_select_037
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_statistical_test_select_038
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_statistical_test_select_039
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_statistical_test_select_040
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_statistical_test_select_041
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_042
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_statistical_test_select_043
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_statistical_test_select_044
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_statistical_test_select_045
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_statistical_test_select_046
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_statistical_test_select_047
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_statistical_test_select_048
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_statistical_test_select_049
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_statistical_test_select_050
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_statistical_test_select_051
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_052
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_statistical_test_select_053
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_statistical_test_select_054
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_statistical_test_select_055
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_statistical_test_select_056
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_statistical_test_select_057
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_statistical_test_select_058
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_statistical_test_select_059
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_statistical_test_select_060
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_061
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
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_statistical_test_select_062
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_063
SELECT STDDEV_POP(value) AS stddev_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_064
SELECT STDDEV_SAMP(value) AS stddev_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_065
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_066
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_067
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_068
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_069
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_070
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_071
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_001
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_072
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_073
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_074
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_075
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_076
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_077
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_078
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_079
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_080
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_081
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_082
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_083
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_084
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_085
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_086
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_087
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_088
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_089
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_090
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_091
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_092
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_093
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_094
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_095
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_096
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_002
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_003
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_004
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_097
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_098
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_099
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_100
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_005
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_101
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_102
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_103
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_104
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_105
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_statistical_test_select_106
SELECT STDDEV_POP(value) AS stddev_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_107
SELECT STDDEV_SAMP(value) AS stddev_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_108
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_109
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_110
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_111
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_112
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_113
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_114
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_006
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_115
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_116
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_117
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_118
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_119
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_120
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_121
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_122
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_123
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_124
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_125
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_126
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_127
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_128
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_129
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_130
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_131
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_132
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_133
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_134
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_135
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_136
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_137
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_138
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_139
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_007
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_008
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_009
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_140
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_141
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_142
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_143
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_010
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_144
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_145
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_146
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_147
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_148
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (20), (30), (40), (50);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_statistical_test_select_149
SELECT STDDEV_SAMP(value) AS stddev_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_150
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_151
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_152
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_153
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_154
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_155
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_156
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_011
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_157
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_158
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_159
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_160
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_161
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_162
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_163
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_164
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_165
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_166
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_167
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_168
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_169
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_170
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_171
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_172
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_173
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_174
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_175
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_176
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_177
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_178
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_179
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_180
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_181
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_012
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_013
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_014
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_182
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_183
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_184
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_185
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_015
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_186
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_187
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_188
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_189
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_190
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (42);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_statistical_test_select_191
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_192
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_193
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_194
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_195
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_196
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_197
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_016
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_198
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_199
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_200
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_201
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_202
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_203
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_204
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_205
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_206
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_207
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_208
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_209
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_210
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_211
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_212
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_213
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_214
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_215
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_216
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_217
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_218
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_219
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_220
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_221
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_222
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_017
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_018
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_019
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_223
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_224
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_225
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_226
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_020
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_227
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_228
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_229
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_230
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_231
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value FLOAT64);
INSERT INTO numbers VALUES (10), (NULL), (30), (NULL), (50);
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

-- Tag: window_functions_window_functions_statistical_test_select_232
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_233
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_234
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_235
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_236
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_237
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_021
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_238
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_239
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_240
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_241
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_242
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_243
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_244
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_245
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_246
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_247
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_248
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_249
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_250
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_251
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_252
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_253
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_254
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_255
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_256
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_257
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_258
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_259
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_260
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_261
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_262
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_022
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_023
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_024
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_263
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_264
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_265
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_266
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_025
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_267
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_268
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_269
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_270
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_271
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

-- Tag: window_functions_window_functions_statistical_test_select_272
SELECT VARIANCE(value) AS variance FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_273
SELECT VAR_POP(value) AS var_pop FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_274
SELECT VAR_SAMP(value) AS var_samp FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_275
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_276
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_026
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_277
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_278
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_279
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_280
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_281
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_282
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_283
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_284
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_285
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_286
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_287
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_288
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_289
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_290
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_291
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_292
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_293
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_294
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_295
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_296
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_297
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_298
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_299
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_300
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_301
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_027
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_028
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_029
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_302
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_303
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_304
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_305
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_030
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_306
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_307
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_308
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_309
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_310
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_statistical_test_select_311
SELECT VARIANCE(value) AS var, STDDEV(value) * STDDEV(value) AS stddev_squared FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_312
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_031
SELECT
PERCENTILE_CONT(value, 0.25) AS q1,
PERCENTILE_CONT(value, 0.50) AS q2,
PERCENTILE_CONT(value, 0.75) AS q3
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_313
SELECT PERCENTILE_DISC(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_314
SELECT APPROX_QUANTILES(value, 4) AS quartiles FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_315
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_316
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_317
SELECT MEDIAN(value) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_318
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_319
SELECT MODE(value) AS mode FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_320
SELECT APPROX_TOP_COUNT(category, 2) AS top_categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_321
SELECT APPROX_TOP_SUM(product, amount, 2) AS top_products FROM sales;
-- Tag: window_functions_window_functions_statistical_test_select_322
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_323
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_324
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_325
SELECT COVAR_POP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_326
SELECT COVAR_SAMP(x, y) AS covariance FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_327
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_328
SELECT COUNT(DISTINCT category) AS distinct_count FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_329
SELECT COUNTIF(value > 25) AS count_gt_25 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_330
SELECT COUNTIF(value > 25) AS count FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_331
SELECT ARRAY_AGG(value ORDER BY value) AS sorted_array FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_332
SELECT ARRAY_AGG(value ORDER BY value LIMIT 3) AS top3 FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_333
SELECT ARRAY_AGG(DISTINCT category) AS categories FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_334
SELECT ARRAY_AGG(value IGNORE NULLS) AS non_null_array FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_335
SELECT ARRAY_AGG(value RESPECT NULLS) AS all_values FROM items;
-- Tag: window_functions_window_functions_statistical_test_select_336
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_337
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_032
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_033
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_034
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_338
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_339
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_340
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_341
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_035
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_342
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_343
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_344
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_345
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_346
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_statistical_test_select_347
SELECT category, STDDEV(value) AS stddev FROM measurements GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_348
SELECT student, PERCENTILE_CONT(score, 0.5) AS median_score FROM scores GROUP BY student ORDER BY student;
-- Tag: window_functions_window_functions_statistical_test_select_036
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
VARIANCE(value) AS variance,
MEDIAN(value) AS median,
MIN(value) AS min,
MAX(value) AS max
FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_037
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_038
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_349
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_350
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_351
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_352
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_039
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_353
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_354
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_355
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_356
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_357
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_statistical_test_select_040
SELECT
product,
amount,
STDDEV(amount) OVER (PARTITION BY product) AS product_stddev
FROM sales
ORDER BY product, amount;
-- Tag: window_functions_window_functions_statistical_test_select_041
SELECT
dept,
salary,
PERCENTILE_CONT(salary, 0.5) OVER (PARTITION BY dept) AS dept_median
FROM employees
ORDER BY dept, salary;
-- Tag: window_functions_window_functions_statistical_test_select_358
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_359
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_360
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_361
SELECT PERCENTILE_CONT(value, 0.5) AS median FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_042
SELECT
AVG(value) AS mean,
STDDEV(value) AS stddev,
MEDIAN(value) AS median
FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_362
SELECT STDDEV(value) AS stddev FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_363
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_364
SELECT PERCENTILE_CONT(value, 1.5) AS result FROM numbers;
-- Tag: window_functions_window_functions_statistical_test_select_365
SELECT CORR(x, y) AS correlation FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_366
SELECT APPROX_TOP_COUNT(category, -1) AS result FROM items;

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

-- Tag: window_functions_window_functions_statistical_test_select_367
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_368
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_statistical_test_select_369
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_370
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_371
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_372
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_373
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_374
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_375
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_376
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_377
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_378
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_statistical_test_select_379
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_statistical_test_select_380
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_381
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_382
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_statistical_test_select_383
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_statistical_test_select_384
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_385
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_386
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_387
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_388
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_389
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_390
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_391
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_392
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_393
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_statistical_test_select_394
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_statistical_test_select_395
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_396
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_397
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_statistical_test_select_398
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_399
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_400
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_401
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_402
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_403
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_404
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_405
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_406
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_407
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_statistical_test_select_408
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_statistical_test_select_409
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_410
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_411
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_statistical_test_select_412
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_413
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_414
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_statistical_test_select_415
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_416
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_statistical_test_select_417
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_418
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_419
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_420
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_statistical_test_select_421
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_statistical_test_select_422
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_423
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_424
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 4.0), (4, 4.0), (5, 5.0), (6, 5.0), (7, 7.0), (8, 9.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, NULL), (3, 20.0), (4, 30.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_425
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_426
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_427
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_428
SELECT STDDEV_SAMP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_429
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_430
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_431
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_432
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_433
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_434
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_435
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_436
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_437
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_438
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_439
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_440
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_441
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_442
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_443
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_444
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_445
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_446
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_447
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_448
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_449
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_450
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_451
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_452
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_453
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_454
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_455
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_456
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, NULL), (3, 20.0), (4, 30.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_457
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_458
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_459
SELECT STDDEV_SAMP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_460
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_461
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_462
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_463
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_464
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_465
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_466
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_467
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_468
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_469
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_470
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_471
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_472
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_473
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_474
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_475
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_476
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_477
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_478
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_479
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_480
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_481
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_482
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_483
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_484
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_485
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_486
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_487
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 10.0), (2, NULL), (3, 20.0), (4, 30.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_488
SELECT STDDEV_POP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_489
SELECT STDDEV_SAMP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_490
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_491
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_492
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_493
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_494
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_495
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_496
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_497
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_498
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_499
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_500
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_501
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_502
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_503
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_504
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_505
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_506
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_507
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_508
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_509
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_510
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_511
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_512
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_513
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_514
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_515
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_516
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_517
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_518
SELECT STDDEV_SAMP(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_519
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_520
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_521
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_522
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_523
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_524
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_525
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_526
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_527
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_528
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_529
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_530
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_531
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_532
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_533
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_534
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_535
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_536
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_537
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_538
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_539
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_540
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_541
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_542
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_543
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_544
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_545
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_546
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 2.0), (2, 4.0), (3, 6.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_547
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_548
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_549
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_550
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_551
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_552
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_553
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_554
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_555
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_556
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_557
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_558
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_559
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_560
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_561
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_562
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_563
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_564
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_565
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_566
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_567
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_568
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_569
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_570
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_571
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_572
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_573
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_574
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value FLOAT64);
INSERT INTO test VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0), (5, 5.0);
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

-- Tag: window_functions_window_functions_statistical_test_select_575
SELECT STDDEV_POP(value) AS pop, STDDEV_SAMP(value) AS samp FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_576
SELECT VAR_POP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_577
SELECT VAR_SAMP(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_578
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_579
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_580
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_581
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_582
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_583
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_584
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_585
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_586
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_587
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_588
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_589
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_590
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_591
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_592
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_593
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_594
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_595
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_596
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_597
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_598
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_599
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_600
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_601
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_602
SELECT VARIANCE(value) AS variance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_603
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_604
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_605
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_606
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_607
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_608
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_609
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_610
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_611
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_612
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_613
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_614
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_615
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_616
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_617
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_618
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_619
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_620
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_621
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_622
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_623
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_624
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_625
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_626
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_627
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_628
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_629
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_630
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_631
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_632
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_633
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_634
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_635
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_636
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_637
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_638
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_639
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_640
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_641
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_642
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_643
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_644
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_645
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_646
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_647
SELECT MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_648
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_649
SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY value) AS p25, \
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY value) AS p75 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_650
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_651
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_652
SELECT PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS p50 FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_653
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_654
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_655
SELECT MODE(value) AS mode FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_656
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_657
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_658
SELECT CORR(x, y) AS correlation FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_659
SELECT COVAR_POP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_660
SELECT COVAR_SAMP(x, y) AS covariance FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_661
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_662
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_663
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_664
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_665
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_666
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_667
SELECT category, STDDEV(value) AS stddev FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_668
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_669
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_670
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_671
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_672
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_673
SELECT category, MEDIAN(value) AS median FROM test GROUP BY category ORDER BY category;
-- Tag: window_functions_window_functions_statistical_test_select_674
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_675
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_676
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_677
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

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

-- Tag: window_functions_window_functions_statistical_test_select_678
SELECT STDDEV(value) AS stddev FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_679
SELECT STDDEV(value) AS stddev, MEDIAN(value) AS median FROM test;
-- Tag: window_functions_window_functions_statistical_test_select_680
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_681
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'A', 3.0), (4, 'B', 10.0), (5, 'B', 10.0);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'B', 10.0);

-- Tag: window_functions_window_functions_statistical_test_select_682
SELECT category FROM test GROUP BY category HAVING STDDEV(value) > 0.5;
-- Tag: window_functions_window_functions_statistical_test_select_683
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, category STRING, value FLOAT64);
INSERT INTO test VALUES (1, 'A', 1.0), (2, 'A', 2.0), (3, 'B', 10.0);

-- Tag: window_functions_window_functions_statistical_test_select_684
SELECT id, value, STDDEV(value) OVER (PARTITION BY category) AS category_stddev FROM test ORDER BY id;

