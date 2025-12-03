-- Sequences - SQL:2023
-- Description: SEQUENCE objects for auto-incrementing values
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: ddl_sequences_test_select_001
SELECT NEXT VALUE FOR yacht_id_seq AS first_value;

-- Tag: ddl_sequences_test_select_002
SELECT NEXT VALUE FOR yacht_id_seq AS second_value;

-- Tag: ddl_sequences_test_select_003
SELECT NEXT VALUE FOR yacht_id_seq AS third_value;

-- Create another sequence
CREATE SEQUENCE maintenance_id_seq;

-- Tag: ddl_sequences_test_select_004
SELECT NEXT VALUE FOR maintenance_id_seq;

-- ----------------------------------------------------------------------------
-- 2. CREATE SEQUENCE with Custom Options
-- ----------------------------------------------------------------------------

-- Start with specific value
CREATE SEQUENCE crew_id_seq START WITH 1000;

-- Tag: ddl_sequences_test_select_005
SELECT NEXT VALUE FOR crew_id_seq;

-- Tag: ddl_sequences_test_select_006
SELECT NEXT VALUE FOR crew_id_seq;

-- Custom increment
CREATE SEQUENCE even_numbers_seq
    START WITH 2
    INCREMENT BY 2;

-- Tag: ddl_sequences_test_select_007
SELECT NEXT VALUE FOR even_numbers_seq;

-- Tag: ddl_sequences_test_select_008
SELECT NEXT VALUE FOR even_numbers_seq;

-- Tag: ddl_sequences_test_select_009
SELECT NEXT VALUE FOR even_numbers_seq;

-- Negative increment (descending)
CREATE SEQUENCE countdown_seq
    START WITH 100
    INCREMENT BY -1
    MINVALUE 1;

-- Tag: ddl_sequences_test_select_010
SELECT NEXT VALUE FOR countdown_seq;

-- Tag: ddl_sequences_test_select_011
SELECT NEXT VALUE FOR countdown_seq;

-- Sequence with MIN and MAX values
CREATE SEQUENCE limited_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 5
    CYCLE;  -- Restart when MAX reached

-- Tag: ddl_sequences_test_select_012
SELECT NEXT VALUE FOR limited_seq; -- 1
-- Tag: ddl_sequences_test_select_013
SELECT NEXT VALUE FOR limited_seq; -- 2
-- Tag: ddl_sequences_test_select_014
SELECT NEXT VALUE FOR limited_seq; -- 3
-- Tag: ddl_sequences_test_select_015
SELECT NEXT VALUE FOR limited_seq; -- 4
-- Tag: ddl_sequences_test_select_016
SELECT NEXT VALUE FOR limited_seq; -- 5
-- Tag: ddl_sequences_test_select_017
SELECT NEXT VALUE FOR limited_seq; -- 1 (cycles back)

-- NO CYCLE (default - will error at MAX)
CREATE SEQUENCE no_cycle_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 3
    NO CYCLE;

-- Tag: ddl_sequences_test_select_018
SELECT NEXT VALUE FOR no_cycle_seq; -- 1
-- Tag: ddl_sequences_test_select_019
SELECT NEXT VALUE FOR no_cycle_seq; -- 2
-- Tag: ddl_sequences_test_select_020
SELECT NEXT VALUE FOR no_cycle_seq; -- 3
-- SELECT NEXT VALUE FOR no_cycle_seq; -- ERROR: exceeds MAXVALUE

-- ----------------------------------------------------------------------------
-- 3. Using SEQUENCE in INSERT Statements
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS yachts;
CREATE TABLE yachts (
    yacht_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    length_feet INT64,
    manufacturer STRING,
    registration_number INT64
);

-- Insert using sequence for primary key
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, registration_number)
VALUES (NEXT VALUE FOR yacht_id_seq, 'Sea Breeze', 45, 'Beneteau', NEXT VALUE FOR even_numbers_seq);

INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, registration_number)
VALUES (NEXT VALUE FOR yacht_id_seq, 'Wind Dancer', 38, 'Jeanneau', NEXT VALUE FOR even_numbers_seq);

INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, registration_number)
VALUES (NEXT VALUE FOR yacht_id_seq, 'Ocean Pearl', 52, 'Bavaria', NEXT VALUE FOR even_numbers_seq);

-- Tag: ddl_sequences_test_select_021
SELECT * FROM yachts ORDER BY yacht_id;

