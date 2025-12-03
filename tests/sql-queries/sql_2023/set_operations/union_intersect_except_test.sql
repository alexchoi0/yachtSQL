-- Union Intersect Except - SQL:2023
-- Description: UNION, INTERSECT, and EXCEPT set operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: set_operations_union_intersect_except_test_select_001
SELECT id, name FROM yacht_owners
UNION
-- Tag: set_operations_union_intersect_except_test_select_002
SELECT id, name FROM suppliers;

-- UNION with WHERE clauses
-- Tag: set_operations_union_intersect_except_test_select_003
SELECT equipment_id, product_name FROM equipment WHERE category = 'Electronics'
UNION
-- Tag: set_operations_union_intersect_except_test_select_004
SELECT equipment_id, product_name FROM equipment WHERE price > 1000;

-- UNION multiple queries (more than 2)
-- Tag: set_operations_union_intersect_except_test_select_005
SELECT id FROM table_a
UNION
-- Tag: set_operations_union_intersect_except_test_select_006
SELECT id FROM table_b
UNION
-- Tag: set_operations_union_intersect_except_test_select_007
SELECT id FROM table_c;

-- UNION with ORDER BY (applies to final result)
-- Tag: set_operations_union_intersect_except_test_select_008
SELECT name FROM crew_members
UNION
-- Tag: set_operations_union_intersect_except_test_select_009
SELECT name FROM contractors
ORDER BY name ASC;

-- ----------------------------------------------------------------------------
-- 2. UNION ALL - Combine results and keep duplicates
-- ----------------------------------------------------------------------------

-- Basic UNION ALL (keeps all rows including duplicates)
-- Tag: set_operations_union_intersect_except_test_select_010
SELECT id, value FROM t1
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_011
SELECT id, value FROM t2;

-- UNION ALL is faster than UNION (no deduplication)
-- Tag: set_operations_union_intersect_except_test_select_012
SELECT n FROM odds
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_013
SELECT n FROM evens;

-- Multiple UNION ALL in sequence
-- Tag: set_operations_union_intersect_except_test_select_014
SELECT n FROM nums
UNION ALL SELECT n FROM nums
UNION ALL SELECT n FROM nums;
-- Returns each row 3 times

-- UNION ALL with different sources
-- Tag: set_operations_union_intersect_except_test_select_015
SELECT email, 'customer' AS source FROM yacht_owners
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_016
SELECT email, 'crew_member' AS source FROM crew_members
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_017
SELECT email, 'supplier' AS source FROM suppliers;

-- ----------------------------------------------------------------------------
-- 3. INTERSECT - Return only rows that appear in both result sets
-- ----------------------------------------------------------------------------

-- Basic INTERSECT (common rows, duplicates removed)
-- Tag: set_operations_union_intersect_except_test_select_018
SELECT id FROM set1
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_019
SELECT id FROM set2;

-- INTERSECT with conditions
-- Tag: set_operations_union_intersect_except_test_select_020
SELECT equipment_id FROM sales WHERE region = 'North'
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_021
SELECT equipment_id FROM sales WHERE region = 'South';
-- Products sold in both regions

-- Multiple INTERSECT operations
-- Tag: set_operations_union_intersect_except_test_select_022
SELECT id FROM t1
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_023
SELECT id FROM t2
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_024
SELECT id FROM t3;
-- IDs that appear in all three tables

-- ----------------------------------------------------------------------------
-- 4. INTERSECT ALL - Return common rows, preserving duplicates
-- ----------------------------------------------------------------------------

-- INTERSECT ALL keeps duplicates based on minimum count
-- Tag: set_operations_union_intersect_except_test_select_025
SELECT value FROM set1  -- Contains: 1, 2, 2, 3
INTERSECT ALL
-- Tag: set_operations_union_intersect_except_test_select_026
SELECT value FROM set2  -- Contains: 2, 2, 2, 4
-- Result: 2, 2 (minimum of 2 occurrences in set1 and 3 in set2)

-- INTERSECT ALL vs INTERSECT comparison
-- Tag: set_operations_union_intersect_except_test_select_027
SELECT n FROM a  -- Contains: 1, 1, 2
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_028
SELECT n FROM b;  -- Contains: 1, 1, 1, 2
-- Result: 1, 2 (distinct)

-- Tag: set_operations_union_intersect_except_test_select_029
SELECT n FROM a
INTERSECT ALL
-- Tag: set_operations_union_intersect_except_test_select_030
SELECT n FROM b;
-- Result: 1, 1, 2 (min count from both sides)

-- ----------------------------------------------------------------------------
-- 5. EXCEPT - Return rows from first query not in second query
-- ----------------------------------------------------------------------------

