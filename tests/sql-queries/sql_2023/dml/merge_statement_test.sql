-- Merge Statement - SQL:2023
-- Description: MERGE statement for upsert operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    name STRING,
    price INT64
);

INSERT INTO equipment VALUES
    (1, 'Widget', 100),
    (2, 'Gadget', 200);

-- Setup: Create source table with updates and new data
DROP TABLE IF EXISTS updates;
CREATE TABLE updates (
    id INT64,
    name STRING,
    price INT64
);

INSERT INTO updates VALUES
    (1, 'Widget', 150),      -- Update existing
    (3, 'Doohickey', 300);   -- Insert new

-- Execute MERGE: Update matching rows, insert non-matching rows
MERGE INTO equipment p
USING updates u
ON p.id = u.id
WHEN MATCHED THEN
    UPDATE SET p.price = u.price
WHEN NOT MATCHED THEN
    INSERT (id, name, price) VALUES (u.id, u.name, u.price);

-- Verify results
-- Tag: dml_merge_statement_test_select_001
SELECT * FROM equipment ORDER BY id;
-- (1, 'Widget', 150)    -- Updated
-- (2, 'Gadget', 200)    -- Unchanged
-- (3, 'Doohickey', 300) -- Inserted

-- MERGE - UPDATE Only

-- Setup: Inventory table
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    id INT64,
    quantity INT64
);

INSERT INTO inventory VALUES (1, 100), (2, 200), (3, 300);

-- Setup: Adjustments
DROP TABLE IF EXISTS adjustments;
CREATE TABLE adjustments (
    id INT64,
    adjustment INT64
);

INSERT INTO adjustments VALUES (1, -10), (2, 20);

-- MERGE: Only update matching rows (no inserts)
MERGE INTO inventory i
USING adjustments a
ON i.id = a.id
WHEN MATCHED THEN
    UPDATE SET i.quantity = i.quantity + a.adjustment;

-- Verify results
-- Tag: dml_merge_statement_test_select_002
SELECT * FROM inventory ORDER BY id;
-- (1, 90)   -- 100 - 10
-- (2, 220)  -- 200 + 20
-- (3, 300)  -- Unchanged

-- MERGE - INSERT Only

-- Setup: Existing yacht_owners
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
    id INT64,
    name STRING
);

INSERT INTO yacht_owners VALUES (1, 'Alice');

-- Setup: New yacht_owners list
DROP TABLE IF EXISTS new_yacht_owners;
CREATE TABLE new_yacht_owners (
    id INT64,
    name STRING
);

INSERT INTO new_yacht_owners VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');

-- MERGE: Only insert non-matching rows
MERGE INTO yacht_owners c
USING new_yacht_owners nc
ON c.id = nc.id
WHEN NOT MATCHED THEN
    INSERT (id, name) VALUES (nc.id, nc.name);

-- Verify results
-- Tag: dml_merge_statement_test_select_003
SELECT * FROM yacht_owners ORDER BY id;
-- (1, 'Alice')   -- Existed
-- (2, 'Bob')     -- Inserted
-- (3, 'Charlie') -- Inserted

-- MERGE - DELETE (NOT MATCHED BY SOURCE)

-- Setup: Target table
DROP TABLE IF EXISTS target;
CREATE TABLE target (
    id INT64,
    value STRING
);

INSERT INTO target VALUES
    (1, 'keep'),
    (2, 'delete'),
    (3, 'delete');

-- Setup: Source table
DROP TABLE IF EXISTS source;
CREATE TABLE source (
    id INT64,
    value STRING
);

INSERT INTO source VALUES
    (1, 'keep'),
    (4, 'new');

-- MERGE: Update, Insert, and Delete
MERGE INTO target t
USING source s
ON t.id = s.id
WHEN MATCHED THEN
    UPDATE SET t.value = s.value
WHEN NOT MATCHED THEN
    INSERT (id, value) VALUES (s.id, s.value)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Verify results
-- Tag: dml_merge_statement_test_select_004
SELECT * FROM target ORDER BY id;
-- (1, 'keep') -- Updated
-- (4, 'new')  -- Inserted
-- Rows 2 and 3 deleted

-- MERGE - Conditional WHEN Clauses

-- Setup
DROP TABLE IF EXISTS equipment_conditional;
CREATE TABLE equipment_conditional (
    id INT64,
    name STRING,
    price INT64,
    active BOOL
);

