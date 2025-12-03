-- Aggregates DML - SQL:2023
-- Description: Basic DML (insert/update) followed by aggregates.

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id INT64,
    amount INT64
);

INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 150);

UPDATE sales SET amount = amount + 10 WHERE id = 1;

-- Tag: sum_after_update
SELECT SUM(amount) AS total_amount FROM sales;

DELETE FROM sales WHERE id = 2;

-- Tag: count_after_delete
SELECT COUNT(*) AS remaining_rows FROM sales;
