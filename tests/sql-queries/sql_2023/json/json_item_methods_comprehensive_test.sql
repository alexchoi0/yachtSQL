-- JSON Item Methods - SQL:2023 Compliance Suite
-- Description: SQL:2023 Features T865-T878 (JSON item functions) test cases
-- PostgreSQL: Pending JSON item method support
-- BigQuery: Pending JSON item method support
-- SQL Standard: SQL:2023 Features T865–T878
-- Notes: SQL:2023 core (normalize for PostgreSQL JSONB / BigQuery JSON)

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_keys_basic
-- **Baseline Case:** Extract keys from simple JSON object

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice", "age": 30, "city": "NYC"}');

-- Tag: json_json_item_methods_comprehensive_test_select_001
SELECT id, JSON_OBJECT_KEYS(obj) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_keys_empty_object
-- **Edge Case:** Empty JSON object {}

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES (1, '{}');

-- Tag: json_json_item_methods_comprehensive_test_select_002
SELECT JSON_OBJECT_KEYS(obj) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_keys_nested_objects
-- **Edge Case:** Nested objects - only returns top-level keys

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"user": {"name": "Alice"}, "active": true}');

-- Tag: json_json_item_methods_comprehensive_test_select_003
SELECT JSON_OBJECT_KEYS(obj) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_keys_null
-- **NULL Handling:** NULL JSON value

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES (1, NULL);

-- Tag: json_json_item_methods_comprehensive_test_select_004
SELECT JSON_OBJECT_KEYS(obj) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_keys_type_error
-- **Error Condition:** Input is JSON array, not object
-- NOTE: Array input should error or return NULL depending on mode.

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[1, 2, 3]');

-- Tag: json_json_item_methods_comprehensive_test_select_005
SELECT JSON_OBJECT_KEYS(arr) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_insert_new_key
-- **Baseline Case:** Insert new key-value pair into JSON object

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_006
SELECT JSON_OBJECT_INSERT(obj, '$.age', 30) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_insert_overwrite
-- **Edge Case:** Insert key that already exists
-- **Challenge:** Should overwrite or error? SQL:2023 specifies behavior

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice", "age": 30}');

-- Tag: json_json_item_methods_comprehensive_test_select_007
SELECT JSON_OBJECT_INSERT(obj, '$.age', 31) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_insert_nested_path
-- **Complex Case:** Insert into nested object path
-- **Path:** $.user.address.city
-- **Challenge:** Create intermediate objects if missing?

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"user": {"name": "Alice"}}');

-- Tag: json_json_item_methods_comprehensive_test_select_008
SELECT JSON_OBJECT_INSERT(obj, '$.user.age', 30) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_insert_invalid_path
-- **Error Condition:** Path doesn't exist and can't be created
-- **Example:** $.nonexistent.key where $.nonexistent is not an object
-- NOTE: Invalid JSON path expected to raise error.

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_009
SELECT JSON_OBJECT_INSERT(obj, '$.name.age', 30) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_insert_null_value
-- **NULL Handling:** Insert NULL as value (not the same as removing key)

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_010
SELECT JSON_OBJECT_INSERT(obj, '$.age', NULL) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_delete_existing_key
-- **Baseline Case:** Delete existing key from JSON object

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice", "age": 30, "city": "NYC"}');

-- Tag: json_json_item_methods_comprehensive_test_select_011
SELECT JSON_OBJECT_DELETE(obj, '$.age') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_delete_missing_key
-- **Edge Case:** Delete key that doesn't exist

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_012
SELECT JSON_OBJECT_DELETE(obj, '$.age') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_delete_nested_key
-- **Complex Case:** Delete nested key

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"user": {"name": "Alice", "age": 30}}');

-- Tag: json_json_item_methods_comprehensive_test_select_013
SELECT JSON_OBJECT_DELETE(obj, '$.user.age') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_object_delete_all_keys
-- **Edge Case:** Delete all keys from object

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_014
SELECT JSON_OBJECT_DELETE(obj, '$.name') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_insert_at_index_0
-- **Baseline Case:** Insert element at beginning of array (index 0)

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES
        (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_015
SELECT JSON_ARRAY_INSERT(arr, '$[0]', 5) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_insert_middle
-- **Baseline Case:** Insert element in middle of array

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_016
SELECT JSON_ARRAY_INSERT(arr, '$[1]', 15) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_insert_beyond_length
-- **Edge Case:** Insert at index > array length
-- **Challenge:** Pad with NULLs? Error? Append at end?

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20]');

-- Tag: json_json_item_methods_comprehensive_test_select_017
SELECT JSON_ARRAY_INSERT(arr, '$[10]', 100) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_insert_empty_array
-- **Edge Case:** Insert into empty array []

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[]');

-- Tag: json_json_item_methods_comprehensive_test_select_018
SELECT JSON_ARRAY_INSERT(arr, '$[0]', 42) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_insert_negative_index
-- **Edge Case:** Negative index (Python-style $[-1] = last element)
-- NOTE: Negative index should be rejected per SQL:2023.

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_019
SELECT JSON_ARRAY_INSERT(arr, '$[-1]', 25) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_delete_by_index
-- **Baseline Case:** Delete element at specific index

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30, 40]');

-- Tag: json_json_item_methods_comprehensive_test_select_020
SELECT JSON_ARRAY_DELETE(arr, '$[1]') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_delete_first
-- **Edge Case:** Delete first element (index 0)

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_021
SELECT JSON_ARRAY_DELETE(arr, '$[0]') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_delete_last
-- **Edge Case:** Delete last element

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_022
SELECT JSON_ARRAY_DELETE(arr, '$[2]') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_delete_out_of_bounds
-- **Error Condition:** Delete at index >= array length
-- NOTE: Deleting outside array bounds should error.

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20]');

