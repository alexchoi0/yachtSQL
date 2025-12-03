-- Unique Null Handling - SQL:2023
-- Description: UNIQUE constraints and NULL value handling
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users_distinct_nulls;
CREATE TABLE users_distinct_nulls (
    user_id INT64 PRIMARY KEY,
    username STRING NOT NULL,
    email STRING UNIQUE NULLS DISTINCT,
    phone STRING UNIQUE NULLS DISTINCT
);

-- Insert valid unique emails
INSERT INTO users_distinct_nulls VALUES
    (1, 'alice', 'alice@example.com', '555-0101');

INSERT INTO users_distinct_nulls VALUES
    (2, 'bob', 'bob@example.com', '555-0102');

-- Duplicate email (should fail)
-- INSERT INTO users_distinct_nulls VALUES
--     (3, 'charlie', 'alice@example.com', '555-0103');

-- Multiple NULLs are allowed with NULLS DISTINCT
INSERT INTO users_distinct_nulls VALUES
    (3, 'charlie', NULL, NULL);

INSERT INTO users_distinct_nulls VALUES
    (4, 'diana', NULL, NULL);

INSERT INTO users_distinct_nulls VALUES
    (5, 'eve', NULL, '555-0105');

-- Verify multiple NULLs exist
-- Tag: constraints_unique_null_handling_test_select_001
SELECT user_id, username, email, phone
FROM users_distinct_nulls
WHERE email IS NULL;

-- ----------------------------------------------------------------------------
-- 2. UNIQUE NULLS NOT DISTINCT (New SQL:2023 Behavior)
-- ----------------------------------------------------------------------------

-- New behavior: At most one NULL is allowed
-- All NULLs are considered equal to each other
DROP TABLE IF EXISTS users_not_distinct_nulls;
CREATE TABLE users_not_distinct_nulls (
    user_id INT64 PRIMARY KEY,
    username STRING NOT NULL,
    email STRING UNIQUE NULLS NOT DISTINCT,
    ssn STRING UNIQUE NULLS NOT DISTINCT
);

-- Insert valid unique emails
INSERT INTO users_not_distinct_nulls VALUES
    (1, 'alice', 'alice@example.com', '123-45-6789');

INSERT INTO users_not_distinct_nulls VALUES
    (2, 'bob', 'bob@example.com', '234-56-7890');

-- First NULL is allowed
INSERT INTO users_not_distinct_nulls VALUES
    (3, 'charlie', NULL, NULL);

-- Second NULL is NOT allowed with NULLS NOT DISTINCT
-- INSERT INTO users_not_distinct_nulls VALUES
--     (4, 'diana', NULL, '345-67-8901');

-- But can insert if email is not NULL
INSERT INTO users_not_distinct_nulls VALUES
    (4, 'diana', 'diana@example.com', NULL);

INSERT INTO users_not_distinct_nulls VALUES
    (5, 'eve', 'eve@example.com', '456-78-9012');

-- Verify only one NULL exists
-- Tag: constraints_unique_null_handling_test_select_002
SELECT user_id, username, email, ssn
FROM users_not_distinct_nulls
WHERE email IS NULL;

-- ----------------------------------------------------------------------------
-- 3. Composite (Multi-Column) UNIQUE Constraints
-- ----------------------------------------------------------------------------

-- UNIQUE NULLS DISTINCT on composite key
DROP TABLE IF EXISTS orders_distinct;
CREATE TABLE orders_distinct (
    order_id INT64 PRIMARY KEY,
    owner_id INT64,
    equipment_id INT64,
    order_date DATE,
    UNIQUE (owner_id, equipment_id) NULLS DISTINCT
);

-- Valid inserts
INSERT INTO orders_distinct VALUES
    (1, 100, 200, DATE '2023-06-01');

INSERT INTO orders_distinct VALUES
    (2, 100, 201, DATE '2023-06-02');

-- Multiple rows with NULL in composite key (NULLS DISTINCT)
INSERT INTO orders_distinct VALUES
    (3, 100, NULL, DATE '2023-06-03');

INSERT INTO orders_distinct VALUES
    (4, 100, NULL, DATE '2023-06-04');

