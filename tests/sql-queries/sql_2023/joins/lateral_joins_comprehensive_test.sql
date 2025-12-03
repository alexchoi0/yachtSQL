-- LATERAL Joins - SQL:2023 Compliance Suite
-- Description: SQL:2023 Feature T491 covering LATERAL joins and correlations
-- PostgreSQL: Pending LATERAL implementation
-- BigQuery: Pending LATERAL implementation
-- SQL Standard: SQL:2023 Feature T491
-- Notes: SQL:2023 core (PostgreSQL/BigQuery adaptors normalize syntax)

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_join_basic_correlation
-- **Baseline Case:** Simple LATERAL join referencing outer table
-- **Example:** For each customer, get their top 3 orders

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES
        (1, 'Alice'),
        (2, 'Bob');

CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);

INSERT INTO orders VALUES
        (1, 1, 100), (2, 1, 200), (3, 1, 150), (4, 1, 300),  -- Alice: 4 orders
        (5, 2, 500), (6, 2, 600)                               -- Bob: 2 orders;

-- Tag: joins_lateral_joins_comprehensive_test_select_001
SELECT c.name, o.order_id, o.amount
         FROM customers c,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_002
             SELECT order_id, amount
             FROM orders
             WHERE orders.customer_id = c.customer_id  -- Correlation!
             ORDER BY amount DESC
             LIMIT 3
         ) o
         ORDER BY c.customer_id, o.amount DESC;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_vs_non_lateral
-- **Comparison Case:** Show difference between LATERAL and non-LATERAL
-- **Important:** Non-LATERAL cannot reference outer table

CREATE TABLE departments (dept_id INT64, dept_name STRING);

INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');

CREATE TABLE employees (emp_id INT64, dept_id INT64, name STRING);

INSERT INTO employees VALUES
        (1, 1, 'Alice'), (2, 1, 'Bob'),
        (3, 2, 'Charlie');

-- Tag: joins_lateral_joins_comprehensive_test_select_003
SELECT d.dept_name, e.name
         FROM departments d,
         (SELECT name FROM employees WHERE dept_id = d.dept_id) e  -- ERROR: d not in scope
         ORDER BY d.dept_id;

-- Tag: joins_lateral_joins_comprehensive_test_select_004
SELECT d.dept_name, e.name
         FROM departments d,
         LATERAL (SELECT name FROM employees WHERE dept_id = d.dept_id) e
         ORDER BY d.dept_id, e.name;

-- ---------------------------------------------------------------------------
-- Source ID: test_left_join_lateral_empty_subquery
-- **Critical Case:** LEFT JOIN LATERAL when subquery returns no rows
-- **Contrast:** INNER JOIN would eliminate the row

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES
        (1, 'Alice'),
        (2, 'Bob'),    -- Bob has no orders
        (3, 'Charlie');

CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);

INSERT INTO orders VALUES
        (1, 1, 100),
        (2, 3, 200)
        -- No orders for customer_id=2 (Bob);

-- Tag: joins_lateral_joins_comprehensive_test_select_005
SELECT c.name, o.order_id, o.amount
         FROM customers c
         LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_006
             SELECT order_id, amount
             FROM orders
             WHERE orders.customer_id = c.customer_id
         ) o ON TRUE
         ORDER BY c.customer_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_inner_join_lateral_filters_empty
-- **Comparison:** INNER JOIN LATERAL eliminates rows with empty subquery
-- **Contrast with LEFT JOIN:** No NULLs, just fewer rows

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');

CREATE TABLE orders (order_id INT64, customer_id INT64);

INSERT INTO orders VALUES (1, 1);

-- Tag: joins_lateral_joins_comprehensive_test_select_007
SELECT c.name, o.order_id
         FROM customers c
         INNER JOIN LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_008
             SELECT order_id FROM orders WHERE orders.customer_id = c.customer_id
         ) o ON TRUE
         ORDER BY c.name;

-- ---------------------------------------------------------------------------
-- Source ID: test_nested_lateral_joins
-- **Complex Case:** LATERAL within LATERAL
-- **Challenge:** Inner LATERAL can reference both outer tables

