-- Aggregates Conditionals - SQL:2023
-- Description: Conditional aggregates using CASE, COALESCE, and NULLIF patterns.

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    id INT64,
    customer STRING,
    status STRING,
    region STRING,
    amount INT64,
    discount INT64
);

INSERT INTO orders VALUES
    (1, 'Alice', 'completed', 'North', 100, 10),
    (2, 'Bob', 'pending', 'South', 80, NULL),
    (3, 'Alice', 'completed', 'South', 200, 20),
    (4, 'Carol', 'cancelled', 'North', 60, NULL),
    (5, 'Dave', 'completed', 'East', 300, NULL);

-- Tag: sum_completed_amount
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) AS completed_total
FROM orders;

-- Tag: avg_completed_amount
SELECT AVG(CASE WHEN status = 'completed' THEN amount END) AS completed_average
FROM orders;

-- Tag: count_completed_orders
SELECT SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_count
FROM orders;

-- Tag: count_high_value_completed
SELECT SUM(CASE WHEN status = 'completed' AND amount > 150 THEN 1 ELSE 0 END) AS high_value_completed
FROM orders;

-- Tag: sum_discount_coalesce
SELECT SUM(COALESCE(discount, 0)) AS total_discount
FROM orders;

-- Tag: avg_discount_excluding_zero
SELECT AVG(CASE WHEN discount IS NOT NULL AND discount <> 0 THEN discount END) AS average_non_zero_discount
FROM orders;

-- Tag: sum_amount_by_status
SELECT status, SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) AS north_amount
FROM orders
GROUP BY status
ORDER BY status;

-- Tag: avg_completed_amount_by_customer
WITH completed AS (
    SELECT customer, SUM(amount) AS completed_sum, COUNT(*) AS completed_count
    FROM orders
    WHERE status = 'completed'
    GROUP BY customer
),
customers AS (
    SELECT DISTINCT customer FROM orders
)
SELECT
    customers.customer,
    CASE
        WHEN completed.completed_count IS NULL THEN NULL
        ELSE CAST(completed.completed_sum AS FLOAT64) / completed.completed_count
    END AS avg_completed_amount
FROM customers
LEFT JOIN completed ON completed.customer = customers.customer
ORDER BY customers.customer;
