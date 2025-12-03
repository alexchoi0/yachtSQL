-- String Types - SQL:2023
-- Description: String data types: VARCHAR, CHAR, TEXT
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS texts;
CREATE TABLE texts (
    id INT64,
    content STRING
);

INSERT INTO texts VALUES (1, 'Hello World');
INSERT INTO texts VALUES (2, '');  -- Empty string
INSERT INTO texts VALUES (3, 'Special chars: @#$%');

-- Tag: data_types_string_types_test_select_001
SELECT * FROM texts;

-- VARCHAR Type (Variable Character)

-- VARCHAR with length specification
DROP TABLE IF EXISTS varchar_test;
CREATE TABLE varchar_test (
    id INT64,
    name VARCHAR(50)
);

INSERT INTO varchar_test VALUES (1, 'Short name');
INSERT INTO varchar_test VALUES (2, 'A very long name that fits within 50 characters');

-- Tag: data_types_string_types_test_select_002
SELECT * FROM varchar_test;

-- TEXT Type (Large Text)

-- TEXT for large strings (no length limit)
DROP TABLE IF EXISTS documents;
CREATE TABLE documents (
    id INT64,
    content TEXT
);

INSERT INTO documents VALUES (1, 'This is a large document with lots of text...');

-- Tag: data_types_string_types_test_select_003
SELECT * FROM documents;

-- CHAR Type (Fixed Length)

-- CHAR(n) - fixed length, padded with spaces
DROP TABLE IF EXISTS fixed_length;
CREATE TABLE fixed_length (
    id INT64,
    code CHAR(5)
);

INSERT INTO fixed_length VALUES (1, 'ABC');   -- Stored as 'ABC  ' (padded)
INSERT INTO fixed_length VALUES (2, 'ABCDE'); -- Stored as 'ABCDE'

-- Tag: data_types_string_types_test_select_004
SELECT * FROM fixed_length;

-- Unicode Strings

-- Full Unicode support
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (
    id INT64,
    text STRING
);

-- Various Unicode characters
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');      -- Chinese
INSERT INTO unicode_texts VALUES (2, 'Привет мир');     -- Russian
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');          -- Emojis
INSERT INTO unicode_texts VALUES (4, 'Héllo Wörld');   -- Accented

-- Tag: data_types_string_types_test_select_005
SELECT * FROM unicode_texts;

-- Long Strings

-- Very long strings (stress test)
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (
    id INT64,
    content STRING
);

-- Insert 10,000 character string
-- INSERT INTO long_texts VALUES (1, REPEAT('A', 10000));

-- Tag: data_types_string_types_test_select_006
SELECT LENGTH(content) FROM long_texts WHERE id = 1;

-- String Concatenation

-- CONCAT function
DROP TABLE IF EXISTS names;
CREATE TABLE names (
    first STRING,
    last STRING
);

INSERT INTO names VALUES ('John', 'Doe');

-- Tag: data_types_string_types_test_select_007
SELECT CONCAT(first, ' ', last) as full_name FROM names;

-- String Functions - TRIM

DROP TABLE IF EXISTS test_trim;
CREATE TABLE test_trim (
    id INT64,
    value STRING
);

INSERT INTO test_trim VALUES (1, '  hello  ');
INSERT INTO test_trim VALUES (2, 'world');
INSERT INTO test_trim VALUES (3, '  spaces  ');

-- TRIM - remove leading and trailing spaces
-- Tag: data_types_string_types_test_select_008
SELECT id, TRIM(value) as trimmed FROM test_trim ORDER BY id;
-- (1, 'hello')
-- (2, 'world')
-- (3, 'spaces')

-- String Functions - LTRIM

DROP TABLE IF EXISTS test_ltrim;
CREATE TABLE test_ltrim (
    id INT64,
    value STRING
);

INSERT INTO test_ltrim VALUES (1, '  left  ');
INSERT INTO test_ltrim VALUES (2, 'middle');

-- LTRIM - remove leading spaces only
-- Tag: data_types_string_types_test_select_009
SELECT id, LTRIM(value) as trimmed FROM test_ltrim ORDER BY id;
-- (1, 'left  ')
-- (2, 'middle')

-- String Functions - RTRIM

DROP TABLE IF EXISTS test_rtrim;
CREATE TABLE test_rtrim (
    id INT64,
    value STRING
);