CREATE TABLE countries (country_id INT64, country_name STRING);

INSERT INTO countries VALUES (1, 'USA'), (2, 'Canada');

CREATE TABLE states (state_id INT64, country_id INT64, state_name STRING);

INSERT INTO states VALUES
        (1, 1, 'California'), (2, 1, 'Texas'),
        (3, 2, 'Ontario');

CREATE TABLE cities (city_id INT64, state_id INT64, city_name STRING, population INT64);

INSERT INTO cities VALUES
        (1, 1, 'Los Angeles', 4000000), (2, 1, 'San Francisco', 900000),
        (3, 2, 'Houston', 2300000),
        (4, 3, 'Toronto', 2900000);

-- Tag: joins_lateral_joins_comprehensive_test_select_001
SELECT
            co.country_name,
            s.state_name,
            c.city_name,
            c.population
         FROM countries co,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_009
             SELECT state_id, state_name
             FROM states
             WHERE states.country_id = co.country_id  -- First correlation
         ) s,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_010
             SELECT city_name, population
             FROM cities
             WHERE cities.state_id = s.state_id       -- Second correlation
             ORDER BY population DESC
             LIMIT 1                                   -- Top city per state
         ) c
         ORDER BY co.country_id, s.state_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_multiple_correlations
-- **Complex Case:** LATERAL subquery references multiple outer tables
-- **Example:** Join on composite key from two outer tables

CREATE TABLE products (product_id INT64, product_name STRING);

INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget');

CREATE TABLE warehouses (warehouse_id INT64, location STRING);

INSERT INTO warehouses VALUES (1, 'NYC'), (2, 'LA');

CREATE TABLE inventory (product_id INT64, warehouse_id INT64, quantity INT64);

INSERT INTO inventory VALUES
        (1, 1, 100), (1, 2, 200),
        (2, 1, 50)
        -- Product 2 not in warehouse 2;

-- Tag: joins_lateral_joins_comprehensive_test_select_002
SELECT
            p.product_name,
            w.location,
            i.quantity
         FROM products p
         CROSS JOIN warehouses w
         LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_011
             SELECT quantity
             FROM inventory
             WHERE inventory.product_id = p.product_id      -- First correlation
               AND inventory.warehouse_id = w.warehouse_id  -- Second correlation
         ) i ON TRUE
         ORDER BY p.product_id, w.warehouse_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_with_aggregates
-- **Integration:** LATERAL subquery with GROUP BY and aggregates
-- **Example:** For each department, get aggregated employee stats

CREATE TABLE departments (dept_id INT64, dept_name STRING);

INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');

CREATE TABLE employees (emp_id INT64, dept_id INT64, salary INT64);

INSERT INTO employees VALUES
        (1, 1, 100000), (2, 1, 120000), (3, 1, 110000),  -- Engineering
        (4, 2, 80000), (5, 2, 90000)                      -- Sales;

-- Tag: joins_lateral_joins_comprehensive_test_select_003
SELECT
            d.dept_name,
            stats.emp_count,
            stats.avg_salary,
            stats.max_salary
         FROM departments d,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_004
             SELECT
                 COUNT(*) AS emp_count,
                 AVG(salary) AS avg_salary,
                 MAX(salary) AS max_salary
             FROM employees e
             WHERE e.dept_id = d.dept_id  -- Correlation
         ) stats
         ORDER BY d.dept_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_with_window_functions
-- **Integration:** LATERAL with window functions
-- **Example:** For each customer, get running total of their orders

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');

CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE, amount INT64);

INSERT INTO orders VALUES
        (1, 1, '2024-01-01', 100),
        (2, 1, '2024-01-05', 200),
        (3, 1, '2024-01-10', 150),
        (4, 2, '2024-01-03', 300);

-- Tag: joins_lateral_joins_comprehensive_test_select_005
SELECT
            c.name,
            o.order_date,
            o.amount,
            o.running_total
         FROM customers c,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_006
             SELECT
                 order_date,
                 amount,
                 SUM(amount) OVER (ORDER BY order_date) AS running_total
             FROM orders
             WHERE orders.customer_id = c.customer_id  -- Correlation
             ORDER BY order_date
         ) o
         ORDER BY c.customer_id, o.order_date;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_unnest_array
