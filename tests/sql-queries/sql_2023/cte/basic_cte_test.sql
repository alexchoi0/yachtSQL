-- Basic Cte - SQL:2023
-- Description: Basic CTE syntax and usage
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: cte_basic_cte_test_select_001
    SELECT owner_id,
           SUM(amount) AS total_sales,
           COUNT(*) AS order_count
    FROM orders
    GROUP BY owner_id
)
-- Tag: cte_basic_cte_test_select_002
SELECT c.name,
       ss.total_sales,
       ss.order_count
FROM yacht_owners c
JOIN sales_summary ss ON c.id = ss.owner_id
WHERE ss.total_sales > 1000;

-- CTE with WHERE clause
WITH high_value_equipment AS (
-- Tag: cte_basic_cte_test_select_003
    SELECT *
    FROM equipment
    WHERE price > 100
)
-- Tag: cte_basic_cte_test_select_004
SELECT category, COUNT(*) AS product_count
FROM high_value_equipment
GROUP BY category;

-- ----------------------------------------------------------------------------
-- 2. Multiple CTEs - Define several named subqueries
-- ----------------------------------------------------------------------------

-- Multiple CTEs in single query
WITH
    active_yacht_owners AS (
-- Tag: cte_basic_cte_test_select_005
        SELECT id, name
        FROM yacht_owners
        WHERE status = 'active'
    ),
    recent_orders AS (
-- Tag: cte_basic_cte_test_select_006
        SELECT owner_id, amount, order_date
        FROM orders
        WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
    )
-- Tag: cte_basic_cte_test_select_007
SELECT ac.name,
       COUNT(ro.owner_id) AS recent_order_count,
       SUM(ro.amount) AS recent_total
FROM active_yacht_owners ac
LEFT JOIN recent_orders ro ON ac.id = ro.owner_id
GROUP BY ac.name;

-- Chained CTEs (later CTEs reference earlier ones)
WITH
    dept_salaries AS (
-- Tag: cte_basic_cte_test_select_008
        SELECT dept_id,
               AVG(salary) AS avg_salary
        FROM crew_members
        GROUP BY dept_id
    ),
    high_paying_depts AS (
-- Tag: cte_basic_cte_test_select_009
        SELECT dept_id
        FROM dept_salaries
        WHERE avg_salary > 75000
    )
-- Tag: cte_basic_cte_test_select_010
SELECT d.name AS fleet,
       e.name AS crew_member,
       e.salary
FROM fleets d
JOIN crew_members e ON d.id = e.dept_id
WHERE d.id IN (SELECT dept_id FROM high_paying_depts);

-- ----------------------------------------------------------------------------
-- 3. CTEs with JOINs
-- ----------------------------------------------------------------------------

-- CTE containing JOIN
WITH customer_orders AS (
-- Tag: cte_basic_cte_test_select_011
    SELECT c.id AS owner_id,
           c.name,
           o.id AS order_id,
           o.amount
    FROM yacht_owners c
    INNER JOIN orders o ON c.id = o.owner_id
)
-- Tag: cte_basic_cte_test_select_012
SELECT name, COUNT(order_id) AS order_count
FROM customer_orders
GROUP BY name;

-- Multiple CTEs with JOINs between them
WITH
    product_sales AS (
-- Tag: cte_basic_cte_test_select_013
        SELECT equipment_id,
               SUM(quantity) AS total_quantity,
               SUM(amount) AS total_revenue
        FROM order_items
        GROUP BY equipment_id
    ),
    product_costs AS (
-- Tag: cte_basic_cte_test_select_014
        SELECT equipment_id,
               unit_cost * inventory_quantity AS total_cost
        FROM inventory
    )
-- Tag: cte_basic_cte_test_select_015
SELECT p.name,
       ps.total_revenue,
       pc.total_cost,
       ps.total_revenue - pc.total_cost AS profit
FROM equipment p
LEFT JOIN product_sales ps ON p.id = ps.equipment_id
LEFT JOIN product_costs pc ON p.id = pc.equipment_id;