INSERT INTO equipment_conditional VALUES
    (1, 'Product A', 100, TRUE),
    (2, 'Product B', 200, FALSE);

DROP TABLE IF EXISTS updates_conditional;
CREATE TABLE updates_conditional (
    id INT64,
    name STRING,
    price INT64
);

INSERT INTO updates_conditional VALUES
    (1, 'Product A', 150),
    (2, 'Product B', 250),
    (3, 'Product C', 300);

-- MERGE: Conditional updates
MERGE INTO equipment_conditional p
USING updates_conditional u
ON p.id = u.id
WHEN MATCHED AND p.active = TRUE THEN
    UPDATE SET p.price = u.price
WHEN MATCHED AND p.active = FALSE THEN
    DELETE
WHEN NOT MATCHED THEN
    INSERT (id, name, price, active) VALUES (u.id, u.name, u.price, TRUE);

-- Verify results
-- Tag: dml_merge_statement_test_select_005
SELECT * FROM equipment_conditional ORDER BY id;
-- (1, 'Product A', 150, TRUE) -- Updated (active = TRUE)
-- (3, 'Product C', 300, TRUE) -- Inserted
-- Product B deleted (active = FALSE)

-- MERGE - With Subquery as Source

-- Setup
DROP TABLE IF EXISTS sales_summary;
CREATE TABLE sales_summary (
    equipment_id INT64,
    total_sales INT64
);

INSERT INTO sales_summary VALUES (1, 1000);

DROP TABLE IF EXISTS sales_detail;
CREATE TABLE sales_detail (
    id INT64,
    equipment_id INT64,
    amount INT64
);

INSERT INTO sales_detail VALUES
    (1, 1, 100),
    (2, 1, 200),
    (3, 2, 300);

-- MERGE: Using subquery as source
MERGE INTO sales_summary ss
USING (
-- Tag: dml_merge_statement_test_select_006
    SELECT equipment_id, SUM(amount) as total
    FROM sales_detail
    GROUP BY equipment_id
) s
ON ss.equipment_id = s.equipment_id
WHEN MATCHED THEN
    UPDATE SET ss.total_sales = ss.total_sales + s.total
WHEN NOT MATCHED THEN
    INSERT (equipment_id, total_sales) VALUES (s.equipment_id, s.total);

-- Verify results
-- Tag: dml_merge_statement_test_select_007
SELECT * FROM sales_summary ORDER BY equipment_id;
-- (1, 1300) -- 1000 + (100 + 200)
-- (2, 300)  -- Newly inserted

-- MERGE - With CTE (Common Table Expression)

-- Setup
DROP TABLE IF EXISTS crew_member_salaries;
CREATE TABLE crew_member_salaries (
    id INT64,
    salary INT64
);

INSERT INTO crew_member_salaries VALUES (1, 50000), (2, 60000);

DROP TABLE IF EXISTS salary_adjustments;
CREATE TABLE salary_adjustments (
    crew_member_id INT64,
    adjustment_percent NUMERIC(5, 2)
);

INSERT INTO salary_adjustments VALUES
    (1, 10.0),
    (2, 5.0),
    (3, 15.0);

-- MERGE: Using CTE
WITH adjusted_salaries AS (
-- Tag: dml_merge_statement_test_select_001
    SELECT
        crew_member_id,
        adjustment_percent,
        50000 * (1 + adjustment_percent / 100) as new_salary
    FROM salary_adjustments
)
MERGE INTO crew_member_salaries e
USING adjusted_salaries a
ON e.id = a.crew_member_id
WHEN MATCHED THEN
    UPDATE SET e.salary = a.new_salary
WHEN NOT MATCHED THEN
    INSERT (id, salary) VALUES (a.crew_member_id, a.new_salary);

-- MERGE - Multiple UPDATE SET Clauses

-- Setup
DROP TABLE IF EXISTS product_inventory;
CREATE TABLE product_inventory (
    id INT64,
    name STRING,
    quantity INT64,
    last_updated TIMESTAMP
);

INSERT INTO product_inventory VALUES
    (1, 'Widget', 100, TIMESTAMP '2024-01-01 00:00:00');

DROP TABLE IF EXISTS inventory_updates;
CREATE TABLE inventory_updates (
    id INT64,
    quantity_change INT64
);

INSERT INTO inventory_updates VALUES (1, 50);

