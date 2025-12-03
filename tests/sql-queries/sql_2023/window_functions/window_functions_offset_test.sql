-- Window Functions Offset - SQL:2023
-- Description: Window offset functions: LAG, LEAD, FIRST_VALUE, LAST_VALUE
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

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

-- Tag: window_functions_window_functions_offset_test_select_001
SELECT id, value,
LAG(value) OVER (ORDER BY id) as prev_value,
LEAD(value) OVER (ORDER BY id) as next_value
FROM sequence
ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_002
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_003
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_offset_test_select_004
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_offset_test_select_005
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_offset_test_select_006
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_offset_test_select_007
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_offset_test_select_008
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_offset_test_select_009
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_offset_test_select_010
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_offset_test_select_011
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_offset_test_select_012
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_offset_test_select_013
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_offset_test_select_014
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_offset_test_select_015
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_offset_test_select_016
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_offset_test_select_017
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_offset_test_select_018
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_offset_test_select_019
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_offset_test_select_020
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_offset_test_select_021
SELECT id, LAG(value, 10) OVER (ORDER BY id) as lagged FROM small_set ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_022
SELECT category, RANK() OVER (PARTITION BY category ORDER BY value DESC) as rank
FROM unique_categories;
-- Tag: window_functions_window_functions_offset_test_select_023
SELECT id, ROW_NUMBER() OVER (ORDER BY value) as rn
FROM data
WHERE value > 1000;
-- Tag: window_functions_window_functions_offset_test_select_024
SELECT id, score, RANK() OVER (ORDER BY score DESC) as rank
FROM nullable_scores;
-- Tag: window_functions_window_functions_offset_test_select_025
SELECT STDDEV_POP(value) as pop_stddev FROM single_value;
-- Tag: window_functions_window_functions_offset_test_select_026
SELECT STDDEV_SAMP(value) as sample_stddev FROM two_values;
-- Tag: window_functions_window_functions_offset_test_select_027
SELECT VAR_POP(value) as pop_var, VAR_SAMP(value) as samp_var FROM identical;
-- Tag: window_functions_window_functions_offset_test_select_028
SELECT MEDIAN(value) as median FROM even_count;
-- Tag: window_functions_window_functions_offset_test_select_029
SELECT MEDIAN(value) as median FROM odd_count;
-- Tag: window_functions_window_functions_offset_test_select_030
SELECT MEDIAN(value) as median FROM with_nulls;
-- Tag: window_functions_window_functions_offset_test_select_031
SELECT STDDEV_SAMP(value) as stddev FROM extreme_values;
-- Tag: window_functions_window_functions_offset_test_select_032
SELECT STDDEV_POP(value) as stddev,
VAR_POP(value) as variance,
MEDIAN(value) as median
FROM empty_table;
-- Tag: window_functions_window_functions_offset_test_select_033
SELECT account,
amount,
SUM(amount) OVER (PARTITION BY account ORDER BY date) as running_total,
RANK() OVER (PARTITION BY account ORDER BY amount DESC) as amount_rank
FROM transactions
ORDER BY account, date;
-- Tag: window_functions_window_functions_offset_test_select_034
SELECT department,
STDDEV_POP(salary) as stddev,
VAR_POP(salary) as variance
FROM salaries
GROUP BY department
HAVING STDDEV_POP(salary) > 10000
ORDER BY stddev DESC;
WITH ranked AS (
-- Tag: window_functions_window_functions_offset_test_select_035
SELECT product_id,
category,
sales,
RANK() OVER (PARTITION BY category ORDER BY sales DESC) as rank
FROM product_sales
)
-- Tag: window_functions_window_functions_offset_test_select_036
SELECT product_id, category, sales, rank
FROM ranked
WHERE rank <= 2
ORDER BY category, rank;
-- Tag: window_functions_window_functions_offset_test_select_037
SELECT numerator / denominator FROM division;
-- Tag: window_functions_window_functions_offset_test_select_038
SELECT RANK() FROM data;
-- Tag: window_functions_window_functions_offset_test_select_039
SELECT category FROM sales WHERE SUM(amount) > 50;

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

-- Tag: window_functions_window_functions_offset_test_select_040
SELECT date, price, LAG(price, 1, 0.0) OVER (ORDER BY date) as prev_price FROM prices ORDER BY date;

