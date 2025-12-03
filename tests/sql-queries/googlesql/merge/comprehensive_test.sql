-- ============================================================================
-- Comprehensive - GoogleSQL/BigQuery
-- ============================================================================
-- Source: tests/merge_statement_bigquery_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

-- Test: Basic MERGE that updates matched rows
-- Expected: Row with id=1 is updated from 'old_value' to 'new_value'
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'old_value');
INSERT INTO source VALUES (1, 'new_value');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value;

SELECT value FROM target WHERE id = 1;

-- Test: UPDATE multiple columns in matched rows
-- Expected: All specified columns are updated
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, name STRING, status STRING, version INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, name STRING, status STRING);
INSERT INTO target VALUES (1, 'Alice', 'active', 1);
INSERT INTO source VALUES (1, 'Alice Updated', 'inactive');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET
    name = S.name,
    status = S.status,
    version = T.version + 1;

SELECT name, status, version FROM target WHERE id = 1;

-- ============================================================================
-- WHEN NOT MATCHED THEN INSERT
-- ============================================================================

-- Test: INSERT new rows when not matched
-- Expected: Source row with id=2 is inserted into target
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'existing');
INSERT INTO source VALUES (2, 'new_value');

MERGE target T
USING source S
ON T.id = S.id
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;
SELECT value FROM target WHERE id = 2;

-- Test: INSERT with DEFAULT values for missing columns
-- Expected: DEFAULT values used for unspecified columns
DROP TABLE IF EXISTS target;
CREATE TABLE target (
    id INT64,
    value STRING,
    status STRING DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'new_value');

MERGE target T
USING source S
ON T.id = S.id
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT status FROM target WHERE id = 1;

-- ============================================================================
-- Combined UPDATE and INSERT (True UPSERT)
-- ============================================================================

-- Test: MERGE with both WHEN MATCHED and WHEN NOT MATCHED
-- Expected: Updates existing row (id=1), inserts new row (id=2)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'old_value');
INSERT INTO source VALUES (1, 'updated_value'), (2, 'new_value');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT id, value FROM target ORDER BY id;

-- Test: MERGE where all source rows match target
-- Expected: All rows updated, none inserted (100% match rate)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'a'), (2, 'b');
INSERT INTO source VALUES (1, 'aa'), (2, 'bb');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;

-- Test: MERGE where no source rows match target
-- Expected: All rows inserted, none updated (0% match rate)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'a'), (2, 'b');
INSERT INTO source VALUES (3, 'c'), (4, 'd');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;

-- ============================================================================
-- WHEN NOT MATCHED BY SOURCE THEN DELETE
-- ============================================================================

-- Test: DELETE rows in target that don't match source
-- Expected: Rows with id=2 and id=3 are deleted
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'keep'), (2, 'delete_me'), (3, 'delete_me_too');
INSERT INTO source VALUES (1, 'updated');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT COUNT(*) FROM target;
SELECT value FROM target WHERE id = 1;

-- Test: Full table synchronization (INSERT + UPDATE + DELETE)
-- Expected: Target becomes exact copy of source
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'update_me'), (2, 'delete_me'), (3, 'keep');
INSERT INTO source VALUES (1, 'updated'), (3, 'keep'), (4, 'new');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value)
WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT id, value FROM target ORDER BY id;

-- ============================================================================
-- Conditional MERGE with AND Clauses
-- ============================================================================

-- Test: WHEN MATCHED AND condition THEN UPDATE
-- Expected: Only rows matching both ON and AND conditions are updated
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64, status STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO target VALUES (1, 10, 'active'), (2, 20, 'inactive');
INSERT INTO source VALUES (1, 100), (2, 200);

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED AND T.status = 'active' THEN UPDATE SET value = S.value;

SELECT id, value FROM target ORDER BY id;

-- Test: Multiple WHEN MATCHED clauses with different conditions
-- Expected: First matching clause is executed
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64, category STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO target VALUES (1, 10, 'A'), (2, 20, 'B');
INSERT INTO source VALUES (1, 100), (2, 200);

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED AND T.category = 'A' THEN UPDATE SET value = S.value * 2
WHEN MATCHED AND T.category = 'B' THEN UPDATE SET value = S.value * 3
WHEN MATCHED THEN UPDATE SET value = S.value;

SELECT value FROM target WHERE id = 1;
SELECT value FROM target WHERE id = 2;

