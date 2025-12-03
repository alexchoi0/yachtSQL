-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/similar_to_operator_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic SIMILAR TO with % wildcard
-- Expected: % matches any sequence of characters (like LIKE)
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Andrew'), (4, 'Charlie');

SELECT name FROM users WHERE name SIMILAR TO 'A%' ORDER BY name;
-- Result: Alice, Andrew

-- Test: Basic SIMILAR TO with _ wildcard
-- Expected: _ matches exactly one character
DROP TABLE IF EXISTS short_names;
CREATE TABLE short_names (id INT64, name STRING);
INSERT INTO short_names VALUES (1, 'Al'), (2, 'Bob'), (3, 'Jo'), (4, 'Alice');

SELECT name FROM short_names WHERE name SIMILAR TO '___' ORDER BY name;
-- Result: Bob (exactly 3 characters)

-- Test: Alternation with |
-- Expected: Match any of multiple patterns
DROP TABLE IF EXISTS people;
CREATE TABLE people (id INT64, name STRING);
INSERT INTO people VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'), (4, 'David');

SELECT name FROM people WHERE name SIMILAR TO 'Alice|Bob|Charlie' ORDER BY name;
-- Result: Alice, Bob, Charlie

-- Test: Character class [abc]
-- Expected: Match any character in set
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'), (4, 'David');

SELECT name FROM names WHERE name SIMILAR TO '[ABC]%' ORDER BY name;
-- Result: Alice, Bob, Charlie (starts with A, B, or C)

-- Test: Negated character class [^abc]
-- Expected: Match characters NOT in set
SELECT name FROM names WHERE name SIMILAR TO '[^AB]%' ORDER BY name;
-- Result: Charlie, David

-- Test: Asterisk * quantifier (zero or more)
-- Expected: Matches zero or more repetitions
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'a'), (2, 'aa'), (3, 'aaa'), (4, 'b');

SELECT value FROM data WHERE value SIMILAR TO 'a*' ORDER BY value;
-- Result: a, aa, aaa

-- Test: Plus + quantifier (one or more)
-- Expected: Matches one or more repetitions
DROP TABLE IF EXISTS plus_data;
CREATE TABLE plus_data (id INT64, value STRING);
INSERT INTO plus_data VALUES (1, ''), (2, 'a'), (3, 'aa'), (4, 'b');

SELECT value FROM plus_data WHERE value SIMILAR TO 'a+' ORDER BY value;
-- Result: a, aa (not empty string)

-- Test: Question ? quantifier (zero or one)
-- Expected: Optional character
DROP TABLE IF EXISTS optional;
CREATE TABLE optional (id INT64, value STRING);
INSERT INTO optional VALUES (1, 'color'), (2, 'colour'), (3, 'colors');

SELECT value FROM optional WHERE value SIMILAR TO 'colou?r' ORDER BY value;
-- Result: color, colour

-- Test: Exact repetition {n}
-- Expected: Exactly n occurrences
DROP TABLE IF EXISTS exact;
CREATE TABLE exact (id INT64, value STRING);
INSERT INTO exact VALUES (1, 'a'), (2, 'aa'), (3, 'aaa'), (4, 'aaaa');

SELECT value FROM exact WHERE value SIMILAR TO 'a{3}' ORDER BY value;
-- Result: aaa

-- Test: Range repetition {m,n}
-- Expected: Between m and n occurrences
DROP TABLE IF EXISTS range;
CREATE TABLE range (id INT64, value STRING);
INSERT INTO range VALUES (1, 'a'), (2, 'aa'), (3, 'aaa'), (4, 'aaaa'), (5, 'aaaaa');

SELECT value FROM range WHERE value SIMILAR TO 'a{2,4}' ORDER BY value;
-- Result: aa, aaa, aaaa

-- Test: Email pattern matching
-- Expected: Simple email validation
DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (id INT64, email STRING);
INSERT INTO contacts VALUES (1, 'alice@example.com'), (2, 'bob@test.org'), (3, 'invalid'), (4, 'charlie@domain.net');

SELECT email FROM contacts WHERE email SIMILAR TO '%@%.%' ORDER BY email;
-- Result: alice@example.com, bob@test.org, charlie@domain.net

-- Test: Phone number pattern
-- Expected: Match XXX-XXX-XXXX format
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64, phone STRING);
INSERT INTO phones VALUES (1, '123-456-7890'), (2, '555-1234'), (3, '9876543210'), (4, '111-222-3333');

SELECT phone FROM phones WHERE phone SIMILAR TO '[0-9]{3}-[0-9]{3}-[0-9]{4}' ORDER BY phone;
-- Result: 123-456-7890, 111-222-3333

-- Test: Grouping with parentheses
-- Expected: Group alternations
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (id INT64, value STRING);
INSERT INTO animals VALUES (1, 'catfish'), (2, 'dogfish'), (3, 'goldfish'), (4, 'cat');

SELECT value FROM animals WHERE value SIMILAR TO '(cat|dog)fish' ORDER BY value;
-- Result: catfish, dogfish

-- Test: NOT SIMILAR TO
-- Expected: Negate pattern match
DROP TABLE IF EXISTS negation;
CREATE TABLE negation (id INT64, name STRING);
INSERT INTO negation VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Andrew'), (4, 'Charlie');

SELECT name FROM negation WHERE name NOT SIMILAR TO 'A%' ORDER BY name;
-- Result: Bob, Charlie

-- Test: Case sensitivity
-- Expected: SIMILAR TO is case-sensitive
DROP TABLE IF EXISTS case_test;
CREATE TABLE case_test (id INT64, name STRING);
INSERT INTO case_test VALUES (1, 'ALICE'), (2, 'alice'), (3, 'Alice');