DROP TABLE IF EXISTS spaces;
CREATE TABLE spaces (id INT64, text STRING);
INSERT INTO spaces VALUES (1, '  leading');
INSERT INTO spaces VALUES (2, 'trailing  ');
INSERT INTO spaces VALUES (3, '  both  ');
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
INSERT INTO whitespace VALUES (1, '   ');
INSERT INTO whitespace VALUES (2, '\t\t');
INSERT INTO whitespace VALUES (3, '
');

-- Tag: window_functions_window_functions_offset_test_select_041
SELECT * FROM spaces;
-- Tag: window_functions_window_functions_offset_test_select_042
SELECT * FROM duplicates;
-- Tag: window_functions_window_functions_offset_test_select_043
SELECT DISTINCT value FROM duplicates;
-- Tag: window_functions_window_functions_offset_test_select_044
SELECT * FROM single;
-- Tag: window_functions_window_functions_offset_test_select_045
SELECT COUNT(*) FROM single;
-- Tag: window_functions_window_functions_offset_test_select_046
SELECT value, COUNT(*) FROM single GROUP BY value;
-- Tag: window_functions_window_functions_offset_test_select_047
SELECT * FROM empty;
-- Tag: window_functions_window_functions_offset_test_select_048
SELECT * FROM data WHERE value > 1000;
-- Tag: window_functions_window_functions_offset_test_select_049
SELECT * FROM data WHERE value > 0;
-- Tag: window_functions_window_functions_offset_test_select_050
SELECT * FROM floats;
-- Tag: window_functions_window_functions_offset_test_select_051
SELECT * FROM floats;
-- Tag: window_functions_window_functions_offset_test_select_052
SELECT * FROM wide;
-- Tag: window_functions_window_functions_offset_test_select_053
SELECT * FROM (SELECT * FROM numbers WHERE value > 3) sub WHERE value < 12;
-- Tag: window_functions_window_functions_offset_test_select_054
SELECT category, COUNT(*) FROM groups GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_055
SELECT DISTINCT value FROM distinct_vals;
-- Tag: window_functions_window_functions_offset_test_select_056
SELECT * FROM data LIMIT 0;
-- Tag: window_functions_window_functions_offset_test_select_057
SELECT * FROM data LIMIT 1;
-- Tag: window_functions_window_functions_offset_test_select_058
SELECT * FROM data LIMIT 10 OFFSET 100;
-- Tag: window_functions_window_functions_offset_test_select_059
SELECT * FROM data ORDER BY value ASC;
-- Tag: window_functions_window_functions_offset_test_select_060
SELECT * FROM whitespace;

DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
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

-- Tag: window_functions_window_functions_offset_test_select_061
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
-- Tag: window_functions_window_functions_offset_test_select_062
SELECT COUNT(*) FROM recovery;
-- Tag: window_functions_window_functions_offset_test_select_063
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
-- Tag: window_functions_window_functions_offset_test_select_064
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
-- Tag: window_functions_window_functions_offset_test_select_001
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
-- Tag: window_functions_window_functions_offset_test_select_065
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
-- Tag: window_functions_window_functions_offset_test_select_066
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
-- Tag: window_functions_window_functions_offset_test_select_067
SELECT * FROM tree_path;
-- Tag: window_functions_window_functions_offset_test_select_068
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
-- Tag: window_functions_window_functions_offset_test_select_069
SELECT COUNT(*) FROM writes;
-- Tag: window_functions_window_functions_offset_test_select_070
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

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

-- Tag: window_functions_window_functions_offset_test_select_071
SELECT day, amount, LAG(amount, 1) OVER (ORDER BY day) AS prev_amount
FROM daily_sales
ORDER BY day;
-- Tag: window_functions_window_functions_offset_test_select_072
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_offset_test_select_073
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_offset_test_select_074
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_075
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_offset_test_select_076
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_077
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_078
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_079
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_080
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_offset_test_select_081
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_offset_test_select_082
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_offset_test_select_083
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_offset_test_select_084
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_offset_test_select_085
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_offset_test_select_086
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_offset_test_select_087
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_offset_test_select_088
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_offset_test_select_089
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_offset_test_select_090
SELECT seq, event, LEAD(event, 1) OVER (ORDER BY seq) AS next_event
FROM events
ORDER BY seq;
-- Tag: window_functions_window_functions_offset_test_select_091
SELECT name, ROW_NUMBER() OVER (ORDER BY value) AS rn
FROM items
ORDER BY rn;
-- Tag: window_functions_window_functions_offset_test_select_092
SELECT STDDEV_POP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_093
SELECT STDDEV(val) FROM samples;
-- Tag: window_functions_window_functions_offset_test_select_094
SELECT VAR_POP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_095
SELECT VAR_SAMP(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_096
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_097
SELECT MEDIAN(val) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_098
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_offset_test_select_099
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_offset_test_select_100
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_offset_test_select_101
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_offset_test_select_102
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_offset_test_select_103
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_offset_test_select_104
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_offset_test_select_105
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_offset_test_select_106
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_offset_test_select_107
SELECT val FROM test WHERE SUM(val) > 5;

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

-- Tag: window_functions_window_functions_offset_test_select_108
SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_109
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_110
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_111
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_112
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_113
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_114
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_115
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_116
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_offset_test_select_117
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_118
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_119
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_120
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_121
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_122
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_123
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_offset_test_select_124
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_125
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_126
SELECT month, revenue, LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_127
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_128
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_129
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_130
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_131
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_132
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_133
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_offset_test_select_134
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_135
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_136
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_137
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_138
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_139
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_140
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_offset_test_select_141
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_142
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_143
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_144
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_145
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_146
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_147
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_148
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_149
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_offset_test_select_150
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_151
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_152
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_153
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_154
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_155
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_156
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_offset_test_select_157
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_158
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_159
SELECT region, amount,
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY amount) as first_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_160
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_161
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_162
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_163
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_164
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_offset_test_select_165
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_166
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_167
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_168
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_169
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_170
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_171
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_offset_test_select_172
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_173
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_174
SELECT region, amount,
LAST_VALUE(amount) OVER (
PARTITION BY region
ORDER BY amount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_amount
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_175
SELECT value, NTH_VALUE(value, 2) OVER (ORDER BY value) as second_value
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_176
SELECT month, amount, SUM(amount) OVER (ORDER BY month) as running_total
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_177
SELECT month, amount, AVG(amount) OVER (ORDER BY month ROWS 2 PRECEDING) as moving_avg
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_178
SELECT id, category, COUNT(*) OVER (PARTITION BY category) as category_count
FROM events;
-- Tag: window_functions_window_functions_offset_test_select_179
SELECT value,
SUM(value) OVER (
ORDER BY value
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) as windowed_sum
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_180
SELECT value,
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as range_count
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_181
SELECT value, NTILE(4) OVER (ORDER BY value) as quartile
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_182
SELECT value, PERCENT_RANK() OVER (ORDER BY value) as pct_rank
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_183
SELECT value, CUME_DIST() OVER (ORDER BY value) as cum_dist
FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_184
SELECT region, amount,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as row_num,
RANK() OVER (ORDER BY amount DESC) as overall_rank
FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_185
SELECT value,
ROW_NUMBER() OVER w as row_num,
RANK() OVER w as rank
FROM data
WINDOW w AS (ORDER BY value DESC);
-- Tag: window_functions_window_functions_offset_test_select_186
SELECT value, ROW_NUMBER() OVER (ORDER BY value NULLS LAST) as row_num
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_187
SELECT category, value,
COUNT(*) OVER (PARTITION BY category) as count
FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_188
SELECT month, revenue, LAG(revenue) OVER (ORDER BY month) AS prev_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_189
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_190
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_191
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_192
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_193
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_194
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_195
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_196
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_197
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_198
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_199
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_200
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_201
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_202
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_203
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_204
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_205
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_206
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_002
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_207
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_003
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_004
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_208
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_209
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_210
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_211
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_212
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_213
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_214
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_215
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_216
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_217
SELECT value, LAG(value, 2) OVER (ORDER BY value) AS lag_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_218
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_219
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_220
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_221
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_222
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_223
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_224
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_225
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_226
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_227
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_228
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_229
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_230
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_231
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_232
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_233
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_234
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_005
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_235
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_006
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_007
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_236
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_237
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_238
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_239
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_240
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_241
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_242
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_243
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_244
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_245
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) AS prev_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_246
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_247
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_248
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_249
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_250
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_251
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_252
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_253
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_254
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_255
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_256
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_257
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_258
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_259
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_260
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_261
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_008
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_262
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_009
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_010
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_263
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_264
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_265
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_266
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_267
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_268
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_269
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_270
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_271
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_272
SELECT product, month, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY month) AS prev_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_273
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_274
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_275
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_276
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_277
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_278
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_279
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_280
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_281
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_282
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_283
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_284
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_285
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_286
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_287
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_011
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_288
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_012
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_013
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_289
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_290
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_291
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_292
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_293
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_294
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_295
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_296
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_297
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_298
SELECT month, revenue, LEAD(revenue) OVER (ORDER BY month) AS next_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_299
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_300
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_301
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_302
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_303
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_304
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_305
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_306
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_307
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_308
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_309
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_310
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_311
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_312
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_014
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_313
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_015
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_016
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_314
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_315
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_316
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_317
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_318
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_319
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_320
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_321
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_322
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_323
SELECT value, LEAD(value, 2) OVER (ORDER BY value) AS lead_2 FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_324
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_325
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_326
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_327
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_328
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_329
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_330
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_331
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_332
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_333
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_334
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_335
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_336
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_017
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_337
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_018
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_019
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_338
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_339
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_340
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_341
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_342
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_343
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_344
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_345
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_346
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_347
SELECT value, LEAD(value, 1, 999) OVER (ORDER BY value) AS next_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_348
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_349
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_350
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_351
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_352
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_353
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_354
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_355
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_356
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_357
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_358
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_359
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_020
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_360
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_021
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_022
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_361
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_362
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_363
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_364
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_365
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_366
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_367
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_368
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_369
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_370
SELECT month, revenue, FIRST_VALUE(revenue) OVER (ORDER BY month) AS first_revenue FROM sales ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_371
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_372
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_373
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_374
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_375
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_376
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_377
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_378
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_379
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_380
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_381
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_023
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_382
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_024
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_025
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_383
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_384
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_385
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_386
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_387
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_388
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_389
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_390
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_391
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_392
SELECT month, revenue,
LAST_VALUE(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_393
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_394
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_395
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_396
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_397
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_398
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_399
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_400
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_401
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_402
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_026
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_403
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_027
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_028
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_404
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_405
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_406
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_407
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_408
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_409
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_410
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_411
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_412
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_413
SELECT product, month, revenue, FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) AS first_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_414
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_415
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_416
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_417
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_418
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_419
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_420
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_421
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_422
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_029
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_423
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_030
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_031
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_424
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_425
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_426
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_427
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_428
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_429
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_430
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_431
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_432
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_433
SELECT product, month, revenue,
LAST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY product, month;
-- Tag: window_functions_window_functions_offset_test_select_434
SELECT value, NTH_VALUE(value, 3) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_435
SELECT value, NTH_VALUE(value, 5) OVER (ORDER BY value) AS fifth_value FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_436
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_437
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_438
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_439
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_440
SELECT value, SUM(value) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_441
SELECT value, amount, SUM(amount) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_sum FROM data ORDER BY value, amount;
-- Tag: window_functions_window_functions_offset_test_select_032
SELECT
month,
revenue,
ROW_NUMBER() OVER (ORDER BY revenue DESC) AS row_num,
RANK() OVER (ORDER BY revenue DESC) AS rank,
LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
LEAD(revenue) OVER (ORDER BY month) AS next_revenue
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_442
SELECT name, score, rank
FROM (SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM scores)
WHERE rank <= 2
ORDER BY rank, name;
-- Tag: window_functions_window_functions_offset_test_select_033
SELECT
month,
revenue,
AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma3
FROM sales
ORDER BY month;
-- Tag: window_functions_window_functions_offset_test_select_034
SELECT
year,
quarter,
revenue,
LAG(revenue, 2) OVER (PARTITION BY quarter ORDER BY year) AS prev_year_revenue
FROM sales
ORDER BY year, quarter;
-- Tag: window_functions_window_functions_offset_test_select_443
SELECT product, revenue, ROW_NUMBER() OVER (PARTITION BY product ORDER BY revenue) AS row_num FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_444
SELECT product, revenue, LAG(revenue) OVER (PARTITION BY product ORDER BY revenue) AS prev_revenue FROM sales;
-- Tag: window_functions_window_functions_offset_test_select_445
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_446
SELECT value, SUM(value) OVER (ORDER BY value ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING) AS window_sum FROM data ORDER BY value;
-- Tag: window_functions_window_functions_offset_test_select_447
SELECT name, score, RANK() OVER (ORDER BY score DESC NULLS LAST) AS rank FROM scores;
-- Tag: window_functions_window_functions_offset_test_select_448
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_449
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_450
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_451
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_452
SELECT value, LAG(value) OVER (ORDER BY value NULLS FIRST) AS prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_453
SELECT NTILE(0) OVER (ORDER BY value) AS bucket FROM data;
-- Tag: window_functions_window_functions_offset_test_select_454
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_455
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (20), (30);