-- MERGE: Update multiple columns
MERGE INTO product_inventory pi
USING inventory_updates iu
ON pi.id = iu.id
WHEN MATCHED THEN
    UPDATE SET
        pi.quantity = pi.quantity + iu.quantity_change,
        pi.last_updated = CURRENT_TIMESTAMP;

-- MERGE - Error Cases

-- Error: Multiple matches (should fail)
-- Each source row can match at most one target row

DROP TABLE IF EXISTS target_multi;
CREATE TABLE target_multi (id INT64, value INT64);
INSERT INTO target_multi VALUES (1, 100), (1, 200);  -- Duplicate ids

DROP TABLE IF EXISTS source_multi;
CREATE TABLE source_multi (id INT64, value INT64);
INSERT INTO source_multi VALUES (1, 999);

-- This should fail: source row matches multiple target rows
-- MERGE INTO target_multi t
-- USING source_multi s
-- ON t.id = s.id
-- WHEN MATCHED THEN UPDATE SET t.value = s.value;

-- MERGE - NULL Handling

-- Setup
DROP TABLE IF EXISTS test_null_merge;
CREATE TABLE test_null_merge (
    id INT64,
    value STRING
);

INSERT INTO test_null_merge VALUES (1, 'existing');

DROP TABLE IF EXISTS source_null;
CREATE TABLE source_null (
    id INT64,
    value STRING
);

INSERT INTO source_null VALUES
    (1, NULL),
    (2, 'new');

-- MERGE: NULL values
MERGE INTO test_null_merge t
USING source_null s
ON t.id = s.id
WHEN MATCHED THEN
    UPDATE SET t.value = s.value  -- Updates to NULL
WHEN NOT MATCHED THEN
    INSERT (id, value) VALUES (s.id, s.value);

-- Verify
-- Tag: dml_merge_statement_test_select_008
SELECT * FROM test_null_merge ORDER BY id;
-- (1, NULL) -- Updated to NULL
-- (2, 'new') -- Inserted

-- MERGE - Empty Source or Target

-- Empty source
DROP TABLE IF EXISTS target_empty_source;
CREATE TABLE target_empty_source (id INT64, value INT64);
INSERT INTO target_empty_source VALUES (1, 100);

DROP TABLE IF EXISTS source_empty;
CREATE TABLE source_empty (id INT64, value INT64);
-- No rows

-- MERGE with empty source: No changes
MERGE INTO target_empty_source t
USING source_empty s
ON t.id = s.id
WHEN MATCHED THEN UPDATE SET t.value = s.value;

-- Verify: target unchanged
-- Tag: dml_merge_statement_test_select_009
SELECT * FROM target_empty_source;

-- Empty target
DROP TABLE IF EXISTS target_empty;
CREATE TABLE target_empty (id INT64, value INT64);
-- No rows

DROP TABLE IF EXISTS source_not_empty;
CREATE TABLE source_not_empty (id INT64, value INT64);
INSERT INTO source_not_empty VALUES (1, 100);

-- MERGE with empty target: Only inserts
MERGE INTO target_empty t
USING source_not_empty s
ON t.id = s.id
WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);

-- Verify: row inserted
-- Tag: dml_merge_statement_test_select_010
SELECT * FROM target_empty;

-- MERGE - Complex Join Conditions

-- Setup
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT64,
    owner_id INT64,
    status STRING
);

INSERT INTO orders VALUES
    (1, 100, 'pending'),
    (2, 101, 'pending');

DROP TABLE IF EXISTS order_updates;
CREATE TABLE order_updates (
    order_id INT64,
    owner_id INT64,
    new_status STRING
);

INSERT INTO order_updates VALUES
    (1, 100, 'shipped'),
    (3, 102, 'pending');

-- MERGE: Join on multiple columns
MERGE INTO orders o
USING order_updates ou
ON o.order_id = ou.order_id AND o.owner_id = ou.owner_id
WHEN MATCHED THEN
    UPDATE SET o.status = ou.new_status
WHEN NOT MATCHED THEN
    INSERT (order_id, owner_id, status)
    VALUES (ou.order_id, ou.owner_id, ou.new_status);

-- Verify
-- Tag: dml_merge_statement_test_select_011
SELECT * FROM orders ORDER BY order_id;
-- (1, 100, 'shipped') -- Updated
-- (2, 101, 'pending') -- Unchanged
-- (3, 102, 'pending') -- Inserted

-- End of File