-- **Set-Returning Case:** LATERAL UNNEST to expand arrays
-- **Example:** For each user, expand their tags array into rows

CREATE TABLE users (user_id INT64, name STRING, tags ARRAY<STRING>);

INSERT INTO users VALUES
        (1, 'Alice', ['admin', 'verified', 'premium']),
        (2, 'Bob', ['verified']),
        (3, 'Charlie', [])  -- Empty array;

-- Tag: joins_lateral_joins_comprehensive_test_select_007
SELECT
            u.name,
            t.tag
         FROM users u,
         LATERAL UNNEST(u.tags) AS t(tag)
         ORDER BY u.user_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_left_join_lateral_unnest_empty_array
-- **Edge Case:** LEFT JOIN LATERAL UNNEST on empty array

CREATE TABLE users (user_id INT64, name STRING, tags ARRAY<STRING>);

INSERT INTO users VALUES
        (1, 'Alice', ['admin']),
        (2, 'Bob', [])  -- Empty array;

-- Tag: joins_lateral_joins_comprehensive_test_select_008
SELECT
            u.name,
            t.tag
         FROM users u
         LEFT JOIN LATERAL UNNEST(u.tags) AS t(tag) ON TRUE
         ORDER BY u.user_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_limit_top_n_per_group
-- **Common Pattern:** Top-N per group using LATERAL + LIMIT
-- **Example:** Top 2 highest-paid employees per department

CREATE TABLE departments (dept_id INT64, dept_name STRING);

INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');

CREATE TABLE employees (emp_id INT64, dept_id INT64, name STRING, salary INT64);

INSERT INTO employees VALUES
        (1, 1, 'Alice', 150000), (2, 1, 'Bob', 120000), (3, 1, 'Charlie', 110000),
        (4, 2, 'Dave', 90000), (5, 2, 'Eve', 85000), (6, 2, 'Frank', 80000);

-- Tag: joins_lateral_joins_comprehensive_test_select_009
SELECT
            d.dept_name,
            e.name,
            e.salary
         FROM departments d,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_012
             SELECT name, salary
             FROM employees
             WHERE employees.dept_id = d.dept_id
             ORDER BY salary DESC
             LIMIT 2  -- Top 2 per department
         ) e
         ORDER BY d.dept_id, e.salary DESC;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_offset_pagination
-- **Edge Case:** LATERAL with OFFSET (skip first N rows per group)
-- **Example:** Get employees ranked 3-5 per department

CREATE TABLE departments (dept_id INT64);

INSERT INTO departments VALUES (1);

CREATE TABLE employees (emp_id INT64, dept_id INT64, rank INT64);

INSERT INTO employees VALUES
        (1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), (5, 1, 5), (6, 1, 6);

-- Tag: joins_lateral_joins_comprehensive_test_select_013
SELECT e.emp_id, e.rank
         FROM departments d,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_014
             SELECT emp_id, rank
             FROM employees
             WHERE employees.dept_id = d.dept_id
             ORDER BY rank
             LIMIT 3 OFFSET 2  -- Skip first 2, get next 3
         ) e
         ORDER BY e.rank;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_invalid_correlation_order
-- **Error Condition:** LATERAL can only reference tables to its LEFT
-- **Example:** Try to reference table that appears later in FROM clause
-- NOTE: Referencing tables to the right of LATERAL should raise an error.

CREATE TABLE a (id INT64);

CREATE TABLE b (id INT64, a_id INT64);

INSERT INTO a VALUES (1);

INSERT INTO b VALUES (1, 1);

-- Tag: joins_lateral_joins_comprehensive_test_select_015
SELECT *
         FROM LATERAL (SELECT id FROM b WHERE b.a_id = a.id) AS lat,
         a;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_without_correlation_redundant
-- **Non-Error but Redundant:** LATERAL without any correlation

CREATE TABLE a (id INT64);

CREATE TABLE b (id INT64);

INSERT INTO a VALUES (1), (2);

INSERT INTO b VALUES (10), (20);

