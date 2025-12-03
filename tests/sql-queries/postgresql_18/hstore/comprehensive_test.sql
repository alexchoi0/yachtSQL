-- PostgreSQL HSTORE Extension Comprehensive Test
-- Tests for hstore data type, operators, and functions

-- ============================================================================
-- HSTORE Constructors
-- ============================================================================

-- hstore from two arrays
SELECT hstore(ARRAY['a', 'b', 'c'], ARRAY['1', '2', '3']) as from_arrays;

-- hstore from text
SELECT 'a=>1, b=>2, c=>3'::hstore as from_text;

-- hstore with NULL values
SELECT hstore(ARRAY['a', 'b'], ARRAY['1', NULL]) as with_null;
SELECT 'a=>1, b=>NULL'::hstore as null_text;

-- Empty hstore
SELECT ''::hstore as empty;

-- hstore with quoted keys/values
SELECT '"key with spaces"=>"value with spaces"'::hstore as quoted;

-- ============================================================================
-- HSTORE Accessor Operator (->)
-- ============================================================================

-- Get single value
SELECT ('a=>1, b=>2'::hstore) -> 'a' as get_a;
SELECT ('a=>1, b=>2'::hstore) -> 'nonexistent' as get_missing;

-- Get multiple values (returns array)
SELECT ('a=>1, b=>2, c=>3'::hstore) -> ARRAY['a', 'c'] as get_multiple;

-- ============================================================================
-- HSTORE Existence Operators (?, ?&, ?|)
-- ============================================================================

-- Single key exists
SELECT ('a=>1, b=>2'::hstore) ? 'a' as exists_a;
SELECT ('a=>1, b=>2'::hstore) ? 'c' as exists_c;

-- All keys exist
SELECT ('a=>1, b=>2, c=>3'::hstore) ?& ARRAY['a', 'b'] as all_exist_true;
SELECT ('a=>1, b=>2'::hstore) ?& ARRAY['a', 'c'] as all_exist_false;

-- Any key exists
SELECT ('a=>1, b=>2'::hstore) ?| ARRAY['a', 'c'] as any_exist_true;
SELECT ('a=>1, b=>2'::hstore) ?| ARRAY['c', 'd'] as any_exist_false;

-- ============================================================================
-- HSTORE Concatenation and Deletion (||, -)
-- ============================================================================

-- Concatenate hstores
SELECT 'a=>1'::hstore || 'b=>2'::hstore as concat;

-- Overwrite with concatenation
SELECT 'a=>1'::hstore || 'a=>2'::hstore as overwrite;

-- Delete single key
SELECT ('a=>1, b=>2, c=>3'::hstore) - 'a' as delete_key;

-- Delete multiple keys
SELECT ('a=>1, b=>2, c=>3'::hstore) - ARRAY['a', 'b'] as delete_keys;

-- Delete matching pairs
SELECT ('a=>1, b=>2'::hstore) - 'a=>1'::hstore as delete_pair;

-- ============================================================================
-- HSTORE Containment (@>, <@)
-- ============================================================================

-- Contains
SELECT ('a=>1, b=>2, c=>3'::hstore) @> ('a=>1'::hstore) as contains_true;
SELECT ('a=>1, b=>2'::hstore) @> ('c=>3'::hstore) as contains_false;

-- Contained by
SELECT ('a=>1'::hstore) <@ ('a=>1, b=>2'::hstore) as contained_true;
SELECT ('a=>1, c=>3'::hstore) <@ ('a=>1, b=>2'::hstore) as contained_false;

-- ============================================================================
-- HSTORE Utility Functions
-- ============================================================================

-- Keys functions
SELECT akeys('a=>1, b=>2, c=>3'::hstore) as array_keys;
SELECT skeys('a=>1, b=>2'::hstore) as set_keys;

-- Values functions
SELECT avals('a=>1, b=>2, c=>3'::hstore) as array_vals;
SELECT svals('a=>1, b=>2'::hstore) as set_vals;

-- Each (set-returning function)
SELECT * FROM each('a=>1, b=>2'::hstore);

-- Convert to JSON
SELECT hstore_to_json('a=>1, b=>2'::hstore) as json;
SELECT hstore_to_jsonb('a=>1, b=>2'::hstore) as jsonb;

-- Convert to arrays
SELECT hstore_to_array('a=>1, b=>2'::hstore) as flat_array;
SELECT hstore_to_matrix('a=>1, b=>2'::hstore) as matrix_array;

-- Slice
SELECT slice('a=>1, b=>2, c=>3'::hstore, ARRAY['a', 'c']) as sliced;

-- Defined
SELECT defined('a=>1, b=>NULL'::hstore, 'a') as a_defined;
SELECT defined('a=>1, b=>NULL'::hstore, 'b') as b_defined;

-- Exist (function form)
SELECT exist('a=>1, b=>2'::hstore, 'a') as a_exists;

-- Delete (function form)
SELECT delete('a=>1, b=>2'::hstore, 'a') as deleted;

-- ============================================================================
-- HSTORE in Tables
-- ============================================================================

CREATE TABLE products (
    id INT PRIMARY KEY,
    name TEXT,
    attributes HSTORE
);

INSERT INTO products VALUES
    (1, 'Widget', 'color=>red, size=>large'),
    (2, 'Gadget', 'color=>blue, weight=>100g'),
    (3, 'Gizmo', 'color=>green, size=>small, material=>plastic');

-- Query with accessor
SELECT name, attributes -> 'color' as color FROM products;

-- Query with existence
SELECT name FROM products WHERE attributes ? 'size';

-- Query with containment
SELECT name FROM products WHERE attributes @> 'color=>red';

-- Update with concatenation
UPDATE products SET attributes = attributes || 'warranty=>1year' WHERE id = 1;
SELECT name, attributes FROM products WHERE id = 1;

-- ============================================================================
-- Edge Cases
-- ============================================================================

-- Unicode
SELECT '日本語=>こんにちは'::hstore -> '日本語' as unicode;

-- Empty string key and value
SELECT '""=>""'::hstore -> '' as empty_key_empty_val;

-- Special characters
SELECT '"key=>val"=>"val=>key"'::hstore -> 'key=>val' as special_chars;

-- Duplicate keys (last wins)
SELECT 'a=>1, a=>2, a=>3'::hstore -> 'a' as dup_key;

-- Very long key/value
SELECT ('longkey_' || repeat('x', 100) || '=>longval_' || repeat('y', 100))::hstore as long_kv;

DROP TABLE products;