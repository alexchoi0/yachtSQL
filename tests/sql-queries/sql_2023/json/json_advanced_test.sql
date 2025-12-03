-- Json Advanced - SQL:2023
-- Description: Advanced JSON operations and nested data handling
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: json_json_advanced_test_select_001
SELECT '{"name": "Alice", "age": 30}'::JSON -> 'name' as name;

-- ->> operator: Extract text value (returns STRING)
-- Tag: json_json_advanced_test_select_002
SELECT '{"name": "Alice", "age": 30}'::JSON ->> 'name' as name;

-- Array index with -> operator
-- Tag: json_json_advanced_test_select_003
SELECT '[10, 20, 30, 40]'::JSON -> 2 as val;

-- Array index with ->> operator
-- Tag: json_json_advanced_test_select_004
SELECT '["alice", "bob", "charlie"]'::JSON ->> 1 as name;

-- Chaining -> operators for nested access
-- Tag: json_json_advanced_test_select_005
SELECT '{"user": {"profile": {"name": "Alice"}}}'::JSON
  -> 'user' -> 'profile' -> 'name' as name;

-- Nonexistent key returns NULL
-- Tag: json_json_advanced_test_select_006
SELECT '{"name": "Alice"}'::JSON -> 'missing' as val;

-- Out of bounds array access returns NULL
-- Tag: json_json_advanced_test_select_007
SELECT '[1, 2, 3]'::JSON -> 10 as val;

-- Negative array index (get from end)
-- Tag: json_json_advanced_test_select_008
SELECT '[10, 20, 30]'::JSON -> -1 as val;

-- NULL handling
-- Tag: json_json_advanced_test_select_009
SELECT NULL::JSON -> 'key' as val;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- Simple array to table
  '[{"id": 1, "name": "Alice"}, {"id": 2, "name": "Bob"}]',
  '$[*]' COLUMNS(
    id INT64 PATH '$.id',
    name STRING PATH '$.name'
  )
) as jt;
-- id | name
-- ---|------
-- 1  | Alice
-- 2  | Bob

-- Nested path extraction
  '{"users": [{"id": 1, "profile": {"age": 30}}]}',
  '$.users[*]' COLUMNS(
    id INT64 PATH '$.id',
    age INT64 PATH '$.profile.age'
  )
) as jt;

-- Ordinality (row number)
  '[{"x": 10}, {"x": 20}, {"x": 30}]',
  '$[*]' COLUMNS(
    row_num FOR ORDINALITY,
    value INT64 PATH '$.x'
  )
) as jt;
-- row_num | value
-- --------|------
-- 1       | 10
-- 2       | 20
-- 3       | 30

-- Missing values return NULL
  '[{"id": 1, "name": "Alice"}, {"id": 2}]',
  '$[*]' COLUMNS(
    id INT64 PATH '$.id',
    name STRING PATH '$.name'
  )
) as jt;

-- Default values on empty
  '[{"id": 1}, {"id": 2}]',
  '$[*]' COLUMNS(
    id INT64 PATH '$.id',
    name STRING PATH '$.name' DEFAULT 'Unknown' ON EMPTY
  )
) as jt;

-- Type coercion
  '[{"id": "123", "active": "true"}]',
  '$[*]' COLUMNS(
    id INT64 PATH '$.id',
    active BOOL PATH '$.active'
  )
) as jt;

-- Empty array
  '[]',
  '$[*]' COLUMNS(id INT64 PATH '$.id')
) as jt;

-- ---------------------------------------------------------------------------
-- JSON_ARRAYAGG: Aggregate into JSON array
-- ---------------------------------------------------------------------------

-- Simple array aggregation
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES (1, 'A', 10);
INSERT INTO items VALUES (2, 'A', 20);
INSERT INTO items VALUES (3, 'A', 30);

-- Tag: json_json_advanced_test_select_010
SELECT JSON_ARRAYAGG(value) as arr FROM items;

