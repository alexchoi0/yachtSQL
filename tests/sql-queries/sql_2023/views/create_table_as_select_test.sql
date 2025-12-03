-- Create Table As Select - SQL:2023
-- Description: CREATE TABLE AS SELECT (CTAS) operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS source;
CREATE TABLE source (
    id INT64,
    name STRING
);

INSERT INTO source VALUES (1, 'Alice'), (2, 'Bob');

-- CREATE TABLE AS SELECT
CREATE TABLE target AS
-- Tag: views_create_table_as_select_test_select_001
SELECT * FROM source;

-- Verify target table exists and has correct data
-- Tag: views_create_table_as_select_test_select_002
SELECT * FROM target ORDER BY id;

-- CTAS - Empty Result Set

-- CTAS with empty result set creates table with schema but no rows
DROP TABLE IF EXISTS source_empty;
CREATE TABLE source_empty (
    id INT64,
    value STRING
);

-- CTAS with WHERE clause that matches nothing
CREATE TABLE empty_target AS
-- Tag: views_create_table_as_select_test_select_003
SELECT * FROM source_empty WHERE id > 1000;

-- Tag: views_create_table_as_select_test_select_004
SELECT COUNT(*) FROM empty_target;

-- Table should have schema (2 columns)
-- SELECT * FROM empty_target;

-- CTAS - Single Row

DROP TABLE IF EXISTS source_single;
CREATE TABLE source_single (
    id INT64,
    name STRING
);

INSERT INTO source_single VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

-- CTAS with single row
CREATE TABLE single_row AS
-- Tag: views_create_table_as_select_test_select_005
SELECT * FROM source_single WHERE id = 2;

-- Tag: views_create_table_as_select_test_select_006
SELECT COUNT(*) FROM single_row;

-- CTAS - Single Column

DROP TABLE IF EXISTS source_multi_col;
CREATE TABLE source_multi_col (
    id INT64,
    name STRING,
    age INT64
);

INSERT INTO source_multi_col VALUES (1, 'Alice', 30), (2, 'Bob', 25);

-- CTAS selecting only one column
CREATE TABLE names_only AS
-- Tag: views_create_table_as_select_test_select_007
SELECT name FROM source_multi_col;

-- Tag: views_create_table_as_select_test_select_008
SELECT * FROM names_only;

-- CTAS - With Column Aliases

DROP TABLE IF EXISTS source_alias;
CREATE TABLE source_alias (
    id INT64,
    value INT64
);

INSERT INTO source_alias VALUES (1, 100), (2, 200);

-- CTAS with explicit column aliases
CREATE TABLE target_alias AS
-- Tag: views_create_table_as_select_test_select_009
SELECT id AS user_id, value AS amount FROM source_alias;

-- Query using new column names
-- Tag: views_create_table_as_select_test_select_010
SELECT user_id, amount FROM target_alias ORDER BY user_id;

-- CTAS - With Computed Columns

DROP TABLE IF EXISTS source_computed;
CREATE TABLE source_computed (
    price INT64,
    quantity INT64
);

INSERT INTO source_computed VALUES (10, 5), (20, 3);

-- CTAS with computed/derived columns
CREATE TABLE derived AS
-- Tag: views_create_table_as_select_test_select_011
SELECT price, quantity, price * quantity AS total FROM source_computed;

-- Tag: views_create_table_as_select_test_select_012
SELECT total FROM derived ORDER BY total;

-- CTAS - With Aggregations

DROP TABLE IF EXISTS sales_source;
CREATE TABLE sales_source (
    product STRING,
    amount INT64
);

INSERT INTO sales_source VALUES
    ('A', 100),
    ('A', 150),
    ('B', 200),
    ('B', 250);

-- CTAS with aggregation functions
CREATE TABLE summary AS
-- Tag: views_create_table_as_select_test_select_001
SELECT
    product,
    SUM(amount) AS total,
    COUNT(*) AS count
FROM sales_source
GROUP BY product;

-- Tag: views_create_table_as_select_test_select_013
SELECT * FROM summary ORDER BY product;
-- ('A', 250, 2)
-- ('B', 450, 2)

-- CTAS - Type Inference

-- CTAS should infer types from literal values
CREATE TABLE int_table AS
-- Tag: views_create_table_as_select_test_select_014
SELECT 1 AS a, 2 AS b, 3 AS c;

-- Tag: views_create_table_as_select_test_select_015
SELECT * FROM int_table;

-- CTAS with string literals
CREATE TABLE string_table AS
-- Tag: views_create_table_as_select_test_select_016
SELECT 'hello' AS greeting, 'world' AS subject;

-- Tag: views_create_table_as_select_test_select_017
SELECT * FROM string_table;

-- CTAS with float literals
CREATE TABLE float_table AS
-- Tag: views_create_table_as_select_test_select_018
SELECT 3.14 AS pi, 2.71 AS e;

-- Tag: views_create_table_as_select_test_select_019
SELECT * FROM float_table;

-- CTAS - With WHERE Clause

DROP TABLE IF EXISTS source_filter;
CREATE TABLE source_filter (
    id INT64,
    value INT64
);