-- Basic EXCEPT (rows in left but not in right)
-- Tag: set_operations_union_intersect_except_test_select_031
SELECT id FROM all_equipment
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_032
SELECT id FROM sold_equipment;
-- Products never sold

-- EXCEPT with conditions
-- Tag: set_operations_union_intersect_except_test_select_033
SELECT owner_id FROM yacht_owners
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_034
SELECT owner_id FROM orders WHERE order_date >= '2024-01-01';
-- Customers with no recent orders

-- Multiple EXCEPT operations
-- Tag: set_operations_union_intersect_except_test_select_035
SELECT id FROM set1
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_036
SELECT id FROM set2
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_037
SELECT id FROM set3;
-- IDs in set1 but not in set2 or set3

-- ----------------------------------------------------------------------------
-- 6. EXCEPT ALL - Remove matching rows, preserving duplicates
-- ----------------------------------------------------------------------------

-- EXCEPT ALL removes minimum occurrences
-- Tag: set_operations_union_intersect_except_test_select_038
SELECT value FROM left_set   -- Contains: 1, 1, 1, 2, 3
EXCEPT ALL
-- Tag: set_operations_union_intersect_except_test_select_039
SELECT value FROM right_set  -- Contains: 1, 2, 2
-- Result: 1, 1, 3 (removed one 1 and one 2)

-- EXCEPT ALL vs EXCEPT comparison
-- Tag: set_operations_union_intersect_except_test_select_040
SELECT n FROM x  -- Contains: 1, 1, 2, 2, 3
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_041
SELECT n FROM y;  -- Contains: 2
-- Result: 1, 3 (removes all 2s)

-- Tag: set_operations_union_intersect_except_test_select_042
SELECT n FROM x
EXCEPT ALL
-- Tag: set_operations_union_intersect_except_test_select_043
SELECT n FROM y;
-- Result: 1, 1, 2, 3 (removes only one 2)

-- ----------------------------------------------------------------------------
-- 7. Type Coercion in Set Operations
-- ----------------------------------------------------------------------------

-- UNION with INT64 and FLOAT64 (coerces to FLOAT64)
-- Tag: set_operations_union_intersect_except_test_select_044
SELECT val FROM ints      -- INT64: 1, 2, 3
UNION
-- Tag: set_operations_union_intersect_except_test_select_045
SELECT val FROM floats;   -- FLOAT64: 3.5, 4.5
-- Result: 1.0, 2.0, 3.0, 3.5, 4.5 (all FLOAT64)

-- UNION ALL also performs type coercion
-- Tag: set_operations_union_intersect_except_test_select_046
SELECT val FROM ints
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_047
SELECT val FROM floats;
-- All values promoted to FLOAT64

-- Three-way UNION with mixed types
-- Tag: set_operations_union_intersect_except_test_select_048
SELECT val FROM t1   -- INT64
UNION
-- Tag: set_operations_union_intersect_except_test_select_049
SELECT val FROM t2   -- FLOAT64
UNION
-- Tag: set_operations_union_intersect_except_test_select_050
SELECT val FROM t3;  -- INT64
-- All coerced to FLOAT64

-- ----------------------------------------------------------------------------
-- 8. Set Operations with NULL Values
-- ----------------------------------------------------------------------------

-- UNION with NULLs (NULLs are treated as equal for deduplication)
-- Tag: set_operations_union_intersect_except_test_select_051
SELECT val FROM t1  -- Contains: 1, NULL
UNION
-- Tag: set_operations_union_intersect_except_test_select_052
SELECT val FROM t2; -- Contains: 2, NULL
-- Result: 1, 2, NULL (one NULL, not two)

-- INTERSECT with NULLs
-- Tag: set_operations_union_intersect_except_test_select_053
SELECT val FROM t1  -- Contains: 1, NULL, 2
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_054
SELECT val FROM t2; -- Contains: NULL, 2, 3
-- Result: NULL, 2

-- EXCEPT with NULLs
-- Tag: set_operations_union_intersect_except_test_select_055
SELECT val FROM t1  -- Contains: 1, NULL, 2
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_056
SELECT val FROM t2; -- Contains: NULL, 3
-- Result: 1, 2 (NULL is removed)

-- ----------------------------------------------------------------------------
-- 9. Set Operations with ORDER BY
-- ----------------------------------------------------------------------------

-- ORDER BY applies to final result set
(SELECT n FROM odds)
UNION
(SELECT n FROM evens)
ORDER BY n DESC;

-- ORDER BY with column alias
-- Tag: set_operations_union_intersect_except_test_select_057
SELECT name AS person_name FROM crew_members
UNION
-- Tag: set_operations_union_intersect_except_test_select_058
SELECT name FROM yacht_owners
ORDER BY person_name;