-- Tag: window_functions_window_functions_offset_test_select_456
SELECT LAG(value, -1) OVER (ORDER BY value) AS result FROM data;
-- Tag: window_functions_window_functions_offset_test_select_457
SELECT NTH_VALUE(value, 0) OVER (ORDER BY value) AS result FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_458
SELECT id, value, LAG(value) OVER (ORDER BY id) as prev_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_459
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_460
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_461
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_462
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_offset_test_select_463
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_464
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_465
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_466
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_467
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_468
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_469
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_470
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_471
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_472
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_473
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_474
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_475
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_476
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_477
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_478
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_479
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_480
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_481
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_482
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_483
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_offset_test_select_484
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_485
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_486
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_487
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_488
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_489
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_490
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_491
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_492
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_493
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_494
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_495
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_496
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_497
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_498
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_499
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_500
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_501
SELECT id, value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_or_zero FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_502
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_503
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_offset_test_select_504
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_505
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_506
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_507
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_508
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_509
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_510
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_511
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_512
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_513
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_514
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_515
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_516
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_517
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_518
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_519
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_520
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_521
SELECT month, region, amount,
LAG(amount) OVER (PARTITION BY region ORDER BY month) as prev_month_amount
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_522
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_offset_test_select_523
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_524
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_525
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_526
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_527
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_528
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_529
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_530
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_531
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_532
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_533
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_534
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_535
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_536
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_537
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_538
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_539
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_540
SELECT id, value, LAG(value, 10) OVER (ORDER BY id) as lag_10 FROM small;
-- Tag: window_functions_window_functions_offset_test_select_541
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_542
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_543
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_544
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_545
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_546
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_547
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_548
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_549
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_550
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_551
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_552
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_553
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_554
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_555
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_556
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_557
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_558
SELECT id, value, LEAD(value) OVER (ORDER BY id) as next_value FROM sequence ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_559
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_560
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_561
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_562
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_563
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_564
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_565
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_566
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_567
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_568
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_569
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_570
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_571
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_572
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_573
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_574
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_575
SELECT id, value, LEAD(value, 2, -1) OVER (ORDER BY id) as lead_2_or_neg1 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_576
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_577
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_578
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_579
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_580
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_581
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_582
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_583
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_584
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_585
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_586
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_587
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_588
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_589
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_590
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_591
SELECT id, event, timestamp,
LAG(event) OVER (ORDER BY timestamp) as prev_event,
LEAD(event) OVER (ORDER BY timestamp) as next_event
FROM timeline ORDER BY timestamp;
-- Tag: window_functions_window_functions_offset_test_select_592
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_593
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_594
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_595
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_596
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_597
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_598
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_599
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_600
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_601
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_602
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_603
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_604
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_605
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_606
SELECT quarter, revenue,
FIRST_VALUE(revenue) OVER (ORDER BY quarter) as first_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_607
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_608
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_609
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_610
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_611
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_612
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_613
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_614
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_615
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_616
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_617
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_618
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_619
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_620
SELECT quarter, revenue,
LAST_VALUE(revenue) OVER (ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_revenue
FROM sales ORDER BY quarter;
-- Tag: window_functions_window_functions_offset_test_select_621
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_622
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_623
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_624
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_625
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_626
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_627
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_628
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_629
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_630
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_631
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_632
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_633
SELECT region, quarter, revenue,
FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter) as first_q,
LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY quarter ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_q
FROM sales ORDER BY region, quarter;
-- Tag: window_functions_window_functions_offset_test_select_634
SELECT id, score, PERCENT_RANK() OVER (ORDER BY score) as pct_rank FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_635
SELECT id, score, CUME_DIST() OVER (ORDER BY score) as cume_dist FROM scores ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_636
SELECT id, value, NTILE(4) OVER (ORDER BY value) as quartile FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_637
SELECT id, NTILE(3) OVER (ORDER BY id) as bucket FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_638
SELECT id, RANK() as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_639
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_640
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_641
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_642
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_643
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_644
SELECT id, region, amount,
RANK() OVER (ORDER BY amount DESC) as overall_rank,
RANK() OVER (PARTITION BY region ORDER BY amount DESC) as region_rank,
ROW_NUMBER() OVER (ORDER BY id) as seq
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_645
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_646
SELECT NTILE(0) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_647
SELECT region, SUM(amount) as total,
RANK() OVER (ORDER BY SUM(amount) DESC) as rank
FROM sales GROUP BY region;
-- Tag: window_functions_window_functions_offset_test_select_648
SELECT * FROM (
-- Tag: window_functions_window_functions_offset_test_select_649
SELECT id, dept, salary,
RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as dept_rank
FROM employees
) ranked WHERE dept_rank = 1;
-- Tag: window_functions_window_functions_offset_test_select_650
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