-- Tag: json_json_item_methods_comprehensive_test_select_023
SELECT JSON_ARRAY_DELETE(arr, '$[10]') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_delete_single_element
-- **Edge Case:** Delete only element from array

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[42]');

-- Tag: json_json_item_methods_comprehensive_test_select_024
SELECT JSON_ARRAY_DELETE(arr, '$[0]') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_append_single_element
-- **Baseline Case:** Append element to end of array

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10, 20, 30]');

-- Tag: json_json_item_methods_comprehensive_test_select_025
SELECT JSON_ARRAY_APPEND(arr, '$', 40) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_append_empty
-- **Edge Case:** Append to empty array []

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[]');

-- Tag: json_json_item_methods_comprehensive_test_select_026
SELECT JSON_ARRAY_APPEND(arr, '$', 100) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_append_multiple
-- **Complex Case:** Append multiple values in single call (if supported)
-- **Challenge:** SQL function signature may not support variadic args

CREATE TABLE json_data (id INT64, arr JSON);

INSERT INTO json_data VALUES (1, '[10]');

-- Tag: json_json_item_methods_comprehensive_test_select_027
SELECT JSON_ARRAY_APPEND(JSON_ARRAY_APPEND(arr, '$', 20), '$', 30) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_append_nested
-- **Complex Case:** Append to nested array
-- **Path:** $.items where items is an array

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES
        (1, '{"items": [1, 2, 3]}');

-- Tag: json_json_item_methods_comprehensive_test_select_028
SELECT JSON_ARRAY_APPEND(obj, '$.items', 4) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_array_append_type_error
-- **Error Condition:** Append to JSON value that is not an array
-- NOTE: JSON_ARRAY_APPEND on non-array should fail.

CREATE TABLE json_data (id INT64, obj JSON);

INSERT INTO json_data VALUES (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_029
SELECT JSON_ARRAY_APPEND(obj, '$', 42) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_chaining
-- **Integration:** Chain multiple JSON operations
-- **Example:** Insert, then delete, then append

CREATE TABLE json_data (id INT64, doc JSON);

INSERT INTO json_data VALUES
        (1, '{"name": "Alice", "items": [1, 2]}');

-- Tag: json_json_item_methods_comprehensive_test_select_001
SELECT
            JSON_ARRAY_APPEND(
                JSON_OBJECT_DELETE(
                    JSON_OBJECT_INSERT(doc, '$.age', 30),
                    '$.name'
                ),
                '$.items',
                3
            ) AS final_doc
         FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_with_join
-- **Integration:** Use JSON item methods in JOIN context
-- **Challenge:** JSON operations + relational operations

CREATE TABLE users (id INT64, profile JSON);

INSERT INTO users VALUES
        (1, '{"name": "Alice", "tags": ["admin"]}'),
        (2, '{"name": "Bob", "tags": []}');

CREATE TABLE new_tags (user_id INT64, tag STRING);

INSERT INTO new_tags VALUES (1, 'verified'), (2, 'active');

-- Tag: json_json_item_methods_comprehensive_test_select_002
SELECT
            u.id,
            JSON_ARRAY_APPEND(u.profile, '$.tags', t.tag) AS updated_profile
         FROM users u
         JOIN new_tags t ON u.id = t.user_id
         ORDER BY u.id;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_null_input
-- **NULL Handling:** All JSON item methods with NULL JSON value

CREATE TABLE json_data (id INT64, doc JSON);

INSERT INTO json_data VALUES (1, NULL);

-- Tag: json_json_item_methods_comprehensive_test_select_003
SELECT
            JSON_OBJECT_KEYS(doc) AS keys,
            JSON_OBJECT_INSERT(doc, '$.x', 1) AS insert_result,
            JSON_OBJECT_DELETE(doc, '$.x') AS delete_result
         FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_invalid_json
-- **Error Condition:** Invalid JSON string (malformed)
-- NOTE: Invalid JSON literal should produce parse error.

CREATE TABLE json_data (id INT64, doc STRING);

INSERT INTO json_data VALUES (1, '{invalid json}');

-- Tag: json_json_item_methods_comprehensive_test_select_030
SELECT JSON_OBJECT_KEYS(CAST(doc AS JSON)) AS keys FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_empty_path
-- **Edge Case:** Empty JSONPath string ''
-- NOTE: Empty JSON path is invalid and should error.

CREATE TABLE json_data (id INT64, doc JSON);

INSERT INTO json_data VALUES (1, '{"name": "Alice"}');

-- Tag: json_json_item_methods_comprehensive_test_select_031
SELECT JSON_OBJECT_DELETE(doc, '') AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_large_document
-- **Performance Case:** Large JSON document (10KB+)
-- **Challenge:** Parsing + manipulation overhead
-- NOTE: Large JSON document (1000 keys) constructed dynamically via Rust loop.

CREATE TABLE json_data (id INT64, doc JSON);

-- Tag: json_json_item_methods_comprehensive_test_select_032
SELECT JSON_OBJECT_INSERT(doc, '$.new_key', 9999) AS updated FROM json_data;

-- ---------------------------------------------------------------------------
-- Source ID: test_json_operations_deep_nesting
-- **Performance Case:** Deeply nested JSON (50+ levels)
-- **Challenge:** Path traversal performance, stack depth
-- NOTE: Deep nesting (~50 levels) built dynamically in test harness; may fail due to depth limits.

CREATE TABLE json_data (id INT64, doc JSON);
