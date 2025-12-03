-- String Functions - SQL:2023
-- Description: String functions: CONCAT, SUBSTRING, UPPER, LOWER, TRIM
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_string_functions_test_select_001
SELECT LENGTH('hello') AS len;

-- Empty string
-- Tag: functions_string_functions_test_select_002
SELECT LENGTH('') AS len;

-- With spaces
-- Tag: functions_string_functions_test_select_003
SELECT LENGTH('  hello  ') AS len;

-- Unicode characters (count characters not bytes)
-- Tag: functions_string_functions_test_select_004
SELECT LENGTH('hello 世界') AS len;

-- Tag: functions_string_functions_test_select_005
SELECT LENGTH('café') AS len;

-- NULL handling
-- Tag: functions_string_functions_test_select_006
SELECT LENGTH(NULL) AS len;

-- CHAR_LENGTH alias
-- Tag: functions_string_functions_test_select_007
SELECT CHAR_LENGTH('hello') AS len;

-- CHARACTER_LENGTH alias
-- Tag: functions_string_functions_test_select_008
SELECT CHARACTER_LENGTH('hello') AS len;

-- ----------------------------------------------------------------------------
-- 2. POSITION FUNCTIONS
-- ----------------------------------------------------------------------------

-- POSITION - found
-- Tag: functions_string_functions_test_select_009
SELECT POSITION('world' IN 'hello world') AS pos;

-- POSITION - not found
-- Tag: functions_string_functions_test_select_010
SELECT POSITION('xyz' IN 'hello world') AS pos;

-- POSITION - at start
-- Tag: functions_string_functions_test_select_011
SELECT POSITION('hello' IN 'hello world') AS pos;

-- POSITION - case sensitive
-- Tag: functions_string_functions_test_select_012
SELECT POSITION('WORLD' IN 'hello world') AS pos;

-- POSITION - empty substring
-- Tag: functions_string_functions_test_select_013
SELECT POSITION('' IN 'hello') AS pos;

-- POSITION - NULL
-- Tag: functions_string_functions_test_select_014
SELECT POSITION('test' IN NULL) AS pos;

-- STRPOS - different argument order
-- Tag: functions_string_functions_test_select_015
SELECT STRPOS('hello world', 'world') AS pos;

-- Tag: functions_string_functions_test_select_016
SELECT STRPOS('hello world', 'xyz') AS pos;

-- ----------------------------------------------------------------------------
-- 3. SUBSTRING EXTRACTION
-- ----------------------------------------------------------------------------

-- LEFT function
-- Tag: functions_string_functions_test_select_017
SELECT LEFT('hello world', 5) AS result;

-- Tag: functions_string_functions_test_select_018
SELECT LEFT('hello', 0) AS result;

-- Tag: functions_string_functions_test_select_019
SELECT LEFT('hello', 100) AS result;

-- RIGHT function
-- Tag: functions_string_functions_test_select_020
SELECT RIGHT('hello world', 5) AS result;

-- Tag: functions_string_functions_test_select_021
SELECT RIGHT('hello', 0) AS result;

-- Tag: functions_string_functions_test_select_022
SELECT RIGHT('hello', 100) AS result;

-- SUBSTRING with position and length
-- Tag: functions_string_functions_test_select_023
SELECT SUBSTRING('hello world', 7, 5) AS result;

-- Tag: functions_string_functions_test_select_024
SELECT SUBSTRING('hello world', 1, 5) AS result;

-- ----------------------------------------------------------------------------
-- 4. CASE CONVERSION
-- ----------------------------------------------------------------------------

-- UPPER
-- Tag: functions_string_functions_test_select_025
SELECT UPPER('hello') AS result;

-- Tag: functions_string_functions_test_select_026
SELECT UPPER('Hello World') AS result;

-- LOWER
-- Tag: functions_string_functions_test_select_027
SELECT LOWER('HELLO') AS result;

-- Tag: functions_string_functions_test_select_028
SELECT LOWER('Hello World') AS result;

-- INITCAP
-- Tag: functions_string_functions_test_select_029
SELECT INITCAP('hello world') AS result;

-- Tag: functions_string_functions_test_select_030
SELECT INITCAP('HELLO WORLD') AS result;

