-- Aggregates Misc - SQL:2023
-- Description: Miscellaneous aggregate examples (count/sum/etc. across scenarios).

DROP TABLE IF EXISTS misc_orders;

CREATE TABLE misc_orders (customer STRING, amount INT64);

INSERT INTO misc_orders VALUES ('Alice', 100);
INSERT INTO misc_orders VALUES ('Alice', 200);
INSERT INTO misc_orders VALUES ('Bob', 50);
INSERT INTO misc_orders VALUES ('Charlie', 300);
INSERT INTO misc_orders VALUES ('Charlie', 250);

-- Tag: order_totals
SELECT customer, COUNT(*) AS num_orders, SUM(amount) AS total_amount, AVG(amount) AS avg_amount
FROM misc_orders
GROUP BY customer
ORDER BY customer;

-- Tag: order_totals_over_200
SELECT customer, SUM(amount) AS total_amount
FROM misc_orders
GROUP BY customer
HAVING SUM(amount) > 200
ORDER BY customer;

DROP TABLE IF EXISTS misc_strings;

CREATE TABLE misc_strings (word STRING);

INSERT INTO misc_strings VALUES ('hello');
INSERT INTO misc_strings VALUES ('world');
INSERT INTO misc_strings VALUES ('test');

-- Tag: string_concat
SELECT STRING_AGG(word, ', ' ORDER BY word) AS concatenated
FROM misc_strings;

DROP TABLE IF EXISTS misc_empty;

CREATE TABLE misc_empty (value INT64);

-- Tag: empty_aggregates
SELECT COUNT(*) AS count_rows, SUM(value) AS sum_value
FROM misc_empty;