-- Test: WHEN NOT MATCHED AND condition THEN INSERT
-- Expected: Only insert rows meeting the condition (value > 100)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 50), (2, 150), (3, 250);

MERGE target T
USING source S
ON T.id = S.id
WHEN NOT MATCHED AND S.value > 100 THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT id FROM target ORDER BY id;

-- ============================================================================
-- MERGE with Subqueries and CTEs
-- ============================================================================

-- Test: MERGE using subquery as source
-- Expected: Subquery results (aggregated data) used for MERGE
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, total INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (equipment_id INT64, quantity INT64);
INSERT INTO target VALUES (1, 100);
INSERT INTO orders VALUES (1, 10), (1, 20), (2, 30);

MERGE target T
USING (SELECT equipment_id as id, SUM(quantity) as qty FROM orders GROUP BY equipment_id) S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET total = T.total + S.qty
WHEN NOT MATCHED THEN INSERT (id, total) VALUES (S.id, S.qty);

SELECT id, total FROM target ORDER BY id;

-- Test: MERGE with CTE as source
-- Expected: CTE results used as MERGE source
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS staging;
CREATE TABLE staging (id INT64, value STRING);
INSERT INTO target VALUES (1, 'old');
INSERT INTO staging VALUES (1, 'new'), (2, 'inserted');

WITH source_cte AS (
    SELECT id, value FROM staging WHERE id <= 2
)
MERGE target T
USING source_cte S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT id, value FROM target ORDER BY id;

-- ============================================================================
-- Edge Cases
-- ============================================================================

-- Test: MERGE with empty source table
-- Expected: Target table unchanged
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'keep_me');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT value FROM target WHERE id = 1;

-- Test: MERGE into empty target table
-- Expected: All source rows inserted
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'a'), (2, 'b');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;

-- Test: NULL values in merge join condition
-- Expected: NULL != NULL, rows with NULL don't match
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (NULL, 'target_null'), (1, 'target_1');
INSERT INTO source VALUES (NULL, 'source_null'), (1, 'source_1');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;

-- Test: MERGE with multi-column join condition
-- Expected: All columns must match for WHEN MATCHED
DROP TABLE IF EXISTS target;
CREATE TABLE target (order_id INT64, equipment_id INT64, quantity INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (order_id INT64, equipment_id INT64, quantity INT64);
INSERT INTO target VALUES (1, 101, 5);
INSERT INTO source VALUES (1, 101, 10), (1, 102, 20);

MERGE target T
USING source S
ON T.order_id = S.order_id AND T.equipment_id = S.equipment_id
WHEN MATCHED THEN UPDATE SET quantity = S.quantity
WHEN NOT MATCHED THEN INSERT (order_id, equipment_id, quantity)
    VALUES (S.order_id, S.equipment_id, S.quantity);

SELECT COUNT(*) FROM target;

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: MERGE where one target row matches multiple source rows
-- Expected: Error (each target row must match at most one source row)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO target VALUES (1, 'original');
INSERT INTO source VALUES (1, 'duplicate1'), (1, 'duplicate2');

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value;
-- Expected error: duplicate matches

-- Test: Invalid column in ON clause
-- Expected: Error - column not found
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);

MERGE target T
USING source S
ON T.nonexistent = S.id
WHEN MATCHED THEN UPDATE SET value = S.value;
-- Expected error: column 'nonexistent' not found

-- ============================================================================
-- Performance and Bulk Operations
-- ============================================================================

-- Test: MERGE with large number of rows
-- Expected: Efficiently handles bulk operations (500 updates + 500 inserts)
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);

-- Insert 500 rows into target (ids 0-499)
-- Insert 1000 rows into source (ids 0-999)
-- Result: 500 updates (0-499) + 500 inserts (500-999) = 1000 total rows

MERGE target T
USING source S
ON T.id = S.id
WHEN MATCHED THEN UPDATE SET value = S.value
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (S.id, S.value);

SELECT COUNT(*) FROM target;

-- ============================================================================
-- Advanced Scenarios
-- ============================================================================

-- Test: MERGE table with itself (self-join)
-- Expected: Can merge table with filtered/transformed version of itself
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'B', 20), (3, 'A', 30);

MERGE data T
USING (SELECT category, SUM(value) as total FROM data WHERE category = 'A' GROUP BY category) S
ON T.category = S.category
WHEN MATCHED THEN UPDATE SET value = S.total;

SELECT value FROM data WHERE category = 'A';