-- Tag: functions_string_functions_test_select_031
SELECT INITCAP('hELLo WoRLd') AS result;

-- ----------------------------------------------------------------------------
-- 5. TRIMMING FUNCTIONS
-- ----------------------------------------------------------------------------

-- TRIM both sides (default)
-- Tag: functions_string_functions_test_select_032
SELECT TRIM('  hello  ') AS result;

-- TRIM leading
-- Tag: functions_string_functions_test_select_033
SELECT TRIM(LEADING FROM '  hello  ') AS result;

-- TRIM trailing
-- Tag: functions_string_functions_test_select_034
SELECT TRIM(TRAILING FROM '  hello  ') AS result;

-- TRIM specific character
-- Tag: functions_string_functions_test_select_035
SELECT TRIM('x' FROM 'xxxhelloxxx') AS result;

-- LTRIM
-- Tag: functions_string_functions_test_select_036
SELECT LTRIM('  hello  ') AS result;

-- RTRIM
-- Tag: functions_string_functions_test_select_037
SELECT RTRIM('  hello  ') AS result;

-- ----------------------------------------------------------------------------
-- 6. PADDING FUNCTIONS
-- ----------------------------------------------------------------------------

-- LPAD with specific character
-- Tag: functions_string_functions_test_select_038
SELECT LPAD('hello', 10, '*') AS result;

-- LPAD no padding needed
-- Tag: functions_string_functions_test_select_039
SELECT LPAD('hello', 5, '*') AS result;

-- LPAD truncate
-- Tag: functions_string_functions_test_select_040
SELECT LPAD('hello', 3, '*') AS result;

-- LPAD multichar fill
-- Tag: functions_string_functions_test_select_041
SELECT LPAD('hello', 10, 'xy') AS result;

-- LPAD default space
-- Tag: functions_string_functions_test_select_042
SELECT LPAD('hello', 8) AS result;

-- RPAD with specific character
-- Tag: functions_string_functions_test_select_043
SELECT RPAD('hello', 10, '*') AS result;

-- RPAD no padding needed
-- Tag: functions_string_functions_test_select_044
SELECT RPAD('hello', 5, '*') AS result;

-- RPAD multichar fill
-- Tag: functions_string_functions_test_select_045
SELECT RPAD('hello', 10, 'xy') AS result;

-- ----------------------------------------------------------------------------
-- 7. STRING MANIPULATION
-- ----------------------------------------------------------------------------

-- CONCAT
-- Tag: functions_string_functions_test_select_046
SELECT CONCAT('hello', ' ', 'world') AS result;

-- Tag: functions_string_functions_test_select_047
SELECT CONCAT('a', 'b', 'c', 'd') AS result;

-- CONCAT with NULL (NULL propagates in standard SQL)
-- Tag: functions_string_functions_test_select_048
SELECT CONCAT('hello', NULL, 'world') AS result;

-- REPEAT
-- Tag: functions_string_functions_test_select_049
SELECT REPEAT('ha', 3) AS result;

-- Tag: functions_string_functions_test_select_050
SELECT REPEAT('hello', 0) AS result;

-- Tag: functions_string_functions_test_select_051
SELECT REPEAT('hello', 1) AS result;

-- REVERSE
-- Tag: functions_string_functions_test_select_052
SELECT REVERSE('hello') AS result;

-- Tag: functions_string_functions_test_select_053
SELECT REVERSE('racecar') AS result;

-- Tag: functions_string_functions_test_select_054
SELECT REVERSE('') AS result;

-- Tag: functions_string_functions_test_select_055
SELECT REVERSE('hello世界') AS result;

-- REPLACE
-- Tag: functions_string_functions_test_select_056
SELECT REPLACE('hello world', 'world', 'there') AS result;

-- Tag: functions_string_functions_test_select_057
SELECT REPLACE('aaaa', 'a', 'b') AS result;

-- Tag: functions_string_functions_test_select_058
SELECT REPLACE('hello', 'xyz', 'abc') AS result;

-- ----------------------------------------------------------------------------
-- 8. CHARACTER FUNCTIONS
-- ----------------------------------------------------------------------------

