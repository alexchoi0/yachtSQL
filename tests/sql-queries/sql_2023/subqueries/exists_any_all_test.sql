-- Exists Any All - SQL:2023
-- Description: EXISTS, ANY, and ALL subquery operators
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: subqueries_exists_any_all_test_select_001
SELECT name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_002
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
);

-- EXISTS with SELECT * (columns don't matter, only row existence)
-- Tag: subqueries_exists_any_all_test_select_003
SELECT name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_004
    SELECT *
    FROM orders o
    WHERE o.owner_id = c.id
);

-- EXISTS with complex condition
-- Tag: subqueries_exists_any_all_test_select_005
SELECT name
FROM equipment p
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_006
    SELECT 1
    FROM sales s
    WHERE s.equipment_id = p.id
      AND s.quantity > 75
);

-- EXISTS with JOIN in subquery
-- Tag: subqueries_exists_any_all_test_select_007
SELECT name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_008
    SELECT 1
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    WHERE o.owner_id = c.id
      AND oi.equipment_id = 123
);

-- Multiple EXISTS conditions (AND)
-- Tag: subqueries_exists_any_all_test_select_009
SELECT name
FROM crew_members e
WHERE EXISTS (SELECT 1 FROM projects p WHERE p.manager_id = e.id)
  AND EXISTS (SELECT 1 FROM certifications c WHERE c.crew_member_id = e.id);

-- Multiple EXISTS conditions (OR)
-- Tag: subqueries_exists_any_all_test_select_010
SELECT name
FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id)
   OR EXISTS (SELECT 1 FROM reviews r WHERE r.user_id = u.id);

-- ----------------------------------------------------------------------------
-- 2. NOT EXISTS - Check if subquery returns no rows
-- ----------------------------------------------------------------------------

-- Basic NOT EXISTS - find yacht_owners with no orders
-- Tag: subqueries_exists_any_all_test_select_011
SELECT name
FROM yacht_owners c
WHERE NOT EXISTS (
-- Tag: subqueries_exists_any_all_test_select_012
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
);

-- NOT EXISTS with date range
-- Tag: subqueries_exists_any_all_test_select_013
SELECT name
FROM yacht_owners c
WHERE NOT EXISTS (
-- Tag: subqueries_exists_any_all_test_select_014
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
      AND o.order_date >= CURRENT_DATE - INTERVAL '90 days'
);

-- NOT EXISTS for anti-join pattern (find orphaned records)
-- Tag: subqueries_exists_any_all_test_select_015
SELECT name
FROM equipment p
WHERE NOT EXISTS (
-- Tag: subqueries_exists_any_all_test_select_016
    SELECT 1
    FROM order_items oi
    WHERE oi.equipment_id = p.id
);

-- Double negative pattern (NOT EXISTS with negative condition)
-- Tag: subqueries_exists_any_all_test_select_017
SELECT name
FROM crew_members e
WHERE NOT EXISTS (
-- Tag: subqueries_exists_any_all_test_select_018
    SELECT 1
    FROM absences a
    WHERE a.crew_member_id = e.id
      AND a.date >= CURRENT_DATE - INTERVAL '30 days'
);

-- ----------------------------------------------------------------------------
-- 3. IN with Subquery - Membership test
-- ----------------------------------------------------------------------------

-- Basic IN with subquery
-- Tag: subqueries_exists_any_all_test_select_019
SELECT name
FROM crew_members
WHERE dept_id IN (
-- Tag: subqueries_exists_any_all_test_select_020
    SELECT id
    FROM fleets
    WHERE location = 'New York'
);

-- IN with correlated subquery
-- Tag: subqueries_exists_any_all_test_select_021
SELECT name, salary
FROM crew_members e1
WHERE salary IN (
-- Tag: subqueries_exists_any_all_test_select_022
    SELECT MAX(salary)
    FROM crew_members e2
    WHERE e2.dept_id = e1.dept_id
);

-- IN with multiple values from subquery
-- Tag: subqueries_exists_any_all_test_select_023
SELECT product_name
FROM equipment
WHERE category_id IN (
-- Tag: subqueries_exists_any_all_test_select_024
    SELECT id
    FROM categories
    WHERE active = true
);

-- ----------------------------------------------------------------------------
-- 4. NOT IN with Subquery - Negative membership test
-- ----------------------------------------------------------------------------