-- Batch insert with sequence
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, registration_number)
-- Tag: ddl_sequences_test_select_001
SELECT
    NEXT VALUE FOR yacht_id_seq,
    'Yacht-' || CAST(n AS STRING),
    40 + n,
    'Manufacturer-' || CAST(n AS STRING),
    NEXT VALUE FOR even_numbers_seq
FROM GENERATE_SERIES(1, 5) AS n;

-- ----------------------------------------------------------------------------
-- 4. ALTER SEQUENCE
-- ----------------------------------------------------------------------------

-- Restart sequence
ALTER SEQUENCE yacht_id_seq RESTART WITH 100;

-- Tag: ddl_sequences_test_select_022
SELECT NEXT VALUE FOR yacht_id_seq;

-- Change increment
ALTER SEQUENCE yacht_id_seq INCREMENT BY 10;

-- Tag: ddl_sequences_test_select_023
SELECT NEXT VALUE FOR yacht_id_seq;

-- Tag: ddl_sequences_test_select_024
SELECT NEXT VALUE FOR yacht_id_seq;

-- Set new MAX value
ALTER SEQUENCE crew_id_seq MAXVALUE 9999 NO CYCLE;

-- Reset to default increment
ALTER SEQUENCE yacht_id_seq INCREMENT BY 1;

-- Tag: ddl_sequences_test_select_025
SELECT NEXT VALUE FOR yacht_id_seq;

-- Change to cycling sequence
ALTER SEQUENCE limited_seq CYCLE;

-- ----------------------------------------------------------------------------
-- 5. Sequences with Multiple Tables (Shared Sequence)
-- ----------------------------------------------------------------------------

-- Create shared sequence for tracking all IDs
CREATE SEQUENCE global_id_seq START WITH 1000;

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    crew_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    role STRING
);

DROP TABLE IF EXISTS maintenance_records;
CREATE TABLE maintenance_records (
    record_id INT64 PRIMARY KEY,
    yacht_id INT64,
    service_date DATE,
    service_type STRING
);

-- Both tables use same sequence
INSERT INTO crew_members (crew_id, name, role)
VALUES (NEXT VALUE FOR global_id_seq, 'Captain Jack', 'Captain');

INSERT INTO maintenance_records (record_id, yacht_id, service_date, service_type)
VALUES (NEXT VALUE FOR global_id_seq, 4, DATE '2024-06-01', 'Engine Service');

INSERT INTO crew_members (crew_id, name, role)
VALUES (NEXT VALUE FOR global_id_seq, 'First Mate Sarah', 'First Mate');

-- Verify unique IDs across tables
-- Tag: ddl_sequences_test_select_026
SELECT crew_id AS id, 'crew' AS type, name AS description FROM crew_members
UNION ALL
-- Tag: ddl_sequences_test_select_027
SELECT record_id AS id, 'maintenance' AS type, service_type AS description FROM maintenance_records
ORDER BY id;

-- ----------------------------------------------------------------------------
-- 6. Sequences with DEFAULT Values
-- ----------------------------------------------------------------------------

-- Use sequence as column default
DROP TABLE IF EXISTS yacht_bookings;
CREATE TABLE yacht_bookings (
    booking_id INT64 DEFAULT (NEXT VALUE FOR global_id_seq) PRIMARY KEY,
    yacht_id INT64,
    customer_name STRING,
    booking_date DATE
);

-- Insert without specifying booking_id
INSERT INTO yacht_bookings (yacht_id, customer_name, booking_date)
VALUES (4, 'John Smith', DATE '2024-07-15');

INSERT INTO yacht_bookings (yacht_id, customer_name, booking_date)
VALUES (5, 'Jane Doe', DATE '2024-07-20');

-- Tag: ddl_sequences_test_select_028
SELECT * FROM yacht_bookings ORDER BY booking_id;

-- Override default by providing explicit value
INSERT INTO yacht_bookings (booking_id, yacht_id, customer_name, booking_date)
VALUES (2000, 6, 'Bob Johnson', DATE '2024-08-01');

-- ----------------------------------------------------------------------------
-- 7. Sequence Performance - CACHE Option
-- ----------------------------------------------------------------------------

-- Create sequence with caching for performance
CREATE SEQUENCE high_volume_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 100;  -- Pre-allocate 100 values in memory