-- Array aggregation with ORDER BY
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (val INT64);
INSERT INTO numbers VALUES (3);
INSERT INTO numbers VALUES (1);
INSERT INTO numbers VALUES (2);

-- Tag: json_json_advanced_test_select_011
SELECT JSON_ARRAYAGG(val ORDER BY val) as arr FROM numbers;

-- Array aggregation with NULLs
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (3);

-- Tag: json_json_advanced_test_select_012
SELECT JSON_ARRAYAGG(val) as arr FROM data;

-- Grouped array aggregation
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (category STRING, amount INT64);
INSERT INTO sales VALUES ('A', 100);
INSERT INTO sales VALUES ('A', 200);
INSERT INTO sales VALUES ('B', 300);

-- Tag: json_json_advanced_test_select_013
SELECT category, JSON_ARRAYAGG(amount) as amounts
FROM sales
GROUP BY category
ORDER BY category;

-- Empty group returns NULL
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (val INT64);
-- Tag: json_json_advanced_test_select_014
SELECT JSON_ARRAYAGG(val) as arr FROM empty_table;

-- ---------------------------------------------------------------------------
-- JSON_OBJECTAGG: Aggregate into JSON object
-- ---------------------------------------------------------------------------

-- Simple object aggregation
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', 2);
INSERT INTO kv VALUES ('c', 3);

-- Tag: json_json_advanced_test_select_015
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;

-- Object aggregation with NULL value
DROP TABLE IF EXISTS kv2;
CREATE TABLE kv2 (key STRING, value INT64);
INSERT INTO kv2 VALUES ('a', 1);
INSERT INTO kv2 VALUES ('b', NULL);

-- Tag: json_json_advanced_test_select_016
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv2;

-- Empty result
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
-- Tag: json_json_advanced_test_select_017
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;

-- ---------------------------------------------------------------------------
-- JSON Type Handling and CAST
-- ---------------------------------------------------------------------------

-- Cast STRING to JSON
-- Tag: json_json_advanced_test_select_018
SELECT CAST('{"name": "Alice"}' AS JSON) as j;

-- Cast JSON to STRING
-- Tag: json_json_advanced_test_select_019
SELECT CAST('{"name": "Alice"}'::JSON AS STRING) as s;

-- JSON_TYPE function
-- Tag: json_json_advanced_test_select_020
SELECT JSON_TYPE('{"a": 1}') as t;

-- Tag: json_json_advanced_test_select_021
SELECT JSON_TYPE('[1, 2, 3]') as t;

-- Tag: json_json_advanced_test_select_022
SELECT JSON_TYPE('"hello"') as t;

-- Tag: json_json_advanced_test_select_023
SELECT JSON_TYPE('42') as t;

-- Tag: json_json_advanced_test_select_024
SELECT JSON_TYPE('true') as t;

-- Tag: json_json_advanced_test_select_025
SELECT JSON_TYPE('null') as t;

-- JSON column storage
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
INSERT INTO json_docs VALUES (1, '{"name": "Alice"}');

-- Tag: json_json_advanced_test_select_026
SELECT doc FROM json_docs WHERE id = 1;

-- ---------------------------------------------------------------------------
-- JSON Schema Validation (if supported)
-- ---------------------------------------------------------------------------

-- Simple schema validation
-- Tag: json_json_advanced_test_select_027
SELECT JSON_SCHEMA_VALID(
  '{"type": "object", "properties": {"name": {"type": "string"}}}',
  '{"name": "Alice"}'
) as valid;

-- Invalid data against schema
-- Tag: json_json_advanced_test_select_028
SELECT JSON_SCHEMA_VALID(
  '{"type": "object", "properties": {"age": {"type": "number"}}}',
  '{"age": "not a number"}'
) as valid;