INSERT INTO source_filter VALUES (1, 100), (2, 50), (3, 200);

-- CTAS with filtered SELECT
CREATE TABLE filtered AS
-- Tag: views_create_table_as_select_test_select_020
SELECT * FROM source_filter WHERE value > 75;

-- Tag: views_create_table_as_select_test_select_021
SELECT COUNT(*) FROM filtered;

-- CTAS - With JOINs

DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
    owner_id INT64,
    name STRING
);

DROP TABLE IF EXISTS orders_ctas;
CREATE TABLE orders_ctas (
    order_id INT64,
    owner_id INT64,
    amount INT64
);

INSERT INTO yacht_owners VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders_ctas VALUES (1, 1, 100), (2, 1, 200), (3, 2, 150);

-- CTAS with JOIN
CREATE TABLE customer_orders AS
-- Tag: views_create_table_as_select_test_select_002
SELECT
    c.name,
    o.order_id,
    o.amount
FROM yacht_owners c
JOIN orders_ctas o ON c.owner_id = o.owner_id;

-- Tag: views_create_table_as_select_test_select_022
SELECT * FROM customer_orders ORDER BY order_id;

-- CTAS - With Subquery

DROP TABLE IF EXISTS crew_members_ctas;
CREATE TABLE crew_members_ctas (
    id INT64,
    name STRING,
    salary INT64
);

INSERT INTO crew_members_ctas VALUES (1, 'Alice', 80000), (2, 'Bob', 60000), (3, 'Charlie', 90000);

-- CTAS with subquery
CREATE TABLE above_average AS
-- Tag: views_create_table_as_select_test_select_023
SELECT * FROM crew_members_ctas
WHERE salary > (SELECT AVG(salary) FROM crew_members_ctas);

-- Tag: views_create_table_as_select_test_select_024
SELECT COUNT(*) FROM above_average;

-- CTAS - With CTE (Common Table Expression)

DROP TABLE IF EXISTS sales_cte;
CREATE TABLE sales_cte (
    product STRING,
    amount INT64
);

INSERT INTO sales_cte VALUES ('Widget', 100), ('Widget', 150), ('Gadget', 200);

-- CTAS with CTE
CREATE TABLE product_totals AS
WITH totals AS (
-- Tag: views_create_table_as_select_test_select_025
    SELECT product, SUM(amount) as total
    FROM sales_cte
    GROUP BY product
)
-- Tag: views_create_table_as_select_test_select_026
SELECT * FROM totals WHERE total > 150;

-- Tag: views_create_table_as_select_test_select_027
SELECT * FROM product_totals ORDER BY product;

-- CTAS - With UNION

DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);

INSERT INTO set1 VALUES (1), (2), (3);
INSERT INTO set2 VALUES (3), (4), (5);

-- CTAS with UNION
CREATE TABLE combined AS
-- Tag: views_create_table_as_select_test_select_028
SELECT value FROM set1
UNION
-- Tag: views_create_table_as_select_test_select_029
SELECT value FROM set2;

-- Tag: views_create_table_as_select_test_select_030
SELECT COUNT(*) FROM combined;

-- CTAS - With UNION ALL

DROP TABLE IF EXISTS set3;
CREATE TABLE set3 (value INT64);
DROP TABLE IF EXISTS set4;
CREATE TABLE set4 (value INT64);

INSERT INTO set3 VALUES (1), (2);
INSERT INTO set4 VALUES (2), (3);

-- CTAS with UNION ALL
CREATE TABLE combined_all AS
-- Tag: views_create_table_as_select_test_select_031
SELECT value FROM set3
UNION ALL
-- Tag: views_create_table_as_select_test_select_032
SELECT value FROM set4;

-- Tag: views_create_table_as_select_test_select_033
SELECT COUNT(*) FROM combined_all;

-- CTAS - With ORDER BY

DROP TABLE IF EXISTS source_order;
CREATE TABLE source_order (
    id INT64,
    value INT64
);

INSERT INTO source_order VALUES (3, 30), (1, 10), (2, 20);

-- CTAS with ORDER BY
CREATE TABLE ordered AS
-- Tag: views_create_table_as_select_test_select_034
SELECT * FROM source_order ORDER BY id ASC;

-- Note: ORDER BY in CTAS may not guarantee storage order
-- Tag: views_create_table_as_select_test_select_035
SELECT * FROM ordered ORDER BY id;

-- CTAS - With LIMIT

DROP TABLE IF EXISTS source_limit;
CREATE TABLE source_limit (
    id INT64,
    value INT64
);

INSERT INTO source_limit VALUES (1, 10), (2, 20), (3, 30), (4, 40);

-- CTAS with LIMIT
CREATE TABLE limited AS
-- Tag: views_create_table_as_select_test_select_036
SELECT * FROM source_limit LIMIT 2;

-- Tag: views_create_table_as_select_test_select_037
SELECT COUNT(*) FROM limited;

-- CTAS - With DISTINCT

DROP TABLE IF EXISTS source_dupes;
CREATE TABLE source_dupes (
    category STRING,
    value INT64
);