-- Without CACHE (default behavior)
CREATE SEQUENCE no_cache_seq
    START WITH 1
    INCREMENT BY 1
    NO CACHE;

-- Demonstrate with bulk insert
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT64 PRIMARY KEY,
    amount NUMERIC(10, 2),
    transaction_date TIMESTAMP
);

-- Fast bulk insert using cached sequence
INSERT INTO transactions (transaction_id, amount, transaction_date)
-- Tag: ddl_sequences_test_select_002
SELECT
    NEXT VALUE FOR high_volume_seq,
    100.00 + (n * 10.5),
    CURRENT_TIMESTAMP
FROM GENERATE_SERIES(1, 50) AS n;

-- ----------------------------------------------------------------------------
-- 8. Sequences in Expressions and Functions
-- ----------------------------------------------------------------------------

-- Use in SELECT expressions
-- Tag: ddl_sequences_test_select_003
SELECT
    NEXT VALUE FOR yacht_id_seq AS next_yacht_id,
    NEXT VALUE FOR crew_id_seq AS next_crew_id,
    CURRENT_TIMESTAMP AS generated_at;

-- Use in CASE expression
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, registration_number)
-- Tag: ddl_sequences_test_select_004
SELECT
    NEXT VALUE FOR yacht_id_seq,
    'Test Yacht ' || CAST(n AS STRING),
    CASE
        WHEN n % 2 = 0 THEN 40
        ELSE 50
    END,
    'TestCo',
    NEXT VALUE FOR even_numbers_seq
FROM GENERATE_SERIES(1, 3) AS n;

-- ----------------------------------------------------------------------------
-- 9. DROP SEQUENCE
-- ----------------------------------------------------------------------------

-- Drop unused sequence
CREATE SEQUENCE temp_seq START WITH 1;

-- Tag: ddl_sequences_test_select_029
SELECT NEXT VALUE FOR temp_seq; -- 1

DROP SEQUENCE temp_seq;

-- Attempting to use dropped sequence would error:
-- SELECT NEXT VALUE FOR temp_seq;  -- ERROR

-- Drop with IF EXISTS
DROP SEQUENCE IF EXISTS non_existent_seq;

-- Drop with CASCADE (if supported - drops dependent objects)
-- DROP SEQUENCE yacht_id_seq CASCADE;

-- ----------------------------------------------------------------------------
-- 10. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Use Case 1: Order numbering system
CREATE SEQUENCE order_number_seq
    START WITH 2024001
    INCREMENT BY 1
    MINVALUE 2024001
    MAXVALUE 2024999;

DROP TABLE IF EXISTS yacht_orders;
CREATE TABLE yacht_orders (
    order_id INT64 DEFAULT (NEXT VALUE FOR order_number_seq) PRIMARY KEY,
    yacht_id INT64,
    order_date DATE,
    total_amount NUMERIC(12, 2)
);

INSERT INTO yacht_orders (yacht_id, order_date, total_amount)
VALUES (4, DATE '2024-06-15', 450000.00);

INSERT INTO yacht_orders (yacht_id, order_date, total_amount)
VALUES (5, DATE '2024-06-20', 520000.00);

-- Use Case 2: Version numbering
CREATE SEQUENCE version_seq
    START WITH 1
    INCREMENT BY 1;

DROP TABLE IF EXISTS yacht_specifications;
CREATE TABLE yacht_specifications (
    spec_id INT64 PRIMARY KEY,
    yacht_id INT64,
    version INT64,
    specification_data STRING,
    created_at TIMESTAMP
);

INSERT INTO yacht_specifications
VALUES (1, 4, NEXT VALUE FOR version_seq, 'Initial specs', CURRENT_TIMESTAMP);

INSERT INTO yacht_specifications
VALUES (2, 4, NEXT VALUE FOR version_seq, 'Updated specs', CURRENT_TIMESTAMP);

-- Use Case 3: Multi-tenant ID generation
CREATE SEQUENCE tenant_a_seq START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE tenant_b_seq START WITH 2000 INCREMENT BY 1;

DROP TABLE IF EXISTS multi_tenant_bookings;
CREATE TABLE multi_tenant_bookings (
    booking_id INT64 PRIMARY KEY,
    tenant_id STRING,
    yacht_id INT64,
    booking_date DATE
);

-- Tenant A booking
INSERT INTO multi_tenant_bookings
VALUES (NEXT VALUE FOR tenant_a_seq, 'TenantA', 4, DATE '2024-07-01');