-- Required fields validation
-- Tag: json_json_advanced_test_select_029
SELECT JSON_SCHEMA_VALID(
  '{"type": "object", "required": ["id", "name"]}',
  '{"id": 1}'
) as valid;

-- Array schema validation
-- Tag: json_json_advanced_test_select_030
SELECT JSON_SCHEMA_VALID(
  '{"type": "array", "items": {"type": "number"}}',
  '[1, 2, 3, 4]'
) as valid;

-- ---------------------------------------------------------------------------
-- JSONPath Advanced Filters
-- ---------------------------------------------------------------------------

-- Filter with greater than
-- Tag: json_json_advanced_test_select_031
SELECT JSON_QUERY(
  '[{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}, {"name": "Charlie", "age": 35}]',
  '$[?(@.age > 28)]'
) as filtered;

-- Filter with complex AND condition
-- Tag: json_json_advanced_test_select_032
SELECT JSON_QUERY(
  '[{"name": "Alice", "age": 30, "city": "NYC"}, {"name": "Bob", "age": 25, "city": "LA"}]',
  '$[?(@.age > 28 && @.city == "NYC")]'
) as filtered;

-- Recursive descent (find all "name" keys)
-- Tag: json_json_advanced_test_select_033
SELECT JSON_QUERY(
  '{"person": {"name": "Alice", "address": {"street": {"name": "Main St"}}}}',
  '$..name'
) as all_names;

-- Wildcard to select all array elements
-- Tag: json_json_advanced_test_select_034
SELECT JSON_QUERY(
  '[{"id": 1}, {"id": 2}, {"id": 3}]',
  '$[*].id'
) as all_ids;

-- Array slice with step
-- Tag: json_json_advanced_test_select_035
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;

-- ---------------------------------------------------------------------------
-- JSON Mutation Operations (PostgreSQL-style)
-- ---------------------------------------------------------------------------

-- JSON_SET: Create or update key
-- SELECT JSON_SET('{"a": 1}', '$.b', 2) as result;

-- JSON_SET: Update existing key
-- SELECT JSON_SET('{"a": 1, "b": 2}', '$.a', 99) as result;

-- JSON_INSERT: Only insert if key doesn't exist
-- SELECT JSON_INSERT('{"a": 1}', '$.a', 99, '$.b', 2) as result;

-- JSON_REPLACE: Only replace if key exists
-- SELECT JSON_REPLACE('{"a": 1}', '$.a', 99, '$.b', 2) as result;

-- JSON_REMOVE: Delete key from object
-- SELECT JSON_REMOVE('{"a": 1, "b": 2, "c": 3}', '$.b') as result;

-- JSON_REMOVE: Delete array element
-- SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

-- ---------------------------------------------------------------------------
-- Round-Trip Type Conversion
-- ---------------------------------------------------------------------------

-- INT64 round-trip
-- Tag: json_json_advanced_test_select_036
SELECT CAST(JSON_EXTRACT('{"val": 9223372036854775807}', '$.val') AS INT64) as val;

-- FLOAT64 precision preservation
-- Tag: json_json_advanced_test_select_037
SELECT CAST(JSON_EXTRACT('{"val": 3.141592653589793}', '$.val') AS FLOAT64) as val;

-- BOOL round-trip
-- Tag: json_json_advanced_test_select_001
SELECT
  CAST(JSON_EXTRACT('{"t": true, "f": false}', '$.t') AS BOOL) as t,
  CAST(JSON_EXTRACT('{"t": true, "f": false}', '$.f') AS BOOL) as f;

-- NULL round-trip
-- Tag: json_json_advanced_test_select_038
SELECT JSON_EXTRACT('{"val": null}', '$.val') as val;

-- String with escape sequences
-- Tag: json_json_advanced_test_select_039
SELECT JSON_EXTRACT('{"text": "Line1\nLine2\tTab\"Quote"}', '$.text') as val;

-- ---------------------------------------------------------------------------
-- Integration with Other SQL Features
-- ---------------------------------------------------------------------------

