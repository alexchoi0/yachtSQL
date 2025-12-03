-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/sequences_autoincrement_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: CREATE SEQUENCE basic
-- Expected: Sequence starts at 1 by default
CREATE SEQUENCE seq_basic;

SELECT NEXTVAL('seq_basic') as val;
-- Result: 1

-- Test: CREATE SEQUENCE with START value
-- Expected: Sequence starts at specified value
CREATE SEQUENCE seq_start START WITH 100;

SELECT NEXTVAL('seq_start') as val;
-- Result: 100

-- Test: CREATE SEQUENCE with INCREMENT
-- Expected: Sequence increments by specified amount
CREATE SEQUENCE seq_inc INCREMENT BY 10;

SELECT NEXTVAL('seq_inc') as v1, NEXTVAL('seq_inc') as v2;
-- Result: v1=1, v2=11

-- Test: CREATE SEQUENCE with MINVALUE and MAXVALUE
-- Expected: Sequence respects bounds, errors at max (NO CYCLE)
CREATE SEQUENCE seq_range START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 10 NO CYCLE;

-- Get values 1 through 10
SELECT NEXTVAL('seq_range'); -- returns 1
SELECT NEXTVAL('seq_range'); -- returns 2
-- ... up to 10
SELECT NEXTVAL('seq_range'); -- ERROR: reached maximum value

-- Test: CREATE SEQUENCE with CYCLE
-- Expected: Sequence wraps to MINVALUE after MAXVALUE
CREATE SEQUENCE seq_cycle START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 3 CYCLE;

SELECT NEXTVAL('seq_cycle') as v1,
    NEXTVAL('seq_cycle') as v2,
    NEXTVAL('seq_cycle') as v3,
    NEXTVAL('seq_cycle') as v4;
-- Result: v1=1, v2=2, v3=3, v4=1 (cycled back)

-- Test: CREATE SEQUENCE descending
-- Expected: Negative increment counts down
CREATE SEQUENCE seq_desc START WITH 100 INCREMENT BY -5;

SELECT NEXTVAL('seq_desc') as v1, NEXTVAL('seq_desc') as v2;
-- Result: v1=100, v2=95

-- Test: CREATE SEQUENCE IF NOT EXISTS
-- Expected: No error if sequence exists
CREATE SEQUENCE seq_test;
CREATE SEQUENCE IF NOT EXISTS seq_test; -- No error

CREATE SEQUENCE seq_test; -- ERROR: sequence already exists

-- Test: CREATE SEQUENCE with CACHE
-- Expected: Performance optimization, doesn't affect functionality
CREATE SEQUENCE seq_cache CACHE 20;

SELECT NEXTVAL('seq_cache') as val;
-- Result: 1

-- Test: DROP SEQUENCE
-- Expected: Sequence removed, cannot use after drop
CREATE SEQUENCE seq_drop;
DROP SEQUENCE seq_drop;

SELECT NEXTVAL('seq_drop');
-- ERROR: sequence "seq_drop" does not exist

-- Test: DROP SEQUENCE IF EXISTS
-- Expected: No error if sequence doesn't exist
DROP SEQUENCE IF EXISTS nonexistent; -- No error
DROP SEQUENCE nonexistent; -- ERROR

-- Test: ALTER SEQUENCE INCREMENT
-- Expected: Change increment value mid-stream
CREATE SEQUENCE seq_alter INCREMENT BY 1;
SELECT NEXTVAL('seq_alter'); -- 1

ALTER SEQUENCE seq_alter INCREMENT BY 10;
SELECT NEXTVAL('seq_alter') as val;
-- Result: 11 (1 + 10)

-- Test: ALTER SEQUENCE RESTART
-- Expected: Reset sequence to new starting point
CREATE SEQUENCE seq_restart;
SELECT NEXTVAL('seq_restart'); -- 1
SELECT NEXTVAL('seq_restart'); -- 2

ALTER SEQUENCE seq_restart RESTART WITH 100;
SELECT NEXTVAL('seq_restart') as val;
-- Result: 100

-- Test: NEXTVAL() function
-- Expected: Returns next value and advances sequence
CREATE SEQUENCE seq_next;

SELECT NEXTVAL('seq_next') as val;
-- Result: 1

-- Test: NEXTVAL() in INSERT
-- Expected: Generate unique IDs
CREATE SEQUENCE seq_insert;
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, name STRING);

INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item1');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item2');
INSERT INTO items VALUES (NEXTVAL('seq_insert'), 'Item3');

SELECT id FROM items ORDER BY id;
-- Result: 1, 2, 3