-- ORDER BY with expression
-- Tag: set_operations_union_intersect_except_test_select_059
SELECT value FROM set1
UNION
-- Tag: set_operations_union_intersect_except_test_select_060
SELECT value FROM set2
ORDER BY LENGTH(value), value;

-- ----------------------------------------------------------------------------
-- 10. Operator Precedence
-- ----------------------------------------------------------------------------

-- INTERSECT has higher precedence than UNION
-- Tag: set_operations_union_intersect_except_test_select_061
SELECT n FROM t1
UNION
-- Tag: set_operations_union_intersect_except_test_select_062
SELECT n FROM t2
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_063
SELECT n FROM t3;
-- Interpreted as: t1 UNION (t2 INTERSECT t3)

-- Use parentheses to control precedence
(SELECT n FROM t1 UNION SELECT n FROM t2)
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_064
SELECT n FROM t3;
-- Different result: (t1 UNION t2) INTERSECT t3

-- EXCEPT has same precedence as UNION (left-to-right)
-- Tag: set_operations_union_intersect_except_test_select_065
SELECT n FROM t1
UNION
-- Tag: set_operations_union_intersect_except_test_select_066
SELECT n FROM t2
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_067
SELECT n FROM t3;
-- Evaluated left-to-right: (t1 UNION t2) EXCEPT t3

-- ----------------------------------------------------------------------------
-- 11. Set Operations with Complex Queries
-- ----------------------------------------------------------------------------

-- UNION with JOINs
-- Tag: set_operations_union_intersect_except_test_select_068
SELECT e.name, d.dept_name
FROM crew_members e
JOIN fleets d ON e.dept_id = d.id
WHERE e.active = true
UNION
-- Tag: set_operations_union_intersect_except_test_select_069
SELECT c.name, 'Contractor' AS dept_name
FROM contractors c
WHERE c.status = 'active';

-- INTERSECT with aggregation
-- Tag: set_operations_union_intersect_except_test_select_070
SELECT owner_id
FROM orders
WHERE order_date >= '2024-01-01'
GROUP BY owner_id
HAVING SUM(amount) > 1000
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_071
SELECT owner_id
FROM premium_members;

-- EXCEPT with subquery
-- Tag: set_operations_union_intersect_except_test_select_072
SELECT equipment_id
FROM inventory
WHERE quantity > 0
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_073
SELECT equipment_id
FROM (
-- Tag: set_operations_union_intersect_except_test_select_074
    SELECT equipment_id
    FROM order_items
    WHERE order_date >= CURRENT_DATE - INTERVAL '90 days'
) recent_sales;

-- ----------------------------------------------------------------------------
-- 12. Set Operations with CTEs
-- ----------------------------------------------------------------------------

-- CTE used in set operations
WITH active_users AS (
-- Tag: set_operations_union_intersect_except_test_select_075
    SELECT id, name FROM users WHERE active = true
)
-- Tag: set_operations_union_intersect_except_test_select_076
SELECT id, name FROM active_users
UNION
-- Tag: set_operations_union_intersect_except_test_select_077
SELECT id, name FROM guests;

-- Set operations within CTE
WITH all_contacts AS (
-- Tag: set_operations_union_intersect_except_test_select_078
    SELECT email FROM yacht_owners
    UNION
-- Tag: set_operations_union_intersect_except_test_select_079
    SELECT email FROM suppliers
    UNION
-- Tag: set_operations_union_intersect_except_test_select_080
    SELECT email FROM crew_members
)
-- Tag: set_operations_union_intersect_except_test_select_081
SELECT * FROM all_contacts
WHERE email LIKE '%@marina.com';

-- ----------------------------------------------------------------------------
-- 13. Column Count and Name Matching
-- ----------------------------------------------------------------------------

-- Columns must match in count
-- Tag: set_operations_union_intersect_except_test_select_082
SELECT id, name FROM t1
UNION
-- Tag: set_operations_union_intersect_except_test_select_083
SELECT id, name FROM t2;
-- OK: Both have 2 columns

-- Column names come from first query
-- Tag: set_operations_union_intersect_except_test_select_084
SELECT id AS user_id, name AS user_name FROM users
UNION
-- Tag: set_operations_union_intersect_except_test_select_085
SELECT id, name FROM guests;
-- Result columns named: user_id, user_name

-- Type compatibility required
-- Tag: set_operations_union_intersect_except_test_select_086
SELECT id FROM t1        -- INT64
UNION
-- Tag: set_operations_union_intersect_except_test_select_087
SELECT name FROM t2;     -- STRING
-- ERROR: Incompatible types (unless database coerces)

-- ----------------------------------------------------------------------------
-- 14. Combining Different Set Operations
-- ----------------------------------------------------------------------------

