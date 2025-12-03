-- Scalar Subqueries - SQL:2023
-- Description: Scalar subqueries returning single values
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: subqueries_scalar_subqueries_test_select_001
SELECT id, (SELECT 42) AS constant
FROM data
ORDER BY id;

-- Scalar subquery with aggregate function
-- Tag: subqueries_scalar_subqueries_test_select_002
SELECT name, salary, (SELECT AVG(salary) FROM crew_members) AS avg_salary
FROM crew_members
ORDER BY name;

-- Scalar subquery in arithmetic expression
-- Tag: subqueries_scalar_subqueries_test_select_003
SELECT name, price, price * (SELECT value FROM settings WHERE key = 'tax_rate') AS tax
FROM equipment
ORDER BY name;

-- Multiple scalar subqueries in SELECT list
-- Tag: subqueries_scalar_subqueries_test_select_004
SELECT id,
       (SELECT min_val FROM stats) AS min_value,
       (SELECT max_val FROM stats) AS max_value
FROM data;

-- ----------------------------------------------------------------------------
-- 2. Correlated Scalar Subqueries - References Outer Query
-- ----------------------------------------------------------------------------

-- Correlated subquery: fleet average for each crew_member
-- Tag: subqueries_scalar_subqueries_test_select_005
SELECT e1.name,
       e1.salary,
       (SELECT AVG(e2.salary)
        FROM crew_members e2
        WHERE e2.dept_id = e1.dept_id) AS dept_avg
FROM crew_members e1
ORDER BY e1.name;

-- Correlated subquery: count related records
-- Tag: subqueries_scalar_subqueries_test_select_006
SELECT d.name,
       (SELECT COUNT(*)
        FROM crew_members e
        WHERE e.dept_id = d.id) AS crew_member_count
FROM fleets d
ORDER BY d.name;

-- Correlated subquery: latest related value
-- Tag: subqueries_scalar_subqueries_test_select_007
SELECT c.name,
       (SELECT MAX(o.order_date)
        FROM orders o
        WHERE o.owner_id = c.id) AS last_order_date
FROM yacht_owners c;

-- Correlated subquery: sum of related records
-- Tag: subqueries_scalar_subqueries_test_select_008
SELECT p.name,
       (SELECT SUM(oi.quantity * oi.price)
        FROM order_items oi
        WHERE oi.equipment_id = p.id) AS total_revenue
FROM equipment p;

-- ----------------------------------------------------------------------------
-- 3. Scalar Subqueries in WHERE Clause
-- ----------------------------------------------------------------------------

-- Compare against scalar subquery result
-- Tag: subqueries_scalar_subqueries_test_select_009
SELECT name, salary
FROM crew_members
WHERE salary > (SELECT AVG(salary) FROM crew_members);

-- Scalar subquery with correlated reference in WHERE
-- Tag: subqueries_scalar_subqueries_test_select_010
SELECT name
FROM crew_members e1
WHERE salary > (SELECT AVG(salary)
                FROM crew_members e2
                WHERE e2.dept_id = e1.dept_id);

-- Multiple conditions with scalar subqueries
-- Tag: subqueries_scalar_subqueries_test_select_011
SELECT name, price
FROM equipment
WHERE price > (SELECT AVG(price) FROM equipment)
  AND price < (SELECT MAX(price) FROM equipment);

-- ----------------------------------------------------------------------------
-- 4. Scalar Subqueries in CASE Expressions
-- ----------------------------------------------------------------------------

-- Scalar subquery inside CASE
-- Tag: subqueries_scalar_subqueries_test_select_012
SELECT name,
       salary,
       CASE
           WHEN salary > (SELECT AVG(salary) FROM crew_members) THEN 'Above Average'
           WHEN salary = (SELECT AVG(salary) FROM crew_members) THEN 'Average'
           ELSE 'Below Average'
       END AS salary_category
FROM crew_members;

