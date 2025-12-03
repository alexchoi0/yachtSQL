-- Offset Functions - SQL:2023
-- Description: Offset window functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT64,
    month INT64,
    revenue INT64,
    product STRING
);

DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices (
    symbol STRING,
    trade_date DATE,
    price FLOAT64
);

DROP TABLE IF EXISTS time_series;
CREATE TABLE time_series (
    ts TIMESTAMP,
    value INT64,
    category STRING
);

-- ----------------------------------------------------------------------------
-- LAG() - Access Previous Row
-- ----------------------------------------------------------------------------

-- LAG() basic - access previous row value
-- SQL:2023 Part 2, Section 7.14
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget');

-- Tag: window_functions_offset_functions_test_select_001
SELECT
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue
FROM sales
ORDER BY month;
-- Month 1: revenue=100, prev_revenue=NULL
-- Month 2: revenue=150, prev_revenue=100
-- Month 3: revenue=200, prev_revenue=150

-- LAG() with default value
-- Tag: window_functions_offset_functions_test_select_002
SELECT
    month,
    revenue,
    LAG(revenue, 1, 0) OVER (ORDER BY month) as prev_revenue
FROM sales
ORDER BY month;
-- Month 1: revenue=100, prev_revenue=0 (default instead of NULL)
-- Month 2: revenue=150, prev_revenue=100
-- Month 3: revenue=200, prev_revenue=150

-- LAG() with offset > 1
-- Tag: window_functions_offset_functions_test_select_003
SELECT
    month,
    revenue,
    LAG(revenue, 2) OVER (ORDER BY month) as two_months_ago
FROM sales
ORDER BY month;
-- Month 1: revenue=100, two_months_ago=NULL
-- Month 2: revenue=150, two_months_ago=NULL
-- Month 3: revenue=200, two_months_ago=100

-- LAG() with PARTITION BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 1, 80, 'Gadget'),
    (4, 2, 120, 'Gadget');

-- Tag: window_functions_offset_functions_test_select_004
SELECT
    product,
    month,
    revenue,
    LAG(revenue, 1) OVER (PARTITION BY product ORDER BY month) as prev_revenue
FROM sales
ORDER BY product, month;
-- Each product has independent LAG calculation

-- LAG() for calculating change from previous value
-- Tag: window_functions_offset_functions_test_select_005
SELECT
    month,
    revenue,
    revenue - LAG(revenue, 1, 0) OVER (ORDER BY month) as revenue_change,
    revenue - LAG(revenue, 1, revenue) OVER (ORDER BY month) as revenue_change_safe
FROM sales
ORDER BY month;
-- revenue_change: difference from previous month (0 for first month)
-- revenue_change_safe: difference (0 for first month using current value as default)

-- LAG() with percentage change
-- Tag: window_functions_offset_functions_test_select_006
SELECT
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue,
    CASE
        WHEN LAG(revenue, 1) OVER (ORDER BY month) IS NULL THEN NULL
        ELSE ((revenue - LAG(revenue, 1) OVER (ORDER BY month)) * 100.0 / LAG(revenue, 1) OVER (ORDER BY month))
    END as percent_change
FROM sales
ORDER BY month;

-- ----------------------------------------------------------------------------
-- LEAD() - Access Next Row
-- ----------------------------------------------------------------------------

-- LEAD() basic - access next row value
-- SQL:2023 Part 2, Section 7.14
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget');

-- Tag: window_functions_offset_functions_test_select_007
SELECT
    month,
    revenue,
    LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales
ORDER BY month;
-- Month 1: revenue=100, next_revenue=150
-- Month 2: revenue=150, next_revenue=200
-- Month 3: revenue=200, next_revenue=NULL

-- LEAD() with default value
-- Tag: window_functions_offset_functions_test_select_008
SELECT
    month,
    revenue,
    LEAD(revenue, 1, 0) OVER (ORDER BY month) as next_revenue
FROM sales
ORDER BY month;
-- Month 1: revenue=100, next_revenue=150
-- Month 2: revenue=150, next_revenue=200
-- Month 3: revenue=200, next_revenue=0 (default)