-- Tenant B booking
INSERT INTO multi_tenant_bookings
VALUES (NEXT VALUE FOR tenant_b_seq, 'TenantB', 5, DATE '2024-07-01');

-- Tenant A another booking
INSERT INTO multi_tenant_bookings
VALUES (NEXT VALUE FOR tenant_a_seq, 'TenantA', 6, DATE '2024-07-02');

-- Use Case 4: Batch numbering
CREATE SEQUENCE batch_seq START WITH 1;

DROP TABLE IF EXISTS maintenance_batches;
CREATE TABLE maintenance_batches (
    batch_id INT64,
    record_id INT64,
    yacht_id INT64,
    service_type STRING
);

-- Assign same batch number to group of records
DO $$
DECLARE batch_num INT64;
BEGIN
    batch_num := NEXT VALUE FOR batch_seq;

    INSERT INTO maintenance_batches (batch_id, record_id, yacht_id, service_type)
    VALUES (batch_num, 1, 4, 'Engine'),
           (batch_num, 2, 5, 'Engine'),
           (batch_num, 3, 6, 'Engine');
END $$;

-- ----------------------------------------------------------------------------
-- 11. Querying Sequence Metadata (Implementation-specific)
-- ----------------------------------------------------------------------------

-- Query sequence information from system catalog
-- SELECT sequence_name, data_type, start_value, increment, minimum_value, maximum_value, cycle_option
-- FROM information_schema.sequences
-- WHERE sequence_schema = 'public';

-- Get current value without incrementing (if supported)
-- SELECT currval('yacht_id_seq');  -- PostgreSQL syntax
-- Note: Standard SQL doesn't have currval, varies by implementation

-- ----------------------------------------------------------------------------
-- 12. Edge Cases
-- ----------------------------------------------------------------------------

-- Sequence with MINVALUE and MAXVALUE equal
CREATE SEQUENCE single_value_seq
    START WITH 42
    INCREMENT BY 1
    MINVALUE 42
    MAXVALUE 42
    NO CYCLE;

-- Tag: ddl_sequences_test_select_030
SELECT NEXT VALUE FOR single_value_seq;

-- SELECT NEXT VALUE FOR single_value_seq;

-- Large increment
CREATE SEQUENCE big_increment_seq
    START WITH 1
    INCREMENT BY 1000;

-- Tag: ddl_sequences_test_select_031
SELECT NEXT VALUE FOR big_increment_seq; -- 1
-- Tag: ddl_sequences_test_select_032
SELECT NEXT VALUE FOR big_increment_seq; -- 1001
-- Tag: ddl_sequences_test_select_033
SELECT NEXT VALUE FOR big_increment_seq; -- 2001

-- Negative start value
CREATE SEQUENCE negative_seq
    START WITH -100
    INCREMENT BY 1;

-- Tag: ddl_sequences_test_select_034
SELECT NEXT VALUE FOR negative_seq; -- -100
-- Tag: ddl_sequences_test_select_035
SELECT NEXT VALUE FOR negative_seq; -- -99

-- ----------------------------------------------------------------------------
-- Cleanup
-- ----------------------------------------------------------------------------

DROP SEQUENCE IF EXISTS yacht_id_seq;
DROP SEQUENCE IF EXISTS maintenance_id_seq;
DROP SEQUENCE IF EXISTS crew_id_seq;
DROP SEQUENCE IF EXISTS even_numbers_seq;
DROP SEQUENCE IF EXISTS countdown_seq;
DROP SEQUENCE IF EXISTS limited_seq;
DROP SEQUENCE IF EXISTS no_cycle_seq;
DROP SEQUENCE IF EXISTS global_id_seq;
DROP SEQUENCE IF EXISTS high_volume_seq;
DROP SEQUENCE IF EXISTS no_cache_seq;
DROP SEQUENCE IF EXISTS order_number_seq;
DROP SEQUENCE IF EXISTS version_seq;
DROP SEQUENCE IF EXISTS tenant_a_seq;
DROP SEQUENCE IF EXISTS tenant_b_seq;
DROP SEQUENCE IF EXISTS batch_seq;
DROP SEQUENCE IF EXISTS single_value_seq;
DROP SEQUENCE IF EXISTS big_increment_seq;
DROP SEQUENCE IF EXISTS negative_seq;

-- End of SEQUENCE Tests
