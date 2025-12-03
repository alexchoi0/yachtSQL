-- Basic Aggregates - SQL:2023
-- Description: Minimal COUNT/SUM/AVG examples including NULL handling and GROUP BY.

DROP TABLE IF EXISTS sales_basic;

CREATE TABLE sales_basic (
    product STRING,
    amount INT64
);

INSERT INTO sales_basic VALUES ('Widget', 100);
INSERT INTO sales_basic VALUES ('Widget', 150);
INSERT INTO sales_basic VALUES ('Gadget', 80);

-- Tag: count_all_rows
SELECT COUNT(*) AS total_rows FROM sales_basic;

-- Tag: sum_all_amounts
SELECT SUM(amount) AS total_amount FROM sales_basic;

-- Tag: avg_all_amounts
SELECT AVG(amount) AS avg_amount FROM sales_basic;

-- Tag: group_by_product
SELECT product, SUM(amount) AS total_amount
FROM sales_basic
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS nullable_numbers;

CREATE TABLE nullable_numbers (value INT64);

INSERT INTO nullable_numbers VALUES (10);
INSERT INTO nullable_numbers VALUES (NULL);
INSERT INTO nullable_numbers VALUES (30);

-- Tag: aggregates_ignore_nulls
SELECT
    COUNT(*) AS total_rows,
    COUNT(value) AS non_null_count,
    SUM(value) AS sum_values,
    AVG(value) AS avg_values
FROM nullable_numbers;

DROP TABLE IF EXISTS empty_numbers;

CREATE TABLE empty_numbers (value INT64);

-- Tag: aggregates_empty_table
SELECT SUM(value) AS sum_values, AVG(value) AS avg_values
FROM empty_numbers;
