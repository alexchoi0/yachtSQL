-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/lateral_join_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic LATERAL join - top 2 crew_members per fleet
-- Expected: Returns top 2 highest paid crew_members per fleet
DROP TABLE IF EXISTS fleets;
CREATE TABLE fleets (dept_id INT64, dept_name STRING);
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (crew_id INT64, dept_id INT64, name STRING, salary INT64);

INSERT INTO fleets VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO crew_members VALUES
    (1, 1, 'Alice', 100000),
    (2, 1, 'Bob', 90000),
    (3, 1, 'Charlie', 95000),
    (4, 2, 'David', 80000),
    (5, 2, 'Eve', 85000);

SELECT d.dept_name, e.name, e.salary
FROM fleets d
CROSS JOIN LATERAL (
    SELECT name, salary
    FROM crew_members
    WHERE dept_id = d.dept_id
    ORDER BY salary DESC
    LIMIT 2
) e
ORDER BY d.dept_name, e.salary DESC;
-- Result: Engineering (Alice 100k, Charlie 95k), Sales (Eve 85k, David 80k)

-- Test: LEFT JOIN LATERAL - includes fleets with no crew_members
-- Expected: Fleets without crew_members show NULL for crew_member data
DROP TABLE IF EXISTS depts_empty;
CREATE TABLE depts_empty (dept_id INT64, dept_name STRING);
DROP TABLE IF EXISTS emps_partial;
CREATE TABLE emps_partial (crew_id INT64, dept_id INT64, name STRING);

INSERT INTO depts_empty VALUES (1, 'Engineering'), (2, 'Sales'), (3, 'HR');
INSERT INTO emps_partial VALUES (1, 1, 'Alice'), (2, 1, 'Bob');

SELECT d.dept_name, e.name
FROM depts_empty d
LEFT JOIN LATERAL (
    SELECT name
    FROM emps_partial
    WHERE dept_id = d.dept_id
    LIMIT 1
) e ON true
ORDER BY d.dept_name;
-- Result: 3 rows, HR has NULL name

-- Test: LATERAL with aggregation
-- Expected: Compute per-fleet statistics
DROP TABLE IF EXISTS dept_list;
CREATE TABLE dept_list (dept_id INT64, dept_name STRING);
DROP TABLE IF EXISTS emp_list;
CREATE TABLE emp_list (dept_id INT64, salary INT64);

INSERT INTO dept_list VALUES (1, 'Engineering'), (2, 'Sales');
INSERT INTO emp_list VALUES
    (1, 100000), (1, 90000), (1, 95000),
    (2, 80000), (2, 85000);

SELECT d.dept_name, stats.avg_salary, stats.emp_count
FROM dept_list d
CROSS JOIN LATERAL (
    SELECT AVG(salary) as avg_salary, COUNT(*) as emp_count
    FROM emp_list
    WHERE dept_id = d.dept_id
) stats
ORDER BY d.dept_name;
-- Result: Engineering avg ~95000, Sales avg ~82500

-- Test: CROSS APPLY (SQL Server style equivalent)
-- Expected: Same as CROSS JOIN LATERAL
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, owner_id INT64);
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (order_id INT64, item_name STRING, price FLOAT64);

INSERT INTO orders VALUES (1, 100), (2, 100), (3, 101);
INSERT INTO order_items VALUES
    (1, 'Widget', 10.0),
    (1, 'Gadget', 20.0),
    (2, 'Gizmo', 15.0);

SELECT o.order_id, items.item_name, items.price
FROM orders o
CROSS APPLY (
    SELECT item_name, price
    FROM order_items
    WHERE order_id = o.order_id
) items
ORDER BY o.order_id, items.item_name;
-- Result: 3 rows (order 3 excluded, no items)

-- Test: OUTER APPLY (SQL Server style)
-- Expected: Same as LEFT JOIN LATERAL
DROP TABLE IF EXISTS orders_all;
CREATE TABLE orders_all (order_id INT64);
DROP TABLE IF EXISTS items_some;
CREATE TABLE items_some (order_id INT64, item_name STRING);

INSERT INTO orders_all VALUES (1), (2), (3);
INSERT INTO items_some VALUES (1, 'Widget'), (2, 'Gadget');

SELECT o.order_id, items.item_name
FROM orders_all o
OUTER APPLY (
    SELECT item_name
    FROM items_some
    WHERE order_id = o.order_id
) items
ORDER BY o.order_id;
-- Result: 3 rows, order 3 has NULL item

-- Test: Multiple LATERAL joins in sequence
-- Expected: Each lateral can reference previous tables
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (a INT64, b INT64);
DROP TABLE IF EXISTS t3;
CREATE TABLE t3 (a INT64, b INT64, c INT64);

INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1, 10), (2, 20);
INSERT INTO t3 VALUES (1, 10, 100), (2, 20, 200);

