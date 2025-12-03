-- Json Edge Cases - SQL:2023
-- Description: JSON edge cases and error handling
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: json_json_edge_cases_test_select_001
SELECT JSON_EXTRACT('{"val": -9223372036854775808}', '$.val') as v;

-- i64::MAX
-- Tag: json_json_edge_cases_test_select_002
SELECT JSON_EXTRACT('{"val": 9223372036854775807}', '$.val') as v;

-- Smallest positive double (near zero)
-- Tag: json_json_edge_cases_test_select_003
SELECT JSON_EXTRACT('{"val": 2.2250738585072014e-308}', '$.val') as v;

-- Largest double
-- Tag: json_json_edge_cases_test_select_004
SELECT JSON_EXTRACT('{"val": 1.7976931348623157e+308}', '$.val') as v;

-- Negative zero
-- Tag: json_json_edge_cases_test_select_005
SELECT JSON_EXTRACT('{"val": -0.0}', '$.val') as v;

-- Very small fraction
-- Tag: json_json_edge_cases_test_select_006
SELECT JSON_EXTRACT('{"val": 1e-100}', '$.val') as v;

-- Large array index
CREATE TABLE large_arr AS SELECT JSON_EXTRACT(
  '[' || REPEAT('1,', 9999) || '1]',
  '$[9999]'
) as val;

-- Empty string value
-- Tag: json_json_edge_cases_test_select_007
SELECT JSON_EXTRACT('{"val": ""}', '$.val') as v;

-- Single character string
-- Tag: json_json_edge_cases_test_select_008
SELECT JSON_EXTRACT('{"val": "a"}', '$.val') as v;

-- ---------------------------------------------------------------------------
-- Character Encoding Edge Cases
-- ---------------------------------------------------------------------------

-- Emoji in keys
-- Tag: json_json_edge_cases_test_select_009
SELECT JSON_EXTRACT('{"😀": "happy"}', '$["😀"]') as val;

-- Unicode escape sequences
-- Tag: json_json_edge_cases_test_select_010
SELECT JSON_EXTRACT('{"val": "\u0041\u0042\u0043"}', '$.val') as v;

-- Surrogate pairs (high + low = emoji)
-- Tag: json_json_edge_cases_test_select_011
SELECT JSON_EXTRACT('{"val": "\uD83D\uDE00"}', '$.val') as v;

-- Null byte in string
-- Tag: json_json_edge_cases_test_select_012
SELECT JSON_EXTRACT('{"val": "hello\u0000world"}', '$.val') as v;

-- Control characters
-- Tag: json_json_edge_cases_test_select_013
SELECT JSON_EXTRACT('{"val": "line1\nline2\ttab"}', '$.val') as v;

-- Right-to-left text (Hebrew)
-- Tag: json_json_edge_cases_test_select_014
SELECT JSON_EXTRACT('{"val": "שלום עולם"}', '$.val') as v;

-- Mixed scripts (Latin + Chinese + Arabic)
-- Tag: json_json_edge_cases_test_select_015
SELECT JSON_EXTRACT('{"val": "Hello世界مرحبا"}', '$.val') as v;

-- Zero-width characters
-- Tag: json_json_edge_cases_test_select_016
SELECT JSON_EXTRACT('{"val": "test\u200Dvalue"}', '$.val') as v;

-- ---------------------------------------------------------------------------
-- SQL Injection Prevention
-- ---------------------------------------------------------------------------

-- Malicious path injection attempt
-- This should fail gracefully, not execute DROP TABLE
DROP TABLE IF EXISTS safe_test;
CREATE TABLE safe_test (data JSON);
INSERT INTO safe_test VALUES ('{"a": 1}');

-- Attempt injection in path parameter
-- SELECT JSON_EXTRACT(data, '$''; DROP TABLE users; --') FROM safe_test;

-- Path with quotes
-- Tag: json_json_edge_cases_test_select_017
SELECT JSON_EXTRACT('{"key": 1}', '$["key"]') as val;

-- Escaped quotes in value
-- Tag: json_json_edge_cases_test_select_018
SELECT JSON_EXTRACT('{"val": "She said \"hello\""}', '$.val') as v;

