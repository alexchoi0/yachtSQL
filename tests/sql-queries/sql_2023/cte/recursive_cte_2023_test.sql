-- Recursive Cte 2023 - SQL:2023
-- Description: Common Table Expressions for query organization
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    crew_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    manager_id INT64,
    fleet STRING,
    FOREIGN KEY (manager_id) REFERENCES crew_members(crew_id)
);

INSERT INTO crew_members VALUES
    (1, 'CEO Alice', NULL, 'Executive'),
    (2, 'VP Bob', 1, 'Engineering'),
    (3, 'VP Carol', 1, 'Sales'),
    (4, 'Manager Dave', 2, 'Engineering'),
    (5, 'Manager Eve', 2, 'Engineering'),
    (6, 'Engineer Frank', 4, 'Engineering'),
    (7, 'Engineer Grace', 4, 'Engineering'),
    (8, 'Engineer Henry', 5, 'Engineering'),
    (9, 'Sales Rep Ivy', 3, 'Sales'),
    (10, 'Sales Rep Jack', 3, 'Sales');

-- Road network (directed graph)
DROP TABLE IF EXISTS roads;
CREATE TABLE roads (
    from_city STRING,
    to_city STRING,
    distance INT64,
    PRIMARY KEY (from_city, to_city)
);

INSERT INTO roads VALUES
    ('A', 'B', 5),
    ('B', 'C', 3),
    ('C', 'D', 4),
    ('D', 'A', 2),  -- Creates cycle: A->B->C->D->A
    ('B', 'D', 7),
    ('A', 'C', 10),
    ('D', 'E', 6),
    ('E', 'F', 4);

-- Social network (undirected, represented as bidirectional)
DROP TABLE IF EXISTS friendships;
CREATE TABLE friendships (
    yacht1 STRING,
    yacht2 STRING,
    PRIMARY KEY (yacht1, yacht2)
);

INSERT INTO friendships VALUES
    ('Alice', 'Bob'),
    ('Bob', 'Alice'),
    ('Bob', 'Charlie'),
    ('Charlie', 'Bob'),
    ('Charlie', 'Diana'),
    ('Diana', 'Charlie'),
    ('Diana', 'Alice'),
    ('Alice', 'Diana');

-- ----------------------------------------------------------------------------
-- 1. SQL:2023 Boolean Cycle Detection (New Syntax)
-- ----------------------------------------------------------------------------

-- Find all paths in road network with boolean cycle detection
WITH RECURSIVE paths AS (
    -- Base case: start from city A
-- Tag: cte_recursive_cte_2023_test_select_001
    SELECT from_city,
           to_city,
           distance,
           from_city AS origin,
           ARRAY[from_city, to_city] AS path,
           distance AS total_distance
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

    -- Recursive case: extend paths
-- Tag: cte_recursive_cte_2023_test_select_002
    SELECT r.from_city,
           r.to_city,
           r.distance,
           p.origin,
           p.path || r.to_city,
           p.total_distance + r.distance
    FROM paths p
    JOIN roads r ON p.to_city = r.from_city
    WHERE NOT r.to_city = ANY(p.path)  -- Manual cycle detection
)
CYCLE from_city, to_city SET is_cycle DEFAULT true USING cycle_path
-- Tag: cte_recursive_cte_2023_test_select_003
SELECT origin,
       to_city AS destination,
       path,
       total_distance,
       is_cycle
FROM paths
WHERE is_cycle = false  -- Exclude cyclic paths
ORDER BY origin, total_distance;

-- SQL:2023 simplified syntax (omit DEFAULT, uses true/false automatically)
WITH RECURSIVE paths_simple AS (
-- Tag: cte_recursive_cte_2023_test_select_004
    SELECT from_city,
           to_city,
           ARRAY[from_city] AS path
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_005
    SELECT r.from_city,
           r.to_city,
           p.path || r.from_city
    FROM paths_simple p
    JOIN roads r ON p.to_city = r.from_city
)
CYCLE from_city SET has_cycle USING cycle_info
-- Tag: cte_recursive_cte_2023_test_select_006
SELECT from_city, to_city, path, has_cycle
FROM paths_simple
WHERE has_cycle = false
ORDER BY from_city, to_city;