SELECT t1.a, x.b, y.c
FROM t1
CROSS JOIN LATERAL (
    SELECT b FROM t2 WHERE t2.a = t1.a
) x
CROSS JOIN LATERAL (
    SELECT c FROM t3 WHERE t3.a = t1.a AND t3.b = x.b
) y
ORDER BY t1.a;
-- Result: 2 rows with matching a, b, c

-- Test: LATERAL with NULL correlation
-- Expected: NULL comparisons return no rows
DROP TABLE IF EXISTS outer_table;
CREATE TABLE outer_table (id INT64, ref_id INT64);
DROP TABLE IF EXISTS inner_table;
CREATE TABLE inner_table (ref_id INT64, data STRING);

INSERT INTO outer_table VALUES (1, 100), (2, NULL), (3, 200);
INSERT INTO inner_table VALUES (100, 'A'), (200, 'B');

SELECT o.id, i.data
FROM outer_table o
CROSS JOIN LATERAL (
    SELECT data FROM inner_table WHERE ref_id = o.ref_id
) i
ORDER BY o.id;
-- Result: 2 rows (id 2 excluded, NULL doesn't match)

-- Test: LATERAL without correlation (degenerates to CROSS JOIN)
-- Expected: Cartesian product
DROP TABLE IF EXISTS table_a;
CREATE TABLE table_a (a INT64);
DROP TABLE IF EXISTS table_b;
CREATE TABLE table_b (b INT64);

INSERT INTO table_a VALUES (1), (2);
INSERT INTO table_b VALUES (10), (20);

SELECT t1.a, x.b
FROM table_a t1
CROSS JOIN LATERAL (
    SELECT b FROM table_b
) x
ORDER BY t1.a, x.b;
-- Result: 4 rows (2 x 2 cartesian product)

-- Test: LATERAL with CTE
-- Expected: CTE visible in lateral subquery
DROP TABLE IF EXISTS order_data;
CREATE TABLE order_data (owner_id INT64, amount FLOAT64);
INSERT INTO order_data VALUES (1, 100), (1, 200), (2, 150);

WITH customer_totals AS (
    SELECT owner_id, SUM(amount) as total
    FROM order_data
    GROUP BY owner_id
)
SELECT ct.owner_id, ct.total, recent.amount
FROM customer_totals ct
CROSS JOIN LATERAL (
    SELECT amount
    FROM order_data
    WHERE owner_id = ct.owner_id
    ORDER BY amount DESC
    LIMIT 1
) recent
ORDER BY ct.owner_id;
-- Result: 2 rows with total and highest order amount

-- Test: LATERAL with window functions
-- Expected: Window functions work in lateral context
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (dept STRING, product STRING, amount FLOAT64);
INSERT INTO sales VALUES
    ('A', 'Widget', 100),
    ('A', 'Gadget', 150),
    ('B', 'Widget', 200);

SELECT DISTINCT dept, top_equipment.product, top_equipment.rank
FROM sales s
CROSS JOIN LATERAL (
    SELECT
        product,
        ROW_NUMBER() OVER (ORDER BY amount DESC) as rank
    FROM sales
    WHERE dept = s.dept
    LIMIT 1
) top_equipment
ORDER BY dept;
-- Result: Top product per fleet

-- Test: Nested LATERAL subqueries
-- Expected: Inner lateral can reference outer tables
DROP TABLE IF EXISTS a;
CREATE TABLE a (a INT64);
DROP TABLE IF EXISTS b;
CREATE TABLE b (a INT64, b INT64);
DROP TABLE IF EXISTS c;
CREATE TABLE c (b INT64, c INT64);

INSERT INTO a VALUES (1);
INSERT INTO b VALUES (1, 10);
INSERT INTO c VALUES (10, 100);

SELECT a.a, x.b, x.c
FROM a
CROSS JOIN LATERAL (
    SELECT b.b, y.c
    FROM b
    WHERE b.a = a.a
    CROSS JOIN LATERAL (
        SELECT c FROM c WHERE c.b = b.b
    ) y
) x;
-- Result: 1 row (1, 10, 100)

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: Invalid column reference in LATERAL
-- Expected: Error - column doesn't exist
DROP TABLE IF EXISTS test1;
CREATE TABLE test1 (id INT64);
DROP TABLE IF EXISTS test2;
CREATE TABLE test2 (id INT64);

SELECT test1.id
FROM test1
CROSS JOIN LATERAL (
    SELECT * FROM test2 WHERE id = test1.nonexistent_col
) x;
-- ERROR: column "nonexistent_col" does not exist

-- Test: Ambiguous column in LATERAL
-- Expected: Error - ambiguous reference
DROP TABLE IF EXISTS amb1;
CREATE TABLE amb1 (id INT64, value INT64);
DROP TABLE IF EXISTS amb2;
CREATE TABLE amb2 (id INT64, value INT64);

SELECT amb1.id
FROM amb1
CROSS JOIN LATERAL (
    SELECT * FROM amb2 WHERE id = value
) x;
-- ERROR: column reference "id" is ambiguous