-- ASCII
-- Tag: functions_string_functions_test_select_059
SELECT ASCII('a') AS result;

-- Tag: functions_string_functions_test_select_060
SELECT ASCII('A') AS result;

-- Tag: functions_string_functions_test_select_061
SELECT ASCII('0') AS result;

-- Tag: functions_string_functions_test_select_062
SELECT ASCII(' ') AS result;

-- Tag: functions_string_functions_test_select_063
SELECT ASCII('hello') AS result;

-- CHR
-- Tag: functions_string_functions_test_select_064
SELECT CHR(97) AS result;

-- Tag: functions_string_functions_test_select_065
SELECT CHR(65) AS result;

-- Tag: functions_string_functions_test_select_066
SELECT CHR(32) AS result;

-- Tag: functions_string_functions_test_select_067
SELECT CHR(10) AS result;

-- ASCII/CHR roundtrip
-- Tag: functions_string_functions_test_select_068
SELECT CHR(ASCII('X')) AS result;

-- ----------------------------------------------------------------------------
-- 9. TRANSLATE FUNCTION
-- ----------------------------------------------------------------------------

-- Basic character replacement
-- Tag: functions_string_functions_test_select_069
SELECT TRANSLATE('hello', 'el', 'ip') AS result;

-- Remove characters (empty 'to' string)
-- Tag: functions_string_functions_test_select_070
SELECT TRANSLATE('abc123def', '0123456789', '') AS result;

-- Partial replacement
-- Tag: functions_string_functions_test_select_071
SELECT TRANSLATE('abc123', '0123456789', 'XYZ') AS result;

-- No matches
-- Tag: functions_string_functions_test_select_072
SELECT TRANSLATE('hello', '123', 'abc') AS result;

-- Special characters
-- Tag: functions_string_functions_test_select_073
SELECT TRANSLATE('a-b_c.d', '-_.', '   ') AS result;

-- ----------------------------------------------------------------------------
-- 10. FORMAT FUNCTION
-- ----------------------------------------------------------------------------

-- String substitution
-- Tag: functions_string_functions_test_select_074
SELECT FORMAT('Hello, %s!', 'World') AS result;

-- Integer substitution
-- Tag: functions_string_functions_test_select_075
SELECT FORMAT('The answer is %d', 42) AS result;

-- Float substitution
-- Tag: functions_string_functions_test_select_076
SELECT FORMAT('Pi is approximately %.2f', 3.14159) AS result;

-- Multiple substitutions
-- Tag: functions_string_functions_test_select_077
SELECT FORMAT('%s has %d apples', 'John', 5) AS result;

-- Mixed types
-- Tag: functions_string_functions_test_select_078
SELECT FORMAT('%s is %d years old with a score of %.1f', 'Bob', 30, 95.5) AS result;

-- No placeholders
-- Tag: functions_string_functions_test_select_079
SELECT FORMAT('Just a plain string') AS result;

-- Escape percent
-- Tag: functions_string_functions_test_select_080
SELECT FORMAT('100%% complete') AS result;

-- Width and precision
-- Tag: functions_string_functions_test_select_081
SELECT FORMAT('Value: %10.3f', 123.456789) AS result;

-- ----------------------------------------------------------------------------
-- 11. QUOTE FUNCTIONS
-- ----------------------------------------------------------------------------

-- QUOTE_IDENT - simple identifier
-- Tag: functions_string_functions_test_select_082
SELECT QUOTE_IDENT('column_name') AS result;

-- QUOTE_IDENT - with spaces
-- Tag: functions_string_functions_test_select_083
SELECT QUOTE_IDENT('my column') AS result;

-- QUOTE_IDENT - with double quotes (escaped by doubling)
-- Tag: functions_string_functions_test_select_084
SELECT QUOTE_IDENT('my"column') AS result;

-- QUOTE_IDENT - with special chars
-- Tag: functions_string_functions_test_select_085
SELECT QUOTE_IDENT('table$name') AS result;

-- QUOTE_IDENT - empty string
-- Tag: functions_string_functions_test_select_086
SELECT QUOTE_IDENT('') AS result;

-- QUOTE_IDENT - reserved keyword
-- Tag: functions_string_functions_test_select_087
SELECT QUOTE_IDENT('select') AS result;