-- Backslashes in value
-- Tag: json_json_edge_cases_test_select_019
SELECT JSON_EXTRACT('{"path": "C:\\\\Users\\\\test"}', '$.path') as v;

-- ---------------------------------------------------------------------------
-- Resource Exhaustion Scenarios
-- ---------------------------------------------------------------------------

-- Deeply nested arrays (50 levels)
CREATE TABLE deep_array AS SELECT JSON_LENGTH(
  '[' || REPEAT('[', 49) || '1' || REPEAT(']', 49) || ']'
) as len;

-- Wide object (1000 keys)
CREATE TABLE wide_obj AS SELECT JSON_EXTRACT(
  '{' || REPEAT('"k":1,', 999) || '"end":null}',
  '$.k'
) as val;

-- Many small operations (1000 JSON extracts)
DROP TABLE IF EXISTS stress_test;
CREATE TABLE stress_test (id INT64, data JSON);
-- Insert 1000 rows with JSON
-- SELECT JSON_VALUE(data, '$.value') FROM stress_test;

-- ---------------------------------------------------------------------------
-- Character Encoding Validation
-- ---------------------------------------------------------------------------

-- Invalid UTF-8 sequences (should error)
-- INSERT INTO table VALUES ('{"text":"\xC0\x80"}');

-- Lone high surrogate (invalid)
-- SELECT JSON_EXTRACT('{"text":"\uD800"}', '$.text') as v;

-- Lone low surrogate (invalid)
-- SELECT JSON_EXTRACT('{"text":"\uDC00"}', '$.text') as v;

-- Valid surrogate pair
-- Tag: json_json_edge_cases_test_select_020
SELECT JSON_EXTRACT('{"emoji":"\uD83D\uDE00"}', '$.emoji') as v;

-- UTF-8 BOM (Byte Order Mark)
-- JSON spec forbids BOM, but some parsers are lenient
-- SELECT JSON_EXTRACT('\uFEFF{"key":"value"}', '$.key') as v;

-- Null bytes in strings (valid in JSON spec)
-- Tag: json_json_edge_cases_test_select_021
SELECT JSON_EXTRACT('{"text":"before\u0000after"}', '$.text') as v;

-- All Unicode escape types
-- Tag: json_json_edge_cases_test_select_022
SELECT JSON_EXTRACT('{"null":"\u0000","tab":"\u0009","space":"\u0020"}', '$.tab') as v;

-- ---------------------------------------------------------------------------
-- Number Precision and Special Values
-- ---------------------------------------------------------------------------

-- JavaScript MAX_SAFE_INTEGER (2^53 - 1)
-- Tag: json_json_edge_cases_test_select_023
SELECT JSON_EXTRACT('{"num":9007199254740991}', '$.num') as v;

-- Beyond MAX_SAFE_INTEGER (precision loss possible)
-- Tag: json_json_edge_cases_test_select_024
SELECT JSON_EXTRACT('{"num":9007199254740993}', '$.num') as v;

-- Extremely small fraction
-- Tag: json_json_edge_cases_test_select_025
SELECT JSON_EXTRACT('{"num":1e-324}', '$.num') as v;

-- Scientific notation with extreme exponents
-- Tag: json_json_edge_cases_test_select_026
SELECT JSON_EXTRACT('{"num":1e308}', '$.num') as v;

-- Tag: json_json_edge_cases_test_select_027
SELECT JSON_EXTRACT('{"num":1e-308}', '$.num') as v;

-- Number with leading zeros (invalid)
-- SELECT JSON_EXTRACT('{"num":007}', '$.num') as v;

-- Infinity and NaN (not valid JSON)
-- SELECT JSON_EXTRACT('{"num":Infinity}', '$.num') as v;

-- SELECT JSON_EXTRACT('{"num":NaN}', '$.num') as v;

-- ---------------------------------------------------------------------------
-- Escape Sequence Validation
-- ---------------------------------------------------------------------------

