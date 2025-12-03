-- ============================================================================
-- Advanced Edge Cases - PostgreSQL 18
-- ============================================================================
-- Source: tests/insert_on_conflict_advanced_edge_cases_tdd.rs
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Composite UNIQUE constraint conflict
-- Expected: Update on multi-column unique violation
DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations (
    resource_id INT64,
    time_slot INT64,
    user_id INT64,
    UNIQUE(resource_id, time_slot)
);

INSERT INTO reservations VALUES (101, 1000, 1);
INSERT INTO reservations VALUES (101, 1000, 2)
ON CONFLICT (resource_id, time_slot) DO UPDATE
SET user_id = EXCLUDED.user_id;

SELECT user_id FROM reservations WHERE resource_id = 101 AND time_slot = 1000;
-- Result: user_id = 2

-- Test: Multiple constraints, different conflicts
-- Expected: Correct constraint identified for conflict
DROP TABLE IF EXISTS multi_constraint;
CREATE TABLE multi_constraint (
    id INT64 PRIMARY KEY,
    email STRING UNIQUE,
    username STRING UNIQUE
);

INSERT INTO multi_constraint VALUES (1, 'alice@example.com', 'alice');
INSERT INTO multi_constraint VALUES (2, 'alice@example.com', 'alice2')
ON CONFLICT (email) DO UPDATE SET username = EXCLUDED.username;

-- Test: ON CONFLICT with CHECK constraint
-- Expected: UPDATE still validates CHECK constraint
DROP TABLE IF EXISTS validated;
CREATE TABLE validated (
    id INT64 PRIMARY KEY,
    value INT64 CHECK (value > 0)
);

INSERT INTO validated VALUES (1, 100);
INSERT INTO validated VALUES (1, -10)
ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value;
-- ERROR: CHECK constraint violation

-- Test: Partial unique index
-- Expected: Conflict only on indexed subset
DROP TABLE IF EXISTS partial_index;
CREATE TABLE partial_index (
    id INT64,
    status STRING,
    email STRING
);
CREATE UNIQUE INDEX partial_idx ON partial_index(email) WHERE status = 'active';

INSERT INTO partial_index VALUES (1, 'active', 'test@example.com');
INSERT INTO partial_index VALUES (2, 'inactive', 'test@example.com');
-- No conflict - partial index doesn't cover inactive

INSERT INTO partial_index VALUES (3, 'active', 'test@example.com')
ON CONFLICT (email) WHERE status = 'active' DO NOTHING;
-- Conflict detected

-- Test: Expression index
-- Expected: Conflict on expression result
DROP TABLE IF EXISTS case_insensitive;
CREATE TABLE case_insensitive (
    id INT64,
    email STRING
);
CREATE UNIQUE INDEX email_lower_idx ON case_insensitive(LOWER(email));

INSERT INTO case_insensitive VALUES (1, 'Test@Example.com');
INSERT INTO case_insensitive VALUES (2, 'test@example.com')
ON CONFLICT (LOWER(email)) DO UPDATE SET email = EXCLUDED.email;

-- Test: Foreign key with ON CONFLICT
-- Expected: Foreign key still enforced
DROP TABLE IF EXISTS fleets;
CREATE TABLE fleets (dept_id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64 PRIMARY KEY,
    dept_id INT64 REFERENCES fleets(dept_id),
    name STRING
);

INSERT INTO fleets VALUES (1, 'Engineering');
INSERT INTO crew_members VALUES (1, 1, 'Alice');

INSERT INTO crew_members VALUES (1, 999, 'Bob')
ON CONFLICT (id) DO UPDATE SET dept_id = EXCLUDED.dept_id;
-- ERROR: Foreign key violation

-- Test: Transaction rollback with ON CONFLICT
-- Expected: ON CONFLICT doesn't prevent rollback
DROP TABLE IF EXISTS transactional;
CREATE TABLE transactional (id INT64 PRIMARY KEY, value STRING);
INSERT INTO transactional VALUES (1, 'original');

BEGIN;
INSERT INTO transactional VALUES (1, 'updated')
ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value;
ROLLBACK;

SELECT value FROM transactional WHERE id = 1;
-- Result: value = 'original' (update rolled back)

-- Test: Concurrent upserts (serialization)
-- Expected: Both transactions succeed without conflict
-- NOTE: Requires actual concurrent execution
DROP TABLE IF EXISTS concurrent_test;
CREATE TABLE concurrent_test (id INT64 PRIMARY KEY, count INT64);

-- Transaction 1: INSERT ... ON CONFLICT
-- Transaction 2: INSERT ... ON CONFLICT (same key)
-- Both should complete without deadlock

-- Test: Very large batch upsert
-- Expected: All rows processed correctly
DROP TABLE IF EXISTS batch_upsert;
CREATE TABLE batch_upsert (id INT64 PRIMARY KEY, value INT64);

-- Insert 10000 rows with conflicts
-- Should handle efficiently