INSERT INTO test_rtrim VALUES (1, '  right  ');
INSERT INTO test_rtrim VALUES (2, 'center');

-- RTRIM - remove trailing spaces only
-- Tag: data_types_string_types_test_select_010
SELECT id, RTRIM(value) as trimmed FROM test_rtrim ORDER BY id;
-- (1, '  right')
-- (2, 'center')

-- String Functions - REPLACE

DROP TABLE IF EXISTS test_replace;
CREATE TABLE test_replace (
    id INT64,
    value STRING
);

INSERT INTO test_replace VALUES (1, 'hello world');
INSERT INTO test_replace VALUES (2, 'foo bar foo');
INSERT INTO test_replace VALUES (3, 'no match here');

-- Tag: data_types_string_types_test_select_011
SELECT id, REPLACE(value, 'foo', 'baz') as replaced
FROM test_replace
ORDER BY id;
-- (1, 'hello world')
-- (2, 'baz bar baz')
-- (3, 'no match here')

-- String Functions - UPPER/LOWER

DROP TABLE IF EXISTS test_case;
CREATE TABLE test_case (
    text STRING
);

INSERT INTO test_case VALUES ('Hello World');

-- Convert to uppercase
-- Tag: data_types_string_types_test_select_012
SELECT UPPER(text) FROM test_case;

-- Convert to lowercase
-- Tag: data_types_string_types_test_select_013
SELECT LOWER(text) FROM test_case;

-- String Functions - SUBSTRING

DROP TABLE IF EXISTS test_substring;
CREATE TABLE test_substring (
    text STRING
);

INSERT INTO test_substring VALUES ('Hello World');

-- Extract substring (position, length)
-- Tag: data_types_string_types_test_select_014
SELECT SUBSTRING(text, 1, 5) FROM test_substring;

-- Tag: data_types_string_types_test_select_015
SELECT SUBSTRING(text, 7) FROM test_substring;

-- String Functions - LENGTH

DROP TABLE IF EXISTS test_length;
CREATE TABLE test_length (
    text STRING
);

INSERT INTO test_length VALUES ('Hello');
INSERT INTO test_length VALUES ('');
INSERT INTO test_length VALUES ('世界');

-- Tag: data_types_string_types_test_select_016
SELECT text, LENGTH(text) as len FROM test_length;
-- ('Hello', 5)
-- ('', 0)
-- ('世界', 2) -- character length, not byte length

-- String Functions - STARTS_WITH

DROP TABLE IF EXISTS test_starts_with;
CREATE TABLE test_starts_with (
    id INT64,
    value STRING
);

INSERT INTO test_starts_with VALUES (1, 'hello world');
INSERT INTO test_starts_with VALUES (2, 'goodbye world');
INSERT INTO test_starts_with VALUES (3, 'hello universe');

-- Filter rows starting with 'hello'
-- Tag: data_types_string_types_test_select_017
SELECT id FROM test_starts_with
WHERE STARTS_WITH(value, 'hello')
ORDER BY id;

-- String Functions - ENDS_WITH

DROP TABLE IF EXISTS test_ends_with;
CREATE TABLE test_ends_with (
    id INT64,
    value STRING
);

INSERT INTO test_ends_with VALUES (1, 'hello world');
INSERT INTO test_ends_with VALUES (2, 'hello universe');
INSERT INTO test_ends_with VALUES (3, 'goodbye world');

-- Filter rows ending with 'world'
-- Tag: data_types_string_types_test_select_018
SELECT id FROM test_ends_with
WHERE ENDS_WITH(value, 'world')
ORDER BY id;

-- String Comparison

DROP TABLE IF EXISTS test_comparison;
CREATE TABLE test_comparison (
    text STRING
);

INSERT INTO test_comparison VALUES ('apple');
INSERT INTO test_comparison VALUES ('banana');
INSERT INTO test_comparison VALUES ('cherry');

-- Equality
-- Tag: data_types_string_types_test_select_019
SELECT * FROM test_comparison WHERE text = 'banana';

-- Lexicographic comparison
-- Tag: data_types_string_types_test_select_020
SELECT * FROM test_comparison WHERE text > 'banana' ORDER BY text;

-- Tag: data_types_string_types_test_select_021
SELECT * FROM test_comparison WHERE text < 'banana' ORDER BY text;

