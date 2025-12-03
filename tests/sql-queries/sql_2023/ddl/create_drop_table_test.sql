-- Create Drop Table - SQL:2023
-- Description: CREATE TABLE and DROP TABLE operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64,
    name STRING,
    age INT64
);

-- Table with multiple data types
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64,
    name STRING,
    salary INT64,
    fleet STRING
);

-- Table with FLOAT64 type
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    name STRING,
    price FLOAT64
);

-- Table with BOOL type
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (
    id INT64,
    active BOOL
);

-- CREATE TABLE IF NOT EXISTS

-- Idempotent table creation (SQL:2016)
CREATE TABLE IF NOT EXISTS test (
    id INT64,
    name STRING
);

-- With constraints
CREATE TABLE IF NOT EXISTS users (
    id INT64,
    email STRING,
    CONSTRAINT pk_users PRIMARY KEY (id)
);

-- CREATE TABLE - Complex Data Types

-- DATE type
DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id INT64,
    event_date DATE
);

-- TIMESTAMP type
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id INT64,
    created_at TIMESTAMP
);

-- DATETIME type
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    id INT64,
    scheduled DATETIME
);

-- TIME type
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (
    id INT64,
    time TIME
);

-- NUMERIC/DECIMAL type
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (
    id INT64,
    amount NUMERIC
);

-- BYTES type
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (
    id INT64,
    data BYTES
);

-- ARRAY type
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (
    id INT64,
    numbers ARRAY<INT64>
);

-- STRUCT type
DROP TABLE IF EXISTS structured;
CREATE TABLE structured (
    id INT64,
    person STRUCT<name STRING, age INT64>
);

-- UUID type (PostgreSQL/SQL:2016 extension)
DROP TABLE IF EXISTS equipment_uuid;
CREATE TABLE equipment_uuid (
    id UUID PRIMARY KEY,
    name STRING
);

-- CREATE TABLE - Mixed Types

-- Table with all common types
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (
    id INT64,
    name STRING,
    score FLOAT64,
    active BOOL,
    created DATE
);

-- Nullable columns
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (
    id INT64,
    value STRING,
    number INT64
);

-- CREATE TABLE - With Precision and Scale

-- NUMERIC with precision and scale
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (
    id INT64,
    amount NUMERIC(10, 2)
);

-- DECIMAL (alias for NUMERIC)
DROP TABLE IF EXISTS test_decimal;
CREATE TABLE test_decimal (
    val DECIMAL(10, 2)
);

-- DROP TABLE

-- Basic DROP TABLE
DROP TABLE users;

-- DROP TABLE IF EXISTS

-- Idempotent table deletion (SQL:2016)

-- Drop multiple times (should not error)

-- TRUNCATE TABLE

-- Remove all rows from table (keep structure)
TRUNCATE TABLE users;

-- CREATE/DROP Cycle

-- Pattern: CREATE IF NOT EXISTS, DROP IF EXISTS, CREATE IF NOT EXISTS
CREATE TABLE IF NOT EXISTS test (id INT64);
INSERT INTO test VALUES (1);


CREATE TABLE IF NOT EXISTS test (id INT64, name STRING);
INSERT INTO test VALUES (2, 'Bob');

-- Edge Cases

-- Table with single column
DROP TABLE IF EXISTS single;
CREATE TABLE single (
    id INT64
);

-- Empty table
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (
    id INT64,
    name STRING
);

-- Large integers (INT64 min/max)
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (
    value INT64
);

INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);

-- Very small floats
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (
    value FLOAT64
);

INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);

-- Long strings
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (
    id INT64,
    content STRING
);

-- Unicode strings
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (
    id INT64,
    text STRING
);

INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');

-- Multiple Tables

-- Creating multiple tables
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (id INT64);
DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (id INT64);

INSERT INTO table1 VALUES (1);
INSERT INTO table2 VALUES (2);

-- End of File