-- JSON with window functions
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
INSERT INTO metrics VALUES (1, '{"value": 10}');
INSERT INTO metrics VALUES (2, '{"value": 20}');
INSERT INTO metrics VALUES (3, '{"value": 30}');

-- Tag: json_json_advanced_test_select_002
SELECT
  id,
  JSON_VALUE(data, '$.value') as val,
  LAG(JSON_VALUE(data, '$.value')) OVER (ORDER BY id) as prev_val
FROM metrics
ORDER BY id;

-- JSON with CTE
WITH json_data AS (
-- Tag: json_json_advanced_test_select_040
  SELECT JSON_ARRAY(1, 2, 3, 4, 5) as arr
)
-- Tag: json_json_advanced_test_select_041
SELECT JSON_LENGTH(arr) as len FROM json_data;

-- JSON with UNION
-- Tag: json_json_advanced_test_select_042
SELECT JSON_OBJECT('type', 'A', 'value', 1) as data
UNION ALL
-- Tag: json_json_advanced_test_select_043
SELECT JSON_OBJECT('type', 'B', 'value', 2) as data;

-- JSON in materialized view
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);
INSERT INTO raw_data VALUES (1, '{"status": "active"}');

DROP VIEW IF EXISTS parsed_data;
CREATE VIEW parsed_data AS
-- Tag: json_json_advanced_test_select_044
SELECT id, JSON_VALUE(payload, '$.status') as status
FROM raw_data;

-- Tag: json_json_advanced_test_select_045
SELECT status FROM parsed_data WHERE id = 1;

-- ---------------------------------------------------------------------------
-- Extreme Nesting Depth
-- ---------------------------------------------------------------------------

-- 100-level nested structure (performance test)
-- Build: {"a":{"a":{"a":...}}} 100 levels deep
-- Path: $.a.a.a... (100 times)
-- SELECT JSON_EXTRACT(<100-level-json>, <100-level-path>) as val;

-- ---------------------------------------------------------------------------
-- Unicode and Character Encoding Edge Cases
-- ---------------------------------------------------------------------------

-- Emoji sequences (multi-codepoint)
-- Tag: json_json_advanced_test_select_046
SELECT JSON_EXTRACT('{"family": "👨‍👩‍👧‍👦", "wave": "👋🏽"}', '$.family') as val;

-- Right-to-left text (Hebrew, Arabic)
-- Tag: json_json_advanced_test_select_047
SELECT JSON_EXTRACT('{"hebrew": "שלום", "arabic": "مرحبا"}', '$.hebrew') as val;

-- Bidirectional text (LTR + RTL)
-- Tag: json_json_advanced_test_select_048
SELECT JSON_EXTRACT('{"mixed": "Hello שלום مرحبا"}', '$.mixed') as val;

-- Combining diacritics
-- Tag: json_json_advanced_test_select_049
SELECT JSON_EXTRACT('{"name": "José"}', '$.name') as val;

-- Null character in string
-- Tag: json_json_advanced_test_select_050
SELECT JSON_EXTRACT('{"text": "hello\u0000world"}', '$.text') as val;

-- Surrogate pairs (emoji)
-- Tag: json_json_advanced_test_select_051
SELECT JSON_EXTRACT('{"emoji": "\uD83D\uDE00"}', '$.emoji') as val;

-- Error Conditions

-- Invalid JSON in CAST
-- SELECT CAST('{invalid json}' AS JSON) as j;

-- NULL key in JSON_OBJECTAGG
-- (Insert row with NULL key, then aggregate - should error)

-- Duplicate keys in JSON_OBJECTAGG
-- (Insert rows with same key, then aggregate - should error)

-- Invalid UTF-8 in JSON

-- Malformed surrogate pairs
-- SELECT JSON_EXTRACT('{"text":"\uD800"}', '$.text') as v;