-- ----------------------------------------------------------------------------
-- 5. Scalar Subqueries with NULL Handling
-- ----------------------------------------------------------------------------

-- Scalar subquery returning NULL (no matching rows)
-- Tag: subqueries_scalar_subqueries_test_select_013
SELECT c.name,
       (SELECT MAX(o.amount)
        FROM orders o
        WHERE o.owner_id = c.id) AS max_order
FROM yacht_owners c;
-- Returns NULL for yacht_owners with no orders

-- Handle NULL with COALESCE
-- Tag: subqueries_scalar_subqueries_test_select_014
SELECT c.name,
       COALESCE((SELECT MAX(o.amount)
                 FROM orders o
                 WHERE o.owner_id = c.id), 0) AS max_order
FROM yacht_owners c;

-- ----------------------------------------------------------------------------
-- 6. Scalar Subqueries with LIMIT
-- ----------------------------------------------------------------------------

-- Scalar subquery with LIMIT to ensure single row
-- Tag: subqueries_scalar_subqueries_test_select_015
SELECT name,
       (SELECT amount
        FROM orders o
        WHERE o.owner_id = c.id
        ORDER BY amount DESC
        LIMIT 1) AS highest_order
FROM yacht_owners c;

-- ----------------------------------------------------------------------------
-- 7. Scalar Subqueries in JOIN Conditions
-- ----------------------------------------------------------------------------

-- Scalar subquery in ON clause
-- Tag: subqueries_scalar_subqueries_test_select_016
SELECT e.name, e.salary
FROM crew_members e
JOIN fleets d
  ON e.dept_id = d.id
  AND e.salary > (SELECT AVG(salary) FROM crew_members WHERE dept_id = d.id);

-- ----------------------------------------------------------------------------
-- 8. Scalar Subqueries in GROUP BY and HAVING
-- ----------------------------------------------------------------------------

-- Scalar subquery in HAVING clause
-- Tag: subqueries_scalar_subqueries_test_select_017
SELECT dept_id, AVG(salary) AS avg_salary
FROM crew_members
GROUP BY dept_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM crew_members);

-- Scalar subquery in SELECT with GROUP BY
-- Tag: subqueries_scalar_subqueries_test_select_018
SELECT dept_id,
       COUNT(*) AS emp_count,
       (SELECT AVG(salary) FROM crew_members) AS marina_avg
FROM crew_members
GROUP BY dept_id;

-- ----------------------------------------------------------------------------
-- 9. Scalar Subqueries in ORDER BY
-- ----------------------------------------------------------------------------

-- Order by difference from scalar subquery
-- Tag: subqueries_scalar_subqueries_test_select_019
SELECT name, salary
FROM crew_members
ORDER BY ABS(salary - (SELECT AVG(salary) FROM crew_members));

-- ----------------------------------------------------------------------------
-- 10. Nested Scalar Subqueries
-- ----------------------------------------------------------------------------

-- Scalar subquery containing another scalar subquery
-- Tag: subqueries_scalar_subqueries_test_select_020
SELECT name,
       salary,
       (SELECT AVG(salary)
        FROM crew_members
        WHERE dept_id = (SELECT id FROM fleets WHERE name = 'Sales')) AS sales_avg
FROM crew_members;

-- ----------------------------------------------------------------------------
-- 11. Scalar Subqueries with Complex Expressions
-- ----------------------------------------------------------------------------

-- Scalar subquery in arithmetic and logical expressions
-- Tag: subqueries_scalar_subqueries_test_select_021
SELECT name,
       price,
       price * (1 + (SELECT value FROM config WHERE key = 'markup')) AS retail_price,
       price > (SELECT AVG(price) FROM equipment WHERE category = p.category) AS above_category_avg
FROM equipment p;

-- Scalar subquery with STRING functions
-- Tag: subqueries_scalar_subqueries_test_select_022
SELECT name,
       (SELECT STRING_AGG(tag, ', ')
        FROM product_tags
        WHERE equipment_id = p.id) AS tags