-- LEAD() with offset > 1
-- Tag: window_functions_offset_functions_test_select_009
SELECT
    month,
    revenue,
    LEAD(revenue, 2) OVER (ORDER BY month) as two_months_ahead
FROM sales
ORDER BY month;
-- Month 1: revenue=100, two_months_ahead=200
-- Month 2: revenue=150, two_months_ahead=NULL
-- Month 3: revenue=200, two_months_ahead=NULL

-- LEAD() with PARTITION BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 1, 80, 'Gadget'),
    (4, 2, 120, 'Gadget');

-- Tag: window_functions_offset_functions_test_select_010
SELECT
    product,
    month,
    revenue,
    LEAD(revenue, 1) OVER (PARTITION BY product ORDER BY month) as next_revenue
FROM sales
ORDER BY product, month;
-- Each product has independent LEAD calculation

-- LEAD() for forecasting
-- Tag: window_functions_offset_functions_test_select_011
SELECT
    month,
    revenue,
    LEAD(revenue, 1) OVER (ORDER BY month) as forecasted_next,
    CASE
        WHEN LEAD(revenue, 1) OVER (ORDER BY month) IS NOT NULL
        THEN LEAD(revenue, 1) OVER (ORDER BY month) > revenue
        ELSE NULL
    END as will_increase
FROM sales
ORDER BY month;

-- ----------------------------------------------------------------------------
-- LAG() and LEAD() Together
-- ----------------------------------------------------------------------------

-- Compare previous, current, and next values
-- Tag: window_functions_offset_functions_test_select_012
SELECT
    month,
    LAG(revenue, 1) OVER (ORDER BY month) as prev_revenue,
    revenue as current_revenue,
    LEAD(revenue, 1) OVER (ORDER BY month) as next_revenue
FROM sales
ORDER BY month;

-- Calculate moving average using LAG and LEAD
-- Tag: window_functions_offset_functions_test_select_013
SELECT
    month,
    revenue,
    (COALESCE(LAG(revenue, 1) OVER (ORDER BY month), revenue) +
     revenue +
     COALESCE(LEAD(revenue, 1) OVER (ORDER BY month), revenue)) / 3.0 as moving_avg_3
FROM sales
ORDER BY month;

-- Find local maxima (value > prev AND value > next)
-- Tag: window_functions_offset_functions_test_select_014
SELECT
    month,
    revenue,
    CASE
        WHEN revenue > COALESCE(LAG(revenue, 1) OVER (ORDER BY month), 0)
         AND revenue > COALESCE(LEAD(revenue, 1) OVER (ORDER BY month), 0)
        THEN true
        ELSE false
    END as is_local_max
FROM sales
ORDER BY month;

-- ----------------------------------------------------------------------------
-- FIRST_VALUE() - First Value in Window Frame
-- ----------------------------------------------------------------------------

-- FIRST_VALUE() with default frame (RANGE UNBOUNDED PRECEDING)
-- SQL:2023 Part 2, Section 7.14
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget'),
    (4, 4, 180, 'Widget');

-- Tag: window_functions_offset_functions_test_select_015
SELECT
    month,
    revenue,
    FIRST_VALUE(revenue) OVER (ORDER BY month) as first_revenue
FROM sales
ORDER BY month;
-- All rows show 100 (first revenue in ordered set)

-- FIRST_VALUE() with PARTITION BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 1, 80, 'Gadget'),
    (4, 2, 120, 'Gadget');

-- Tag: window_functions_offset_functions_test_select_016
SELECT
    product,
    month,
    revenue,
    FIRST_VALUE(revenue) OVER (PARTITION BY product ORDER BY month) as first_revenue_in_product
FROM sales
ORDER BY product, month;
-- Widget shows 100, Gadget shows 80 (first in each partition)

