-- Recursive Cte - SQL:2023
-- Description: Recursive CTEs for hierarchical and graph queries
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: cte_recursive_cte_test_select_001
    SELECT 1 AS n

    UNION ALL

    -- Recursive case: Add 1 until we reach 10
-- Tag: cte_recursive_cte_test_select_002
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
-- Tag: cte_recursive_cte_test_select_003
SELECT * FROM numbers;

-- Generate sequence with custom increment
WITH RECURSIVE evens AS (
-- Tag: cte_recursive_cte_test_select_004
    SELECT 0 AS n
    UNION ALL
-- Tag: cte_recursive_cte_test_select_005
    SELECT n + 2
    FROM evens
    WHERE n < 10
)
-- Tag: cte_recursive_cte_test_select_006
SELECT * FROM evens;

-- ----------------------------------------------------------------------------
-- 2. Mathematical Sequences - Fibonacci, Factorial
-- ----------------------------------------------------------------------------

-- Fibonacci sequence (first 10 numbers)
WITH RECURSIVE fibonacci AS (
    -- Base case: F(0) = 0, F(1) = 1
-- Tag: cte_recursive_cte_test_select_007
    SELECT 0 AS fib, 1 AS next_fib, 1 AS n

    UNION ALL

    -- Recursive case: F(n+1) = F(n) + F(n-1)
-- Tag: cte_recursive_cte_test_select_008
    SELECT next_fib,
           fib + next_fib,
           n + 1
    FROM fibonacci
    WHERE n < 10
)
-- Tag: cte_recursive_cte_test_select_009
SELECT fib FROM fibonacci;

-- Factorial calculation (1! through 5!)
WITH RECURSIVE factorial AS (
    -- Base case: 1! = 1
-- Tag: cte_recursive_cte_test_select_010
    SELECT 1 AS n, 1 AS fact

    UNION ALL

    -- Recursive case: n! = n * (n-1)!
-- Tag: cte_recursive_cte_test_select_011
    SELECT n + 1,
           fact * (n + 1)
    FROM factorial
    WHERE n < 5
)
-- Tag: cte_recursive_cte_test_select_012
SELECT n, fact FROM factorial
ORDER BY n;

-- ----------------------------------------------------------------------------
-- 3. Organizational Hierarchy - Employee/Manager Trees
-- ----------------------------------------------------------------------------

-- Find all subordinates under a manager (descendants)
WITH RECURSIVE subordinates AS (
    -- Base case: Start with specific manager (id = 2)
-- Tag: cte_recursive_cte_test_select_013
    SELECT id, name, manager_id, 0 AS level
    FROM crew_members
    WHERE id = 2

    UNION ALL

    -- Recursive case: Find direct reports
-- Tag: cte_recursive_cte_test_select_014
    SELECT e.id, e.name, e.manager_id, s.level + 1
    FROM crew_members e
    INNER JOIN subordinates s ON e.manager_id = s.id
)
-- Tag: cte_recursive_cte_test_select_015
SELECT * FROM subordinates
ORDER BY level, id;

-- Build complete org chart from CEO down
WITH RECURSIVE org_tree AS (
    -- Base case: CEO (manager_id IS NULL)
-- Tag: cte_recursive_cte_test_select_016
    SELECT id, name, manager_id, 0 AS level
    FROM crew_members
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: All crew_members under current level
-- Tag: cte_recursive_cte_test_select_017
    SELECT e.id, e.name, e.manager_id, t.level + 1
    FROM crew_members e
    JOIN org_tree t ON e.manager_id = t.id
)
-- Tag: cte_recursive_cte_test_select_018
SELECT * FROM org_tree
ORDER BY level, id;

-- Find all managers above an crew_member (ancestors)
WITH RECURSIVE managers AS (
    -- Base case: Start with specific crew_member (id = 4)
-- Tag: cte_recursive_cte_test_select_019
    SELECT id, name, manager_id
    FROM crew_members
    WHERE id = 4

    UNION ALL

    -- Recursive case: Go up the management chain
-- Tag: cte_recursive_cte_test_select_020
    SELECT e.id, e.name, e.manager_id
    FROM crew_members e
    JOIN managers m ON e.id = m.manager_id
)
-- Tag: cte_recursive_cte_test_select_021
SELECT name FROM managers
WHERE id != 4
ORDER BY id;

-- Hierarchy with depth tracking
WITH RECURSIVE hierarchy AS (
    -- Base case: Root nodes
-- Tag: cte_recursive_cte_test_select_022
    SELECT id, name, manager_id, 0 AS depth
    FROM crew_members
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: Children nodes
-- Tag: cte_recursive_cte_test_select_023
    SELECT e.id, e.name, e.manager_id, h.depth + 1
    FROM crew_members e
    JOIN hierarchy h ON e.manager_id = h.id
)
-- Tag: cte_recursive_cte_test_select_024
SELECT name, depth
FROM hierarchy
ORDER BY depth;