-- Basic NOT IN - find crew_members not in specific fleets
-- Tag: subqueries_exists_any_all_test_select_025
SELECT name
FROM crew_members
WHERE dept_id NOT IN (
-- Tag: subqueries_exists_any_all_test_select_026
    SELECT id
    FROM fleets
    WHERE name IN ('HR', 'Finance')
);

-- NOT IN to find unmatched records
-- Tag: subqueries_exists_any_all_test_select_027
SELECT name
FROM equipment
WHERE id NOT IN (
-- Tag: subqueries_exists_any_all_test_select_028
    SELECT DISTINCT equipment_id
    FROM sales
    WHERE sale_date >= '2024-01-01'
);

-- NOT IN with NULL handling (important edge case)
-- Note: NOT IN returns NULL if subquery contains NULL
-- Tag: subqueries_exists_any_all_test_select_029
SELECT name
FROM crew_members
WHERE dept_id NOT IN (
-- Tag: subqueries_exists_any_all_test_select_030
    SELECT id FROM fleets WHERE id IS NOT NULL
);

-- ----------------------------------------------------------------------------
-- 5. ANY / SOME - Compare against any value in subquery
-- ----------------------------------------------------------------------------

-- Compare with ANY (= ANY is equivalent to IN)
-- Tag: subqueries_exists_any_all_test_select_031
SELECT name, salary
FROM crew_members
WHERE salary > ANY (
-- Tag: subqueries_exists_any_all_test_select_032
    SELECT salary
    FROM crew_members
    WHERE dept_id = 5
);

-- Greater than ANY (greater than at least one)
-- Tag: subqueries_exists_any_all_test_select_033
SELECT product_name, price
FROM equipment
WHERE price > ANY (
-- Tag: subqueries_exists_any_all_test_select_034
    SELECT price
    FROM equipment
    WHERE category = 'Electronics'
);

-- Less than ANY
-- Tag: subqueries_exists_any_all_test_select_035
SELECT name, age
FROM users
WHERE age < ANY (
-- Tag: subqueries_exists_any_all_test_select_036
    SELECT age
    FROM users
    WHERE country = 'USA'
);

-- Equals ANY (same as IN)
-- Tag: subqueries_exists_any_all_test_select_037
SELECT name
FROM crew_members
WHERE dept_id = ANY (
-- Tag: subqueries_exists_any_all_test_select_038
    SELECT id
    FROM fleets
    WHERE budget > 1000000
);

-- SOME is synonym for ANY
-- Tag: subqueries_exists_any_all_test_select_039
SELECT name
FROM crew_members
WHERE salary > SOME (
-- Tag: subqueries_exists_any_all_test_select_040
    SELECT salary
    FROM crew_members
    WHERE title = 'Manager'
);

-- ----------------------------------------------------------------------------
-- 6. ALL - Compare against all values in subquery
-- ----------------------------------------------------------------------------

-- Greater than ALL (greater than every value)
-- Tag: subqueries_exists_any_all_test_select_041
SELECT name, salary
FROM crew_members
WHERE salary > ALL (
-- Tag: subqueries_exists_any_all_test_select_042
    SELECT salary
    FROM crew_members
    WHERE dept_id = 3
);

-- Less than ALL (less than every value)
-- Tag: subqueries_exists_any_all_test_select_043
SELECT product_name, price
FROM equipment
WHERE price < ALL (
-- Tag: subqueries_exists_any_all_test_select_044
    SELECT price
    FROM equipment
    WHERE category = 'Premium'
);

-- Equals ALL (only true if subquery returns single distinct value)
-- Tag: subqueries_exists_any_all_test_select_045
SELECT name
FROM crew_members
WHERE dept_id = ALL (
-- Tag: subqueries_exists_any_all_test_select_046
    SELECT dept_id
    FROM crew_members
    WHERE title = 'CEO'
);

-- Not equals ALL (different from all values, equivalent to NOT IN)
-- Tag: subqueries_exists_any_all_test_select_047
SELECT name
FROM crew_members
WHERE dept_id <> ALL (
-- Tag: subqueries_exists_any_all_test_select_048
    SELECT id
    FROM fleets
    WHERE location = 'Remote'
);

