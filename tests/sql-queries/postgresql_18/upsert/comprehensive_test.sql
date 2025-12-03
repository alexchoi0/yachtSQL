-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/insert_on_conflict_upsert_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic ON CONFLICT DO NOTHING
-- Expected: Duplicate key ignored, no error
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');

INSERT INTO users VALUES (1, 'Bob', 'bob@example.com')
ON CONFLICT (id) DO NOTHING;

SELECT * FROM users;
-- Result: Still shows Alice, Bob insert ignored

-- Test: ON CONFLICT DO UPDATE
-- Expected: Update existing row on conflict
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64 PRIMARY KEY, name STRING, stock INT64);
INSERT INTO equipment VALUES (1, 'Widget', 100);

INSERT INTO equipment VALUES (1, 'Widget', 50)
ON CONFLICT (id) DO UPDATE SET stock = EXCLUDED.stock;

SELECT * FROM equipment WHERE id = 1;
-- Result: stock updated to 50

-- Test: UPDATE with multiple columns
-- Expected: Update all specified columns
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (sku STRING PRIMARY KEY, quantity INT64, price FLOAT64);
INSERT INTO inventory VALUES ('ABC123', 10, 19.99);

INSERT INTO inventory VALUES ('ABC123', 5, 24.99)
ON CONFLICT (sku) DO UPDATE
SET quantity = EXCLUDED.quantity,
    price = EXCLUDED.price;

SELECT * FROM inventory WHERE sku = 'ABC123';
-- Result: quantity = 5, price = 24.99

-- Test: EXCLUDED keyword - reference inserted values
-- Expected: Can add to existing value
DROP TABLE IF EXISTS counters;
CREATE TABLE counters (id INT64 PRIMARY KEY, count INT64);
INSERT INTO counters VALUES (1, 10);

INSERT INTO counters VALUES (1, 5)
ON CONFLICT (id) DO UPDATE SET count = counters.count + EXCLUDED.count;

SELECT count FROM counters WHERE id = 1;
-- Result: count = 15 (10 + 5)

-- Test: ON CONFLICT on UNIQUE constraint
-- Expected: Works with unique index, not just PRIMARY KEY
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING UNIQUE, verified BOOL);
INSERT INTO emails VALUES (1, 'test@example.com', false);

INSERT INTO emails VALUES (2, 'test@example.com', true)
ON CONFLICT (email) DO UPDATE SET verified = EXCLUDED.verified;

SELECT id, verified FROM emails WHERE email = 'test@example.com';
-- Result: id still 1, verified now true

-- Test: WHERE clause in ON CONFLICT DO UPDATE
-- Expected: Only update if condition met
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64 PRIMARY KEY, value INT64, updated_at INT64);
INSERT INTO data VALUES (1, 100, 1000);

INSERT INTO data VALUES (1, 50, 2000)
ON CONFLICT (id) DO UPDATE
SET value = EXCLUDED.value, updated_at = EXCLUDED.updated_at
WHERE data.updated_at < EXCLUDED.updated_at;

SELECT * FROM data WHERE id = 1;
-- Result: value = 50, updated_at = 2000

-- Test: Multi-column UNIQUE constraint
-- Expected: Conflict on combined key
DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings (room_id INT64, date INT64, guest STRING, UNIQUE(room_id, date));
INSERT INTO bookings VALUES (101, 20240115, 'Alice');

INSERT INTO bookings VALUES (101, 20240115, 'Bob')
ON CONFLICT (room_id, date) DO UPDATE SET guest = EXCLUDED.guest;

SELECT guest FROM bookings WHERE room_id = 101 AND date = 20240115;
-- Result: guest = Bob

-- Test: INSERT multiple rows with ON CONFLICT
-- Expected: Each row processed independently
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'First'), (2, 'Second');

INSERT INTO items VALUES (1, 'Updated1'), (2, 'Updated2'), (3, 'New')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

SELECT * FROM items ORDER BY id;
-- Result: 1='Updated1', 2='Updated2', 3='New'

-- Test: ON CONFLICT with computed values
-- Expected: Can use expressions in UPDATE
DROP TABLE IF EXISTS stats;
CREATE TABLE stats (id INT64 PRIMARY KEY, total INT64, count INT64, avg FLOAT64);
INSERT INTO stats VALUES (1, 100, 10, 10.0);

INSERT INTO stats VALUES (1, 50, 5, 0.0)
ON CONFLICT (id) DO UPDATE
SET total = stats.total + EXCLUDED.total,
    count = stats.count + EXCLUDED.count,
    avg = (stats.total + EXCLUDED.total) / (stats.count + EXCLUDED.count);

SELECT * FROM stats WHERE id = 1;
-- Result: total=150, count=15, avg=10.0

-- Test: DO NOTHING with WHERE clause
-- Expected: Conditional ignore
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64 PRIMARY KEY, level STRING, message STRING);
INSERT INTO logs VALUES (1, 'INFO', 'Initial');

