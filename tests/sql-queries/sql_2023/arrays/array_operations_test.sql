-- Array Operations - SQL:2023
-- Description: Array operations: indexing, slicing, concatenation
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: arrays_array_operations_test_select_001
SELECT ARRAY[1, 2, 3, 4, 5] as nums;

-- String array
-- Tag: arrays_array_operations_test_select_002
SELECT ARRAY['apple', 'banana', 'cherry'] as fruits;

-- Float array
-- Tag: arrays_array_operations_test_select_003
SELECT ARRAY[1.5, 2.5, 3.5] as floats;

-- Boolean array
-- Tag: arrays_array_operations_test_select_004
SELECT ARRAY[true, false, true] as bools;

-- Date array
-- Tag: arrays_array_operations_test_select_005
SELECT ARRAY[DATE '2024-01-01', DATE '2024-12-31'] as dates;

-- Empty array (typed)
-- Tag: arrays_array_operations_test_select_006
SELECT ARRAY<INT64>[] as empty_int_array;

-- Tag: arrays_array_operations_test_select_007
SELECT CAST([] AS ARRAY<STRING>) as empty_str_array;

-- Array with NULL elements
-- Tag: arrays_array_operations_test_select_008
SELECT ARRAY[1, NULL, 3, NULL, 5] as with_nulls;

-- Nested arrays
-- Tag: arrays_array_operations_test_select_009
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6]] as nested;

-- ---------------------------------------------------------------------------
-- ARRAY_LENGTH: Get array size
-- ---------------------------------------------------------------------------

-- Basic length
DROP TABLE IF EXISTS arrays;
CREATE TABLE arrays (id INT64, items ARRAY<STRING>);
INSERT INTO arrays VALUES (1, ARRAY['apple', 'banana', 'cherry']);
INSERT INTO arrays VALUES (2, ARRAY['x']);
INSERT INTO arrays VALUES (3, ARRAY<STRING>[]);

-- Tag: arrays_array_operations_test_select_010
SELECT id, ARRAY_LENGTH(items) as len FROM arrays ORDER BY id;

-- NULL array returns NULL
DROP TABLE IF EXISTS null_arrays;
CREATE TABLE null_arrays (id INT64, items ARRAY<INT64>);
INSERT INTO null_arrays VALUES (1, NULL);

-- Tag: arrays_array_operations_test_select_011
SELECT ARRAY_LENGTH(items) as len FROM null_arrays;

-- Length of different types
-- Tag: arrays_array_operations_test_select_012
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5]) as len;

-- Tag: arrays_array_operations_test_select_013
SELECT ARRAY_LENGTH(ARRAY[1.5, 2.5, 3.5]) as len;

-- Tag: arrays_array_operations_test_select_014
SELECT ARRAY_LENGTH(ARRAY[true, false, true]) as len;

-- ---------------------------------------------------------------------------
-- Array Subscript [n]: Access elements (1-based indexing)
-- ---------------------------------------------------------------------------

-- First element (index 1)
-- Tag: arrays_array_operations_test_select_015
SELECT ARRAY[10, 20, 30][1] as first;

-- Last element (index = length)
-- Tag: arrays_array_operations_test_select_016
SELECT ARRAY[1, 2, 3, 4, 5][5] as last;

-- Middle element
-- Tag: arrays_array_operations_test_select_017
SELECT ARRAY['a', 'b', 'c', 'd'][2] as middle;

-- Single element array
-- Tag: arrays_array_operations_test_select_018
SELECT ARRAY[42][1] as only;

-- Empty array access returns NULL
-- Tag: arrays_array_operations_test_select_019
SELECT ARRAY<INT64>[][1] as empty_access;

-- Negative index (access from end, -1 = last)
-- Tag: arrays_array_operations_test_select_020
SELECT ARRAY['a', 'b', 'c', 'd'][-1] as last;

-- Tag: arrays_array_operations_test_select_021
SELECT ARRAY[1, 2, 3, 4, 5][-2] as second_last;

-- Tag: arrays_array_operations_test_select_022
SELECT ARRAY[10, 20, 30][-3] as first_from_end;

-- Out of bounds returns NULL
-- Tag: arrays_array_operations_test_select_023
SELECT ARRAY[1, 2, 3][10] as out_of_bounds;

-- Tag: arrays_array_operations_test_select_024
SELECT ARRAY[1, 2, 3][-10] as negative_out_of_bounds;