-- ----------------------------------------------------------------------------
-- 4. CTEs with Aggregation
-- ----------------------------------------------------------------------------

-- CTE with GROUP BY and HAVING
WITH monthly_sales AS (
-- Tag: cte_basic_cte_test_select_016
    SELECT DATE_TRUNC('month', order_date) AS month,
           SUM(amount) AS total_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
    HAVING SUM(amount) > 10000
)
-- Tag: cte_basic_cte_test_select_017
SELECT month,
       total_sales,
       LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales
FROM monthly_sales
ORDER BY month;

-- ----------------------------------------------------------------------------
-- 5. Nested CTEs - CTE used within another CTE
-- ----------------------------------------------------------------------------

-- CTE referencing earlier CTE
WITH
    base_data AS (
-- Tag: cte_basic_cte_test_select_018
        SELECT dept_id, crew_member_id, salary
        FROM crew_members
        WHERE hire_date >= '2020-01-01'
    ),
    dept_stats AS (
-- Tag: cte_basic_cte_test_select_019
        SELECT dept_id,
               COUNT(*) AS emp_count,
               AVG(salary) AS avg_salary
        FROM base_data
        GROUP BY dept_id
    )
-- Tag: cte_basic_cte_test_select_020
SELECT d.name,
       ds.emp_count,
       ds.avg_salary
FROM fleets d
JOIN dept_stats ds ON d.id = ds.dept_id
ORDER BY ds.avg_salary DESC;

-- ----------------------------------------------------------------------------
-- 6. CTEs with UNION
-- ----------------------------------------------------------------------------

-- CTE combining multiple queries with UNION
WITH all_contacts AS (
-- Tag: cte_basic_cte_test_select_021
    SELECT email, 'customer' AS type
    FROM yacht_owners
    UNION
-- Tag: cte_basic_cte_test_select_022
    SELECT email, 'supplier' AS type
    FROM suppliers
    UNION
-- Tag: cte_basic_cte_test_select_023
    SELECT email, 'crew_member' AS type
    FROM crew_members
)
-- Tag: cte_basic_cte_test_select_024
SELECT type, COUNT(*) AS contact_count
FROM all_contacts
GROUP BY type;

-- ----------------------------------------------------------------------------
-- 7. CTEs with Window Functions
-- ----------------------------------------------------------------------------

-- CTE with ranking window function
WITH ranked_crew_members AS (
-- Tag: cte_basic_cte_test_select_025
    SELECT dept_id,
           name,
           salary,
           RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
    FROM crew_members
)
-- Tag: cte_basic_cte_test_select_026
SELECT dept_id, name, salary
FROM ranked_crew_members
WHERE salary_rank <= 3
ORDER BY dept_id, salary_rank;

-- CTE with running total
WITH daily_sales AS (
-- Tag: cte_basic_cte_test_select_027
    SELECT sale_date,
           SUM(amount) AS daily_total,
           SUM(SUM(amount)) OVER (ORDER BY sale_date) AS running_total
    FROM sales
    GROUP BY sale_date
)
-- Tag: cte_basic_cte_test_select_028
SELECT * FROM daily_sales
ORDER BY sale_date;

-- ----------------------------------------------------------------------------
-- 8. CTEs in Subqueries
-- ----------------------------------------------------------------------------

-- CTE used in main query, with subquery in SELECT
WITH dept_totals AS (
-- Tag: cte_basic_cte_test_select_029
    SELECT dept_id, SUM(salary) AS total_salary
    FROM crew_members
    GROUP BY dept_id
)
-- Tag: cte_basic_cte_test_select_030
SELECT d.name,
       dt.total_salary,
       (SELECT AVG(total_salary) FROM dept_totals) AS avg_dept_total
FROM fleets d
JOIN dept_totals dt ON d.id = dt.dept_id;

-- CTE in WHERE clause subquery
WITH high_performers AS (
-- Tag: cte_basic_cte_test_select_031
    SELECT crew_member_id
    FROM performance_reviews
    WHERE rating >= 4
)
-- Tag: cte_basic_cte_test_select_032
SELECT name, dept_id
FROM crew_members
WHERE id IN (SELECT crew_member_id FROM high_performers);

