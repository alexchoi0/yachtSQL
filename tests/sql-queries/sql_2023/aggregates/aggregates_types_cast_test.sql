-- Aggregates Types Cast - SQL:2023
-- Description: Aggregates that cast strings to numeric types before summation/averaging.

DROP TABLE IF EXISTS cast_orders;

CREATE TABLE cast_orders (
    customer STRING,
    amount_text STRING
);

INSERT INTO cast_orders VALUES ('Alice', '100');
INSERT INTO cast_orders VALUES ('Alice', '150');
INSERT INTO cast_orders VALUES ('Bob', '50');
INSERT INTO cast_orders VALUES ('Bob', NULL);

-- Tag: sum_cast_from_string
SELECT SUM(CAST(amount_text AS INT64)) AS total_amount
FROM cast_orders;

-- Tag: avg_cast_by_customer
SELECT customer, AVG(CAST(amount_text AS INT64)) AS avg_amount
FROM cast_orders
GROUP BY customer
ORDER BY customer;

DROP TABLE IF EXISTS cast_empty;

CREATE TABLE cast_empty (value_text STRING);

-- Tag: empty_cast_aggregate
SELECT SUM(CAST(value_text AS INT64)) AS total FROM cast_empty;