FROM equipment p;

-- ----------------------------------------------------------------------------
-- 12. Scalar Subqueries vs Column References
-- ----------------------------------------------------------------------------

-- Compare scalar subquery to direct column
-- Tag: subqueries_scalar_subqueries_test_select_023
SELECT name,
       salary,
       salary - (SELECT AVG(salary) FROM crew_members) AS diff_from_avg
FROM crew_members
ORDER BY diff_from_avg DESC;

-- ----------------------------------------------------------------------------
-- 13. Scalar Subqueries in UPDATE and DELETE
-- ----------------------------------------------------------------------------

-- UPDATE using scalar subquery
UPDATE crew_members
SET salary = salary * (SELECT multiplier FROM adjustments WHERE type = 'annual_raise')
WHERE dept_id = 5;

-- DELETE using scalar subquery comparison
DELETE FROM equipment
WHERE price < (SELECT AVG(price) * 0.5 FROM equipment);

-- ----------------------------------------------------------------------------
-- 14. Scalar Subqueries with Window Functions
-- ----------------------------------------------------------------------------

-- Scalar subquery combined with window function
-- Tag: subqueries_scalar_subqueries_test_select_024
SELECT name,
       salary,
       (SELECT AVG(salary) FROM crew_members) AS marina_avg,
       AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg
FROM crew_members;

-- ----------------------------------------------------------------------------
-- 15. Performance Considerations
-- ----------------------------------------------------------------------------

-- Correlated scalar subquery (executed once per outer row - can be slow)
-- Tag: subqueries_scalar_subqueries_test_select_025
SELECT c.name,
       (SELECT COUNT(*) FROM orders o WHERE o.owner_id = c.id) AS order_count
FROM yacht_owners c;

-- Better alternative: JOIN with aggregation
-- Tag: subqueries_scalar_subqueries_test_select_026
SELECT c.name,
       COUNT(o.id) AS order_count
FROM yacht_owners c
LEFT JOIN orders o ON o.owner_id = c.id
GROUP BY c.name;

-- Non-correlated scalar subquery (executed once - faster)
-- Tag: subqueries_scalar_subqueries_test_select_027
SELECT name, salary, (SELECT AVG(salary) FROM crew_members) AS avg_salary
FROM crew_members;

-- ----------------------------------------------------------------------------
-- 16. Edge Cases
-- ----------------------------------------------------------------------------

-- Scalar subquery with empty table (returns NULL)
-- Tag: subqueries_scalar_subqueries_test_select_028
SELECT (SELECT value FROM empty_table) AS result;
-- Result: NULL

-- Scalar subquery that should return one row but returns zero
-- Tag: subqueries_scalar_subqueries_test_select_029
SELECT name,
       (SELECT amount FROM orders WHERE owner_id = 999) AS amount
FROM yacht_owners;
-- Result: NULL for amount

-- ----------------------------------------------------------------------------
-- 17. Error Conditions
-- ----------------------------------------------------------------------------

-- ERROR: Scalar subquery returns multiple rows (will fail at runtime)
-- SELECT name, (SELECT id FROM crew_members) FROM fleets;
-- Fix: Add WHERE, LIMIT, or aggregate function

-- ERROR: Scalar subquery returns multiple columns (will fail)
-- SELECT name, (SELECT id, name FROM crew_members LIMIT 1) FROM fleets;
-- Fix: Select only one column

-- ----------------------------------------------------------------------------
-- Notes:
-- - Scalar subquery MUST return exactly 1 column
-- - Scalar subquery can return 0 or 1 row (0 rows = NULL)
-- - Correlated subqueries reference columns from outer query
-- - Correlated subqueries execute once per outer row (performance impact)
-- - Non-correlated subqueries execute once for entire query
-- - Use LIMIT 1 to ensure single row when multiple might exist
-- - Common uses: averages, counts, max/min values, lookups
-- ----------------------------------------------------------------------------
