-- Alter Table - SQL:2023
-- Description: ALTER TABLE operations for schema modifications
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64,
    name STRING
);

INSERT INTO users VALUES (1, 'Alice');

-- Add new column (existing rows will have NULL)
ALTER TABLE users ADD COLUMN age INT64;

-- Verify: existing row has NULL for new column
-- Tag: ddl_alter_table_test_select_001
SELECT id, name, age FROM users WHERE id = 1;

-- New inserts work with all columns
INSERT INTO users VALUES (2, 'Bob', 30);

-- ALTER TABLE - ADD COLUMN with DEFAULT

-- Add column with DEFAULT value
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    name STRING
);

INSERT INTO equipment VALUES (1, 'Widget');

-- Add column with default (existing rows get default value)
ALTER TABLE equipment ADD COLUMN price FLOAT64 DEFAULT 0.0;

-- Verify: existing row has default value
-- Tag: ddl_alter_table_test_select_002
SELECT id, name, price FROM equipment WHERE id = 1;

-- ALTER TABLE - ADD COLUMN NOT NULL with DEFAULT

-- Add NOT NULL column with DEFAULT (should succeed)
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);

-- DEFAULT satisfies NOT NULL constraint
ALTER TABLE items ADD COLUMN quantity INT64 NOT NULL DEFAULT 0;

-- Tag: ddl_alter_table_test_select_003
SELECT quantity FROM items WHERE id = 1;

-- ALTER TABLE - ADD COLUMN NOT NULL without DEFAULT

-- Should fail when table has data
DROP TABLE IF EXISTS items_fail;
CREATE TABLE items_fail (id INT64);
INSERT INTO items_fail VALUES (1);

-- This should fail: can't add NOT NULL without DEFAULT to table with data
-- ALTER TABLE items_fail ADD COLUMN quantity INT64 NOT NULL;

-- ALTER TABLE - ADD COLUMN with CHECK Constraint

-- Add column with CHECK constraint
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64,
    name STRING
);

ALTER TABLE crew_members ADD COLUMN salary FLOAT64 CHECK (salary > 0);

-- Allow NULL (CHECK passes NULL)
INSERT INTO crew_members VALUES (1, 'Alice', NULL);

-- Allow valid value
INSERT INTO crew_members VALUES (2, 'Bob', 50000.0);

-- Reject invalid value
-- INSERT INTO crew_members VALUES (3, 'Charlie', -1000.0);

-- ALTER TABLE - ADD Multiple Columns

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (id INT64);

-- Add columns sequentially
ALTER TABLE contacts ADD COLUMN email STRING;
ALTER TABLE contacts ADD COLUMN phone STRING;
ALTER TABLE contacts ADD COLUMN age INT64;

-- Insert with all columns
INSERT INTO contacts VALUES (1, 'alice@example.com', '555-1234', 25);

-- Tag: ddl_alter_table_test_select_004
SELECT * FROM contacts WHERE id = 1;

-- ALTER TABLE - DROP COLUMN (Basic)

-- Drop a column from table
DROP TABLE IF EXISTS users_drop;
CREATE TABLE users_drop (
    id INT64,
    name STRING,
    email STRING
);

INSERT INTO users_drop VALUES (1, 'Alice', 'alice@example.com');

-- Drop the email column
ALTER TABLE users_drop DROP COLUMN email;

-- Verify: only id and name remain
-- Tag: ddl_alter_table_test_select_005
SELECT * FROM users_drop WHERE id = 1;

-- Cannot reference dropped column
-- SELECT email FROM users_drop;

-- ALTER TABLE - DROP COLUMN Preserves Data

DROP TABLE IF EXISTS equipment_drop;
CREATE TABLE equipment_drop (
    id INT64,
    name STRING,
    price FLOAT64
);

INSERT INTO equipment_drop VALUES (1, 'Widget', 19.99);

-- Drop price column
ALTER TABLE equipment_drop DROP COLUMN price;

-- Verify remaining data is preserved
-- Tag: ddl_alter_table_test_select_006
SELECT id, name FROM equipment_drop WHERE id = 1;

-- ALTER TABLE - DROP COLUMN Edge Cases

-- Cannot drop the last column
DROP TABLE IF EXISTS single_col;
CREATE TABLE single_col (id INT64);

-- ALTER TABLE single_col DROP COLUMN id;

-- Cannot drop non-existent column
DROP TABLE IF EXISTS test_drop;
CREATE TABLE test_drop (id INT64, name STRING);

-- ALTER TABLE test_drop DROP COLUMN email;

-- ALTER TABLE - DROP COLUMN IF EXISTS

-- Idempotent column deletion
DROP TABLE IF EXISTS test_drop_if_exists;
CREATE TABLE test_drop_if_exists (id INT64, name STRING);

-- Should succeed even though email doesn't exist
ALTER TABLE test_drop_if_exists DROP COLUMN IF EXISTS email;

-- Drop existing column with IF EXISTS
ALTER TABLE test_drop_if_exists DROP COLUMN IF EXISTS name;

-- ALTER TABLE - RENAME COLUMN

-- Rename a column
DROP TABLE IF EXISTS test_rename;
CREATE TABLE test_rename (
    id INT64,
    old_name STRING
);

INSERT INTO test_rename VALUES (1, 'value');

-- Rename column
ALTER TABLE test_rename RENAME COLUMN old_name TO new_name;

