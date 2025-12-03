-- Grouping Extensions - SQL:2023
-- Description: Minimal ROLLUP example showing subtotals and grand total.

DROP TABLE IF EXISTS grouping_sales;

CREATE TABLE grouping_sales (
    region STRING,
    product STRING,
    amount INT64
);

INSERT INTO grouping_sales VALUES ('East', 'Widget', 100);
INSERT INTO grouping_sales VALUES ('East', 'Gadget', 150);
INSERT INTO grouping_sales VALUES ('West', 'Widget', 120);

-- Tag: rollup_region_product_small
SELECT region, product, SUM(amount) AS total
FROM grouping_sales
GROUP BY ROLLUP(region, product)
ORDER BY region NULLS LAST, product NULLS LAST;
