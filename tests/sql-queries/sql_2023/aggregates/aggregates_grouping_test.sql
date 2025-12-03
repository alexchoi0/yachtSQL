-- Aggregates Grouping - SQL:2023
-- Description: ROLLUP over (region, product) with deterministic totals.

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    region STRING,
    product STRING,
    amount INT64
);

INSERT INTO sales VALUES ('East', 'Widget', 100);
INSERT INTO sales VALUES ('South', 'Widget', 120);
INSERT INTO sales VALUES ('West', 'Widget', 200);

-- Tag: rollup_region_product
SELECT region, product, SUM(amount) AS total
FROM sales
GROUP BY ROLLUP(region, product)
ORDER BY region, product;