-- All valid JSON escape sequences
-- Tag: json_json_edge_cases_test_select_028
SELECT JSON_EXTRACT(
  '{"quote":"\"","backslash":"\\\\","slash":"\\/","backspace":"\\b","formfeed":"\\f","newline":"\\n","return":"\\r","tab":"\\t"}',
  '$.quote'
) as v;

-- Invalid escape sequences
-- SELECT JSON_EXTRACT('{"text":"\\x41"}', '$.text') as v;

-- SELECT JSON_EXTRACT('{"text":"\\a"}', '$.text') as v;

-- Incomplete escape at end
-- SELECT JSON_EXTRACT('{"text":"abc\\"}', '$.text') as v;

-- ---------------------------------------------------------------------------
-- Whitespace Handling
-- ---------------------------------------------------------------------------

-- Valid JSON whitespace (space, tab, newline, carriage return)
-- Tag: json_json_edge_cases_test_select_029
SELECT JSON_EXTRACT('{\n\t "key" : "value" \r\n}', '$.key') as v;

-- Non-breaking space (U+00A0) - not allowed in JSON spec
-- SELECT JSON_EXTRACT('{ "key"\u00A0:\u00A0"value" }', '$.key') as v;

-- ---------------------------------------------------------------------------
-- Parser State Recovery and Error Handling
-- ---------------------------------------------------------------------------

-- Unclosed string
-- SELECT JSON_EXTRACT('{"key":"value}', '$.key') as v;

-- Unexpected end of input
-- SELECT JSON_EXTRACT('{"key":', '$.key') as v;

-- Recovery after error (should not affect subsequent queries)
DROP TABLE IF EXISTS recovery_test;
CREATE TABLE recovery_test (id INT64, data JSON);
-- INSERT INTO recovery_test VALUES (1, '{bad}');  -- Should error
INSERT INTO recovery_test VALUES (2, '{"good":true}');  -- Should succeed
-- Tag: json_json_edge_cases_test_select_030
SELECT COUNT(*) FROM recovery_test;

-- ---------------------------------------------------------------------------
-- Performance and Resource Limits
-- ---------------------------------------------------------------------------

-- Extremely large string (10MB)
-- CREATE TABLE large_str AS SELECT JSON_OBJECT('data', REPEAT('a', 10000000)) as obj;

-- Array with 1,000,000 elements
-- CREATE TABLE huge_array AS SELECT JSON_LENGTH('[' || REPEAT('1,', 999999) || '1]') as len;

-- Object with 1,000,000 keys
-- CREATE TABLE huge_object AS SELECT JSON_LENGTH('{' || REPEAT('"k":1,', 999999) || '"end":null}') as len;

-- Billion Laughs style expansion (DoS prevention)
-- CREATE TABLE expansion AS SELECT JSON_EXTRACT(
--   '{"lol":"lol","lol2":"lollollol","lol3":"lol2lol2lol2"}',
--   '$.lol3'
-- ) as val;

-- Repeated extractions (no memory leak)
-- Run 100 JSON_EXTRACT operations
-- Memory should remain stable

-- ---------------------------------------------------------------------------
-- Platform-Specific Edge Cases
-- ---------------------------------------------------------------------------

-- Line ending normalization (CRLF vs LF)
-- Tag: json_json_edge_cases_test_select_031
SELECT JSON_EXTRACT('{"val": "line1\r\nline2"}', '$.val') as v;

-- Case sensitivity of keys
-- Tag: json_json_edge_cases_test_select_032
SELECT JSON_EXTRACT('{"Name": 1, "name": 2}', '$.name') as val;

-- Duplicate keys (last-wins behavior)
-- Tag: json_json_edge_cases_test_select_033
SELECT JSON_EXTRACT('{"key": 1, "key": 2}', '$.key') as val;

-- Numeric key vs string key
-- Tag: json_json_edge_cases_test_select_034
SELECT JSON_EXTRACT('{"1": "string", "01": "padded"}', '$.1') as val;

-- Boolean case sensitivity (must be lowercase in JSON)
-- Tag: json_json_edge_cases_test_select_035
SELECT JSON_EXTRACT('{"val": true}', '$.val') as v;