-- Zero index (invalid in 1-based indexing)
-- Tag: arrays_array_operations_test_select_025
SELECT ARRAY[1, 2, 3][0] as zero_index;

-- NULL array subscript
DROP TABLE IF EXISTS subscript_test;
CREATE TABLE subscript_test (id INT64, data ARRAY<INT64>);
INSERT INTO subscript_test VALUES (1, NULL);

-- Tag: arrays_array_operations_test_select_026
SELECT data[1] as element FROM subscript_test WHERE id = 1;

-- Array with NULL elements
-- Tag: arrays_array_operations_test_select_027
SELECT ARRAY[1, NULL, 3][2] as null_element;

-- Nested array subscripting
-- Tag: arrays_array_operations_test_select_028
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6]][2] as middle_array;

-- Chained subscripting
-- Tag: arrays_array_operations_test_select_029
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6]][2][1] as nested_element;

-- Three-level nesting
-- Tag: arrays_array_operations_test_select_030
SELECT ARRAY[
  ARRAY[ARRAY[1, 2], ARRAY[3, 4]],
  ARRAY[ARRAY[5, 6], ARRAY[7, 8]]
][1][2][1] as deep;

-- Expression as index
-- Tag: arrays_array_operations_test_select_031
SELECT ARRAY[10, 20, 30, 40, 50][2 + 1] as computed;

-- Function result as index
-- Tag: arrays_array_operations_test_select_032
SELECT ARRAY[100, 200, 300, 400][CAST(2.7 AS INT64)] as func_idx;

-- ---------------------------------------------------------------------------
-- Array Slicing [start:end]: Extract subarrays
-- ---------------------------------------------------------------------------

-- Basic range [2:4] (inclusive)
-- Tag: arrays_array_operations_test_select_033
SELECT ARRAY[10, 20, 30, 40, 50][2:4] as slice;

-- First two elements
-- Tag: arrays_array_operations_test_select_034
SELECT ARRAY['a', 'b', 'c', 'd'][1:2] as first_two;

-- Last two elements
-- Tag: arrays_array_operations_test_select_035
SELECT ARRAY[1, 2, 3, 4, 5][4:5] as last_two;

-- Single element slice
-- Tag: arrays_array_operations_test_select_036
SELECT ARRAY[10, 20, 30][2:2] as single;

-- Full array slice
-- Tag: arrays_array_operations_test_select_037
SELECT ARRAY[1, 2, 3, 4][1:4] as full;

-- Open-ended slice (from start)
-- Tag: arrays_array_operations_test_select_038
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;

-- Open-ended slice (to end)
-- Tag: arrays_array_operations_test_select_039
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;

-- Full open-ended slice
-- Tag: arrays_array_operations_test_select_040
SELECT ARRAY['x', 'y', 'z'][:] as all;

-- Negative indices in slice
-- Tag: arrays_array_operations_test_select_041
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;

-- Tag: arrays_array_operations_test_select_042
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;

-- Mixed positive/negative
-- Tag: arrays_array_operations_test_select_043
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;

-- Negative open-ended (last 2 elements)
-- Tag: arrays_array_operations_test_select_044
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;

-- Empty slice (start > end)
-- Tag: arrays_array_operations_test_select_045
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;

-- Slice of empty array
-- Tag: arrays_array_operations_test_select_046
SELECT ARRAY<INT64>[][1:3] as empty_slice;

-- Out of bounds clamping
-- Tag: arrays_array_operations_test_select_047
SELECT ARRAY[1, 2, 3][1:100] as clamped;

-- Tag: arrays_array_operations_test_select_048
SELECT ARRAY[10, 20, 30][-100:2] as clamped_negative;

-- NULL array slice
DROP TABLE IF EXISTS slice_test;
CREATE TABLE slice_test (id INT64, values ARRAY<INT64>);
INSERT INTO slice_test VALUES (1, NULL);

-- Tag: arrays_array_operations_test_select_049
SELECT values[1:3] as slice FROM slice_test WHERE id = 1;

-- Slice with NULL elements preserved
-- Tag: arrays_array_operations_test_select_050
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;

-- ---------------------------------------------------------------------------
-- ARRAY_CONCAT: Concatenate arrays
-- ---------------------------------------------------------------------------

-- Basic concatenation
-- Tag: arrays_array_operations_test_select_051
SELECT ARRAY_CONCAT(ARRAY['a', 'b'], ARRAY['c', 'd']) as result;

