-- Aggregates Subqueries - SQL:2023
-- Description: Aggregates involving subqueries.

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    customer STRING,
    amount INT64
);

INSERT INTO orders VALUES ('Alice', 100);
INSERT INTO orders VALUES ('Bob', 50);
INSERT INTO orders VALUES ('Charlie', 200);

-- Tag: sum_over_subquery
SELECT SUM(amount) AS total
FROM (SELECT amount FROM orders WHERE amount > 75) AS filtered;

-- Tag: customer_totals_over_threshold
SELECT customer, SUM(amount) AS total
FROM orders
GROUP BY customer
HAVING SUM(amount) > (SELECT AVG(amount) FROM orders)
ORDER BY customer;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    region STRING,
    amount INT64
);

INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES ('East', 150);
INSERT INTO sales VALUES ('West', 120);

-- Tag: subquery_in_where
SELECT region, amount
FROM sales
WHERE amount > (SELECT AVG(amount) FROM sales WHERE region = 'East')
ORDER BY region, amount;