-- FIRST_VALUE() with explicit frame
-- Tag: window_functions_offset_functions_test_select_017
SELECT
    month,
    revenue,
    FIRST_VALUE(revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as first_revenue
FROM sales
ORDER BY month;

-- FIRST_VALUE() vs initial value comparison
-- Tag: window_functions_offset_functions_test_select_018
SELECT
    month,
    revenue,
    FIRST_VALUE(revenue) OVER (ORDER BY month) as baseline,
    revenue - FIRST_VALUE(revenue) OVER (ORDER BY month) as change_from_baseline,
    ((revenue - FIRST_VALUE(revenue) OVER (ORDER BY month)) * 100.0 /
     FIRST_VALUE(revenue) OVER (ORDER BY month)) as percent_change_from_baseline
FROM sales
ORDER BY month;

-- ----------------------------------------------------------------------------
-- LAST_VALUE() - Last Value in Window Frame
-- ----------------------------------------------------------------------------

-- LAST_VALUE() with ROWS frame (important!)
-- Default frame is RANGE UNBOUNDED PRECEDING, which only includes current row as "last"
-- Must use ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget');

-- Tag: window_functions_offset_functions_test_select_019
SELECT
    month,
    revenue,
    LAST_VALUE(revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as last_revenue
FROM sales
ORDER BY month;
-- All rows show 200 (last revenue in ordered set)

-- LAST_VALUE() with default frame (caution!)
-- Tag: window_functions_offset_functions_test_select_020
SELECT
    month,
    revenue,
    LAST_VALUE(revenue) OVER (ORDER BY month) as last_with_default_frame
FROM sales
ORDER BY month;
-- Each row shows its own revenue (current row is "last" in default frame)

-- LAST_VALUE() with PARTITION BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 1, 80, 'Gadget'),
    (4, 2, 120, 'Gadget');

-- Tag: window_functions_offset_functions_test_select_021
SELECT
    product,
    month,
    revenue,
    LAST_VALUE(revenue) OVER (
        PARTITION BY product
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as last_revenue_in_product
FROM sales
ORDER BY product, month;
-- Widget shows 150, Gadget shows 120 (last in each partition)

-- FIRST_VALUE() and LAST_VALUE() together
-- Tag: window_functions_offset_functions_test_select_022
SELECT
    month,
    revenue,
    FIRST_VALUE(revenue) OVER w as first_val,
    LAST_VALUE(revenue) OVER w as last_val,
    LAST_VALUE(revenue) OVER w - FIRST_VALUE(revenue) OVER w as range
FROM sales
WINDOW w AS (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY month;

-- ----------------------------------------------------------------------------
-- NTH_VALUE() - Nth Value in Window Frame
-- ----------------------------------------------------------------------------

-- NTH_VALUE() basic - get the nth value
-- SQL:2023 Part 2, Section 7.14
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget'),
    (4, 4, 180, 'Widget'),
    (5, 5, 220, 'Widget');

-- Get 2nd value
-- Tag: window_functions_offset_functions_test_select_023
SELECT
    month,
    revenue,
    NTH_VALUE(revenue, 2) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as second_revenue
FROM sales
ORDER BY month;
-- All rows show 150 (2nd revenue)

-- Get 3rd value
-- Tag: window_functions_offset_functions_test_select_024
SELECT
    month,
    revenue,
    NTH_VALUE(revenue, 3) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as third_revenue
FROM sales
ORDER BY month;
-- All rows show 200 (3rd revenue)

-- NTH_VALUE() with PARTITION BY
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget'),
    (4, 1, 80, 'Gadget'),
    (5, 2, 120, 'Gadget');

-- Tag: window_functions_offset_functions_test_select_025
SELECT
    product,
    month,
    revenue,
    NTH_VALUE(revenue, 2) OVER (
        PARTITION BY product
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as second_revenue_in_product
FROM sales
ORDER BY product, month;
-- Widget shows 150, Gadget shows 120

-- NTH_VALUE() when n exceeds row count
-- Tag: window_functions_offset_functions_test_select_026
SELECT
    month,
    revenue,
    NTH_VALUE(revenue, 10) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as tenth_revenue
FROM sales;
-- Returns NULL (only 5 rows)

-- Get median using NTH_VALUE (for odd count)
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, 150, 'Widget'),
    (3, 3, 200, 'Widget'),
    (4, 4, 250, 'Widget'),
    (5, 5, 300, 'Widget');

-- Tag: window_functions_offset_functions_test_select_027
SELECT
    NTH_VALUE(revenue, 3) OVER (
        ORDER BY revenue
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as median_revenue
FROM sales
LIMIT 1;
-- Middle value of 5 sorted values = 3rd value = 200

-- ----------------------------------------------------------------------------
-- Complex Offset Scenarios
-- ----------------------------------------------------------------------------

-- Running comparison with first value
-- Tag: window_functions_offset_functions_test_select_028
SELECT
    month,
    revenue,
    FIRST_VALUE(revenue) OVER (ORDER BY month) as baseline,
    LAG(revenue, 1) OVER (ORDER BY month) as prev,
    LEAD(revenue, 1) OVER (ORDER BY month) as next,
    revenue > LAG(revenue, 1, revenue) OVER (ORDER BY month) as up_from_prev,
    revenue < LEAD(revenue, 1, revenue) OVER (ORDER BY month) as down_to_next
FROM sales
ORDER BY month;

-- Multi-step LAG/LEAD
-- Tag: window_functions_offset_functions_test_select_029
SELECT
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as lag_1,
    LAG(revenue, 2) OVER (ORDER BY month) as lag_2,
    LAG(revenue, 3) OVER (ORDER BY month) as lag_3,
    LEAD(revenue, 1) OVER (ORDER BY month) as lead_1,
    LEAD(revenue, 2) OVER (ORDER BY month) as lead_2
FROM sales
ORDER BY month;

-- Stock price analysis example
DELETE FROM stock_prices;
INSERT INTO stock_prices VALUES
    ('AAPL', DATE '2024-01-01', 150.00),
    ('AAPL', DATE '2024-01-02', 152.50),
    ('AAPL', DATE '2024-01-03', 151.00),
    ('AAPL', DATE '2024-01-04', 153.75),
    ('AAPL', DATE '2024-01-05', 155.00);

-- Tag: window_functions_offset_functions_test_select_030
SELECT
    trade_date,
    price,
    price - LAG(price, 1) OVER (ORDER BY trade_date) as daily_change,
    ((price - LAG(price, 1) OVER (ORDER BY trade_date)) * 100.0 /
     LAG(price, 1) OVER (ORDER BY trade_date)) as daily_pct_change,
    price - FIRST_VALUE(price) OVER (ORDER BY trade_date) as change_from_start,
    FIRST_VALUE(price) OVER (ORDER BY trade_date) as period_low,
    LAST_VALUE(price) OVER (
        ORDER BY trade_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as period_high
FROM stock_prices
ORDER BY trade_date;

-- ----------------------------------------------------------------------------
-- Edge Cases
-- ----------------------------------------------------------------------------

-- Single row
DELETE FROM sales;
INSERT INTO sales VALUES (1, 1, 100, 'Widget');

-- Tag: window_functions_offset_functions_test_select_031
SELECT
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as prev,
    LEAD(revenue, 1) OVER (ORDER BY month) as next,
    FIRST_VALUE(revenue) OVER (ORDER BY month) as first_val,
    LAST_VALUE(revenue) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as last_val
FROM sales;

-- NULL values in data
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget'),
    (2, 2, NULL, 'Widget'),
    (3, 3, 200, 'Widget');

-- Tag: window_functions_offset_functions_test_select_032
SELECT
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as prev,
    LEAD(revenue, 1) OVER (ORDER BY month) as next
FROM sales
ORDER BY month;
-- NULL values are preserved in LAG/LEAD

-- Empty partition
DELETE FROM sales;
INSERT INTO sales VALUES
    (1, 1, 100, 'Widget');

-- Tag: window_functions_offset_functions_test_select_033
SELECT
    product,
    month,
    revenue,
    LAG(revenue, 1) OVER (PARTITION BY product ORDER BY month) as prev
FROM sales
WHERE product = 'Gadget';  -- No rows match

-- Large offset
-- Tag: window_functions_offset_functions_test_select_034
SELECT
    month,
    revenue,
    LAG(revenue, 100) OVER (ORDER BY month) as far_back,
    LEAD(revenue, 100) OVER (ORDER BY month) as far_ahead
FROM sales;
-- Offset exceeds window size: returns NULL

-- ----------------------------------------------------------------------------
-- Cleanup
-- ----------------------------------------------------------------------------