-- ----------------------------------------------------------------------------
-- 4. Tree Structures - File Systems, Categories
-- ----------------------------------------------------------------------------

-- File system tree with path construction
WITH RECURSIVE tree AS (
    -- Base case: Root directory
-- Tag: cte_recursive_cte_test_select_025
    SELECT id, name, parent_id, 0 AS depth, name AS path
    FROM files
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive case: Subdirectories and files
-- Tag: cte_recursive_cte_test_select_026
    SELECT f.id, f.name, f.parent_id, t.depth + 1, t.path || '/' || f.name
    FROM files f
    JOIN tree t ON f.parent_id = t.id
)
-- Tag: cte_recursive_cte_test_select_027
SELECT name, depth, path
FROM tree
ORDER BY path;

-- Find all ancestors of a category (breadcrumb trail)
WITH RECURSIVE ancestors AS (
    -- Base case: Specific category (e.g., Laptops)
-- Tag: cte_recursive_cte_test_select_028
    SELECT id, name, parent_id
    FROM categories
    WHERE id = 4

    UNION ALL

    -- Recursive case: Parent categories
-- Tag: cte_recursive_cte_test_select_029
    SELECT c.id, c.name, c.parent_id
    FROM categories c
    JOIN ancestors a ON c.id = a.parent_id
)
-- Tag: cte_recursive_cte_test_select_030
SELECT name FROM ancestors
ORDER BY id;

-- Find all descendants of a category (subcategories)
WITH RECURSIVE descendants AS (
    -- Base case: Root category
-- Tag: cte_recursive_cte_test_select_031
    SELECT id, name, parent_id
    FROM categories
    WHERE id = 1

    UNION ALL

    -- Recursive case: Child categories
-- Tag: cte_recursive_cte_test_select_032
    SELECT c.id, c.name, c.parent_id
    FROM categories c
    JOIN descendants d ON c.parent_id = d.id
)
-- Tag: cte_recursive_cte_test_select_033
SELECT * FROM descendants;

-- ----------------------------------------------------------------------------
-- 5. Graph Traversal - Dependencies, Networks
-- ----------------------------------------------------------------------------

-- Find all transitive dependencies
WITH RECURSIVE all_deps AS (
    -- Base case: Direct dependencies of module 'A'
-- Tag: cte_recursive_cte_test_select_034
    SELECT module, depends_on, 1 AS level
    FROM dependencies
    WHERE module = 'A'

    UNION ALL

    -- Recursive case: Dependencies of dependencies
-- Tag: cte_recursive_cte_test_select_035
    SELECT d.module, d.depends_on, a.level + 1
    FROM dependencies d
    JOIN all_deps a ON d.module = a.depends_on
)
-- Tag: cte_recursive_cte_test_select_036
SELECT DISTINCT depends_on
FROM all_deps;

-- Transitive closure (reachability in a graph)
WITH RECURSIVE reachable AS (
    -- Base case: Direct edges from node 1
-- Tag: cte_recursive_cte_test_select_037
    SELECT src, dst
    FROM edges
    WHERE src = 1

    UNION

    -- Recursive case: Follow edges
-- Tag: cte_recursive_cte_test_select_038
    SELECT e.src, e.dst
    FROM edges e
    JOIN reachable r ON e.src = r.dst
)
-- Tag: cte_recursive_cte_test_select_039
SELECT * FROM reachable;

-- ----------------------------------------------------------------------------
-- 6. Cycle Detection and Path Tracking
-- ----------------------------------------------------------------------------

-- Detect cycles in graph using path array
WITH RECURSIVE paths AS (
    -- Base case: Starting node with initial path
-- Tag: cte_recursive_cte_test_select_040
    SELECT src, dst, ARRAY[src] AS path, false AS has_cycle
    FROM edges
    WHERE src = 1

    UNION ALL

    -- Recursive case: Extend path, check for cycles
-- Tag: cte_recursive_cte_test_select_041
    SELECT e.src, e.dst,
           ARRAY_APPEND(p.path, e.src),
           ARRAY_POSITION(p.path, e.dst) > 0 AS has_cycle
    FROM edges e
    JOIN paths p ON e.src = p.dst
    WHERE NOT p.has_cycle
      AND ARRAY_LENGTH(p.path) < 10
)
-- Tag: cte_recursive_cte_test_select_042
SELECT * FROM paths
WHERE has_cycle = true;

