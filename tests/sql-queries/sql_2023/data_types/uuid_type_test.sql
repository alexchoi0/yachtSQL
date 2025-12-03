-- Uuid Type - SQL:2023
-- Description: UUID data type and UUID functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: data_types_uuid_type_test_select_001
SELECT UUID '550e8400-e29b-41d4-a716-446655440000' AS id;

-- UUID as Primary Key

-- Create table with UUID primary key
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id UUID PRIMARY KEY,
    name STRING
);

-- Insert UUIDs
INSERT INTO equipment VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'Product A'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'Product B');

-- Tag: data_types_uuid_type_test_select_002
SELECT * FROM equipment ORDER BY id;

-- UUID Primary Key - Duplicate Check

-- Attempt to insert duplicate UUID (should fail)
-- INSERT INTO equipment VALUES
--     (UUID '123e4567-e89b-12d3-a456-426614174000', 'Duplicate');

-- UUID Format Validation

-- Standard UUID format: 8-4-4-4-12 hexadecimal digits
-- Valid format:
-- Tag: data_types_uuid_type_test_select_003
SELECT UUID '550e8400-e29b-41d4-a716-446655440000';

-- Invalid formats (should fail):
-- SELECT UUID '550e8400-e29b-41d4-a716';  -- Too short
-- SELECT UUID '550e8400e29b41d4a716446655440000';  -- No hyphens
-- SELECT UUID '550e8400-e29b-41d4-a716-44665544000g';  -- Invalid hex

-- UUID Generation - GEN_RANDOM_UUID()

-- Generate random UUID (Version 4)
DROP TABLE IF EXISTS test_gen_uuid;
CREATE TABLE test_gen_uuid (
    id UUID DEFAULT GEN_RANDOM_UUID(),
    name STRING
);

-- Insert without specifying UUID (generated automatically)
INSERT INTO test_gen_uuid (name) VALUES ('Auto UUID 1');
INSERT INTO test_gen_uuid (name) VALUES ('Auto UUID 2');

-- Each row should have unique UUID
-- Tag: data_types_uuid_type_test_select_004
SELECT id, name FROM test_gen_uuid;

-- UUID Comparisons - Equality

DROP TABLE IF EXISTS uuid_test;
CREATE TABLE uuid_test (
    id UUID,
    value STRING
);

INSERT INTO uuid_test VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'First'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'Second'),
    (UUID '323e4567-e89b-12d3-a456-426614174002', 'Third');

-- Equality comparison
-- Tag: data_types_uuid_type_test_select_005
SELECT * FROM uuid_test
WHERE id = UUID '223e4567-e89b-12d3-a456-426614174001';

-- Inequality
-- Tag: data_types_uuid_type_test_select_006
SELECT * FROM uuid_test
WHERE id != UUID '223e4567-e89b-12d3-a456-426614174001';

-- UUID Comparisons - Ordering

DROP TABLE IF EXISTS uuid_order;
CREATE TABLE uuid_order (
    id UUID,
    value INT64
);

INSERT INTO uuid_order VALUES
    (UUID '323e4567-e89b-12d3-a456-426614174002', 3),
    (UUID '123e4567-e89b-12d3-a456-426614174000', 1),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 2);

-- Order by UUID (lexicographic)
-- Tag: data_types_uuid_type_test_select_007
SELECT * FROM uuid_order ORDER BY id ASC;

-- UUID String Conversion - TO_STRING

DROP TABLE IF EXISTS uuid_to_string;
CREATE TABLE uuid_to_string (
    id UUID
);

INSERT INTO uuid_to_string VALUES (UUID '550e8400-e29b-41d4-a716-446655440000');

-- Convert UUID to string
-- Tag: data_types_uuid_type_test_select_008
SELECT CAST(id AS STRING) as uuid_string FROM uuid_to_string;

-- UUID String Conversion - FROM_STRING