-- ----------------------------------------------------------------------------
-- 2. Employee Hierarchy with Cycle Detection
-- ----------------------------------------------------------------------------

-- Traverse organizational hierarchy with cycle detection
WITH RECURSIVE emp_hierarchy AS (
    -- Base case: start from CEO
-- Tag: cte_recursive_cte_2023_test_select_007
    SELECT crew_id,
           name,
           manager_id,
           0 AS level,
           CAST(name AS STRING) AS path
    FROM crew_members
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: get direct reports
-- Tag: cte_recursive_cte_2023_test_select_008
    SELECT e.crew_id,
           e.name,
           e.manager_id,
           h.level + 1,
           h.path || ' -> ' || e.name
    FROM emp_hierarchy h
    JOIN crew_members e ON h.crew_id = e.manager_id
)
CYCLE crew_id SET is_cyclic USING cycle_track
-- Tag: cte_recursive_cte_2023_test_select_009
SELECT level,
       name,
       path,
       is_cyclic
FROM emp_hierarchy
WHERE is_cyclic = false
ORDER BY level, name;

-- Find reporting chain for specific crew_member
WITH RECURSIVE reporting_chain AS (
    -- Base case: start from specific crew_member
-- Tag: cte_recursive_cte_2023_test_select_010
    SELECT crew_id,
           name,
           manager_id,
           0 AS depth,
           name AS chain
    FROM crew_members
    WHERE crew_id = 6  -- Frank

    UNION ALL

    -- Recursive case: go up to managers
-- Tag: cte_recursive_cte_2023_test_select_011
    SELECT e.crew_id,
           e.name,
           e.manager_id,
           r.depth + 1,
           e.name || ' -> ' || r.chain
    FROM reporting_chain r
    JOIN crew_members e ON r.manager_id = e.crew_id
)
CYCLE crew_id SET has_loop DEFAULT true USING loop_path
-- Tag: cte_recursive_cte_2023_test_select_012
SELECT name, depth, chain, has_loop
FROM reporting_chain
WHERE has_loop = false
ORDER BY depth DESC;

-- ----------------------------------------------------------------------------
-- 3. Graph Traversal with Path Tracking
-- ----------------------------------------------------------------------------

-- Find all reachable cities from A with path tracking
WITH RECURSIVE reachable_cities AS (
    -- Base case
-- Tag: cte_recursive_cte_2023_test_select_013
    SELECT from_city AS city,
           to_city AS next_city,
           1 AS hops,
           ARRAY[from_city, to_city] AS full_path,
           distance AS total_dist
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

    -- Recursive case
-- Tag: cte_recursive_cte_2023_test_select_014
    SELECT r.city,
           r.to_city,
           rc.hops + 1,
           rc.full_path || r.to_city,
           rc.total_dist + r.distance
    FROM reachable_cities rc
    JOIN roads r ON rc.next_city = r.from_city
)
CYCLE city, next_city SET cycle_detected DEFAULT true USING cycle_path_col
-- Tag: cte_recursive_cte_2023_test_select_015
SELECT city AS start,
       next_city AS destination,
       hops,
       full_path,
       total_dist,
       cycle_detected
FROM reachable_cities
WHERE cycle_detected = false
  AND hops <= 4
ORDER BY hops, total_dist;