-- Track full path as string
WITH RECURSIVE paths AS (
    -- Base case: Root nodes with name as path
-- Tag: cte_recursive_cte_test_select_043
    SELECT id, name, name AS path
    FROM nodes
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive case: Append to path
-- Tag: cte_recursive_cte_test_select_044
    SELECT n.id, n.name, p.path || '->' || n.name
    FROM nodes n
    JOIN paths p ON n.parent_id = p.id
)
-- Tag: cte_recursive_cte_test_select_045
SELECT name, path FROM paths
ORDER BY id;

-- ----------------------------------------------------------------------------
-- 7. UNION vs UNION ALL in Recursion
-- ----------------------------------------------------------------------------

-- UNION automatically deduplicates (prevents infinite loops on cycles)
WITH RECURSIVE paths AS (
-- Tag: cte_recursive_cte_test_select_046
    SELECT src, dst, 1 AS depth
    FROM edges
    WHERE src = 1

    UNION  -- Deduplicates automatically

-- Tag: cte_recursive_cte_test_select_047
    SELECT e.src, e.dst, p.depth + 1
    FROM edges e
    JOIN paths p ON e.src = p.dst
    WHERE p.depth < 10
)
-- Tag: cte_recursive_cte_test_select_048
SELECT * FROM paths;

-- UNION ALL requires explicit termination condition
WITH RECURSIVE nums AS (
-- Tag: cte_recursive_cte_test_select_049
    SELECT 1 AS n

    UNION ALL  -- No deduplication

-- Tag: cte_recursive_cte_test_select_050
    SELECT n + 1
    FROM nums
    WHERE n < 5  -- MUST have termination condition
)
-- Tag: cte_recursive_cte_test_select_051
SELECT * FROM nums;

-- ----------------------------------------------------------------------------
-- 8. Multiple Recursive CTEs
-- ----------------------------------------------------------------------------

-- Two independent recursive CTEs in same query
WITH RECURSIVE
    evens AS (
-- Tag: cte_recursive_cte_test_select_052
        SELECT 0 AS n
        UNION ALL
-- Tag: cte_recursive_cte_test_select_053
        SELECT n + 2 FROM evens WHERE n < 10
    ),
    odds AS (
-- Tag: cte_recursive_cte_test_select_054
        SELECT 1 AS n
        UNION ALL
-- Tag: cte_recursive_cte_test_select_055
        SELECT n + 2 FROM odds WHERE n < 10
    )
-- Tag: cte_recursive_cte_test_select_056
SELECT 'even' AS type, n FROM evens
UNION ALL
-- Tag: cte_recursive_cte_test_select_057
SELECT 'odd' AS type, n FROM odds
ORDER BY n;

-- Recursive CTEs referencing each other
WITH RECURSIVE
    cte1 AS (
-- Tag: cte_recursive_cte_test_select_058
        SELECT 1 AS n, 'A' AS label
        UNION ALL
-- Tag: cte_recursive_cte_test_select_059
        SELECT n + 1, 'A' FROM cte1 WHERE n < 3
    ),
    cte2 AS (
-- Tag: cte_recursive_cte_test_select_060
        SELECT n, label FROM cte1
        UNION ALL
-- Tag: cte_recursive_cte_test_select_061
        SELECT n + 10, 'B' FROM cte2
        WHERE n < 20 AND label = 'A'
    )
-- Tag: cte_recursive_cte_test_select_062
SELECT * FROM cte2;

-- ----------------------------------------------------------------------------
-- 9. Recursive CTEs with Aggregation
-- ----------------------------------------------------------------------------

-- Aggregate at each level of hierarchy
WITH RECURSIVE hierarchy AS (
    -- Base case: CEO
-- Tag: cte_recursive_cte_test_select_063
    SELECT id, name, manager_id, salary, 0 AS level
    FROM crew_members
    WHERE id = 1

    UNION ALL

    -- Recursive case: All subordinates
-- Tag: cte_recursive_cte_test_select_064
    SELECT e.id, e.name, e.manager_id, e.salary, h.level + 1
    FROM crew_members e
    JOIN hierarchy h ON e.manager_id = h.id
)
-- Tag: cte_recursive_cte_test_select_065
SELECT level,
       SUM(salary) AS total_salary
FROM hierarchy
GROUP BY level
ORDER BY level;

-- ----------------------------------------------------------------------------
-- 10. Edge Cases
-- ----------------------------------------------------------------------------

-- Empty base case (no rows returned)
WITH RECURSIVE rec AS (
-- Tag: cte_recursive_cte_test_select_066
    SELECT id FROM empty_table

    UNION ALL

-- Tag: cte_recursive_cte_test_select_067
    SELECT id + 1 FROM rec WHERE id < 5
)
-- Tag: cte_recursive_cte_test_select_068
SELECT * FROM rec;
-- Result: 0 rows