INSERT INTO orders_distinct VALUES
    (5, NULL, 200, DATE '2023-06-05');

INSERT INTO orders_distinct VALUES
    (6, NULL, 200, DATE '2023-06-06');

INSERT INTO orders_distinct VALUES
    (7, NULL, NULL, DATE '2023-06-07');

INSERT INTO orders_distinct VALUES
    (8, NULL, NULL, DATE '2023-06-08');

-- UNIQUE NULLS NOT DISTINCT on composite key
DROP TABLE IF EXISTS orders_not_distinct;
CREATE TABLE orders_not_distinct (
    order_id INT64 PRIMARY KEY,
    owner_id INT64,
    equipment_id INT64,
    order_date DATE,
    UNIQUE (owner_id, equipment_id) NULLS NOT DISTINCT
);

-- Valid inserts
INSERT INTO orders_not_distinct VALUES
    (1, 100, 200, DATE '2023-06-01');

-- First occurrence with NULL
INSERT INTO orders_not_distinct VALUES
    (2, 100, NULL, DATE '2023-06-02');

-- Second occurrence with same NULL pattern
-- INSERT INTO orders_not_distinct VALUES
--     (3, 100, NULL, DATE '2023-06-03');

-- Different customer with NULL product
INSERT INTO orders_not_distinct VALUES
    (3, 101, NULL, DATE '2023-06-03');

-- Both NULL
INSERT INTO orders_not_distinct VALUES
    (4, NULL, NULL, DATE '2023-06-04');

-- Second both NULL
-- INSERT INTO orders_not_distinct VALUES
--     (5, NULL, NULL, DATE '2023-06-05');

-- ----------------------------------------------------------------------------
-- 4. Named Constraints with NULL Handling
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    equipment_id INT64 PRIMARY KEY,
    sku STRING,
    upc STRING,
    name STRING NOT NULL,
    CONSTRAINT uq_sku UNIQUE (sku) NULLS DISTINCT,
    CONSTRAINT uq_upc UNIQUE (upc) NULLS NOT DISTINCT
);

-- Insert equipment
INSERT INTO equipment VALUES
    (1, 'SKU001', '012345678901', 'Product A');

INSERT INTO equipment VALUES
    (2, 'SKU002', '012345678902', 'Product B');

-- Multiple NULL SKUs allowed (NULLS DISTINCT)
INSERT INTO equipment VALUES
    (3, NULL, '012345678903', 'Product C');

INSERT INTO equipment VALUES
    (4, NULL, '012345678904', 'Product D');

-- Only one NULL UPC allowed (NULLS NOT DISTINCT)
INSERT INTO equipment VALUES
    (5, 'SKU005', NULL, 'Product E');

-- INSERT INTO equipment VALUES
--     (6, 'SKU006', NULL, 'Product F');

-- ----------------------------------------------------------------------------
-- 5. ALTER TABLE to Add/Modify NULL Handling
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    crew_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    badge_number STRING,
    parking_spot STRING
);

-- Initially no UNIQUE constraint
INSERT INTO crew_members VALUES
    (1, 'Alice', 'B001', 'P001'),
    (2, 'Bob', 'B002', NULL),
    (3, 'Charlie', NULL, NULL);

-- Add UNIQUE constraint with NULLS DISTINCT
ALTER TABLE crew_members
ADD CONSTRAINT uq_badge UNIQUE (badge_number) NULLS DISTINCT;

-- Now multiple NULLs are allowed for badge_number
INSERT INTO crew_members VALUES (4, 'Diana', NULL, 'P004');

-- Add UNIQUE constraint with NULLS NOT DISTINCT
ALTER TABLE crew_members
ADD CONSTRAINT uq_parking UNIQUE (parking_spot) NULLS NOT DISTINCT;

-- Delete one NULL parking spot
DELETE FROM crew_members WHERE crew_id = 3;

-- Now can add NULLS NOT DISTINCT constraint
ALTER TABLE crew_members
ADD CONSTRAINT uq_parking UNIQUE (parking_spot) NULLS NOT DISTINCT;