-- Multiple arrays
-- Tag: arrays_array_operations_test_select_052
SELECT ARRAY_CONCAT(ARRAY[1], ARRAY[2, 3], ARRAY[4, 5, 6]) as result;

-- Concatenate empty arrays
-- Tag: arrays_array_operations_test_select_053
SELECT ARRAY_CONCAT(
  CAST([] AS ARRAY<INT64>),
  CAST([] AS ARRAY<INT64>)
) as result;

-- Non-empty + empty
-- Tag: arrays_array_operations_test_select_054
SELECT ARRAY_CONCAT(ARRAY[1, 2], CAST([] AS ARRAY<INT64>)) as result;

-- Concatenate with NULL array
-- Tag: arrays_array_operations_test_select_055
SELECT ARRAY_CONCAT(ARRAY[1, 2], NULL) as result;

-- ---------------------------------------------------------------------------
-- ARRAY_APPEND / ARRAY_PREPEND: Add elements
-- ---------------------------------------------------------------------------

-- Append element to end
-- Tag: arrays_array_operations_test_select_056
SELECT ARRAY_APPEND(ARRAY[1, 2, 3], 4) as result;

-- Prepend element to beginning
-- Tag: arrays_array_operations_test_select_057
SELECT ARRAY_PREPEND(0, ARRAY[1, 2, 3]) as result;

-- Append to empty array
-- Tag: arrays_array_operations_test_select_058
SELECT ARRAY_APPEND(CAST([] AS ARRAY<STRING>), 'first') as result;

-- Append NULL element
-- Tag: arrays_array_operations_test_select_059
SELECT ARRAY_APPEND(ARRAY[1, 2], NULL) as result;

-- ---------------------------------------------------------------------------
-- ARRAY_POSITION: Find element index (1-based)
-- ---------------------------------------------------------------------------

-- Find first occurrence
-- Tag: arrays_array_operations_test_select_060
SELECT ARRAY_POSITION(ARRAY['a', 'b', 'c', 'b'], 'b') as pos;

-- Element not found
-- Tag: arrays_array_operations_test_select_061
SELECT ARRAY_POSITION(ARRAY[1, 2, 3], 99) as pos;

-- ---------------------------------------------------------------------------
-- ARRAY_REMOVE: Remove all occurrences
-- ---------------------------------------------------------------------------

-- Remove all occurrences
-- Tag: arrays_array_operations_test_select_062
SELECT ARRAY_REMOVE(ARRAY[1, 2, 3, 2, 4], 2) as result;

-- Remove value not in array
-- Tag: arrays_array_operations_test_select_063
SELECT ARRAY_REMOVE(ARRAY[1, 2, 3], 99) as result;

-- Remove all elements
-- Tag: arrays_array_operations_test_select_064
SELECT ARRAY_REMOVE(ARRAY[5, 5, 5], 5) as result;

-- ---------------------------------------------------------------------------
-- ARRAY_REPLACE: Replace all occurrences
-- ---------------------------------------------------------------------------

-- Replace all occurrences
-- Tag: arrays_array_operations_test_select_065
SELECT ARRAY_REPLACE(ARRAY['a', 'b', 'a', 'c'], 'a', 'x') as result;

-- Replace value not found
-- Tag: arrays_array_operations_test_select_066
SELECT ARRAY_REPLACE(ARRAY[1, 2, 3], 99, 100) as result;

-- ---------------------------------------------------------------------------
-- ARRAY_CONTAINS: Check membership
-- ---------------------------------------------------------------------------

-- Value exists
-- Tag: arrays_array_operations_test_select_067
SELECT ARRAY_CONTAINS(ARRAY[1, 2, 3], 2) as found;

-- Value not found
-- Tag: arrays_array_operations_test_select_068
SELECT ARRAY_CONTAINS(ARRAY[1, 2, 3], 99) as found;

-- ---------------------------------------------------------------------------
-- ARRAY_DISTINCT: Remove duplicates
-- ---------------------------------------------------------------------------

-- Remove duplicates
-- Tag: arrays_array_operations_test_select_069
SELECT ARRAY_DISTINCT(ARRAY[1, 2, 2, 3, 1, 4]) as result;

-- ---------------------------------------------------------------------------
-- ARRAY_REVERSE: Reverse array
-- ---------------------------------------------------------------------------

-- Reverse array
-- Tag: arrays_array_operations_test_select_070
SELECT ARRAY_REVERSE(ARRAY[1, 2, 3, 4, 5]) as result;