DROP TABLE IF EXISTS uuid_from_string;
CREATE TABLE uuid_from_string (
    id UUID
);

-- Parse string to UUID
INSERT INTO uuid_from_string VALUES (CAST('550e8400-e29b-41d4-a716-446655440000' AS UUID));

-- Tag: data_types_uuid_type_test_select_009
SELECT * FROM uuid_from_string;

-- UUID NULL Handling

DROP TABLE IF EXISTS uuid_null;
CREATE TABLE uuid_null (
    id UUID,
    value STRING
);

INSERT INTO uuid_null VALUES (UUID '123e4567-e89b-12d3-a456-426614174000', 'Has UUID');
INSERT INTO uuid_null VALUES (NULL, 'No UUID');

-- IS NULL
-- Tag: data_types_uuid_type_test_select_010
SELECT * FROM uuid_null WHERE id IS NULL;

-- IS NOT NULL
-- Tag: data_types_uuid_type_test_select_011
SELECT * FROM uuid_null WHERE id IS NOT NULL;

-- UUID in Foreign Keys

-- Parent table with UUID primary key
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
    id UUID PRIMARY KEY,
    name STRING
);

-- Child table with UUID foreign key
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT64,
    owner_id UUID,
    amount INT64,
    FOREIGN KEY (owner_id) REFERENCES yacht_owners(id)
);

-- Insert customer
INSERT INTO yacht_owners VALUES
    (UUID '550e8400-e29b-41d4-a716-446655440000', 'Alice');

-- Insert order with valid owner_id
INSERT INTO orders VALUES
    (1, UUID '550e8400-e29b-41d4-a716-446655440000', 100);

-- Attempt to insert order with invalid owner_id (should fail)
-- INSERT INTO orders VALUES
--     (2, UUID '999e9999-e99b-99d9-a999-999999999999', 200);

-- UUID in Joins

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    username STRING
);

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
    session_id INT64,
    user_id UUID,
    login_time TIMESTAMP
);

INSERT INTO users VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'alice'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'bob');

INSERT INTO sessions VALUES
    (1, UUID '123e4567-e89b-12d3-a456-426614174000', TIMESTAMP '2024-01-15 10:00:00'),
    (2, UUID '123e4567-e89b-12d3-a456-426614174000', TIMESTAMP '2024-01-15 14:00:00'),
    (3, UUID '223e4567-e89b-12d3-a456-426614174001', TIMESTAMP '2024-01-15 11:00:00');

-- Join on UUID
-- Tag: data_types_uuid_type_test_select_012
SELECT u.username, s.login_time
FROM users u
JOIN sessions s ON u.user_id = s.user_id
ORDER BY u.username, s.login_time;
-- ('alice', 2024-01-15 10:00:00)
-- ('alice', 2024-01-15 14:00:00)
-- ('bob', 2024-01-15 11:00:00)

-- UUID Aggregations

DROP TABLE IF EXISTS uuid_agg;
CREATE TABLE uuid_agg (
    group_id INT64,
    item_id UUID
);

INSERT INTO uuid_agg VALUES
    (1, UUID '123e4567-e89b-12d3-a456-426614174000'),
    (1, UUID '223e4567-e89b-12d3-a456-426614174001'),
    (2, UUID '323e4567-e89b-12d3-a456-426614174002');

-- COUNT
-- Tag: data_types_uuid_type_test_select_013
SELECT group_id, COUNT(item_id) as count
FROM uuid_agg
GROUP BY group_id
ORDER BY group_id;
-- (1, 2)
-- (2, 1)

-- MIN/MAX (lexicographic order)
-- Tag: data_types_uuid_type_test_select_001
SELECT
    MIN(item_id) as min_uuid,
    MAX(item_id) as max_uuid
FROM uuid_agg;

-- UUID in IN Clause

DROP TABLE IF EXISTS uuid_in_test;
CREATE TABLE uuid_in_test (
    id UUID,
    name STRING
);