-- Can't insert another NULL parking spot
-- INSERT INTO crew_members VALUES (5, 'Eve', 'B005', NULL);

-- ----------------------------------------------------------------------------
-- 6. Interaction with NOT NULL
-- ----------------------------------------------------------------------------

-- UNIQUE + NOT NULL makes NULL handling irrelevant
DROP TABLE IF EXISTS accounts_not_null;
CREATE TABLE accounts_not_null (
    account_id INT64 PRIMARY KEY,
    email STRING NOT NULL UNIQUE NULLS DISTINCT,
    username STRING NOT NULL UNIQUE NULLS NOT DISTINCT
);

-- NULLs are not allowed due to NOT NULL
-- INSERT INTO accounts_not_null VALUES (1, NULL, 'user1');

-- INSERT INTO accounts_not_null VALUES (1, 'user1@example.com', NULL);

-- Valid inserts
INSERT INTO accounts_not_null VALUES
    (1, 'user1@example.com', 'user1');

INSERT INTO accounts_not_null VALUES
    (2, 'user2@example.com', 'user2');

-- Duplicates still rejected
-- INSERT INTO accounts_not_null VALUES (3, 'user1@example.com', 'user3');

-- ----------------------------------------------------------------------------
-- 7. Default Behavior (No explicit NULLS clause)
-- ----------------------------------------------------------------------------

-- When NULLS DISTINCT/NOT DISTINCT is omitted, behavior is implementation-defined
-- In SQL:2023 compliant implementations, default should be NULLS DISTINCT
DROP TABLE IF EXISTS default_behavior;
CREATE TABLE default_behavior (
    id INT64 PRIMARY KEY,
    value STRING UNIQUE  -- No explicit NULLS clause
);

-- This should behave like NULLS DISTINCT (multiple NULLs allowed)
INSERT INTO default_behavior VALUES (1, 'a');
INSERT INTO default_behavior VALUES (2, NULL);
INSERT INTO default_behavior VALUES (3, NULL);

-- ----------------------------------------------------------------------------
-- 8. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Use Case 1: Email addresses (multiple users without email allowed)
DROP TABLE IF EXISTS newsletter_subscribers;
CREATE TABLE newsletter_subscribers (
    subscriber_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    email STRING UNIQUE NULLS DISTINCT,
    subscribed_date DATE
);

-- Multiple users can have NULL email (e.g., waiting for verification)
INSERT INTO newsletter_subscribers VALUES
    (1, 'Alice', 'alice@example.com', DATE '2023-01-15'),
    (2, 'Bob', NULL, DATE '2023-02-20'),
    (3, 'Charlie', NULL, DATE '2023-03-10');

-- Use Case 2: Social Security Numbers (at most one unknown)
DROP TABLE IF EXISTS citizens;
CREATE TABLE citizens (
    citizen_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    ssn STRING UNIQUE NULLS NOT DISTINCT,
    birth_date DATE
);

-- Only one person can have unknown SSN
INSERT INTO citizens VALUES
    (1, 'Alice', '123-45-6789', DATE '1990-01-15'),
    (2, 'Bob', '234-56-7890', DATE '1985-06-20'),
    (3, 'Unknown', NULL, DATE '1980-01-01');

-- Can't insert another unknown SSN
-- INSERT INTO citizens VALUES (4, 'Another Unknown', NULL, DATE '1975-05-10');

-- Use Case 3: Business identifiers (multiple pending registrations)
DROP TABLE IF EXISTS marinas;
CREATE TABLE marinas (
    marina_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    tax_id STRING UNIQUE NULLS DISTINCT,
    incorporation_date DATE
);

-- Multiple marinas can be pending tax ID assignment
INSERT INTO marinas VALUES
    (1, 'TechCorp', '12-3456789', DATE '2020-01-15'),
    (2, 'StartupA', NULL, DATE '2023-06-01'),
    (3, 'StartupB', NULL, DATE '2023-06-15');

-- Use Case 4: Inventory tracking (unique serial numbers)
DROP TABLE IF EXISTS inventory_items;
CREATE TABLE inventory_items (
    item_id INT64 PRIMARY KEY,
    product_name STRING NOT NULL,
    serial_number STRING UNIQUE NULLS NOT DISTINCT,
    purchase_date DATE
);

