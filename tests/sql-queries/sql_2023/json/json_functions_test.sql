-- Json Functions - SQL:2023
-- Description: JSON extraction and manipulation functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: json_json_functions_test_select_001
SELECT JSON_EXTRACT('{"name": "Alice", "age": 30}', '$.name') as name;

-- Nested field extraction
-- Tag: json_json_functions_test_select_002
SELECT JSON_EXTRACT('{"user": {"name": "Bob", "age": 25}}', '$.user.name') as name;

-- Array element access
-- Tag: json_json_functions_test_select_003
SELECT JSON_EXTRACT('[10, 20, 30, 40]', '$[1]') as val;

-- Array in object
-- Tag: json_json_functions_test_select_004
SELECT JSON_EXTRACT('{"scores": [85, 92, 78]}', '$.scores[1]') as score;

-- Deep nesting
-- Tag: json_json_functions_test_select_005
SELECT JSON_EXTRACT('{"a": {"b": {"c": {"d": 42}}}}', '$.a.b.c.d') as val;

-- Nonexistent path returns NULL
-- Tag: json_json_functions_test_select_006
SELECT JSON_EXTRACT('{"name": "Alice"}', '$.missing') as val;

-- NULL JSON input
-- Tag: json_json_functions_test_select_007
SELECT JSON_EXTRACT(NULL, '$.name') as val;

-- NULL path
-- Tag: json_json_functions_test_select_008
SELECT JSON_EXTRACT('{"name": "Alice"}', NULL) as val;

-- Unicode characters
-- Tag: json_json_functions_test_select_009
SELECT JSON_EXTRACT('{"emoji": "😀🎉", "chinese": "你好"}', '$.emoji') as val;

-- Escaped characters
-- Tag: json_json_functions_test_select_010
SELECT JSON_EXTRACT('{"path": "C:\\Users\\Alice"}', '$.path') as val;

-- Large numbers
-- Tag: json_json_functions_test_select_011
SELECT JSON_EXTRACT('{"bignum": 9223372036854775807}', '$.bignum') as val;

-- Floating point precision
-- Tag: json_json_functions_test_select_012
SELECT JSON_EXTRACT('{"pi": 3.141592653589793}', '$.pi') as val;

-- Deeply nested structure (10 levels)
-- Tag: json_json_functions_test_select_013
SELECT JSON_EXTRACT(
  '{"l1": {"l2": {"l3": {"l4": {"l5": {"l6": {"l7": {"l8": {"l9": {"l10": "deep"}}}}}}}}}}',
  '$.l1.l2.l3.l4.l5.l6.l7.l8.l9.l10'
) as val;

-- Empty string key
-- Tag: json_json_functions_test_select_014
SELECT JSON_EXTRACT('{"": "empty key"}', '$.') as val;

-- Special characters in key (use bracket notation)
-- Tag: json_json_functions_test_select_015
SELECT JSON_EXTRACT('{"key.with.dots": "value"}', '$["key.with.dots"]') as val;

-- ---------------------------------------------------------------------------
-- JSON_VALUE: Extract scalar values (returns text, not JSON)
-- ---------------------------------------------------------------------------

-- Extract string value
-- Tag: json_json_functions_test_select_016
SELECT JSON_VALUE('{"name": "Alice"}', '$.name') as val;

-- Extract number
-- Tag: json_json_functions_test_select_017
SELECT JSON_VALUE('{"age": 30}', '$.age') as val;

-- Extract boolean
-- Tag: json_json_functions_test_select_018
SELECT JSON_VALUE('{"active": true}', '$.active') as val;

-- Extract null
-- Tag: json_json_functions_test_select_019
SELECT JSON_VALUE('{"value": null}', '$.value') as val;

-- ---------------------------------------------------------------------------
-- JSON_OBJECT: Construct JSON objects
-- ---------------------------------------------------------------------------

-- Simple object construction
-- Tag: json_json_functions_test_select_020
SELECT JSON_OBJECT('name', 'Alice', 'age', 30) as obj;

-- Empty object
-- Tag: json_json_functions_test_select_021
SELECT JSON_OBJECT() as obj;

-- Object with NULL value
-- Tag: json_json_functions_test_select_022
SELECT JSON_OBJECT('name', 'Alice', 'email', NULL) as obj;

-- Nested object
-- Tag: json_json_functions_test_select_023
SELECT JSON_OBJECT('user', JSON_OBJECT('name', 'Bob', 'age', 25)) as obj;

-- ---------------------------------------------------------------------------
-- JSON_ARRAY: Construct JSON arrays
-- ---------------------------------------------------------------------------

-- Simple array
-- Tag: json_json_functions_test_select_024
SELECT JSON_ARRAY(1, 2, 3, 4, 5) as arr;

-- Empty array
-- Tag: json_json_functions_test_select_025
SELECT JSON_ARRAY() as arr;

-- Mixed types
-- Tag: json_json_functions_test_select_026
SELECT JSON_ARRAY('hello', 42, 3.14, TRUE, NULL) as arr;

-- Nested arrays
-- Tag: json_json_functions_test_select_027
SELECT JSON_ARRAY(JSON_ARRAY(1, 2), JSON_ARRAY(3, 4)) as arr;

-- Array with objects
-- Tag: json_json_functions_test_select_028
SELECT JSON_ARRAY(JSON_OBJECT('id', 1), JSON_OBJECT('id', 2)) as arr;

-- ---------------------------------------------------------------------------
-- JSON_QUERY: Query with complex paths (advanced filtering)
-- ---------------------------------------------------------------------------

-- Get all array elements
-- Tag: json_json_functions_test_select_029
SELECT JSON_QUERY('[1, 2, 3, 4]', '$[*]') as vals;