SELECT name FROM case_test WHERE name SIMILAR TO 'Alice';
-- Result: Alice (exact case only)

-- Test: Case-insensitive workaround using [Aa]
-- Expected: Match all case variations
DROP TABLE IF EXISTS case_insensitive;
CREATE TABLE case_insensitive (id INT64, name STRING);
INSERT INTO case_insensitive VALUES (1, 'ALICE'), (2, 'alice'), (3, 'Alice'), (4, 'Bob');

SELECT name FROM case_insensitive WHERE name SIMILAR TO '[Aa][Ll][Ii][Cc][Ee]' ORDER BY name;
-- Result: ALICE, Alice, alice

-- Test: NULL handling
-- Expected: NULL SIMILAR TO pattern returns NULL (three-valued logic)
DROP TABLE IF EXISTS with_null;
CREATE TABLE with_null (id INT64, name STRING);
INSERT INTO with_null VALUES (1, 'Alice'), (2, NULL), (3, 'Bob');

SELECT name FROM with_null WHERE name SIMILAR TO 'A%';
-- Result: Alice (NULL excluded)

-- Test: NULL pattern
-- Expected: No rows match NULL pattern
DROP TABLE IF EXISTS null_pattern;
CREATE TABLE null_pattern (id INT64, name STRING);
INSERT INTO null_pattern VALUES (1, 'Alice'), (2, 'Bob');

SELECT name FROM null_pattern WHERE name SIMILAR TO NULL;
-- Result: 0 rows

-- Test: ESCAPE clause for special characters
-- Expected: Escape % to match literal percent
DROP TABLE IF EXISTS percents;
CREATE TABLE percents (id INT64, value STRING);
INSERT INTO percents VALUES (1, '100%'), (2, '50%'), (3, '100');

SELECT value FROM percents WHERE value SIMILAR TO '%\\%' ESCAPE '\\';
-- Result: 100%, 50%

-- Test: SIMILAR TO in CASE expression
-- Expected: Conditional logic based on pattern
DROP TABLE IF EXISTS validation;
CREATE TABLE validation (id INT64, email STRING);
INSERT INTO validation VALUES (1, 'alice@example.com'), (2, 'bob@test.org'), (3, 'invalid');

SELECT email,
    CASE WHEN email SIMILAR TO '%@%.%' THEN 'Valid' ELSE 'Invalid' END as status
FROM validation ORDER BY id;
-- Result: Valid, Valid, Invalid

-- Test: SIMILAR TO with JOINs
-- Expected: Pattern matching in join conditions
DROP TABLE IF EXISTS user_list;
CREATE TABLE user_list (id INT64, name STRING);
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO user_list VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Andrew');
INSERT INTO patterns VALUES (1, 'A%');

SELECT u.name FROM user_list u
JOIN patterns p ON u.name SIMILAR TO p.pattern
ORDER BY u.name;
-- Result: Alice, Andrew

-- Test: SIMILAR TO in HAVING clause
-- Expected: Filter aggregated results by pattern
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, region STRING, amount INT64);
INSERT INTO sales VALUES (1, 'East', 100), (2, 'East', 200), (3, 'West', 150), (4, 'North', 180);

SELECT region, SUM(amount) as total
FROM sales
GROUP BY region
HAVING region SIMILAR TO 'E%|W%'
ORDER BY region;
-- Result: East, West

-- Test: Empty string pattern
-- Expected: Match only empty strings
DROP TABLE IF EXISTS empty_test;
CREATE TABLE empty_test (id INT64, value STRING);
INSERT INTO empty_test VALUES (1, ''), (2, 'a'), (3, 'b');

SELECT value FROM empty_test WHERE value SIMILAR TO '';
-- Result: '' (empty string)

-- Test: Empty table
-- Expected: No rows returned
DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (id INT64, value STRING);

SELECT value FROM empty_table WHERE value SIMILAR TO 'A%';
-- Result: 0 rows

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: Invalid pattern syntax
-- Expected: Error with helpful message
DROP TABLE IF EXISTS error_test;
CREATE TABLE error_test (id INT64, value STRING);
INSERT INTO error_test VALUES (1, 'test');

SELECT value FROM error_test WHERE value SIMILAR TO '[invalid';
-- ERROR: invalid regular expression: brackets [] not balanced

-- ============================================================================
-- Complex Real-World Patterns
-- ============================================================================

-- Test: All special characters together
-- Expected: Complex pattern matching
DROP TABLE IF EXISTS complex;
CREATE TABLE complex (id INT64, value STRING);
INSERT INTO complex VALUES (1, 'test123'), (2, 'test'), (3, 'test12');

SELECT value FROM complex WHERE value SIMILAR TO 'test[0-9]+' ORDER BY value;
-- Result: test12, test123

-- Test: Performance with large dataset
-- Expected: Handle 1000 rows efficiently
DROP TABLE IF EXISTS large_pattern;
CREATE TABLE large_pattern (id INT64, value STRING);
-- Insert 1000 rows
-- Query with SIMILAR TO should be performant

SELECT COUNT(*) FROM large_pattern WHERE value SIMILAR TO 'value[0-9]+';
-- Result: count of matching rows

-- ============================================================================
-- Best Practices Examples
-- ============================================================================

-- Common useful patterns:
-- Email: '%@%.%'
-- Phone (US): '[0-9]{3}-[0-9]{3}-[0-9]{4}'
-- ZIP code: '[0-9]{5}'
-- Alphanumeric: '[A-Za-z0-9]+'
-- URL: '%(http|https)://%'