-- Tag: window_functions_window_functions_offset_test_select_651
SELECT value, LAG(value) OVER (ORDER BY value) as prev_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_652
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_653
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_offset_test_select_654
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_655
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_656
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_657
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_658
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_659
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_660
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_661
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_662
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_663
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_664
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_665
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_666
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_667
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_668
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_669
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_670
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_671
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_672
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_673
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_674
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_675
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_676
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_677
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_678
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_679
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_680
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_681
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_offset_test_select_682
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_683
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_684
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_685
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_686
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_687
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_688
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_689
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_690
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_691
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_692
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_693
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_694
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_695
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_696
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_697
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_698
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_699
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_700
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_701
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_702
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_703
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_704
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_705
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_706
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_707
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

-- Tag: window_functions_window_functions_offset_test_select_708
SELECT value, LAG(value, 2) OVER (ORDER BY value) as prev2 FROM data;
-- Tag: window_functions_window_functions_offset_test_select_709
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_710
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_711
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_712
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_713
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_714
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_715
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_716
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_717
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_718
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_719
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_720
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_721
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_722
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_723
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_724
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_725
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_726
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_727
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_728
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_729
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_730
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_731
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_732
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_733
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_734
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_735
SELECT value, LAG(value, 1, 0) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_736
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_737
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_738
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_739
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_740
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_741
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_742
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_743
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_744
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_745
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_746
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_747
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_748
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_749
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_750
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_751
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_752
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_753
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_754
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_755
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_756
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_757
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_758
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_759
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_760
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_761
SELECT value, LEAD(value) OVER (ORDER BY value) as next_value FROM data;
-- Tag: window_functions_window_functions_offset_test_select_762
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_763
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_764
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_765
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_766
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_767
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_768
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_769
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_770
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_771
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_772
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_773
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_774
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_775
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_776
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_777
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_778
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_779
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_780
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_781
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_782
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_783
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_784
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_785
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_786
SELECT value, LEAD(value) OVER (ORDER BY value) as next FROM data;
-- Tag: window_functions_window_functions_offset_test_select_787
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_788
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_789
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_790
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_791
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_792
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_793
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_794
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_795
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_796
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_797
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_798
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_799
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_800
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_801
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_802
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_803
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_804
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_805
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_806
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_807
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_808
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_809
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_810
SELECT category, value, \
LAG(value) OVER (PARTITION BY category ORDER BY value) as prev \
FROM data ORDER BY category, value;
-- Tag: window_functions_window_functions_offset_test_select_811
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_812
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_813
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_814
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_815
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_816
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_817
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_818
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_819
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_820
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_821
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_822
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_823
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_824
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_825
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_826
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_827
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_828
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_829
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_830
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_831
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_832
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_833
SELECT value, LAG(value, 10) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_834
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_835
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_836
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_837
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_838
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_839
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_840
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_841
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_842
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_843
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_844
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_845
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_846
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_847
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_848
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_849
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_850
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_851
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_852
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_853
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_854
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_855
SELECT value, FIRST_VALUE(value) OVER (ORDER BY value) as first FROM data;
-- Tag: window_functions_window_functions_offset_test_select_856
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_857
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_858
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_859
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_860
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_861
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_862
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_863
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_864
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_865
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_866
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_867
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_868
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_869
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_870
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_871
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_872
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_873
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_874
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_875
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_876
SELECT value, LAST_VALUE(value) OVER (ORDER BY value) as last FROM data;
-- Tag: window_functions_window_functions_offset_test_select_877
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_878
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_879
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_880
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_881
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_882
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_883
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_884
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_885
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_886
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_887
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_888
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_889
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_890
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_891
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_892
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_893
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_894
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_895
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_896
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as last \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_897
SELECT value, \
NTH_VALUE(value, 3) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as third \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_898
SELECT value, \
NTH_VALUE(value, 5) OVER (ORDER BY value \
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) \
as fifth \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_899
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_900
SELECT value, \
COUNT(*) OVER (ORDER BY value RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as cnt \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_901
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_902
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) \
as remaining_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_903
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_904
SELECT category, value, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_905
SELECT region, dept, value, \
ROW_NUMBER() OVER (PARTITION BY region, dept ORDER BY value) as rn \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_906
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn FROM data;
-- Tag: window_functions_window_functions_offset_test_select_907
SELECT value, \
SUM(value) OVER (ORDER BY value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) \
as running_sum \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_908
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_909
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_910
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_911
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_912
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_913
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_914
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_915
SELECT value, LAG(value) OVER (ORDER BY value) as prev FROM data;
-- Tag: window_functions_window_functions_offset_test_select_916
SELECT category, SUM(value) FROM data GROUP BY category;
-- Tag: window_functions_window_functions_offset_test_select_917
SELECT category, value, SUM(value) OVER (PARTITION BY category) as sum FROM data;
-- Tag: window_functions_window_functions_offset_test_select_918
SELECT id, category, \
ROW_NUMBER() OVER (PARTITION BY category ORDER BY id) as rn, \
RANK() OVER (PARTITION BY category ORDER BY id) as rank \
FROM data;
-- Tag: window_functions_window_functions_offset_test_select_919
SELECT value, ROW_NUMBER() OVER (ORDER BY value) as rn \
FROM data \
WHERE value > 5;
-- Tag: window_functions_window_functions_offset_test_select_920
SELECT product, SUM(amount) as total, \
RANK() OVER (ORDER BY SUM(amount) DESC) as rank \
FROM sales \
GROUP BY product \
HAVING RANK() OVER (ORDER BY SUM(amount) DESC) = 1;
-- Tag: window_functions_window_functions_offset_test_select_921
SELECT region, product, amount, \
ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount) as rn_region, \
ROW_NUMBER() OVER (PARTITION BY product ORDER BY amount) as rn_product, \
ROW_NUMBER() OVER (ORDER BY amount) as rn_overall \
FROM sales;

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

