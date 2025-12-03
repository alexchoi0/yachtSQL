-- Table Ddl Enhancements - SQL:2023
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS test_position;
CREATE TABLE test_position (
  id INT64,
  name STRING
);

-- Add column at the beginning
ALTER TABLE test_position ADD COLUMN seq INT64 FIRST;

-- Result column order: seq, id, name

-- Add column after specific column (AFTER)
ALTER TABLE test_position ADD COLUMN email STRING AFTER name;

-- Result column order: seq, id, name, email

-- Generated Columns (Computed Columns)

-- GENERATED ALWAYS AS (expression)
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
  id INT64,
  first_name STRING,
  last_name STRING,
  -- Generated column: computed from other columns
  full_name STRING GENERATED ALWAYS AS (first_name || ' ' || last_name),
  salary NUMERIC(10, 2),
  -- Generated column: computed value
  annual_bonus NUMERIC(10, 2) GENERATED ALWAYS AS (salary * 0.1)
);

INSERT INTO crew_members (id, first_name, last_name, salary)
VALUES (1, 'John', 'Doe', 50000.00);

-- full_name and annual_bonus are automatically computed
-- Tag: ddl_table_ddl_enhancements_test_select_001
SELECT id, full_name, annual_bonus FROM crew_members WHERE id = 1;

-- Generated Columns - STORED vs VIRTUAL

-- STORED: Physically stored in table
DROP TABLE IF EXISTS equipment_stored;
CREATE TABLE equipment_stored (
  id INT64,
  price NUMERIC(10, 2),
  tax_rate NUMERIC(3, 2) DEFAULT 0.08,
  -- Computed and stored
  price_with_tax NUMERIC(10, 2) GENERATED ALWAYS AS (price * (1 + tax_rate)) STORED
);

-- VIRTUAL: Computed on read (not stored)
DROP TABLE IF EXISTS equipment_virtual;
CREATE TABLE equipment_virtual (
  id INT64,
  price NUMERIC(10, 2),
  tax_rate NUMERIC(3, 2) DEFAULT 0.08,
  -- Computed on query (not stored)
  price_with_tax NUMERIC(10, 2) GENERATED ALWAYS AS (price * (1 + tax_rate)) VIRTUAL
);

-- Generated Columns - Edge Cases

-- Generated column with NULL handling
DROP TABLE IF EXISTS test_generated_null;
CREATE TABLE test_generated_null (
  id INT64,
  value1 INT64,
  value2 INT64,
  -- If either value is NULL, result is NULL
  sum_value INT64 GENERATED ALWAYS AS (value1 + value2)
);

INSERT INTO test_generated_null (id, value1, value2) VALUES (1, 10, 20);
INSERT INTO test_generated_null (id, value1, value2) VALUES (2, 10, NULL);

-- Tag: ddl_table_ddl_enhancements_test_select_002
SELECT * FROM test_generated_null;
-- Row 1: sum_value = 30
-- Row 2: sum_value = NULL

-- Storage Options

-- Table with storage engine specification (vendor-specific)
DROP TABLE IF EXISTS test_storage;
CREATE TABLE test_storage (
  id INT64,
  data STRING
) ENGINE = InnoDB;

-- Table with row format
DROP TABLE IF EXISTS test_row_format;
CREATE TABLE test_row_format (
  id INT64,
  data STRING
) ROW_FORMAT = COMPRESSED;

-- Table with character set and collation
DROP TABLE IF EXISTS test_charset;
CREATE TABLE test_charset (
  id INT64,
  data STRING
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Table Options - Partitioning

-- Range partitioning
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  id INT64,
  sale_date DATE,
  amount NUMERIC(10, 2)
)
PARTITION BY RANGE (YEAR(sale_date)) (
  PARTITION p2020 VALUES LESS THAN (2021),
  PARTITION p2021 VALUES LESS THAN (2022),
  PARTITION p2022 VALUES LESS THAN (2023),
  PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- List partitioning
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
  id INT64,
  name STRING,
  region STRING
)
PARTITION BY LIST (region) (
  PARTITION p_north VALUES IN ('North', 'Northeast', 'Northwest'),
  PARTITION p_south VALUES IN ('South', 'Southeast', 'Southwest'),
  PARTITION p_other VALUES IN (DEFAULT)
);

-- Hash partitioning
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT64,
  owner_id INT64,
  order_date DATE
)
PARTITION BY HASH(owner_id)
PARTITIONS 4;

-- Table Compression

-- Table with compression
DROP TABLE IF EXISTS compressed_data;
CREATE TABLE compressed_data (
  id INT64,
  large_text STRING
) COMPRESSION = 'ZLIB';

-- Column-level compression
DROP TABLE IF EXISTS mixed_compression;
CREATE TABLE mixed_compression (
  id INT64,
  small_data STRING,
  large_data STRING COMPRESSION = 'SNAPPY'
);