-- Single node tree (no recursion occurs)
WITH RECURSIVE tree AS (
-- Tag: cte_recursive_cte_test_select_069
    SELECT id, parent_id
    FROM nodes
    WHERE parent_id IS NULL

    UNION ALL

-- Tag: cte_recursive_cte_test_select_070
    SELECT n.id, n.parent_id
    FROM nodes n
    JOIN tree t ON n.parent_id = t.id
)
-- Tag: cte_recursive_cte_test_select_071
SELECT * FROM tree;
-- Result: Only root node if tree has single node

-- Multiple roots (forest instead of tree)
WITH RECURSIVE tree AS (
    -- Base case: All root nodes (multiple)
-- Tag: cte_recursive_cte_test_select_072
    SELECT id, parent_id, 0 AS level
    FROM nodes
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive case: Children of all roots
-- Tag: cte_recursive_cte_test_select_073
    SELECT n.id, n.parent_id, t.level + 1
    FROM nodes n
    JOIN tree t ON n.parent_id = t.id
)
-- Tag: cte_recursive_cte_test_select_074
SELECT * FROM tree;

-- Filtering in recursive part (only active crew_members)
WITH RECURSIVE active_tree AS (
    -- Base case: CEO
-- Tag: cte_recursive_cte_test_select_075
    SELECT id, name, manager_id
    FROM crew_members
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: Only active subordinates
-- Tag: cte_recursive_cte_test_select_076
    SELECT e.id, e.name, e.manager_id
    FROM crew_members e
    JOIN active_tree t ON e.manager_id = t.id
    WHERE e.active = true
)
-- Tag: cte_recursive_cte_test_select_077
SELECT * FROM active_tree;

-- ----------------------------------------------------------------------------
-- 11. Maximum Depth / Recursion Limit
-- ----------------------------------------------------------------------------

-- Deep recursion (up to 1000 levels)
WITH RECURSIVE deep AS (
-- Tag: cte_recursive_cte_test_select_078
    SELECT 1 AS n

    UNION ALL

-- Tag: cte_recursive_cte_test_select_079
    SELECT n + 1
    FROM deep
    WHERE n < 1000
)
-- Tag: cte_recursive_cte_test_select_080
SELECT MAX(n) AS max_depth FROM deep;

-- ----------------------------------------------------------------------------
-- 12. Integration with Other SQL Features
-- ----------------------------------------------------------------------------

-- Recursive CTE with JOIN to external table
WITH RECURSIVE hierarchy AS (
-- Tag: cte_recursive_cte_test_select_081
    SELECT id, name, manager_id
    FROM crew_members
    WHERE manager_id IS NULL

    UNION ALL

-- Tag: cte_recursive_cte_test_select_082
    SELECT e.id, e.name, e.manager_id
    FROM crew_members e
    JOIN hierarchy h ON e.manager_id = h.id
)
-- Tag: cte_recursive_cte_test_select_083
SELECT h.name, d.dept
FROM hierarchy h
JOIN fleets d ON h.id = d.crew_member_id
ORDER BY h.id;

-- Recursive CTE in subquery
-- Tag: cte_recursive_cte_test_select_084
SELECT *
FROM (
    WITH RECURSIVE nums AS (
-- Tag: cte_recursive_cte_test_select_085
        SELECT 1 AS n
        UNION ALL
-- Tag: cte_recursive_cte_test_select_086
        SELECT n + 1 FROM nums WHERE n < 5
    )
-- Tag: cte_recursive_cte_test_select_087
    SELECT * FROM nums
) AS subquery
WHERE n > 2;

-- ----------------------------------------------------------------------------
-- 13. Bill of Materials (BOM) Pattern
-- ----------------------------------------------------------------------------

-- Exploded BOM - all parts needed for a product
WITH RECURSIVE bom AS (
    -- Base case: Top-level product
-- Tag: cte_recursive_cte_test_select_088
    SELECT equipment_id, part_id, quantity, 1 AS level
    FROM parts
    WHERE equipment_id = 'PRODUCT-A'

    UNION ALL

    -- Recursive case: Sub-parts
-- Tag: cte_recursive_cte_test_select_089
    SELECT p.equipment_id, p.part_id, b.quantity * p.quantity, b.level + 1
    FROM parts p
    JOIN bom b ON p.equipment_id = b.part_id
)
-- Tag: cte_recursive_cte_test_select_090
SELECT part_id, SUM(quantity) AS total_quantity
FROM bom
GROUP BY part_id;

-- ----------------------------------------------------------------------------
-- Notes:
-- - Base case: Non-recursive SELECT (initial rows)
-- - Recursive case: SELECT referencing the CTE itself
-- - Termination: WHERE clause MUST prevent infinite recursion
-- - UNION removes duplicates, UNION ALL keeps them
-- - Most databases have recursion depth limits (100-1000)
-- - Use for: hierarchies, graphs, sequences, trees
-- - Performance: May be slower than iterative solutions for very deep recursion
-- ----------------------------------------------------------------------------