-- Verify: new name works, old name doesn't
-- Tag: ddl_alter_table_test_select_007
SELECT id, new_name FROM test_rename WHERE id = 1;

-- SELECT old_name FROM test_rename;

-- ALTER TABLE - RENAME TABLE

-- Rename entire table
DROP TABLE IF EXISTS old_table;
CREATE TABLE old_table (id INT64);
INSERT INTO old_table VALUES (1);

-- Rename table
ALTER TABLE old_table RENAME TO new_table;

-- Verify: new name works
-- Tag: ddl_alter_table_test_select_008
SELECT * FROM new_table;

-- Old name doesn't work
-- SELECT * FROM old_table;

-- ALTER TABLE - ALTER COLUMN (Type Changes)

-- Change column data type
DROP TABLE IF EXISTS test_alter_type;
CREATE TABLE test_alter_type (
    id INT64,
    value STRING
);

INSERT INTO test_alter_type VALUES (1, '100');

-- Change STRING to INT64
ALTER TABLE test_alter_type ALTER COLUMN value TYPE INT64;

-- Verify type change
-- Tag: ddl_alter_table_test_select_009
SELECT * FROM test_alter_type WHERE value = 100;

-- ALTER TABLE - ALTER COLUMN (NULL Constraints)

-- Add NOT NULL constraint
DROP TABLE IF EXISTS test_not_null;
CREATE TABLE test_not_null (
    id INT64,
    value STRING
);

INSERT INTO test_not_null VALUES (1, 'data');

-- Add NOT NULL constraint
ALTER TABLE test_not_null ALTER COLUMN value SET NOT NULL;

-- Cannot insert NULL now
-- INSERT INTO test_not_null VALUES (2, NULL);

-- Remove NOT NULL constraint
ALTER TABLE test_not_null ALTER COLUMN value DROP NOT NULL;

-- Can insert NULL now
INSERT INTO test_not_null VALUES (2, NULL);

-- ALTER TABLE - ALTER COLUMN (DEFAULT Values)

-- Set default value
DROP TABLE IF EXISTS test_default;
CREATE TABLE test_default (
    id INT64,
    status STRING
);

-- Add default value
ALTER TABLE test_default ALTER COLUMN status SET DEFAULT 'active';

-- Insert without specifying status
INSERT INTO test_default (id) VALUES (1);

-- Verify default was applied
-- Tag: ddl_alter_table_test_select_010
SELECT * FROM test_default WHERE id = 1;

-- Drop default
ALTER TABLE test_default ALTER COLUMN status DROP DEFAULT;

-- ALTER TABLE - ADD CONSTRAINT

-- Add table-level constraints after creation

-- Add PRIMARY KEY
DROP TABLE IF EXISTS test_pk;
CREATE TABLE test_pk (
    id INT64,
    name STRING
);

ALTER TABLE test_pk ADD CONSTRAINT pk_test_pk PRIMARY KEY (id);

-- Add FOREIGN KEY
DROP TABLE IF EXISTS parent_table;
CREATE TABLE parent_table (id INT64 PRIMARY KEY);
DROP TABLE IF EXISTS child_table;
CREATE TABLE child_table (
    id INT64,
    parent_id INT64
);

ALTER TABLE child_table ADD CONSTRAINT fk_parent
    FOREIGN KEY (parent_id) REFERENCES parent_table(id);

-- Add CHECK constraint
DROP TABLE IF EXISTS test_check;
CREATE TABLE test_check (
    id INT64,
    age INT64
);

ALTER TABLE test_check ADD CONSTRAINT check_age CHECK (age >= 0);

-- Add UNIQUE constraint
DROP TABLE IF EXISTS test_unique;
CREATE TABLE test_unique (
    id INT64,
    email STRING
);

ALTER TABLE test_unique ADD CONSTRAINT unique_email UNIQUE (email);

-- ALTER TABLE - DROP CONSTRAINT

-- Drop named constraints
DROP TABLE IF EXISTS test_drop_constraint;
CREATE TABLE test_drop_constraint (
    id INT64,
    age INT64,
    CONSTRAINT check_age CHECK (age >= 0)
);

-- Drop the constraint
ALTER TABLE test_drop_constraint DROP CONSTRAINT check_age;

-- ALTER TABLE - IF EXISTS Variants

-- Fail silently if table doesn't exist
ALTER TABLE IF EXISTS nonexistent_table ADD COLUMN new_col STRING;

-- Fail silently if column doesn't exist
DROP TABLE IF EXISTS test_if_exists;
CREATE TABLE test_if_exists (id INT64);
ALTER TABLE test_if_exists DROP COLUMN IF EXISTS nonexistent_col;

-- Complex ALTER TABLE Scenarios

-- Multiple operations on same table
DROP TABLE IF EXISTS complex_alter;
CREATE TABLE complex_alter (
    id INT64,
    old_col STRING,
    temp_col INT64
);

-- Sequence of alterations
ALTER TABLE complex_alter ADD COLUMN new_col STRING;
ALTER TABLE complex_alter DROP COLUMN temp_col;
ALTER TABLE complex_alter RENAME COLUMN old_col TO renamed_col;
ALTER TABLE complex_alter ALTER COLUMN new_col SET DEFAULT 'default_value';

-- Verify final structure
INSERT INTO complex_alter (id, renamed_col) VALUES (1, 'test');
-- Tag: ddl_alter_table_test_select_011
SELECT * FROM complex_alter WHERE id = 1;

-- End of File