-- Shortest path with cycle detection
WITH RECURSIVE shortest_paths AS (
-- Tag: cte_recursive_cte_2023_test_select_016
    SELECT from_city,
           to_city,
           distance,
           ARRAY[from_city, to_city] AS path
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_017
    SELECT r.from_city,
           r.to_city,
           sp.distance + r.distance,
           sp.path || r.to_city
    FROM shortest_paths sp
    JOIN roads r ON sp.to_city = r.from_city
)
CYCLE to_city SET has_cycle USING cycle_info
-- Tag: cte_recursive_cte_2023_test_select_018
SELECT to_city AS destination,
       MIN(distance) AS shortest_distance,
       ARRAY_AGG(path ORDER BY distance LIMIT 1)[0] AS shortest_path
FROM shortest_paths
WHERE has_cycle = false
GROUP BY to_city
ORDER BY shortest_distance;

-- ----------------------------------------------------------------------------
-- 4. Social Network Friend-of-Friend with Cycle Detection
-- ----------------------------------------------------------------------------

-- Find friends within N degrees of separation
WITH RECURSIVE friend_network AS (
    -- Base case: direct friends of Alice
-- Tag: cte_recursive_cte_2023_test_select_019
    SELECT yacht1 AS origin,
           yacht2 AS friend,
           1 AS degree,
           ARRAY[yacht1, yacht2] AS connection_path
    FROM friendships
    WHERE yacht1 = 'Alice'

    UNION ALL

    -- Recursive case: friends of friends
-- Tag: cte_recursive_cte_2023_test_select_020
    SELECT fn.origin,
           f.yacht2,
           fn.degree + 1,
           fn.connection_path || f.yacht2
    FROM friend_network fn
    JOIN friendships f ON fn.friend = f.yacht1
    WHERE fn.degree < 3  -- Limit to 3 degrees
)
CYCLE friend SET is_circular DEFAULT true USING circular_path
-- Tag: cte_recursive_cte_2023_test_select_021
SELECT origin,
       friend,
       degree,
       connection_path,
       is_circular
FROM friend_network
WHERE is_circular = false
  AND friend <> origin  -- Exclude self
ORDER BY degree, friend;

-- Count unique friends at each degree
WITH RECURSIVE friend_degrees AS (
-- Tag: cte_recursive_cte_2023_test_select_022
    SELECT yacht1, yacht2, 1 AS degree
    FROM friendships
    WHERE yacht1 = 'Alice'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_023
    SELECT fd.yacht1, f.yacht2, fd.degree + 1
    FROM friend_degrees fd
    JOIN friendships f ON fd.yacht2 = f.yacht1
    WHERE fd.degree < 4
)
CYCLE yacht2 SET cycle_flag USING cycle_data
-- Tag: cte_recursive_cte_2023_test_select_024
SELECT degree,
       COUNT(DISTINCT yacht2) AS unique_friends
FROM friend_degrees
WHERE cycle_flag = false
  AND yacht2 <> 'Alice'
GROUP BY degree
ORDER BY degree;

-- ----------------------------------------------------------------------------
-- 5. Bill of Materials (BOM) with Cycle Detection
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS parts;
CREATE TABLE parts (
    part_id INT64 PRIMARY KEY,
    part_name STRING NOT NULL,
    parent_part_id INT64,
    quantity INT64,
    FOREIGN KEY (parent_part_id) REFERENCES parts(part_id)
);

INSERT INTO parts VALUES
    (1, 'Bicycle', NULL, 1),
    (2, 'Frame', 1, 1),
    (3, 'Wheel', 1, 2),
    (4, 'Tire', 3, 1),
    (5, 'Rim', 3, 1),
    (6, 'Spoke', 5, 36),
    (7, 'Brake', 1, 2),
    (8, 'Brake Pad', 7, 2);