-- Test: CURRVAL() after NEXTVAL
-- Expected: Returns current value without advancing
CREATE SEQUENCE seq_curr;
SELECT NEXTVAL('seq_curr'); -- 1

SELECT CURRVAL('seq_curr') as val;
-- Result: 1

SELECT NEXTVAL('seq_curr'); -- 2
SELECT CURRVAL('seq_curr') as val;
-- Result: 2

-- Test: CURRVAL() before NEXTVAL
-- Expected: Error - must call NEXTVAL first in session
CREATE SEQUENCE seq_curr_err;

SELECT CURRVAL('seq_curr_err');
-- ERROR: currval called before nextval for sequence

-- Test: CURRVAL() doesn't advance sequence
-- Expected: Multiple CURRVAL calls return same value
CREATE SEQUENCE seq_noadvance;
SELECT NEXTVAL('seq_noadvance'); -- 1

SELECT CURRVAL('seq_noadvance'); -- Still 1
SELECT CURRVAL('seq_noadvance'); -- Still 1

SELECT NEXTVAL('seq_noadvance') as val;
-- Result: 2

-- Test: SETVAL() function
-- Expected: Manually set sequence value
CREATE SEQUENCE seq_set;
SELECT SETVAL('seq_set', 100);

SELECT NEXTVAL('seq_set') as val;
-- Result: 101

-- Test: SETVAL() with is_called parameter
-- Expected: Control whether next NEXTVAL returns set value or incremented
CREATE SEQUENCE seq_setcall;

-- is_called=true (default): NEXTVAL returns value + increment
SELECT SETVAL('seq_setcall', 50, true);
SELECT NEXTVAL('seq_setcall') as val;
-- Result: 51

-- is_called=false: NEXTVAL returns the set value
SELECT SETVAL('seq_setcall', 100, false);
SELECT NEXTVAL('seq_setcall') as val;
-- Result: 100

-- Test: LASTVAL() function
-- Expected: Returns last value from most recently used sequence
CREATE SEQUENCE seq_last;
SELECT NEXTVAL('seq_last');

SELECT LASTVAL() as val;
-- Result: 1

-- Test: LASTVAL() tracks most recent sequence
-- Expected: Returns value from last NEXTVAL call regardless of sequence
CREATE SEQUENCE seq1;
CREATE SEQUENCE seq2 START WITH 100;

SELECT NEXTVAL('seq1'); -- 1
SELECT NEXTVAL('seq2'); -- 100

SELECT LASTVAL() as val;
-- Result: 100 (most recent)

-- Test: (MySQL style)
-- Expected: Column automatically gets next value
DROP TABLE IF EXISTS items_auto;
CREATE TABLE items_auto (id INT64 , name STRING, PRIMARY KEY (id));

INSERT INTO items_auto (name) VALUES ('Item1');
INSERT INTO items_auto (name) VALUES ('Item2');
INSERT INTO items_auto (name) VALUES ('Item3');

SELECT id FROM items_auto ORDER BY id;
-- Result: 1, 2, 3

-- Test: with explicit value
-- Expected: Can specify value, next auto value continues from there
DROP TABLE IF EXISTS items_explicit;
CREATE TABLE items_explicit (id INT64 , name STRING, PRIMARY KEY (id));

INSERT INTO items_explicit (id, name) VALUES (10, 'Item10');
INSERT INTO items_explicit (name) VALUES ('Item11');

SELECT id FROM items_explicit ORDER BY id;
-- Result: 10, 11

-- Expected: Returns auto-generated ID from last INSERT
DROP TABLE IF EXISTS items_last_id;
CREATE TABLE items_last_id (id INT64 , name STRING, PRIMARY KEY (id));

INSERT INTO items_last_id (name) VALUES ('Item1');
-- Result: 1

INSERT INTO items_last_id (name) VALUES ('Item2');
-- Result: 2

-- Test: SERIAL type (PostgreSQL style)
-- Expected: Creates implicit sequence and auto-increment column
DROP TABLE IF EXISTS items_serial;
CREATE TABLE items_serial (id SERIAL, name STRING);

INSERT INTO items_serial (name) VALUES ('Item1');
INSERT INTO items_serial (name) VALUES ('Item2');

SELECT id FROM items_serial ORDER BY id;
-- Result: 1, 2

-- Test: BIGSERIAL type
-- Expected: Same as SERIAL but for 64-bit integers
DROP TABLE IF EXISTS items_bigserial;
CREATE TABLE items_bigserial (id BIGSERIAL, name STRING);

INSERT INTO items_bigserial (name) VALUES ('Item1');

SELECT id FROM items_bigserial;
-- Result: 1