INSERT INTO logs VALUES (1, 'ERROR', 'Should not insert')
ON CONFLICT (id) WHERE level != 'ERROR' DO NOTHING;

SELECT * FROM logs WHERE id = 1;
-- Result: Still shows INFO level

-- Test: NULL in unique column
-- Expected: NULLs don't conflict
DROP TABLE IF EXISTS nullable_unique;
CREATE TABLE nullable_unique (id INT64, email STRING UNIQUE);
INSERT INTO nullable_unique VALUES (1, NULL);
INSERT INTO nullable_unique VALUES (2, NULL);

SELECT COUNT(*) FROM nullable_unique WHERE email IS NULL;
-- Result: 2 rows (NULLs are distinct)

-- Test: ON CONFLICT with RETURNING
-- Expected: Return affected row
DROP TABLE IF EXISTS records;
CREATE TABLE records (id INT64 PRIMARY KEY, value STRING);
INSERT INTO records VALUES (1, 'original');

INSERT INTO records VALUES (1, 'updated')
ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value
RETURNING *;
-- Result: Returns (1, 'updated')

-- Test: RETURNING distinguishes insert vs update
-- Expected: Can identify which action occurred
DROP TABLE IF EXISTS audit;
CREATE TABLE audit (id INT64 PRIMARY KEY, data STRING, action STRING);

INSERT INTO audit VALUES (1, 'new', 'insert')
ON CONFLICT (id) DO UPDATE
SET data = EXCLUDED.data, action = 'update'
RETURNING *;
-- Result: Can see if it was insert or update

-- Test: Empty INSERT with ON CONFLICT
-- Expected: No rows affected
DROP TABLE IF EXISTS empty_test;
CREATE TABLE empty_test (id INT64 PRIMARY KEY);
INSERT INTO empty_test SELECT * FROM empty_test WHERE false
ON CONFLICT (id) DO NOTHING;
-- Result: 0 rows affected

-- Test: ON CONFLICT with DEFAULT values
-- Expected: DEFAULT used for non-conflicting columns
DROP TABLE IF EXISTS with_defaults;
CREATE TABLE with_defaults (id INT64 PRIMARY KEY, value INT64 DEFAULT 100, name STRING);

INSERT INTO with_defaults (id, name) VALUES (1, 'test')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

SELECT * FROM with_defaults WHERE id = 1;
-- Result: value uses DEFAULT (100)

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: ON CONFLICT without constraint
-- Expected: Error - must specify constraint or index
DROP TABLE IF EXISTS no_constraint;
CREATE TABLE no_constraint (id INT64, value STRING);

INSERT INTO no_constraint VALUES (1, 'test')
ON CONFLICT DO NOTHING;
-- ERROR: ON CONFLICT requires inference specification or constraint name

-- Test: Invalid constraint name
-- Expected: Error - constraint doesn't exist
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (id INT64 PRIMARY KEY);

INSERT INTO test_table VALUES (1)
ON CONFLICT (nonexistent_column) DO NOTHING;
-- ERROR: there is no unique or exclusion constraint matching the ON CONFLICT specification

-- Test: ON CONFLICT on non-unique column
-- Expected: Error - column not indexed uniquely
DROP TABLE IF EXISTS non_unique_col;
CREATE TABLE non_unique_col (id INT64, category STRING);

INSERT INTO non_unique_col VALUES (1, 'A')
ON CONFLICT (category) DO NOTHING;
-- ERROR: no unique constraint on category

-- ============================================================================
-- Real-World Scenarios
-- ============================================================================

-- Test: Idempotent user creation
-- Expected: Safe retry of user creation
DROP TABLE IF EXISTS app_users;
CREATE TABLE app_users (id INT64 PRIMARY KEY, email STRING UNIQUE, created_at INT64);

INSERT INTO app_users VALUES (1, 'alice@example.com', 1000)
ON CONFLICT (email) DO NOTHING;
-- Can run multiple times safely

-- Test: Counter increment
-- Expected: Atomic increment or create
DROP TABLE IF EXISTS view_counts;
CREATE TABLE view_counts (page_id INT64 PRIMARY KEY, views INT64);

INSERT INTO view_counts VALUES (1, 1)
ON CONFLICT (page_id) DO UPDATE SET views = view_counts.views + 1;
-- Increment if exists, create with 1 if not

-- Test: Last-write-wins semantics
-- Expected: Always keep newest data
DROP TABLE IF EXISTS cache;
CREATE TABLE cache (key STRING PRIMARY KEY, value STRING, timestamp INT64);

INSERT INTO cache VALUES ('user:1', 'data', 2000)
ON CONFLICT (key) DO UPDATE
SET value = EXCLUDED.value, timestamp = EXCLUDED.timestamp
WHERE cache.timestamp < EXCLUDED.timestamp;
-- Only update if newer