-- Items can have serial numbers or be bulk items (one NULL entry)
INSERT INTO inventory_items VALUES
    (1, 'Laptop', 'SN123456', DATE '2023-01-15'),
    (2, 'Mouse', NULL, DATE '2023-02-20');

-- Can't track multiple bulk items with NULL serial
-- INSERT INTO inventory_items VALUES (3, 'Keyboard', NULL, DATE '2023-03-10');

-- Use Case 5: Composite key for appointments
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    appointment_id INT64 PRIMARY KEY,
    doctor_id INT64,
    patient_id INT64,
    appointment_time TIMESTAMP,
    UNIQUE (doctor_id, appointment_time) NULLS NOT DISTINCT
);

-- Doctor can't have two appointments at same time
INSERT INTO appointments VALUES
    (1, 100, 200, TIMESTAMP '2023-06-15 09:00:00');

-- INSERT INTO appointments VALUES
--     (2, 100, 201, TIMESTAMP '2023-06-15 09:00:00');

-- Emergency appointment (NULL doctor, to be assigned)
INSERT INTO appointments VALUES
    (2, NULL, 201, TIMESTAMP '2023-06-15 09:00:00');

-- Can't have two unassigned appointments at same time
-- INSERT INTO appointments VALUES
--     (3, NULL, 202, TIMESTAMP '2023-06-15 09:00:00');

-- ----------------------------------------------------------------------------
-- 9. Query Patterns with NULL Handling
-- ----------------------------------------------------------------------------

-- Find all users with NULL emails (NULLS DISTINCT case)
-- Tag: constraints_unique_null_handling_test_select_003
SELECT user_id, username
FROM users_distinct_nulls
WHERE email IS NULL;

-- Find user with NULL email (NULLS NOT DISTINCT case)
-- Tag: constraints_unique_null_handling_test_select_004
SELECT user_id, username
FROM users_not_distinct_nulls
WHERE email IS NULL;

-- Count unique vs NULL values
-- Tag: constraints_unique_null_handling_test_select_001
SELECT
    COUNT(DISTINCT email) AS unique_emails,
    COUNT(email) AS non_null_emails,
    COUNT(*) - COUNT(email) AS null_emails
FROM users_distinct_nulls;

-- Join on columns with NULLS NOT DISTINCT
-- NULLs will not match in standard JOIN (IS NOT DISTINCT FROM needed)
-- Tag: constraints_unique_null_handling_test_select_005
SELECT u1.username AS user1,
       u2.username AS user2
FROM users_not_distinct_nulls u1
JOIN users_not_distinct_nulls u2
    ON u1.email IS NOT DISTINCT FROM u2.email
WHERE u1.user_id < u2.user_id;

-- ----------------------------------------------------------------------------
-- 10. Migration Scenarios
-- ----------------------------------------------------------------------------

-- Migrating from NULLS DISTINCT to NULLS NOT DISTINCT
DROP TABLE IF EXISTS temp_migration;
CREATE TABLE temp_migration (
    id INT64 PRIMARY KEY,
    code STRING UNIQUE NULLS DISTINCT
);

INSERT INTO temp_migration VALUES (1, 'A'), (2, NULL), (3, NULL);

-- To migrate to NULLS NOT DISTINCT:
-- 1. Identify rows with NULL
-- Tag: constraints_unique_null_handling_test_select_006
SELECT COUNT(*) AS null_count FROM temp_migration WHERE code IS NULL;

-- 2. Keep only one NULL (decide which to keep)
UPDATE temp_migration SET code = 'TEMP_' || CAST(id AS STRING) WHERE id = 3 AND code IS NULL;

-- 3. Drop old constraint and add new one
ALTER TABLE temp_migration DROP CONSTRAINT temp_migration_code_key;
ALTER TABLE temp_migration ADD CONSTRAINT uq_code UNIQUE (code) NULLS NOT DISTINCT;

-- Now only one NULL is allowed
-- INSERT INTO temp_migration VALUES (4, NULL);

-- End of UNIQUE NULL Handling Tests