-- Test: SERIAL creates implicit sequence
-- Expected: Can query the auto-created sequence
DROP TABLE IF EXISTS items_seq;
CREATE TABLE items_seq (id SERIAL, name STRING);

-- Before insert, CURRVAL errors
SELECT CURRVAL('items_seq_id_seq');
-- ERROR: currval not yet defined

INSERT INTO items_seq (name) VALUES ('Item1');

SELECT CURRVAL('items_seq_id_seq') as val;
-- Result: 1

-- Test: IDENTITY column (SQL Standard / SQL Server style)
-- Expected: Auto-increment with IDENTITY syntax
DROP TABLE IF EXISTS items_identity;
CREATE TABLE items_identity (id INT64 IDENTITY(1, 1), name STRING);

INSERT INTO items_identity (name) VALUES ('Item1');
INSERT INTO items_identity (name) VALUES ('Item2');

SELECT id FROM items_identity ORDER BY id;
-- Result: 1, 2

-- Test: IDENTITY with custom start and increment
-- Expected: Start at 100, increment by 5
DROP TABLE IF EXISTS items_custom;
CREATE TABLE items_custom (id INT64 IDENTITY(100, 5), name STRING);

INSERT INTO items_custom (name) VALUES ('Item1');
INSERT INTO items_custom (name) VALUES ('Item2');

SELECT id FROM items_custom ORDER BY id;
-- Result: 100, 105

-- Test: 
-- Expected: Cannot insert explicit values
DROP TABLE IF EXISTS items_always;
CREATE TABLE items_always (id INT64 , name STRING);

INSERT INTO items_always (name) VALUES ('Item1'); -- OK

INSERT INTO items_always (id, name) VALUES (10, 'Item2');
-- ERROR: cannot insert into column with GENERATED ALWAYS

-- Test: GENERATED ALWAYS with OVERRIDE
-- Expected: Override allows explicit values
DROP TABLE IF EXISTS items_override;
CREATE TABLE items_override (id INT64 , name STRING);

INSERT INTO items_override (id, name) OVERRIDING SYSTEM VALUE VALUES (100, 'Item100');

SELECT id FROM items_override;
-- Result: 100

-- Test: GENERATED BY DEFAULT AS IDENTITY
-- Expected: Auto-generate by default, but allow explicit values
DROP TABLE IF EXISTS items_default;
CREATE TABLE items_default (id INT64 GENERATED BY DEFAULT AS IDENTITY, name STRING);

INSERT INTO items_default (name) VALUES ('Item1'); -- Auto-generated: 1
INSERT INTO items_default (id, name) VALUES (100, 'Item100'); -- Explicit: 100
INSERT INTO items_default (name) VALUES ('Item101'); -- Auto continues: 101

SELECT id FROM items_default ORDER BY id;
-- Result: 1, 100, 101

-- Test: GENERATED BY DEFAULT with options
-- Expected: Custom start and increment
DROP TABLE IF EXISTS items_opts;
CREATE TABLE items_opts (id INT64 GENERATED BY DEFAULT AS IDENTITY (START WITH 1000 INCREMENT BY 10), name STRING);

INSERT INTO items_opts (name) VALUES ('Item1');
INSERT INTO items_opts (name) VALUES ('Item2');

SELECT id FROM items_opts ORDER BY id;
-- Result: 1000, 1010

-- Test: Sequence gap on rollback
-- Expected: Sequence values consumed even if transaction rolls back
CREATE SEQUENCE seq_gap;
DROP TABLE IF EXISTS gap_items;
CREATE TABLE gap_items (id INT64, name STRING);

BEGIN;
INSERT INTO gap_items VALUES (NEXTVAL('seq_gap'), 'Item1');
ROLLBACK;

INSERT INTO gap_items VALUES (NEXTVAL('seq_gap'), 'Item2');

SELECT id FROM gap_items;
-- Result: 2 (value 1 was consumed by rollback)

-- Test: Multiple sequences are independent
-- Expected: Each sequence maintains its own state
CREATE SEQUENCE seq_a START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_b START WITH 100 INCREMENT BY 10;

SELECT NEXTVAL('seq_a') as a, NEXTVAL('seq_b') as b;
-- Result: a=1, b=100

-- Test: Sequence with DEFAULT value
-- Expected: DEFAULT clause calls NEXTVAL automatically
CREATE SEQUENCE seq_default;
DROP TABLE IF EXISTS items_default_seq;
CREATE TABLE items_default_seq (id INT64 DEFAULT NEXTVAL('seq_default'), name STRING);

INSERT INTO items_default_seq (name) VALUES ('Item1');
INSERT INTO items_default_seq (name) VALUES ('Item2');

SELECT id FROM items_default_seq ORDER BY id;
-- Result: 1, 2