-- QUOTE_LITERAL - simple
-- Tag: functions_string_functions_test_select_088
SELECT QUOTE_LITERAL('hello') AS result;

-- QUOTE_LITERAL - with single quote (escaped by doubling)
-- Tag: functions_string_functions_test_select_089
SELECT QUOTE_LITERAL('it''s') AS result;

-- QUOTE_LITERAL - with double quote
-- Tag: functions_string_functions_test_select_090
SELECT QUOTE_LITERAL('say "hello"') AS result;

-- QUOTE_LITERAL - empty string
-- Tag: functions_string_functions_test_select_091
SELECT QUOTE_LITERAL('') AS result;

-- QUOTE_LITERAL - with newline
-- Tag: functions_string_functions_test_select_092
SELECT QUOTE_LITERAL('line1\nline2') AS result;

-- ----------------------------------------------------------------------------
-- 12. SPLIT FUNCTION (Returns ARRAY)
-- ----------------------------------------------------------------------------

-- Basic split
-- Tag: functions_string_functions_test_select_093
SELECT SPLIT('a,b,c', ',') AS parts;

-- No delimiter found
-- Tag: functions_string_functions_test_select_094
SELECT SPLIT('hello', ',') AS parts;

-- Empty string
-- Tag: functions_string_functions_test_select_095
SELECT SPLIT('', ',') AS parts;

-- Trailing delimiter
-- Tag: functions_string_functions_test_select_096
SELECT SPLIT('a,b,c,', ',') AS parts;

-- Consecutive delimiters
-- Tag: functions_string_functions_test_select_097
SELECT SPLIT('a,,b', ',') AS parts;

-- Multi-character delimiter
-- Tag: functions_string_functions_test_select_098
SELECT SPLIT('a::b::c', '::') AS parts;

-- Space delimiter
-- Tag: functions_string_functions_test_select_099
SELECT SPLIT('hello world test', ' ') AS parts;

-- ----------------------------------------------------------------------------
-- 13. INTEGRATION SCENARIOS
-- ----------------------------------------------------------------------------

-- Nested functions
-- Tag: functions_string_functions_test_select_100
SELECT UPPER(LEFT(REVERSE('hello'), 3)) AS result;

-- Tag: functions_string_functions_test_select_101
SELECT UPPER(TRIM('  hello  ')) AS result;

-- Extract email username
-- Tag: functions_string_functions_test_select_102
SELECT SUBSTR('user@example.com', 1, POSITION('@' IN 'user@example.com') - 1) AS username;

-- Extract file extension
-- Tag: functions_string_functions_test_select_103
SELECT RIGHT('document.pdf', LENGTH('document.pdf') - POSITION('.' IN 'document.pdf')) AS extension;

-- Palindrome check
-- Tag: functions_string_functions_test_select_104
SELECT 'racecar' = REVERSE('racecar') AS is_palindrome;

-- Tag: functions_string_functions_test_select_105
SELECT 'hello' = REVERSE('hello') AS is_palindrome;

-- Full name formatting
-- Tag: functions_string_functions_test_select_106
SELECT CONCAT(INITCAP('john'), ' ', INITCAP('doe')) AS full_name;

-- Word count using SPLIT
-- Tag: functions_string_functions_test_select_107
SELECT ARRAY_LENGTH(SPLIT('the quick brown fox', ' ')) AS word_count;

-- NULL handling across functions
-- Tag: functions_string_functions_test_select_108
SELECT LENGTH(NULL) AS len,
       UPPER(NULL) AS upper,
       REVERSE(NULL) AS rev,
       CONCAT('hello', NULL) AS concat_null;

-- Empty string handling
-- Tag: functions_string_functions_test_select_109
SELECT LENGTH('') AS len,
       UPPER('') AS upper,
       REVERSE('') AS rev,
       TRIM('') AS trim;

-- Unicode handling
-- Tag: functions_string_functions_test_select_110
SELECT LENGTH('café') AS len,
       UPPER('café') AS upper,
       LOWER('CAFÉ') AS lower,
       REVERSE('café') AS rev;

-- End of String Functions Tests