-- Filter expression (JSONPath)
-- Tag: json_json_functions_test_select_030
SELECT JSON_QUERY(
  '[{"age": 25}, {"age": 35}, {"age": 20}]',
  '$[?(@.age > 22)]'
) as filtered;

-- Recursive descent (find all matching keys at any depth)
-- Tag: json_json_functions_test_select_031
SELECT JSON_QUERY('{"a": {"b": 1}, "c": {"b": 2}}', '$..b') as vals;

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- Simple value check

-- Value not found

-- Check in object field
  '{"name": "Alice", "age": 30}',
  '"Alice"',
  '$.name'
) as contains;

-- Nested array containment

-- ---------------------------------------------------------------------------
-- JSON_KEYS: Get object keys
-- ---------------------------------------------------------------------------

-- Simple object keys
-- Tag: json_json_functions_test_select_032
SELECT JSON_KEYS('{"name": "Alice", "age": 30, "city": "NYC"}') as keys;

-- Keys from nested object
-- Tag: json_json_functions_test_select_033
SELECT JSON_KEYS(
  '{"user": {"name": "Bob", "age": 25}}',
  '$.user'
) as keys;

-- Empty object
-- Tag: json_json_functions_test_select_034
SELECT JSON_KEYS('{}') as keys;

-- ---------------------------------------------------------------------------
-- JSON_LENGTH: Get array/object size
-- ---------------------------------------------------------------------------

-- Array length
-- Tag: json_json_functions_test_select_035
SELECT JSON_LENGTH('[1, 2, 3, 4, 5]') as len;

-- Object length (number of keys)
-- Tag: json_json_functions_test_select_036
SELECT JSON_LENGTH('{"a": 1, "b": 2, "c": 3}') as len;

-- Empty array
-- Tag: json_json_functions_test_select_037
SELECT JSON_LENGTH('[]') as len;

-- Nested path length
-- Tag: json_json_functions_test_select_038
SELECT JSON_LENGTH('{"items": [1, 2, 3, 4]}', '$.items') as len;

-- Scalar value
-- Tag: json_json_functions_test_select_039
SELECT JSON_LENGTH('"hello"') as len;

-- NULL input
-- Tag: json_json_functions_test_select_040
SELECT JSON_LENGTH(NULL) as len;

-- ---------------------------------------------------------------------------
-- Integration: JSON in WHERE, SELECT, JOIN
-- ---------------------------------------------------------------------------

-- Use JSON_EXTRACT in WHERE clause
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, data STRING);
INSERT INTO users VALUES (1, '{"name": "Alice", "age": 30}');
INSERT INTO users VALUES (2, '{"name": "Bob", "age": 25}');
INSERT INTO users VALUES (3, '{"name": "Charlie", "age": 35}');

-- Tag: json_json_functions_test_select_041
SELECT id FROM users
WHERE JSON_VALUE(data, '$.age') > 28
ORDER BY id;

-- Construct JSON from table columns
DROP TABLE IF EXISTS people;
CREATE TABLE people (name STRING, age INT64);
INSERT INTO people VALUES ('Alice', 30);

-- Tag: json_json_functions_test_select_042
SELECT JSON_OBJECT('person_name', name, 'person_age', age) as json
FROM people;

-- JSON_ARRAYAGG: Aggregate values into JSON array
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (student STRING, score INT64);
INSERT INTO scores VALUES ('Alice', 85);
INSERT INTO scores VALUES ('Alice', 92);
INSERT INTO scores VALUES ('Alice', 78);

-- Tag: json_json_functions_test_select_043
SELECT student, JSON_ARRAYAGG(score) as all_scores
FROM scores
GROUP BY student;

-- JSON in JOIN condition
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data STRING);
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (user_id INT64, name STRING);
INSERT INTO orders VALUES (1, '{"user_id": 100, "amount": 50}');
INSERT INTO yacht_owners VALUES (100, 'Alice');

-- Tag: json_json_functions_test_select_044
SELECT o.id, c.name
FROM orders o
JOIN yacht_owners c ON JSON_VALUE(o.data, '$.user_id') = c.user_id;

-- Nested JSON function calls
-- Tag: json_json_functions_test_select_045
SELECT JSON_EXTRACT(
  JSON_OBJECT('data', JSON_ARRAY(1, 2, 3)),
  '$.data[1]'
) as val;

-- ---------------------------------------------------------------------------
-- Performance Tests
-- ---------------------------------------------------------------------------

-- Large array length
-- Tag: json_json_functions_test_select_046
SELECT JSON_LENGTH('[' || REPEAT('1,', 9999) || '1]') as len;

-- Large object
-- Tag: json_json_functions_test_select_047
SELECT JSON_LENGTH(
  '{' || REPEAT('"key":1,', 999) || '"end":null}'
) as len;

-- Error Conditions (should fail)

-- Malformed JSON
-- SELECT JSON_EXTRACT('{invalid json}', '$.name') as val;

-- Invalid JSONPath
-- SELECT JSON_EXTRACT('{"a": 1}', 'invalid path') as val;

-- JSON_VALUE on non-scalar (should error)
-- SELECT JSON_VALUE('{"obj": {"a": 1}}', '$.obj') as val;

-- JSON_OBJECT with odd number of arguments
-- SELECT JSON_OBJECT('name', 'Alice', 'orphan') as obj;

-- JSON_OBJECT with NULL key
-- SELECT JSON_OBJECT(NULL, 'value') as obj;

-- JSON_OBJECT with non-string key
-- SELECT JSON_OBJECT(123, 'value') as obj;

-- JSON_KEYS on array (should error)
-- SELECT JSON_KEYS('[1, 2, 3]') as keys;