INSERT INTO uuid_in_test VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'First'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'Second'),
    (UUID '323e4567-e89b-12d3-a456-426614174002', 'Third');

-- IN clause with UUIDs
-- Tag: data_types_uuid_type_test_select_014
SELECT * FROM uuid_in_test
WHERE id IN (
    UUID '123e4567-e89b-12d3-a456-426614174000',
    UUID '323e4567-e89b-12d3-a456-426614174002'
)
ORDER BY name;

-- UUID Case Sensitivity

-- UUIDs are case-insensitive (standard format)
-- Tag: data_types_uuid_type_test_select_002
SELECT
    UUID '550e8400-e29b-41d4-a716-446655440000' =
    UUID '550E8400-E29B-41D4-A716-446655440000' as are_equal;

-- UUID Distinct

DROP TABLE IF EXISTS uuid_distinct;
CREATE TABLE uuid_distinct (
    id UUID
);

INSERT INTO uuid_distinct VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000'),
    (UUID '123e4567-e89b-12d3-a456-426614174000'),
    (UUID '223e4567-e89b-12d3-a456-426614174001');

-- SELECT DISTINCT
-- Tag: data_types_uuid_type_test_select_015
SELECT DISTINCT id FROM uuid_distinct ORDER BY id;

-- UUID Group By

DROP TABLE IF EXISTS uuid_group;
CREATE TABLE uuid_group (
    user_id UUID,
    action STRING
);

INSERT INTO uuid_group VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'login'),
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'logout'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'login');

-- GROUP BY UUID
-- Tag: data_types_uuid_type_test_select_016
SELECT user_id, COUNT(*) as action_count
FROM uuid_group
GROUP BY user_id
ORDER BY user_id;
-- (123e4567-..., 2)
-- (223e4567-..., 1)

-- UUID with Indexes

-- Create index on UUID column
DROP TABLE IF EXISTS uuid_indexed;
CREATE TABLE uuid_indexed (
    id UUID,
    data STRING
);

CREATE INDEX idx_uuid ON uuid_indexed(id);

INSERT INTO uuid_indexed VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 'Data 1'),
    (UUID '223e4567-e89b-12d3-a456-426614174001', 'Data 2');

-- Query using index
-- Tag: data_types_uuid_type_test_select_017
SELECT * FROM uuid_indexed
WHERE id = UUID '123e4567-e89b-12d3-a456-426614174000';

-- UUID Versions

-- Version 4 (random) - most common
-- Generated by GEN_RANDOM_UUID()

-- Version 1 (timestamp-based) - if supported
-- SELECT UUID_V1() as time_based_uuid;

-- Version 5 (namespace-based) - if supported
-- SELECT UUID_V5('ns:DNS', 'example.com') as namespace_uuid;

-- UUID Binary Representation

-- UUIDs can be stored as 16-byte binary for efficiency
DROP TABLE IF EXISTS uuid_binary;
CREATE TABLE uuid_binary (
    id BYTES,  -- 16 bytes for UUID
    name STRING
);

-- Convert UUID to bytes and back
-- INSERT INTO uuid_binary VALUES
--     (UUID_TO_BYTES(UUID '123e4567-e89b-12d3-a456-426614174000'), 'Test');

-- SELECT BYTES_TO_UUID(id) as uuid, name FROM uuid_binary;

-- UUID Practical Use Cases

-- Distributed system identifiers
DROP TABLE IF EXISTS distributed_records;
CREATE TABLE distributed_records (
    record_id UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    node_id INT64,
    data STRING,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- No coordination needed across nodes
INSERT INTO distributed_records (node_id, data) VALUES (1, 'Record from node 1');
INSERT INTO distributed_records (node_id, data) VALUES (2, 'Record from node 2');

-- Each record has globally unique ID
-- Tag: data_types_uuid_type_test_select_018
SELECT * FROM distributed_records;

-- End of File