-- String LIKE Pattern Matching

DROP TABLE IF EXISTS test_like;
CREATE TABLE test_like (
    name STRING
);

INSERT INTO test_like VALUES ('Alice');
INSERT INTO test_like VALUES ('Bob');
INSERT INTO test_like VALUES ('Alicia');
INSERT INTO test_like VALUES ('Albert');

-- LIKE with wildcard %
-- Tag: data_types_string_types_test_select_022
SELECT * FROM test_like WHERE name LIKE 'Al%';

-- LIKE with wildcard _
-- Tag: data_types_string_types_test_select_023
SELECT * FROM test_like WHERE name LIKE 'A___e';

-- String NULL Handling

DROP TABLE IF EXISTS test_null;
CREATE TABLE test_null (
    id INT64,
    text STRING
);

INSERT INTO test_null VALUES (1, 'text');
INSERT INTO test_null VALUES (2, NULL);
INSERT INTO test_null VALUES (3, '');

-- IS NULL
-- Tag: data_types_string_types_test_select_024
SELECT id FROM test_null WHERE text IS NULL;

-- IS NOT NULL
-- Tag: data_types_string_types_test_select_025
SELECT id FROM test_null WHERE text IS NOT NULL;

-- Empty string is not NULL
-- Tag: data_types_string_types_test_select_026
SELECT id FROM test_null WHERE text = '';

-- String Concatenation with NULL

DROP TABLE IF EXISTS test_concat_null;
CREATE TABLE test_concat_null (
    a STRING,
    b STRING
);

INSERT INTO test_concat_null VALUES ('hello', 'world');
INSERT INTO test_concat_null VALUES ('hello', NULL);
INSERT INTO test_concat_null VALUES (NULL, 'world');

-- Tag: data_types_string_types_test_select_027
SELECT CONCAT(a, ' ', b) FROM test_concat_null;
-- Row 1: 'hello world'
-- Row 2: NULL (any NULL operand makes result NULL)
-- Row 3: NULL

-- String Collation

-- Case-sensitive comparison (default)
DROP TABLE IF EXISTS test_collation;
CREATE TABLE test_collation (
    text STRING
);

INSERT INTO test_collation VALUES ('Apple');
INSERT INTO test_collation VALUES ('apple');
INSERT INTO test_collation VALUES ('APPLE');

-- Case-sensitive equality
-- Tag: data_types_string_types_test_select_028
SELECT * FROM test_collation WHERE text = 'apple';

-- Case-insensitive LIKE
-- Tag: data_types_string_types_test_select_029
SELECT * FROM test_collation WHERE LOWER(text) = 'apple';

-- String Escape Sequences

DROP TABLE IF EXISTS test_escape;
CREATE TABLE test_escape (
    text STRING
);

-- Single quotes escaped with double single quotes
INSERT INTO test_escape VALUES ('It''s a string');

-- Backslash escapes (if supported)
INSERT INTO test_escape VALUES ('Line 1\nLine 2');
INSERT INTO test_escape VALUES ('Tab\there');

-- Tag: data_types_string_types_test_select_030
SELECT * FROM test_escape;

-- Empty String vs NULL

DROP TABLE IF EXISTS test_empty_vs_null;
CREATE TABLE test_empty_vs_null (
    text STRING
);

INSERT INTO test_empty_vs_null VALUES ('');
INSERT INTO test_empty_vs_null VALUES (NULL);

-- Empty string has length 0
-- Tag: data_types_string_types_test_select_031
SELECT LENGTH(text) FROM test_empty_vs_null WHERE text = '';

-- NULL has no length
-- Tag: data_types_string_types_test_select_032
SELECT LENGTH(text) FROM test_empty_vs_null WHERE text IS NULL;

-- String Aggregation

-- STRING_AGG (if supported)
DROP TABLE IF EXISTS test_agg;
CREATE TABLE test_agg (
    group_id INT64,
    value STRING
);

INSERT INTO test_agg VALUES (1, 'a'), (1, 'b'), (2, 'c'), (2, 'd');

-- Concatenate strings per group
-- Tag: data_types_string_types_test_select_033
SELECT group_id, STRING_AGG(value, ',') as combined
FROM test_agg
GROUP BY group_id
ORDER BY group_id;
-- (1, 'a,b')
-- (2, 'c,d')

-- End of File