-- Mix of UNION, INTERSECT, EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_088
SELECT id FROM set_a
UNION
-- Tag: set_operations_union_intersect_except_test_select_089
SELECT id FROM set_b
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_090
SELECT id FROM set_c
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_091
SELECT id FROM set_d;
-- Precedence: INTERSECT > UNION/EXCEPT (left-to-right)

-- Use parentheses for clarity
(
    (SELECT id FROM set_a UNION SELECT id FROM set_b)
    INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_092
    SELECT id FROM set_c
)
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_093
SELECT id FROM set_d;

-- ----------------------------------------------------------------------------
-- 15. Set Operations with LIMIT
-- ----------------------------------------------------------------------------

-- LIMIT on individual queries (parentheses required)
(SELECT name FROM crew_members ORDER BY hire_date DESC LIMIT 10)
UNION
(SELECT name FROM contractors ORDER BY start_date DESC LIMIT 10)
ORDER BY name;

-- LIMIT on final result
-- Tag: set_operations_union_intersect_except_test_select_094
SELECT name FROM crew_members
UNION
-- Tag: set_operations_union_intersect_except_test_select_095
SELECT name FROM contractors
ORDER BY name
LIMIT 20;

-- ----------------------------------------------------------------------------
-- 16. Performance Considerations
-- ----------------------------------------------------------------------------

-- UNION ALL is faster than UNION (no deduplication overhead)
-- Tag: set_operations_union_intersect_except_test_select_096
SELECT id FROM large_table_1
UNION ALL  -- Faster
-- Tag: set_operations_union_intersect_except_test_select_097
SELECT id FROM large_table_2;

-- Tag: set_operations_union_intersect_except_test_select_098
SELECT id FROM large_table_1
UNION      -- Slower (must deduplicate)
-- Tag: set_operations_union_intersect_except_test_select_099
SELECT id FROM large_table_2;

-- If you know there are no duplicates, use UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_100
SELECT id FROM table_2024
UNION ALL
-- Tag: set_operations_union_intersect_except_test_select_101
SELECT id FROM table_2023;
-- Faster and correct if years don't overlap

-- ----------------------------------------------------------------------------
-- 17. Edge Cases
-- ----------------------------------------------------------------------------

-- UNION with empty result set
-- Tag: set_operations_union_intersect_except_test_select_102
SELECT id FROM table1 WHERE 1=0
UNION
-- Tag: set_operations_union_intersect_except_test_select_103
SELECT id FROM table2;
-- Returns only table2 results

-- INTERSECT with empty result set
-- Tag: set_operations_union_intersect_except_test_select_104
SELECT id FROM table1
INTERSECT
-- Tag: set_operations_union_intersect_except_test_select_105
SELECT id FROM table2 WHERE 1=0;
-- Returns empty result

-- EXCEPT with empty right side
-- Tag: set_operations_union_intersect_except_test_select_106
SELECT id FROM table1
EXCEPT
-- Tag: set_operations_union_intersect_except_test_select_107
SELECT id FROM table2 WHERE 1=0;
-- Returns all table1 results

-- All empty
-- Tag: set_operations_union_intersect_except_test_select_108
SELECT id FROM table1 WHERE 1=0
UNION
-- Tag: set_operations_union_intersect_except_test_select_109
SELECT id FROM table2 WHERE 1=0;
-- Returns empty result

-- ----------------------------------------------------------------------------
-- 18. Advanced Patterns
-- ----------------------------------------------------------------------------

-- Symmetric difference (rows in A or B but not both)
(SELECT id FROM set_a EXCEPT SELECT id FROM set_b)
UNION
(SELECT id FROM set_b EXCEPT SELECT id FROM set_a);

-- Full outer join simulation with UNION
-- Tag: set_operations_union_intersect_except_test_select_110
SELECT a.id, a.val, b.val
FROM table_a a
LEFT JOIN table_b b ON a.id = b.id
UNION
-- Tag: set_operations_union_intersect_except_test_select_111
SELECT b.id, a.val, b.val
FROM table_b b
LEFT JOIN table_a a ON b.id = a.id;

-- ----------------------------------------------------------------------------
-- Notes:
-- - UNION: Combines results, removes duplicates
-- - UNION ALL: Combines results, keeps duplicates (faster)
-- - INTERSECT: Returns common rows (duplicates removed)
-- - INTERSECT ALL: Returns common rows (preserves duplicates)
-- - EXCEPT: Returns rows in first query not in second
-- - EXCEPT ALL: Returns rows accounting for duplicate counts
-- - Column count must match between queries
-- - Column types must be compatible (auto-coercion may apply)
-- - Column names come from first query
-- - ORDER BY applies to final combined result
-- - INTERSECT has higher precedence than UNION/EXCEPT
-- - Use parentheses to control precedence
-- - UNION ALL is much faster when duplicates don't matter
-- - NULL values are treated as equal in set operations
-- ----------------------------------------------------------------------------
