-- Aggregates DDL - SQL:2023
-- Description: Demonstrates aggregates after DDL alterations.

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id INT64,
    amount INT64
);

ALTER TABLE sales ADD COLUMN tax INT64 DEFAULT 0;

INSERT INTO sales (id, amount, tax) VALUES (1, 100, 10);
INSERT INTO sales (id, amount) VALUES (2, 150);

-- Tag: sum_with_added_column
SELECT SUM(amount + tax) AS total_with_tax FROM sales;
