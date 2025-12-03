-- Basic Joins - SQL:2023
-- Description: Basic JOIN operations and join conditions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: joins_basic_joins_test_select_001
SELECT yacht_owners.name, orders.amount
FROM yacht_owners
INNER JOIN orders ON yacht_owners.id = orders.owner_id;

-- INNER JOIN with additional WHERE clause
-- Tag: joins_basic_joins_test_select_002
SELECT yacht_owners.name, orders.amount
FROM yacht_owners
INNER JOIN orders ON yacht_owners.id = orders.owner_id
WHERE orders.amount > 150.0;

-- INNER JOIN with multiple conditions (AND)
-- Tag: joins_basic_joins_test_select_003
SELECT equipment.name, inventory.quantity
FROM equipment
INNER JOIN inventory
  ON equipment.id = inventory.equipment_id
  AND equipment.category = inventory.product_category;

-- ----------------------------------------------------------------------------
-- 2. LEFT OUTER JOIN - Returns all rows from left table + matching right rows
-- ----------------------------------------------------------------------------

-- Basic LEFT JOIN (returns yacht_owners even without orders)
-- Tag: joins_basic_joins_test_select_004
SELECT yacht_owners.name, orders.amount
FROM yacht_owners
LEFT JOIN orders ON yacht_owners.id = orders.owner_id;

-- LEFT JOIN to find records with no match (NULL check)
-- Tag: joins_basic_joins_test_select_005
SELECT yacht_owners.name
FROM yacht_owners
LEFT JOIN orders ON yacht_owners.id = orders.owner_id
WHERE orders.order_id IS NULL;

-- ----------------------------------------------------------------------------
-- 3. RIGHT OUTER JOIN - Returns all rows from right table + matching left rows
-- ----------------------------------------------------------------------------

-- Basic RIGHT JOIN (returns fleets even without crew_members)
-- Tag: joins_basic_joins_test_select_006
SELECT crew_members.name, fleets.dept_name
FROM crew_members
RIGHT JOIN fleets ON crew_members.id = fleets.crew_member_id;

-- ----------------------------------------------------------------------------
-- 4. FULL OUTER JOIN - Returns all rows from both tables
-- ----------------------------------------------------------------------------

-- Basic FULL OUTER JOIN (includes unmatched rows from both sides)
-- Tag: joins_basic_joins_test_select_007
SELECT table_a.value AS a_value, table_b.value AS b_value
FROM table_a
FULL OUTER JOIN table_b ON table_a.id = table_b.id;

-- ----------------------------------------------------------------------------
-- 5. CROSS JOIN - Cartesian product of both tables
-- ----------------------------------------------------------------------------

-- Explicit CROSS JOIN syntax
-- Tag: joins_basic_joins_test_select_008
SELECT colors.color, sizes.size
FROM colors
CROSS JOIN sizes;

-- Implicit CROSS JOIN (comma syntax)
-- Tag: joins_basic_joins_test_select_009
SELECT colors.color, sizes.size
FROM colors, sizes;

-- ----------------------------------------------------------------------------
-- 6. SELF JOIN - Table joined with itself
-- ----------------------------------------------------------------------------

-- Self-join to find crew_member-manager pairs
-- Tag: joins_basic_joins_test_select_010
SELECT e1.name AS crew_member, e2.name AS manager
FROM crew_members e1
LEFT JOIN crew_members e2 ON e1.manager_id = e2.id;

-- Self-join to find pairs with matching criteria
-- Tag: joins_basic_joins_test_select_011
SELECT u1.id AS id1, u2.id AS id2
FROM users u1
JOIN users u2
  ON u1.city = u2.city
  AND u1.age = u2.age
  AND u1.id < u2.id
ORDER BY u1.id, u2.id;

-- Self-join to compare consecutive rows
-- Tag: joins_basic_joins_test_select_012
SELECT m1.day, m1.value AS today, m2.value AS tomorrow,
       m2.value - m1.value AS change
FROM metrics m1
JOIN metrics m2 ON m2.day = m1.day + 1
ORDER BY m1.day;

-- ----------------------------------------------------------------------------
-- 7. MULTIPLE JOINS - Joining more than two tables
-- ----------------------------------------------------------------------------

