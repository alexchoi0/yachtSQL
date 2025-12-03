-- Aggregates Basic - SQL:2023
-- Description: Deterministic coverage for COUNT, SUM, AVG, MIN, MAX, DISTINCT, GROUP BY, and HAVING.

DROP TABLE IF EXISTS sales_summary;

CREATE TABLE sales_summary (category STRING, amount INT64);

INSERT INTO sales_summary VALUES
    ('A', 100),
    ('A', 150),
    ('B', 200),
    ('B', 120),
    ('C', 300);

-- Tag: count_all_rows
SELECT COUNT(*) AS total_rows FROM sales_summary;

-- Tag: count_non_null_column
SELECT COUNT(category) AS category_count FROM sales_summary;

-- Tag: sum_amount
SELECT SUM(amount) AS total_amount FROM sales_summary;

-- Tag: avg_amount
SELECT AVG(amount) AS average_amount FROM sales_summary;

-- Tag: min_max_amount
SELECT MIN(amount) AS min_amount, MAX(amount) AS max_amount FROM sales_summary;

-- Tag: group_by_category
SELECT category, COUNT(*) AS order_count, SUM(amount) AS total_amount
FROM sales_summary
GROUP BY category
ORDER BY category;

-- Tag: having_total_over_two_hundred
SELECT category, SUM(amount) AS total_amount
FROM sales_summary
GROUP BY category
HAVING SUM(amount) > 200
ORDER BY category;

-- Tag: distinct_amounts
SELECT COUNT(DISTINCT amount) AS distinct_amounts FROM sales_summary;

DROP TABLE IF EXISTS optional_sales;

CREATE TABLE optional_sales (id INT64, amount INT64);

INSERT INTO optional_sales VALUES
    (1, 100),
    (2, NULL),
    (3, 200);

-- Tag: count_with_nulls
SELECT COUNT(amount) AS non_null_count, COUNT(*) AS total_rows
FROM optional_sales;

DROP TABLE IF EXISTS empty_sales;

CREATE TABLE empty_sales (id INT64, amount INT64);

-- Tag: aggregates_empty_table
SELECT COUNT(*) AS total_rows, SUM(amount) AS total_amount FROM empty_sales;