-- ---------------------------------------------------------------------------
-- UNNEST: Convert array to rows
-- ---------------------------------------------------------------------------

-- Basic UNNEST
-- Tag: arrays_array_operations_test_select_071
SELECT * FROM UNNEST(ARRAY[1, 2, 3, 4, 5]) as num;

-- UNNEST with alias
-- Tag: arrays_array_operations_test_select_072
SELECT num FROM UNNEST(ARRAY[10, 20, 30]) as num;

-- UNNEST with NULL elements
-- Tag: arrays_array_operations_test_select_073
SELECT * FROM UNNEST(ARRAY[1, NULL, 3]) as val;

-- UNNEST empty array
-- Tag: arrays_array_operations_test_select_074
SELECT * FROM UNNEST(CAST([] AS ARRAY<INT64>)) as val;

-- ---------------------------------------------------------------------------
-- Integration: Arrays in WHERE, SELECT, JOIN
-- ---------------------------------------------------------------------------

-- Use array subscript in WHERE
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64, tags ARRAY<STRING>);
INSERT INTO equipment VALUES (1, ARRAY['new', 'sale', 'featured']);
INSERT INTO equipment VALUES (2, ARRAY['old', 'clearance']);

-- Tag: arrays_array_operations_test_select_075
SELECT id FROM equipment WHERE tags[1] = 'new';

-- Compare array elements in WHERE
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (player STRING, rounds ARRAY<INT64>);
INSERT INTO scores VALUES ('Alice', ARRAY[10, 20, 30]);
INSERT INTO scores VALUES ('Bob', ARRAY[15, 25, 35]);

-- Tag: arrays_array_operations_test_select_076
SELECT player FROM scores WHERE rounds[2] > 22;

-- NULL-safe array WHERE
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, data ARRAY<INT64>);
INSERT INTO items VALUES (1, ARRAY[1, 2, 3]);
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, ARRAY[4, 5, 6]);

-- Tag: arrays_array_operations_test_select_077
SELECT id FROM items WHERE data[1] IS NOT NULL ORDER BY id;

-- Array in JOIN condition
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, item_ids ARRAY<INT64>);
DROP TABLE IF EXISTS catalog;
CREATE TABLE catalog (item_id INT64, name STRING);
INSERT INTO orders VALUES (1, ARRAY[101, 102, 103]);
INSERT INTO catalog VALUES (101, 'Widget');

-- Tag: arrays_array_operations_test_select_078
SELECT o.id, c.name
FROM orders o
JOIN catalog c ON c.item_id = o.item_ids[1];

-- Array slicing in WHERE
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);

-- Tag: arrays_array_operations_test_select_079
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;

-- Nested array subscripting in SELECT
-- Tag: arrays_array_operations_test_select_080
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4]][2][1] as val;

-- Slice with array functions
-- Tag: arrays_array_operations_test_select_081
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;

-- Tag: arrays_array_operations_test_select_082
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;

-- ---------------------------------------------------------------------------
-- Performance Tests
-- ---------------------------------------------------------------------------

-- Large array length (10,000 elements)
-- SELECT ARRAY_LENGTH(ARRAY[generate series or repeat pattern]) as len;

-- Access large array element
-- SELECT large_array[5000] as middle_element;

-- Slice large array
-- SELECT large_array[1000:2000] as slice;

-- Error Conditions

-- Float as index (should error)
-- SELECT ARRAY[1, 2, 3][1.5] as bad_index;

-- String as index (should error)
-- SELECT ARRAY[1, 2, 3]['invalid'] as bad_index;

-- Subscript non-array (should error)
-- SELECT 42[1] as not_array;

-- Type mismatch in ARRAY_CONCAT
-- SELECT ARRAY_CONCAT(ARRAY[1, 2], ARRAY['a', 'b']) as mismatched;

-- Summary
-- This file covers standard SQL array operations:
-- - ARRAY construction and literals
-- - ARRAY_LENGTH for size
-- - Subscripting [n] for element access (1-based, negative indices)
-- - Slicing [start:end] for subarray extraction
-- - ARRAY_CONCAT for combining arrays
-- - ARRAY_APPEND/PREPEND for adding elements
-- - ARRAY_POSITION for finding elements
-- - ARRAY_REMOVE/REPLACE for modifications
-- - ARRAY_CONTAINS for membership testing
-- - UNNEST for converting to rows