-- Tag: window_functions_window_functions_offset_test_select_922
SELECT id, value, LAG(value) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_923
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_924
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_925
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_926
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_927
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_928
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_929
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_930
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_931
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_932
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_933
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_934
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_935
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_936
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_937
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_938
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_939
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_940
SELECT id, value, LAG(value, 2) OVER (ORDER BY id) AS prev2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_941
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_942
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_943
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_944
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_945
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_946
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_947
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_948
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_949
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_950
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_951
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_952
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_953
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_954
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_955
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_956
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_957
SELECT id, LAG(value, 1, -1) OVER (ORDER BY id) AS prev_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_958
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_959
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_960
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_961
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_962
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_963
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_964
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_965
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_966
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_967
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_968
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_969
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_970
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_971
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_972
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_973
SELECT id, value, LEAD(value) OVER (ORDER BY id) AS next_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_974
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_975
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_976
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_977
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_978
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_979
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_980
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_981
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_982
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_983
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_984
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_985
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_986
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_987
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_988
SELECT id, LEAD(value, 2) OVER (ORDER BY id) AS next2_value FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_989
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_990
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_991
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_992
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_993
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_994
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_995
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_996
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_997
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_998
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_999
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1000
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1001
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1002
SELECT id, value, FIRST_VALUE(value) OVER (ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1003
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1004
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1005
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1006
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1007
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1008
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1009
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1010
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_1011
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1012
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1013
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1014
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1015
SELECT category, value, FIRST_VALUE(value) OVER (PARTITION BY category ORDER BY id) AS first_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1016
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1017
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1018
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1019
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1020
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1021
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1022
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_1023
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1024
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1025
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1026
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1027
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1028
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1029
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1030
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1031
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1032
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1033
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_1034
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1035
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1036
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1037
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1038
SELECT id, value, LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1039
SELECT id, NTH_VALUE(value, 2) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS second_val FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1040
SELECT id, value, SUM(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1041
SELECT id, SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS forward_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1042
SELECT id, score, SUM(value) OVER (ORDER BY score RANGE UNBOUNDED PRECEDING) AS range_sum FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1043
SELECT RANK() OVER (PARTITION BY category ORDER BY value) AS rank FROM test;
-- Tag: window_functions_window_functions_offset_test_select_1044
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1045
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1046
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1047
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1048
SELECT id, LAG(value) OVER (ORDER BY id) AS prev, LEAD(value) OVER (ORDER BY id) AS next FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1049
SELECT COUNT(*) FROM (SELECT id, RANK() OVER (ORDER BY value) AS rank FROM test) t;
-- Tag: window_functions_window_functions_offset_test_select_1050
SELECT id, \
RANK() OVER (ORDER BY value) AS rank, \
DENSE_RANK() OVER (ORDER BY value) AS dense_rank, \
LAG(value) OVER (ORDER BY id) AS prev, \
LEAD(value) OVER (ORDER BY id) AS next \
FROM test ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1051
SELECT * FROM (SELECT id, value, RANK() OVER (ORDER BY value DESC) AS rank FROM test) t WHERE rank <= 2;

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

-- Tag: window_functions_window_functions_offset_test_select_1052
SELECT date, value, LAG(value, 1) OVER (ORDER BY date) as prev_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1053
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1054
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1055
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1056
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1057
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1058
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1059
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1060
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1061
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1062
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1063
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1064
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1065
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1066
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1067
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1068
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1069
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1070
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1071
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1072
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1073
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1074
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1075
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1076
SELECT value, LAG(value, 2) OVER (ORDER BY id) as lag_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1077
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1078
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1079
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1080
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1081
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1082
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1083
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1084
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1085
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1086
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1087
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1088
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1089
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1090
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1091
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1092
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1093
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1094
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1095
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1096
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1097
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1098
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1099
SELECT value, LAG(value, 1, 0) OVER (ORDER BY id) as prev_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1100
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1101
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1102
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1103
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1104
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1105
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1106
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1107
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1108
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1109
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1110
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1111
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1112
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1113
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1114
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1115
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1116
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1117
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1118
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1119
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1120
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1121
SELECT region, month, amount, \
LAG(amount, 1) OVER (PARTITION BY region ORDER BY month) as prev_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1122
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1123
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1124
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1125
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1126
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1127
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1128
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1129
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1130
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1131
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1132
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1133
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1134
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1135
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1136
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1137
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1138
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1139
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1140
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1141
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1142
SELECT status, LAG(status, 1) OVER (ORDER BY id) as prev_status FROM events ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1143
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1144
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1145
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1146
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1147
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1148
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1149
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1150
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1151
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1152
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1153
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1154
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1155
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1156
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1157
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1158
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1159
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1160
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1161
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1162
SELECT date, value, LEAD(value, 1) OVER (ORDER BY date) as next_value FROM timeseries ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1163
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1164
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1165
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1166
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1167
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1168
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1169
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1170
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1171
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1172
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1173
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1174
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1175
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1176
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1177
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1178
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1179
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1180
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1181
SELECT value, LEAD(value, 2) OVER (ORDER BY id) as lead_2 FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1182
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1183
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1184
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1185
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1186
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1187
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1188
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1189
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1190
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1191
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1192
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1193
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1194
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1195
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1196
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1197
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1198
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1199
SELECT value, LEAD(value, 1, -1) OVER (ORDER BY id) as next_value FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1200
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1201
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1202
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1203
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1204
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1205
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1206
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1207
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1208
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1209
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1210
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1211
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1212
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1213
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1214
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1215
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1216
SELECT date, price, \
LAG(price, 1) OVER (ORDER BY date) as prev_price, \
LEAD(price, 1) OVER (ORDER BY date) as next_price \
FROM prices ORDER BY date;
-- Tag: window_functions_window_functions_offset_test_select_1217
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1218
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1219
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1220
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1221
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1222
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1223
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1224
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1225
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1226
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1227
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1228
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1229
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1230
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1231
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1232
SELECT value, FIRST_VALUE(value) OVER (ORDER BY id) as first_val FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1233
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1234
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1235
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1236
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1237
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1238
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1239
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1240
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1241
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1242
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1243
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1244
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1245
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1246
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1247
SELECT value, \
LAST_VALUE(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1248
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1249
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1250
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1251
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1252
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1253
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1254
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1255
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1256
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1257
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1258
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1259
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1260
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1261
SELECT region, month, amount, \
FIRST_VALUE(amount) OVER (PARTITION BY region ORDER BY month) as first_month \
FROM sales ORDER BY region, month;
-- Tag: window_functions_window_functions_offset_test_select_1262
SELECT value, \
AVG(value) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as moving_avg \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1263
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1264
SELECT value, \
SUM(value) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND CURRENT ROW) as current_only \
FROM data ORDER BY id;
-- Tag: window_functions_window_functions_offset_test_select_1265
SELECT amount, \
RANK() OVER (ORDER BY amount DESC) as rank, \
ROW_NUMBER() OVER (ORDER BY amount DESC) as row_num, \
LAG(amount, 1) OVER (ORDER BY amount DESC) as prev_amount \
FROM sales ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1266
SELECT region, amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales WHERE region = 'East' ORDER BY amount DESC;
-- Tag: window_functions_window_functions_offset_test_select_1267
SELECT * FROM ( \
-- Tag: window_functions_window_functions_offset_test_select_1268
SELECT amount, RANK() OVER (ORDER BY amount DESC) as rank \
FROM sales \
) WHERE rank <= 2 \
ORDER BY rank;
-- Tag: window_functions_window_functions_offset_test_select_1269
SELECT RANK() OVER () as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1270
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1271
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1272
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1273
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

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

-- Tag: window_functions_window_functions_offset_test_select_1274
SELECT LAG(value, -1) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1275
SELECT SUM(value) OVER (ORDER BY id) FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1276
SELECT RANK() OVER (ORDER BY value) as rank FROM data;
-- Tag: window_functions_window_functions_offset_test_select_1277
SELECT value, RANK() OVER (ORDER BY value) as rank FROM data;