-- Chain of INNER JOINs
-- Tag: joins_basic_joins_test_select_013
SELECT users.name, equipment.name
FROM orders
INNER JOIN users ON orders.user_id = users.id
INNER JOIN equipment ON orders.equipment_id = equipment.id;

-- Mixed join types (INNER and LEFT)
-- Tag: joins_basic_joins_test_select_014
SELECT c.name, o.id AS order_id, p.amount AS payment_amount
FROM yacht_owners c
INNER JOIN orders o ON o.owner_id = c.id
LEFT JOIN payments p ON p.order_id = o.id
ORDER BY c.id, o.id;

-- ----------------------------------------------------------------------------
-- 8. JOIN with USING clause - Shorthand when column names match
-- ----------------------------------------------------------------------------

-- JOIN USING single column (alternative to ON table1.id = table2.id)
-- Tag: joins_basic_joins_test_select_015
SELECT c.name, o.amount
FROM yacht_owners c
JOIN orders2 o USING (id)
ORDER BY c.id;

-- JOIN USING multiple columns
-- Tag: joins_basic_joins_test_select_016
SELECT a, b, val1, val2
FROM t1
JOIN t2 USING (a, b)
ORDER BY a, b;

-- ----------------------------------------------------------------------------
-- 9. NATURAL JOIN - Implicit join on all columns with matching names
-- ----------------------------------------------------------------------------

-- NATURAL JOIN (automatically joins on all common column names)
-- Tag: joins_basic_joins_test_select_017
SELECT *
FROM table1
NATURAL JOIN table2;

-- ----------------------------------------------------------------------------
-- 10. JOIN with AGGREGATION
-- ----------------------------------------------------------------------------

-- JOIN with GROUP BY and aggregates
-- Tag: joins_basic_joins_test_select_018
SELECT yacht_owners.name,
       COUNT(*) AS order_count,
       SUM(orders.amount) AS total
FROM yacht_owners
INNER JOIN orders ON yacht_owners.id = orders.owner_id
GROUP BY yacht_owners.name;

-- ----------------------------------------------------------------------------
-- 11. JOIN with ORDER BY
-- ----------------------------------------------------------------------------

-- JOIN results sorted by joined column
-- Tag: joins_basic_joins_test_select_019
SELECT yacht_owners.name, orders.amount
FROM yacht_owners
INNER JOIN orders ON yacht_owners.id = orders.owner_id
ORDER BY orders.amount DESC;

-- ----------------------------------------------------------------------------
-- 12. JOIN with LIMIT
-- ----------------------------------------------------------------------------

-- Limit results after JOIN
-- Tag: joins_basic_joins_test_select_020
SELECT yacht_owners.name, orders.amount
FROM yacht_owners
INNER JOIN orders ON yacht_owners.id = orders.owner_id
LIMIT 2;

-- ----------------------------------------------------------------------------
-- 13. JOIN on expressions and computed columns
-- ----------------------------------------------------------------------------

-- JOIN on range condition
-- Tag: joins_basic_joins_test_select_021
SELECT p.item, p.price, d.discount
FROM prices p
JOIN discounts d
  ON p.price >= d.min_price
  AND p.price < d.max_price
ORDER BY p.id;

-- JOIN on computed column (expression in ON clause)
-- Tag: joins_basic_joins_test_select_022
SELECT t1.id, t1.value, t2.double_value
FROM t1
JOIN t2 ON t2.double_value = t1.value * 2
ORDER BY t1.id;

-- JOIN using functions in condition
-- Tag: joins_basic_joins_test_select_023
SELECT u.email, d.domain
FROM users u
JOIN domains d
  ON SUBSTRING(u.email, POSITION('@' IN u.email) + 1) = d.domain
ORDER BY u.id;

-- ----------------------------------------------------------------------------
-- 14. JOIN with empty tables (edge cases)
-- ----------------------------------------------------------------------------

-- JOIN where one table is empty (returns no rows for INNER JOIN)
-- Tag: joins_basic_joins_test_select_024
SELECT *
FROM table1
INNER JOIN table2 ON table1.id = table2.id;
-- Result: 0 rows if table2 is empty

-- LEFT JOIN with empty right table (returns left rows with NULL)
-- Tag: joins_basic_joins_test_select_025
SELECT table1.*, table2.*
FROM table1
LEFT JOIN table2 ON table1.id = table2.id;
-- Result: All table1 rows with NULL for table2 columns