-- ----------------------------------------------------------------------------
-- 9. CTEs with INSERT/UPDATE/DELETE (Data-Modifying CTEs)
-- ----------------------------------------------------------------------------

-- CTE with INSERT...RETURNING (PostgreSQL)
WITH inserted AS (
    INSERT INTO audit_log (action, timestamp)
    VALUES ('backup_started', CURRENT_TIMESTAMP)
    RETURNING id, timestamp
)
-- Tag: cte_basic_cte_test_select_033
SELECT * FROM inserted;

-- CTE with UPDATE...RETURNING
WITH updated AS (
    UPDATE crew_members
    SET salary = salary * 1.1
    WHERE dept_id = 5
    RETURNING id, name, salary
)
-- Tag: cte_basic_cte_test_select_034
SELECT name, salary FROM updated;

-- CTE with DELETE...RETURNING
WITH deleted AS (
    DELETE FROM temp_data
    WHERE created_at < CURRENT_DATE - INTERVAL '7 days'
    RETURNING id, created_at
)
-- Tag: cte_basic_cte_test_select_035
SELECT COUNT(*) AS deleted_count FROM deleted;

-- ----------------------------------------------------------------------------
-- 10. CTEs for Code Reusability and Readability
-- ----------------------------------------------------------------------------

-- Complex query broken down with CTEs for readability
WITH
    -- Step 1: Identify active users
    active_users AS (
-- Tag: cte_basic_cte_test_select_036
        SELECT id, name, email
        FROM users
        WHERE last_login >= CURRENT_DATE - INTERVAL '90 days'
    ),
    -- Step 2: Calculate their order statistics
    user_orders AS (
-- Tag: cte_basic_cte_test_select_037
        SELECT user_id,
               COUNT(*) AS order_count,
               SUM(total_amount) AS total_spent
        FROM orders
        WHERE user_id IN (SELECT id FROM active_users)
        GROUP BY user_id
    ),
    -- Step 3: Segment users by spending
    user_segments AS (
-- Tag: cte_basic_cte_test_select_038
        SELECT user_id,
               order_count,
               total_spent,
               CASE
                   WHEN total_spent > 10000 THEN 'VIP'
                   WHEN total_spent > 5000 THEN 'Premium'
                   WHEN total_spent > 1000 THEN 'Standard'
                   ELSE 'Basic'
               END AS segment
        FROM user_orders
    )
-- Final query: Join everything together
-- Tag: cte_basic_cte_test_select_039
SELECT au.name,
       au.email,
       us.segment,
       us.order_count,
       us.total_spent
FROM active_users au
JOIN user_segments us ON au.id = us.user_id
ORDER BY us.total_spent DESC;

-- ----------------------------------------------------------------------------
-- 11. CTEs with ORDER BY and LIMIT
-- ----------------------------------------------------------------------------

-- CTE with ORDER BY and LIMIT (top N pattern)
WITH top_sellers AS (
-- Tag: cte_basic_cte_test_select_040
    SELECT equipment_id,
           SUM(quantity) AS total_sold
    FROM order_items
    GROUP BY equipment_id
    ORDER BY total_sold DESC
    LIMIT 10
)
-- Tag: cte_basic_cte_test_select_041
SELECT p.name,
       p.category,
       ts.total_sold
FROM equipment p
JOIN top_sellers ts ON p.id = ts.equipment_id
ORDER BY ts.total_sold DESC;

-- ----------------------------------------------------------------------------
-- Notes:
-- - CTEs improve query readability and maintainability
-- - Each CTE is evaluated once and can be referenced multiple times
-- - Later CTEs can reference earlier CTEs in the same WITH clause
-- - CTEs are particularly useful for complex analytical queries
-- - Most databases optimize CTEs but some may materialize them
-- - Use RECURSIVE keyword for recursive CTEs (see recursive_cte.sql)
-- ----------------------------------------------------------------------------