-- Explode BOM with cycle detection
WITH RECURSIVE bom_explosion AS (
    -- Base case: top-level part
-- Tag: cte_recursive_cte_2023_test_select_025
    SELECT part_id,
           part_name,
           parent_part_id,
           quantity,
           0 AS level,
           quantity AS total_quantity,
           CAST(part_name AS STRING) AS hierarchy
    FROM parts
    WHERE part_id = 1  -- Bicycle

    UNION ALL

    -- Recursive case: get sub-parts
-- Tag: cte_recursive_cte_2023_test_select_026
    SELECT p.part_id,
           p.part_name,
           p.parent_part_id,
           p.quantity,
           b.level + 1,
           b.total_quantity * p.quantity,
           b.hierarchy || ' > ' || p.part_name
    FROM bom_explosion b
    JOIN parts p ON b.part_id = p.parent_part_id
)
CYCLE part_id SET has_circular_dependency DEFAULT true USING dependency_path
-- Tag: cte_recursive_cte_2023_test_select_027
SELECT level,
       part_name,
       total_quantity,
       hierarchy,
       has_circular_dependency
FROM bom_explosion
WHERE has_circular_dependency = false
ORDER BY level, part_name;

-- ----------------------------------------------------------------------------
-- 6. Predecessor/Successor Chains
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
    task_id INT64 PRIMARY KEY,
    task_name STRING NOT NULL,
    predecessor_id INT64,
    duration_days INT64,
    FOREIGN KEY (predecessor_id) REFERENCES tasks(task_id)
);

INSERT INTO tasks VALUES
    (1, 'Design', NULL, 5),
    (2, 'Develop', 1, 10),
    (3, 'Test', 2, 5),
    (4, 'Deploy', 3, 2),
    (5, 'Document', 1, 3),
    (6, 'Review', 5, 2);

-- Calculate critical path with cycle detection
WITH RECURSIVE task_chain AS (
    -- Base case: tasks with no predecessors
-- Tag: cte_recursive_cte_2023_test_select_028
    SELECT task_id,
           task_name,
           predecessor_id,
           duration_days,
           0 AS start_day,
           duration_days AS end_day,
           ARRAY[task_id] AS chain
    FROM tasks
    WHERE predecessor_id IS NULL

    UNION ALL

    -- Recursive case: dependent tasks
-- Tag: cte_recursive_cte_2023_test_select_029
    SELECT t.task_id,
           t.task_name,
           t.predecessor_id,
           t.duration_days,
           tc.end_day AS start_day,
           tc.end_day + t.duration_days AS end_day,
           tc.chain || t.task_id
    FROM task_chain tc
    JOIN tasks t ON tc.task_id = t.predecessor_id
)
CYCLE task_id SET circular_dependency DEFAULT true USING dep_path
-- Tag: cte_recursive_cte_2023_test_select_030
SELECT task_name,
       start_day,
       end_day,
       duration_days,
       chain,
       circular_dependency
FROM task_chain
WHERE circular_dependency = false
ORDER BY end_day DESC;

-- ----------------------------------------------------------------------------
-- 7. Comparison: Pre-SQL:2023 vs SQL:2023 Syntax
-- ----------------------------------------------------------------------------

-- Pre-SQL:2023: Explicit string values for cycle marks
WITH RECURSIVE old_style_paths AS (
-- Tag: cte_recursive_cte_2023_test_select_031
    SELECT from_city, to_city, ARRAY[from_city] AS path
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_032
    SELECT r.from_city, r.to_city, p.path || r.from_city
    FROM old_style_paths p
    JOIN roads r ON p.to_city = r.from_city
)
CYCLE from_city SET is_cycle TO 'Y' DEFAULT 'N' USING cycle_path
-- Tag: cte_recursive_cte_2023_test_select_033
SELECT from_city, to_city, path, is_cycle
FROM old_style_paths
WHERE is_cycle = 'N'
ORDER BY from_city;

-- SQL:2023: Boolean cycle marks (cleaner, more efficient)
WITH RECURSIVE new_style_paths AS (
-- Tag: cte_recursive_cte_2023_test_select_034
    SELECT from_city, to_city, ARRAY[from_city] AS path
    FROM roads
    WHERE from_city = 'A'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_035
    SELECT r.from_city, r.to_city, p.path || r.from_city
    FROM new_style_paths p
    JOIN roads r ON p.to_city = r.from_city
)
CYCLE from_city SET is_cycle USING cycle_path  -- Defaults to boolean true/false
-- Tag: cte_recursive_cte_2023_test_select_036
SELECT from_city, to_city, path, is_cycle
FROM new_style_paths
WHERE is_cycle = false
ORDER BY from_city;

