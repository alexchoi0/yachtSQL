-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/returning_clause_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: INSERT ... RETURNING basic
-- Expected: Returns inserted row
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, email STRING);

INSERT INTO users VALUES (1, 'Alice', 'alice@example.com')
RETURNING *;
-- Result: (1, 'Alice', 'alice@example.com')

-- Test: INSERT ... RETURNING specific columns
-- Expected: Returns only requested columns
INSERT INTO users VALUES (2, 'Bob', 'bob@example.com')
RETURNING id, name;
-- Result: (2, 'Bob')

-- Test: INSERT ... RETURNING with expression
-- Expected: Can compute values in RETURNING
INSERT INTO users VALUES (3, 'Charlie', 'charlie@example.com')
RETURNING id, UPPER(name) as name_upper, LENGTH(email) as email_len;
-- Result: (3, 'CHARLIE', 19)

-- Test: INSERT multiple rows with RETURNING
-- Expected: Returns all inserted rows
INSERT INTO users VALUES (4, 'David', 'david@example.com'), (5, 'Eve', 'eve@example.com')
RETURNING id, name;
-- Result: 2 rows returned

-- Test: UPDATE ... RETURNING
-- Expected: Returns updated rows
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64, name STRING, price FLOAT64);
INSERT INTO equipment VALUES (1, 'Widget', 10.0), (2, 'Gadget', 20.0);

UPDATE equipment
SET price = price * 1.1
WHERE id = 1
RETURNING *;
-- Result: (1, 'Widget', 11.0)

-- Test: UPDATE ... RETURNING old and new values
-- Expected: Can show both old values and expressions
UPDATE equipment
SET price = 25.0
WHERE id = 2
RETURNING id, name, price as new_price;
-- Result: (2, 'Gadget', 25.0)

-- Test: DELETE ... RETURNING
-- Expected: Returns deleted rows
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING, timestamp INT64);
INSERT INTO logs VALUES (1, 'old', 100), (2, 'recent', 200);

DELETE FROM logs
WHERE timestamp < 150
RETURNING *;
-- Result: (1, 'old', 100)

-- Test: DELETE ... RETURNING for archival
-- Expected: Can move deleted data to archive
DROP TABLE IF EXISTS active_records;
CREATE TABLE active_records (id INT64, data STRING);
DROP TABLE IF EXISTS archived_records;
CREATE TABLE archived_records (id INT64, data STRING);
INSERT INTO active_records VALUES (1, 'data1'), (2, 'data2');

WITH deleted AS (
  DELETE FROM active_records
  WHERE id = 1
  RETURNING *
)
INSERT INTO archived_records SELECT * FROM deleted;

SELECT * FROM archived_records;
-- Result: (1, 'data1')

-- Test: RETURNING with auto-increment
-- Expected: Returns generated ID
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);

INSERT INTO items (name) VALUES ('Item1')
RETURNING id;
-- Result: returns auto-generated id

-- Test: RETURNING with sequence
-- Expected: Returns sequence-generated value
CREATE SEQUENCE item_seq;
DROP TABLE IF EXISTS seq_items;
CREATE TABLE seq_items (id INT64, name STRING);

INSERT INTO seq_items VALUES (NEXTVAL('item_seq'), 'Item1')
RETURNING id;
-- Result: returns sequence value

-- Test: RETURNING with DEFAULT values
-- Expected: Shows default values used
DROP TABLE IF EXISTS with_defaults;
CREATE TABLE with_defaults (id INT64, created_at INT64 DEFAULT 1000, status STRING DEFAULT 'active');

INSERT INTO with_defaults (id) VALUES (1)
RETURNING *;
-- Result: (1, 1000, 'active')

-- Test: RETURNING in CTE
-- Expected: Can chain operations using RETURNING
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (id INT64, balance FLOAT64);
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (account_id INT64, amount FLOAT64);
INSERT INTO accounts VALUES (1, 100.0);

WITH updated AS (
  UPDATE accounts
  SET balance = balance - 10.0
  WHERE id = 1
  RETURNING id, balance
)
INSERT INTO transactions SELECT id, -10.0 FROM updated
RETURNING *;
-- Result: transaction record

