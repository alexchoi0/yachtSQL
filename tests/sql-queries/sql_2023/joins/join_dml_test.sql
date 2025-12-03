-- Join Dml - SQL:2023
-- Description: JOIN operations combined with DML statements
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: joins_join_dml_test_select_001
    SELECT user_id FROM scores WHERE points >= 1000
)
UPDATE users
SET level = 'advanced'
FROM high_scorers
WHERE users.id = high_scorers.user_id;

-- ----------------------------------------------------------------------------
-- 3. DELETE...USING - Delete rows based on joined table data
-- ----------------------------------------------------------------------------

-- Basic DELETE...USING with simple join
DELETE FROM users
USING to_delete
WHERE users.id = to_delete.user_id;

-- DELETE...USING with complex condition
DELETE FROM orders
USING cancelled_users
WHERE orders.user_id = cancelled_users.user_id
  AND orders.status = 'pending';

-- DELETE...USING with multiple tables
DELETE FROM logs
USING inactive_users, log_types_to_clean
WHERE logs.user_id = inactive_users.user_id
  AND logs.type = log_types_to_clean.type;

-- DELETE with self-join (remove duplicates, keep newest)
DELETE FROM contacts c1
USING contacts c2
WHERE c1.email = c2.email
  AND c1.created_at < c2.created_at;

-- DELETE all rows matching a condition (cross join pattern)
DELETE FROM temp
USING cleanup
WHERE cleanup.flag = TRUE;

-- DELETE...USING with RETURNING clause (PostgreSQL)
DELETE FROM equipment
USING discontinued_categories
WHERE equipment.category = discontinued_categories.category
RETURNING equipment.id, equipment.name;

-- ----------------------------------------------------------------------------
-- 4. DELETE...USING with Common Table Expressions (CTEs)
-- ----------------------------------------------------------------------------

-- DELETE using CTE to identify rows to remove
WITH inactive AS (
-- Tag: joins_join_dml_test_select_002
    SELECT user_id FROM activity WHERE last_active > 60
)
DELETE FROM sessions
USING inactive
WHERE sessions.user_id = inactive.user_id;

-- ----------------------------------------------------------------------------
-- 5. Edge Cases and Special Scenarios
-- ----------------------------------------------------------------------------

-- UPDATE...FROM where no rows match (no updates occur)
UPDATE users
SET name = updates.new_name
FROM updates
WHERE users.id = updates.user_id;
-- No rows updated if no matching user_id

-- UPDATE...FROM setting column to NULL
UPDATE users
SET email = email_updates.new_email
FROM email_updates
WHERE users.id = email_updates.user_id;
-- Sets email to NULL if new_email is NULL

-- DELETE...USING where no rows match (no deletions occur)
DELETE FROM users
USING to_delete
WHERE users.id = to_delete.user_id;
-- No rows deleted if no matching user_id

-- UPDATE using self-join with circular reference
UPDATE nums n1
SET value = n2.value + 1
FROM nums n2
WHERE n1.id = n2.id;

-- ----------------------------------------------------------------------------
-- 6. Performance - Batch Operations
-- ----------------------------------------------------------------------------

-- Batch UPDATE of many rows (100 items)
UPDATE items
SET price = items.price * price_changes.multiplier
FROM price_changes
WHERE items.id = price_changes.item_id;
-- Efficiently updates all matching rows in single operation

-- Batch DELETE of many rows (100 records)
DELETE FROM records
USING to_remove
WHERE records.id = to_remove.record_id;
-- Efficiently deletes all matching rows in single operation

-- ----------------------------------------------------------------------------
-- 7. Error Conditions (These should produce errors)
-- ----------------------------------------------------------------------------

-- Ambiguous column reference (missing table qualifier)
-- ERROR: This will fail due to ambiguous 'id' column
UPDATE t1
SET value = t2.value
FROM t2
WHERE id = t2.id;
-- FIX: Use t1.id = t2.id

-- Invalid column reference
-- ERROR: Column 'nonexistent' does not exist
DELETE FROM users
USING filter
WHERE users.nonexistent = filter.user_id;

-- ----------------------------------------------------------------------------
-- 8. INSERT INTO ... SELECT with JOIN
-- ----------------------------------------------------------------------------

-- INSERT using JOIN to combine data from multiple tables
INSERT INTO summary (user_id, order_count, total_amount)
-- Tag: joins_join_dml_test_select_003
SELECT u.id, COUNT(o.id), SUM(o.amount)
FROM users u
LEFT JOIN orders o ON u.id = o.owner_id
GROUP BY u.id;

-- INSERT with complex multi-table JOIN
INSERT INTO report (name, product, amount)
-- Tag: joins_join_dml_test_select_004
SELECT users.name, equipment.name, orders.amount
FROM orders
INNER JOIN users ON orders.user_id = users.id
INNER JOIN equipment ON orders.equipment_id = equipment.id
WHERE orders.order_date >= CURRENT_DATE - INTERVAL '30 days';

-- ----------------------------------------------------------------------------
-- 9. BigQuery Alternative Syntax (for reference)
-- ----------------------------------------------------------------------------

-- BigQuery uses different syntax for UPDATE/DELETE with JOINs:
-- UPDATE target
-- SET target.column = source.column
-- FROM target
-- INNER JOIN source ON target.id = source.id
-- WHERE condition;

-- ----------------------------------------------------------------------------
-- Notes:
-- - PostgreSQL: Full support for UPDATE...FROM and DELETE...USING
-- - BigQuery: Different syntax, uses UPDATE...FROM...WHERE and DELETE...WHERE IN
-- - SQL Server: Similar to PostgreSQL but uses different join syntax
-- - Oracle: Uses MERGE statement for similar functionality
-- - SQL:2023 Standard: Supports these patterns but implementations vary
-- ----------------------------------------------------------------------------