-- ----------------------------------------------------------------------------
-- 7. EXISTS vs IN - Performance and Semantics
-- ----------------------------------------------------------------------------

-- EXISTS pattern (short-circuits on first match)
-- Tag: subqueries_exists_any_all_test_select_049
SELECT name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_050
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
);

-- Equivalent IN pattern (may materialize full subquery)
-- Tag: subqueries_exists_any_all_test_select_051
SELECT name
FROM yacht_owners
WHERE id IN (
-- Tag: subqueries_exists_any_all_test_select_052
    SELECT DISTINCT owner_id
    FROM orders
);

-- EXISTS is better for checking existence (stops at first match)
-- IN is better when you need the actual values or distinct is important

-- ----------------------------------------------------------------------------
-- 8. Correlated vs Non-Correlated Subqueries
-- ----------------------------------------------------------------------------

-- Non-correlated subquery (executes once)
-- Tag: subqueries_exists_any_all_test_select_053
SELECT name
FROM crew_members
WHERE dept_id IN (
-- Tag: subqueries_exists_any_all_test_select_054
    SELECT id
    FROM fleets
    WHERE budget > 500000
);

-- Correlated subquery (executes once per outer row)
-- Tag: subqueries_exists_any_all_test_select_055
SELECT name, salary
FROM crew_members e1
WHERE salary > (
-- Tag: subqueries_exists_any_all_test_select_056
    SELECT AVG(salary)
    FROM crew_members e2
    WHERE e2.dept_id = e1.dept_id
);

-- ----------------------------------------------------------------------------
-- 9. Nested Subqueries with EXISTS
-- ----------------------------------------------------------------------------

-- Nested EXISTS (3 levels deep)
-- Tag: subqueries_exists_any_all_test_select_057
SELECT c.name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_058
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
      AND EXISTS (
-- Tag: subqueries_exists_any_all_test_select_059
          SELECT 1
          FROM order_items oi
          WHERE oi.order_id = o.id
            AND EXISTS (
-- Tag: subqueries_exists_any_all_test_select_060
                SELECT 1
                FROM equipment p
                WHERE p.id = oi.equipment_id
                  AND p.category = 'Electronics'
            )
      )
);

-- ----------------------------------------------------------------------------
-- 10. EXISTS with Aggregation
-- ----------------------------------------------------------------------------

-- EXISTS with HAVING in subquery
-- Tag: subqueries_exists_any_all_test_select_061
SELECT d.name
FROM fleets d
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_062
    SELECT 1
    FROM crew_members e
    WHERE e.dept_id = d.id
    GROUP BY e.dept_id
    HAVING COUNT(*) > 10
);

-- EXISTS with aggregated condition
-- Tag: subqueries_exists_any_all_test_select_063
SELECT p.name
FROM equipment p
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_064
    SELECT 1
    FROM order_items oi
    WHERE oi.equipment_id = p.id
    GROUP BY oi.equipment_id
    HAVING SUM(oi.quantity) > 100
);

-- ----------------------------------------------------------------------------
-- 11. Edge Cases
-- ----------------------------------------------------------------------------

-- EXISTS with empty subquery result (returns false)
-- Tag: subqueries_exists_any_all_test_select_065
SELECT name
FROM yacht_owners
WHERE EXISTS (SELECT 1 FROM orders WHERE 1=0);
-- Returns 0 rows

-- NOT EXISTS with empty subquery result (returns true)
-- Tag: subqueries_exists_any_all_test_select_066
SELECT name
FROM yacht_owners
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE 1=0);
-- Returns all yacht_owners

-- IN with empty subquery (returns false)
-- Tag: subqueries_exists_any_all_test_select_067
SELECT name
FROM crew_members
WHERE dept_id IN (SELECT id FROM fleets WHERE 1=0);
-- Returns 0 rows

-- NOT IN with NULL in subquery (returns NULL/false for all rows)
-- Tag: subqueries_exists_any_all_test_select_068
SELECT name
FROM crew_members
WHERE dept_id NOT IN (1, 2, NULL);
-- Returns 0 rows due to NULL handling

-- ANY with empty subquery (comparison undefined)
-- Tag: subqueries_exists_any_all_test_select_069
SELECT name
FROM crew_members
WHERE salary > ANY (SELECT salary FROM crew_members WHERE 1=0);
-- Returns 0 rows