-- Test: RETURNING with JOIN (in subquery)
-- Expected: Can access joined data in outer query
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, owner_id INT64, total FLOAT64);
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (id INT64, name STRING);
INSERT INTO yacht_owners VALUES (1, 'Alice');

INSERT INTO orders VALUES (1, 1, 100.0)
RETURNING id, owner_id, total;
-- Then join with yacht_owners in outer query

-- Test: RETURNING NULL values
-- Expected: Returns NULL where applicable
DROP TABLE IF EXISTS nullable_table;
CREATE TABLE nullable_table (id INT64, optional_field STRING);

INSERT INTO nullable_table VALUES (1, NULL)
RETURNING *;
-- Result: (1, NULL)

-- Test: RETURNING with computed columns
-- Expected: Can use expressions and functions
DROP TABLE IF EXISTS calculations;
CREATE TABLE calculations (id INT64, a INT64, b INT64);

INSERT INTO calculations VALUES (1, 10, 20)
RETURNING id, a, b, a + b as sum, a * b as product;
-- Result: (1, 10, 20, 30, 200)

-- Test: RETURNING with CASE expression
-- Expected: Conditional logic in RETURNING
DROP TABLE IF EXISTS statuses;
CREATE TABLE statuses (id INT64, value INT64);

INSERT INTO statuses VALUES (1, 100), (2, -50)
RETURNING id,
  CASE WHEN value > 0 THEN 'positive' ELSE 'negative' END as classification;
-- Result: (1, 'positive'), (2, 'negative')

-- Test: UPDATE with no matching rows
-- Expected: RETURNING returns no rows
DROP TABLE IF EXISTS empty_update;
CREATE TABLE empty_update (id INT64, value STRING);

UPDATE empty_update
SET value = 'new'
WHERE id = 999
RETURNING *;
-- Result: 0 rows

-- Test: RETURNING with aggregates in outer query
-- Expected: Can aggregate RETURNING results
DROP TABLE IF EXISTS batch_insert;
CREATE TABLE batch_insert (id INT64, amount FLOAT64);

WITH inserted AS (
  INSERT INTO batch_insert VALUES (1, 100), (2, 200), (3, 150)
  RETURNING amount
)
SELECT SUM(amount) as total FROM inserted;
-- Result: total = 450

-- Test: RETURNING * with all columns
-- Expected: Returns all columns in order
DROP TABLE IF EXISTS all_cols;
CREATE TABLE all_cols (a INT64, b STRING, c FLOAT64, d BOOL);

INSERT INTO all_cols VALUES (1, 'test', 3.14, true)
RETURNING *;
-- Result: (1, 'test', 3.14, true)

-- Test: DELETE with complex WHERE and RETURNING
-- Expected: Returns only deleted rows matching criteria
DROP TABLE IF EXISTS complex_delete;
CREATE TABLE complex_delete (id INT64, category STRING, value INT64);
INSERT INTO complex_delete VALUES
  (1, 'A', 10),
  (2, 'A', 20),
  (3, 'B', 15);

DELETE FROM complex_delete
WHERE category = 'A' AND value > 15
RETURNING *;
-- Result: (2, 'A', 20)

-- Test: RETURNING in transaction
-- Expected: Returns data even if transaction rolls back
DROP TABLE IF EXISTS transactional;
CREATE TABLE transactional (id INT64, value STRING);

BEGIN;
INSERT INTO transactional VALUES (1, 'test')
RETURNING *;
ROLLBACK;
-- RETURNING shows data, but rollback prevents persistence

-- Test: ON CONFLICT with RETURNING
-- Expected: Returns result of insert or update
DROP TABLE IF EXISTS upsert_return;
CREATE TABLE upsert_return (id INT64 PRIMARY KEY, value STRING);
INSERT INTO upsert_return VALUES (1, 'original');

INSERT INTO upsert_return VALUES (1, 'updated')
ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value
RETURNING *;
-- Result: (1, 'updated')