-- Tag: joins_lateral_joins_comprehensive_test_select_016
SELECT a.id, b.id
         FROM a,
         LATERAL (SELECT id FROM b) b  -- No correlation, LATERAL is redundant
         ORDER BY a.id, b.id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_performance_large_outer
-- **Performance Case:** LATERAL with 1000 outer rows
-- **Challenge:** Subquery executed 1000 times (once per outer row)
-- NOTE: Populates 1000 outer rows and 10k inner rows via Rust loops (not expanded here).

CREATE TABLE outer_table (id INT64);

CREATE TABLE inner_table (id INT64, outer_id INT64, value INT64);

-- Tag: joins_lateral_joins_comprehensive_test_select_017
SELECT o.id, i.value
         FROM outer_table o,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_018
             SELECT value
             FROM inner_table
             WHERE inner_table.outer_id = o.id
             LIMIT 1
         ) i
         LIMIT 100;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_complex_subquery
-- **Integration:** LATERAL with complex subquery (JOIN, WHERE, GROUP BY, HAVING, ORDER BY)
-- **Challenge:** Full SQL feature support within LATERAL subquery

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');

CREATE TABLE orders (order_id INT64, customer_id INT64, product_id INT64, amount INT64);

INSERT INTO orders VALUES
        (1, 1, 100, 50), (2, 1, 100, 30), (3, 1, 200, 70),
        (4, 2, 100, 40);

CREATE TABLE products (product_id INT64, category STRING);

INSERT INTO products VALUES (100, 'Electronics'), (200, 'Books');

-- Tag: joins_lateral_joins_comprehensive_test_select_010
SELECT
            c.name,
            cat.category,
            cat.total_amount
         FROM customers c,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_011
             SELECT
                 p.category,
                 SUM(o.amount) AS total_amount
             FROM orders o
             JOIN products p ON o.product_id = p.product_id
             WHERE o.customer_id = c.customer_id  -- Correlation
             GROUP BY p.category
             HAVING SUM(o.amount) > 50            -- Filter aggregates
             ORDER BY SUM(o.amount) DESC
             LIMIT 1                               -- Top category per customer
         ) cat
         ORDER BY c.customer_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_union_in_subquery
-- **Integration:** LATERAL subquery contains UNION
-- **Example:** Combine multiple sources per outer row

CREATE TABLE users (user_id INT64, name STRING);

INSERT INTO users VALUES (1, 'Alice');

CREATE TABLE email_log (user_id INT64, event STRING);

INSERT INTO email_log VALUES (1, 'sent');

CREATE TABLE sms_log (user_id INT64, event STRING);

INSERT INTO sms_log VALUES (1, 'delivered');

-- Tag: joins_lateral_joins_comprehensive_test_select_019
SELECT u.name, events.event
         FROM users u,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_020
             SELECT event FROM email_log WHERE user_id = u.user_id
             UNION ALL
-- Tag: joins_lateral_joins_comprehensive_test_select_021
             SELECT event FROM sms_log WHERE user_id = u.user_id
         ) events
         ORDER BY events.event;

-- ---------------------------------------------------------------------------
-- Source ID: test_lateral_with_cte
-- **Integration:** LATERAL subquery references CTE
-- **Challenge:** Scope resolution across CTE and LATERAL

CREATE TABLE customers (customer_id INT64, name STRING);

INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');

CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);

INSERT INTO orders VALUES
        (1, 1, 100), (2, 1, 200),
        (3, 2, 150);

WITH high_value_orders AS (
-- Tag: joins_lateral_joins_comprehensive_test_select_022
             SELECT order_id, customer_id, amount
             FROM orders
             WHERE amount > 100
         )
-- Tag: joins_lateral_joins_comprehensive_test_select_012
         SELECT
             c.name,
             hvo.order_id,
             hvo.amount
         FROM customers c,
         LATERAL (
-- Tag: joins_lateral_joins_comprehensive_test_select_023
             SELECT order_id, amount
             FROM high_value_orders
             WHERE high_value_orders.customer_id = c.customer_id  -- Correlation
             ORDER BY amount DESC
         ) hvo
         ORDER BY c.customer_id;