-- ALL with empty subquery (returns true)
-- Tag: subqueries_exists_any_all_test_select_070
SELECT name
FROM crew_members
WHERE salary > ALL (SELECT salary FROM crew_members WHERE 1=0);
-- Returns all crew_members (vacuous truth)

-- ----------------------------------------------------------------------------
-- 12. SEMI JOIN and ANTI JOIN Patterns
-- ----------------------------------------------------------------------------

-- SEMI JOIN (using EXISTS) - yacht_owners who have orders
-- Tag: subqueries_exists_any_all_test_select_071
SELECT c.name, c.email
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_072
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
);

-- ANTI JOIN (using NOT EXISTS) - yacht_owners without orders
-- Tag: subqueries_exists_any_all_test_select_073
SELECT c.name, c.email
FROM yacht_owners c
WHERE NOT EXISTS (
-- Tag: subqueries_exists_any_all_test_select_074
    SELECT 1
    FROM orders o
    WHERE o.owner_id = c.id
);

-- SEMI JOIN alternative (using IN)
-- Tag: subqueries_exists_any_all_test_select_075
SELECT c.name, c.email
FROM yacht_owners c
WHERE c.id IN (
-- Tag: subqueries_exists_any_all_test_select_076
    SELECT DISTINCT owner_id
    FROM orders
);

-- ANTI JOIN alternative (using NOT IN with NULL safety)
-- Tag: subqueries_exists_any_all_test_select_077
SELECT c.name, c.email
FROM yacht_owners c
WHERE c.id NOT IN (
-- Tag: subqueries_exists_any_all_test_select_078
    SELECT owner_id
    FROM orders
    WHERE owner_id IS NOT NULL
);

-- ----------------------------------------------------------------------------
-- 13. Complex Conditions with Multiple Operators
-- ----------------------------------------------------------------------------

-- Combining EXISTS and IN
-- Tag: subqueries_exists_any_all_test_select_079
SELECT name
FROM equipment p
WHERE p.category_id IN (SELECT id FROM categories WHERE active = true)
  AND EXISTS (SELECT 1 FROM reviews r WHERE r.equipment_id = p.id AND r.rating >= 4);

-- Combining NOT EXISTS and NOT IN
-- Tag: subqueries_exists_any_all_test_select_080
SELECT name
FROM crew_members e
WHERE e.dept_id NOT IN (SELECT id FROM fleets WHERE location = 'Remote')
  AND NOT EXISTS (SELECT 1 FROM absences a WHERE a.crew_member_id = e.id);

-- ALL and ANY together
-- Tag: subqueries_exists_any_all_test_select_081
SELECT name, salary
FROM crew_members
WHERE salary > ANY (SELECT salary FROM crew_members WHERE dept_id = 1)
  AND salary < ALL (SELECT salary FROM crew_members WHERE title = 'CEO');

-- ----------------------------------------------------------------------------
-- 14. Short-Circuit Evaluation
-- ----------------------------------------------------------------------------

-- EXISTS short-circuits after finding first match (performance optimization)
-- Tag: subqueries_exists_any_all_test_select_082
SELECT c.name
FROM yacht_owners c
WHERE EXISTS (
-- Tag: subqueries_exists_any_all_test_select_083
    SELECT 1  -- SELECT 1 is conventional, doesn't matter what is selected
    FROM orders o
    WHERE o.owner_id = c.id
    LIMIT 1  -- LIMIT is redundant with EXISTS but explicit
);

-- ----------------------------------------------------------------------------
-- Notes:
-- - EXISTS: Returns true if subquery returns at least one row
-- - NOT EXISTS: Returns true if subquery returns zero rows
-- - IN: Returns true if value matches any value in subquery
-- - NOT IN: Returns true if value matches no value in subquery
--   WARNING: NOT IN returns NULL/false if subquery contains NULL
-- - ANY: Returns true if comparison is true for at least one subquery value
-- - ALL: Returns true if comparison is true for all subquery values
-- - SOME: Synonym for ANY
-- - EXISTS usually faster than IN for existence checks (short-circuits)
-- - IN better when you need distinct values or small result sets
-- - Correlated subqueries run once per outer row (can be slow)
-- - Non-correlated subqueries run once for entire query (faster)
-- ----------------------------------------------------------------------------