-- Table Comments and Metadata

-- Table with comment
DROP TABLE IF EXISTS documented_table;
CREATE TABLE documented_table (
  id INT64 COMMENT 'Primary key identifier',
  name STRING COMMENT 'User full name',
  email STRING COMMENT 'Contact email address'
) COMMENT = 'User information table';

-- Add comment to existing table
ALTER TABLE documented_table COMMENT = 'Updated user information table';

-- Add comment to existing column
ALTER TABLE documented_table MODIFY COLUMN name STRING COMMENT 'Updated: User full name';

-- Identity Columns (Auto-increment)

-- IDENTITY column (SQL:2003 standard)
DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity (
  id INT64 ,
  name STRING
);

-- IDENTITY with options
DROP TABLE IF EXISTS test_identity_options;
CREATE TABLE test_identity_options (
  id INT64 (START WITH 100 INCREMENT BY 10),
  name STRING
);

-- IDENTITY BY DEFAULT (can override)
DROP TABLE IF EXISTS test_identity_default;
CREATE TABLE test_identity_default (
  id INT64 GENERATED BY DEFAULT AS IDENTITY,
  name STRING
);

INSERT INTO test_identity_default (name) VALUES ('Auto'); -- id auto-generated
INSERT INTO test_identity_default (id, name) VALUES (999, 'Manual'); -- id overridden

-- Temporal Tables (System Versioning)

-- Table with system versioning
DROP TABLE IF EXISTS versioned_equipment;
CREATE TABLE versioned_equipment (
  id INT64,
  name STRING,
  price NUMERIC(10, 2),
  -- System versioning columns
  valid_from TIMESTAMP GENERATED ALWAYS AS ROW START,
  valid_to TIMESTAMP GENERATED ALWAYS AS ROW END,
  PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
) WITH SYSTEM VERSIONING;

-- Query current data
-- Tag: ddl_table_ddl_enhancements_test_select_003
SELECT * FROM versioned_equipment;

-- Query historical data
-- Tag: ddl_table_ddl_enhancements_test_select_004
SELECT * FROM versioned_equipment FOR SYSTEM_TIME AS OF TIMESTAMP '2024-01-01 00:00:00';

-- Query changes between timestamps
-- Tag: ddl_table_ddl_enhancements_test_select_005
SELECT * FROM versioned_equipment FOR SYSTEM_TIME BETWEEN
  TIMESTAMP '2024-01-01 00:00:00' AND TIMESTAMP '2024-12-31 23:59:59';

-- Invisible Columns

-- Columns that are not shown in SELECT *
DROP TABLE IF EXISTS test_invisible;
CREATE TABLE test_invisible (
  id INT64,
  public_data STRING,
  internal_data STRING INVISIBLE,
  audit_timestamp TIMESTAMP INVISIBLE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO test_invisible (id, public_data, internal_data)
VALUES (1, 'visible', 'hidden');

-- SELECT * shows only visible columns
-- Tag: ddl_table_ddl_enhancements_test_select_006
SELECT * FROM test_invisible; -- Returns: id, public_data

-- Explicitly select invisible column
-- Tag: ddl_table_ddl_enhancements_test_select_007
SELECT id, public_data, internal_data FROM test_invisible; -- Returns all

-- Check Option for Views (related to tables)

-- Create view with check option
DROP TABLE IF EXISTS base_table;
CREATE TABLE base_table (
  id INT64,
  status STRING
);

DROP VIEW IF EXISTS active_items;
CREATE VIEW active_items AS
-- Tag: ddl_table_ddl_enhancements_test_select_008
SELECT * FROM base_table WHERE status = 'active'
WITH CHECK OPTION;

-- Insert through view enforces WHERE clause
INSERT INTO active_items VALUES (1, 'active'); -- OK
-- INSERT INTO active_items VALUES (2, 'inactive'); -- Error: violates check option

-- Multi-column Generation

-- Multiple generated columns depending on each other
DROP TABLE IF EXISTS complex_generated;
CREATE TABLE complex_generated (
  id INT64,
  quantity INT64,
  unit_price NUMERIC(10, 2),
  -- First level: computed from base columns
  subtotal NUMERIC(10, 2) GENERATED ALWAYS AS (quantity * unit_price),
  tax_rate NUMERIC(3, 2) DEFAULT 0.08,
  -- Second level: computed from generated column
  tax_amount NUMERIC(10, 2) GENERATED ALWAYS AS (subtotal * tax_rate),
  -- Third level: computed from multiple generated columns
  total NUMERIC(10, 2) GENERATED ALWAYS AS (subtotal + tax_amount)
);

INSERT INTO complex_generated (id, quantity, unit_price)
VALUES (1, 10, 25.00);

-- Tag: ddl_table_ddl_enhancements_test_select_009
SELECT * FROM complex_generated WHERE id = 1;

-- End of File