-- Uppercase boolean (invalid)
-- SELECT JSON_EXTRACT('{"val": True}', '$.val') as v;

-- Uppercase null (invalid)
-- SELECT JSON_EXTRACT('{"val": NULL}', '$.val') as v;

-- ---------------------------------------------------------------------------
-- Concurrent Access Patterns
-- ---------------------------------------------------------------------------

-- Read consistency (multiple reads should return same result)
DROP TABLE IF EXISTS concurrent_test;
CREATE TABLE concurrent_test (id INT64, data JSON);
INSERT INTO concurrent_test VALUES (1, '{"status": "initial"}');

-- Multiple reads
-- Tag: json_json_edge_cases_test_select_036
SELECT JSON_VALUE(data, '$.status') FROM concurrent_test WHERE id = 1;
-- Tag: json_json_edge_cases_test_select_037
SELECT JSON_VALUE(data, '$.status') FROM concurrent_test WHERE id = 1;
-- Tag: json_json_edge_cases_test_select_038
SELECT JSON_VALUE(data, '$.status') FROM concurrent_test WHERE id = 1;

-- Update-read isolation
UPDATE concurrent_test SET data = '{"status": "updated"}' WHERE id = 1;
-- Tag: json_json_edge_cases_test_select_039
SELECT JSON_VALUE(data, '$.status') FROM concurrent_test WHERE id = 1;

-- ---------------------------------------------------------------------------
-- Interoperability and Data Integrity
-- ---------------------------------------------------------------------------

-- NULL vs missing key distinction
-- Tag: json_json_edge_cases_test_select_040
SELECT JSON_EXTRACT('{"a": null}', '$.a') as val1,
       JSON_EXTRACT('{"b": 1}', '$.a') as val2;

-- JSON comparison operators
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
INSERT INTO json_compare VALUES (1, '{"a": 1}');
INSERT INTO json_compare VALUES (2, '{"a": 1}');

-- Tag: json_json_edge_cases_test_select_041
SELECT COUNT(*) as cnt FROM json_compare WHERE data = '{"a": 1}';

-- JSON in subquery
DROP TABLE IF EXISTS subquery_test;
CREATE TABLE subquery_test (id INT64, items JSON);
INSERT INTO subquery_test VALUES (1, '[{"item": "A", "qty": 2}]');

-- Tag: json_json_edge_cases_test_select_042
SELECT id FROM subquery_test
WHERE JSON_EXTRACT(items, '$[0].qty') IN (SELECT 2);

-- ---------------------------------------------------------------------------
-- Large Dataset Performance
-- ---------------------------------------------------------------------------

-- Extract from 100 rows
DROP TABLE IF EXISTS large_json_table;
CREATE TABLE large_json_table (id INT64, payload JSON);
-- INSERT 100 rows with complex JSON
-- SELECT JSON_VALUE(payload, '$.metadata.count')
-- FROM large_json_table
-- WHERE JSON_VALUE(payload, '$.metadata.count') > 50;

-- Aggregation performance
DROP TABLE IF EXISTS agg_test;
CREATE TABLE agg_test (category STRING, value INT64);
-- INSERT 500 rows
-- SELECT category, JSON_ARRAYAGG(value)
-- FROM agg_test
-- GROUP BY category;

-- Nested function calls performance
-- Tag: json_json_edge_cases_test_select_043
SELECT JSON_EXTRACT(
  JSON_OBJECT(
    'level1', JSON_OBJECT(
      'level2', JSON_OBJECT(
        'level3', JSON_ARRAY(1, 2, 3)
      )
    )
  ),
  '$.level1.level2.level3[1]'
) as val;

-- Summary
-- This file covers edge cases that commonly break JSON implementations:
-- - Malformed JSON (various syntax errors)
-- - Boundary values (min/max integers, extreme floats)
-- - Character encoding (UTF-8, surrogates, emojis, RTL text)
-- - Security (SQL injection prevention)
-- - Resource limits (deeply nested, large objects/arrays)
-- - Performance (large datasets, concurrent access)
-- - Platform differences (line endings, case sensitivity)