-- ----------------------------------------------------------------------------
-- 8. Complex Multi-Column Cycle Detection
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS state_transitions;
CREATE TABLE state_transitions (
    from_state STRING,
    to_state STRING,
    action STRING,
    cost INT64,
    PRIMARY KEY (from_state, to_state, action)
);

INSERT INTO state_transitions VALUES
    ('Start', 'A', 'init', 1),
    ('A', 'B', 'process', 2),
    ('B', 'C', 'validate', 1),
    ('C', 'End', 'finish', 1),
    ('A', 'C', 'skip', 3),
    ('B', 'A', 'retry', 1),  -- Potential cycle
    ('C', 'A', 'reset', 2);  -- Potential cycle

-- Find all state transition paths
WITH RECURSIVE state_paths AS (
-- Tag: cte_recursive_cte_2023_test_select_037
    SELECT from_state,
           to_state,
           action,
           cost,
           ARRAY[from_state, to_state] AS states_visited,
           cost AS total_cost,
           ARRAY[action] AS actions_taken
    FROM state_transitions
    WHERE from_state = 'Start'

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_038
    SELECT st.from_state,
           st.to_state,
           st.action,
           st.cost,
           sp.states_visited || st.to_state,
           sp.total_cost + st.cost,
           sp.actions_taken || st.action
    FROM state_paths sp
    JOIN state_transitions st ON sp.to_state = st.from_state
    WHERE ARRAY_LENGTH(sp.states_visited) < 6  -- Depth limit
)
CYCLE from_state, to_state SET has_cycle DEFAULT true USING cycle_track
-- Tag: cte_recursive_cte_2023_test_select_039
SELECT to_state AS final_state,
       states_visited,
       actions_taken,
       total_cost,
       has_cycle
FROM state_paths
WHERE has_cycle = false
ORDER BY total_cost, ARRAY_LENGTH(states_visited);

-- ----------------------------------------------------------------------------
-- 9. Performance Considerations
-- ----------------------------------------------------------------------------

-- Cycle detection prevents infinite recursion
-- Boolean cycle marks are more efficient than string comparisons

-- Example: Large graph traversal with early termination
DROP TABLE IF EXISTS large_graph;
CREATE TABLE large_graph (
    node_id INT64,
    neighbor_id INT64,
    PRIMARY KEY (node_id, neighbor_id)
);

-- Generate test data
INSERT INTO large_graph
-- Tag: cte_recursive_cte_2023_test_select_040
SELECT n, n + 1 FROM GENERATE_SERIES(1, 100) AS n
UNION ALL
-- Tag: cte_recursive_cte_2023_test_select_041
SELECT 100, 1;  -- Create one cycle

-- Traverse with cycle detection (prevents infinite loop)
WITH RECURSIVE traversal AS (
-- Tag: cte_recursive_cte_2023_test_select_042
    SELECT node_id, neighbor_id, 1 AS depth
    FROM large_graph
    WHERE node_id = 1

    UNION ALL

-- Tag: cte_recursive_cte_2023_test_select_043
    SELECT g.node_id, g.neighbor_id, t.depth + 1
    FROM traversal t
    JOIN large_graph g ON t.neighbor_id = g.node_id
    WHERE t.depth < 150  -- Safety limit
)
CYCLE node_id SET cycle_detected USING cycle_path
-- Tag: cte_recursive_cte_2023_test_select_044
SELECT MAX(depth) AS max_depth_before_cycle,
       COUNT(*) AS total_nodes_visited,
       COUNT(*) FILTER (WHERE cycle_detected = true) AS cycles_detected
FROM traversal;

-- End of Recursive CTE 2023 Enhancements Tests