INSERT INTO source_dupes VALUES ('A', 1), ('A', 1), ('B', 2), ('B', 2);

-- CTAS with DISTINCT
CREATE TABLE unique_vals AS
-- Tag: views_create_table_as_select_test_select_038
SELECT DISTINCT category, value FROM source_dupes;

-- Tag: views_create_table_as_select_test_select_039
SELECT COUNT(*) FROM unique_vals;

-- CTAS - NULL Handling

DROP TABLE IF EXISTS source_nulls;
CREATE TABLE source_nulls (
    id INT64,
    value STRING
);

INSERT INTO source_nulls VALUES (1, 'A'), (2, NULL), (3, 'C');

-- CTAS preserves NULLs
CREATE TABLE with_nulls AS
-- Tag: views_create_table_as_select_test_select_040
SELECT * FROM source_nulls;

-- Tag: views_create_table_as_select_test_select_041
SELECT COUNT(*) FROM with_nulls WHERE value IS NULL;

-- CTAS - Multiple Data Types

DROP TABLE IF EXISTS source_types;
CREATE TABLE source_types (
    int_col INT64,
    float_col FLOAT64,
    string_col STRING,
    bool_col BOOL,
    date_col DATE
);

INSERT INTO source_types VALUES
    (1, 3.14, 'test', TRUE, DATE '2024-01-15');

-- CTAS preserves all data types
CREATE TABLE types_preserved AS
-- Tag: views_create_table_as_select_test_select_042
SELECT * FROM source_types;

-- Tag: views_create_table_as_select_test_select_043
SELECT * FROM types_preserved;

-- CTAS - Large Result Set

-- CTAS with many rows (stress test)
DROP TABLE IF EXISTS large_source;
CREATE TABLE large_source (
    id INT64,
    value INT64
);

-- Insert 1000 rows (using loop or bulk insert)
-- INSERT INTO large_source VALUES (1, 1), (2, 2), ... (1000, 1000);

-- CTAS with large result
CREATE TABLE large_target AS
-- Tag: views_create_table_as_select_test_select_044
SELECT * FROM large_source;

-- Tag: views_create_table_as_select_test_select_045
SELECT COUNT(*) FROM large_target;

-- CTAS - Window Functions

DROP TABLE IF EXISTS source_window;
CREATE TABLE source_window (
    id INT64,
    category STRING,
    value INT64
);

INSERT INTO source_window VALUES
    (1, 'A', 100),
    (2, 'A', 150),
    (3, 'B', 200);

-- CTAS with window function
CREATE TABLE with_rank AS
-- Tag: views_create_table_as_select_test_select_003
SELECT
    id,
    category,
    value,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY value) AS rank
FROM source_window;

-- Tag: views_create_table_as_select_test_select_046
SELECT * FROM with_rank ORDER BY id;

-- CTAS - CASE Expression

DROP TABLE IF EXISTS source_case;
CREATE TABLE source_case (
    id INT64,
    score INT64
);

INSERT INTO source_case VALUES (1, 95), (2, 75), (3, 55);

-- CTAS with CASE
CREATE TABLE graded AS
-- Tag: views_create_table_as_select_test_select_004
SELECT
    id,
    score,
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score >= 70 THEN 'B'
        ELSE 'C'
    END AS grade
FROM source_case;

-- Tag: views_create_table_as_select_test_select_047
SELECT * FROM graded ORDER BY id;

-- CTAS - From Multiple Tables

DROP TABLE IF EXISTS table_a;
CREATE TABLE table_a (
    id INT64,
    value_a STRING
);

DROP TABLE IF EXISTS table_b;
CREATE TABLE table_b (
    id INT64,
    value_b STRING
);

INSERT INTO table_a VALUES (1, 'A1'), (2, 'A2');
INSERT INTO table_b VALUES (2, 'B2'), (3, 'B3');

-- CTAS combining multiple tables
CREATE TABLE combined_tables AS
-- Tag: views_create_table_as_select_test_select_048
SELECT a.id, a.value_a, b.value_b
FROM table_a a
LEFT JOIN table_b b ON a.id = b.id;

-- Tag: views_create_table_as_select_test_select_049
SELECT * FROM combined_tables ORDER BY id;

-- Error Cases

-- Duplicate table name (should fail)
DROP TABLE IF EXISTS duplicate_test;
CREATE TABLE duplicate_test (id INT64);
-- CREATE TABLE duplicate_test AS SELECT 1 AS id;

-- Invalid query (should fail)
-- CREATE TABLE invalid AS SELECT * FROM nonexistent_table;

-- CTAS - Independence from Source

-- CTAS creates independent copy
DROP TABLE IF EXISTS source_independent;
CREATE TABLE source_independent (
    id INT64,
    value INT64
);

INSERT INTO source_independent VALUES (1, 100);

CREATE TABLE copy AS
-- Tag: views_create_table_as_select_test_select_050
SELECT * FROM source_independent;

-- Modify source
INSERT INTO source_independent VALUES (2, 200);

-- Copy should remain unchanged
-- Tag: views_create_table_as_select_test_select_051
SELECT COUNT(*) FROM copy;

-- End of File
