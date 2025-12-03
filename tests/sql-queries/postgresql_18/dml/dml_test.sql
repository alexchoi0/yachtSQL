-- ============================================================================
-- Dml - PostgreSQL 18
-- ============================================================================
-- Source: Migrated from 13 test files
-- Description: Data Manipulation Language: INSERT, UPDATE, DELETE, MERGE
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, 'EMP[0-9]+');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (code_id INT64, code STRING);
INSERT INTO codes VALUES (1, 'EMP001');
INSERT INTO codes VALUES (2, 'EMP002');
INSERT INTO codes VALUES (3, 'MGR001');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'report.PDF');
INSERT INTO files VALUES (2, 'image.JPG');
INSERT INTO files VALUES (3, 'data.CSV');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'hello');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT c.code_id FROM codes c, patterns p WHERE c.code SIMILAR TO p.pattern ORDER BY c.code_id;
SELECT id, CASE WHEN filename ILIKE '%.pdf' THEN 'Document' WHEN filename ILIKE '%.jpg' THEN 'Image' ELSE 'Other' END as file_type FROM files ORDER BY id;
SELECT id FROM logs WHERE message ILIKE '%needle%';
SELECT id FROM data WHERE text SIMILAR TO '' ORDER BY id;
SELECT id FROM data WHERE text SIMILAR TO '[a-z';
SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_ilike_with_case_expression
-- Source: comparison_operators_advanced_tdd.rs:702
-- ============================================================================
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'report.PDF');
INSERT INTO files VALUES (2, 'image.JPG');
INSERT INTO files VALUES (3, 'data.CSV');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'hello');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT id, CASE WHEN filename ILIKE '%.pdf' THEN 'Document' WHEN filename ILIKE '%.jpg' THEN 'Image' ELSE 'Other' END as file_type FROM files ORDER BY id;
SELECT id FROM logs WHERE message ILIKE '%needle%';
SELECT id FROM data WHERE text SIMILAR TO '' ORDER BY id;
SELECT id FROM data WHERE text SIMILAR TO '[a-z';
SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_ilike_very_long_string
-- Source: comparison_operators_advanced_tdd.rs:739
-- ============================================================================
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'hello');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT id FROM logs WHERE message ILIKE '%needle%';
SELECT id FROM data WHERE text SIMILAR TO '' ORDER BY id;
SELECT id FROM data WHERE text SIMILAR TO '[a-z';
SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_similar_to_empty_string_pattern
-- Source: comparison_operators_advanced_tdd.rs:758
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'hello');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT id FROM data WHERE text SIMILAR TO '' ORDER BY id;
SELECT id FROM data WHERE text SIMILAR TO '[a-z';
SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_similar_to_invalid_pattern
-- Source: comparison_operators_advanced_tdd.rs:779
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT id FROM data WHERE text SIMILAR TO '[a-z';
SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_similar_to_invalid_escape
-- Source: comparison_operators_advanced_tdd.rs:794
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
DROP TABLE IF EXISTS names;
CREATE TABLE names (id INT64, name STRING);
INSERT INTO names VALUES (1, 'café');
INSERT INTO names VALUES (2, 'cafe\u{0301}');

SELECT id FROM data WHERE text SIMILAR TO '%test%' ESCAPE 'AB';
SELECT id FROM names WHERE name ILIKE 'café' ORDER BY id;

-- ============================================================================
-- Test: test_not_equal_operator_int64
-- Source: comparison_operators_not_equal_similar_to_regex.rs:18
-- ============================================================================
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64 PRIMARY KEY, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 30);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, status STRING);
INSERT INTO users VALUES (1, 'active');
INSERT INTO users VALUES (2, 'inactive');
INSERT INTO users VALUES (3, 'pending');
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64 PRIMARY KEY, temp FLOAT64);
INSERT INTO measurements VALUES (1, 98.6);
INSERT INTO measurements VALUES (2, 100.0);
INSERT INTO measurements VALUES (3, 97.5);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value INT64);
INSERT INTO items VALUES (1, 10);
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 20);
INSERT INTO test VALUES (3, 30);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM numbers WHERE value <> 20;
SELECT id FROM users WHERE status <> 'active';
SELECT id FROM measurements WHERE temp <> 98.6;
SELECT id FROM items WHERE value <> 10;
SELECT id FROM test WHERE value <> 20;
SELECT id FROM test WHERE value != 20;
SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_not_equal_operator_string
-- Source: comparison_operators_not_equal_similar_to_regex.rs:41
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, status STRING);
INSERT INTO users VALUES (1, 'active');
INSERT INTO users VALUES (2, 'inactive');
INSERT INTO users VALUES (3, 'pending');
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64 PRIMARY KEY, temp FLOAT64);
INSERT INTO measurements VALUES (1, 98.6);
INSERT INTO measurements VALUES (2, 100.0);
INSERT INTO measurements VALUES (3, 97.5);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value INT64);
INSERT INTO items VALUES (1, 10);
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 20);
INSERT INTO test VALUES (3, 30);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM users WHERE status <> 'active';
SELECT id FROM measurements WHERE temp <> 98.6;
SELECT id FROM items WHERE value <> 10;
SELECT id FROM test WHERE value <> 20;
SELECT id FROM test WHERE value != 20;
SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_not_equal_operator_float64
-- Source: comparison_operators_not_equal_similar_to_regex.rs:68
-- ============================================================================
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64 PRIMARY KEY, temp FLOAT64);
INSERT INTO measurements VALUES (1, 98.6);
INSERT INTO measurements VALUES (2, 100.0);
INSERT INTO measurements VALUES (3, 97.5);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value INT64);
INSERT INTO items VALUES (1, 10);
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 20);
INSERT INTO test VALUES (3, 30);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM measurements WHERE temp <> 98.6;
SELECT id FROM items WHERE value <> 10;
SELECT id FROM test WHERE value <> 20;
SELECT id FROM test WHERE value != 20;
SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_not_equal_operator_with_null
-- Source: comparison_operators_not_equal_similar_to_regex.rs:96
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value INT64);
INSERT INTO items VALUES (1, 10);
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 20);
INSERT INTO test VALUES (3, 30);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE value <> 10;
SELECT id FROM test WHERE value <> 20;
SELECT id FROM test WHERE value != 20;
SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_not_equal_same_as_not_equals
-- Source: comparison_operators_not_equal_similar_to_regex.rs:124
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value INT64);
INSERT INTO test VALUES (1, 10);
INSERT INTO test VALUES (2, 20);
INSERT INTO test VALUES (3, 30);
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM test WHERE value <> 20;
SELECT id FROM test WHERE value != 20;
SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_basic_pattern
-- Source: comparison_operators_not_equal_similar_to_regex.rs:159
-- ============================================================================
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM emails WHERE email SIMILAR TO '%@example.com';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_with_percent_wildcard
-- Source: comparison_operators_not_equal_similar_to_regex.rs:186
-- ============================================================================
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING);
INSERT INTO products VALUES (1, 'PROD-123-ABC');
INSERT INTO products VALUES (2, 'ITEM-456-XYZ');
INSERT INTO products VALUES (3, 'PROD-789-DEF');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%';
SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_with_underscore_wildcard
-- Source: comparison_operators_not_equal_similar_to_regex.rs:213
-- ============================================================================
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'A1');
INSERT INTO codes VALUES (2, 'A2');
INSERT INTO codes VALUES (3, 'B1');
INSERT INTO codes VALUES (4, 'AB1');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM codes WHERE code SIMILAR TO 'A_';
SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_with_character_class
-- Source: comparison_operators_not_equal_similar_to_regex.rs:239
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING);
INSERT INTO items VALUES (1, 'A123');
INSERT INTO items VALUES (2, 'B456');
INSERT INTO items VALUES (3, 'C789');
INSERT INTO items VALUES (4, 'X000');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE code SIMILAR TO '[ABC]%';
SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_with_alternation
-- Source: comparison_operators_not_equal_similar_to_regex.rs:269
-- ============================================================================
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64 PRIMARY KEY, filename STRING);
INSERT INTO files VALUES (1, 'document.pdf');
INSERT INTO files VALUES (2, 'image.jpg');
INSERT INTO files VALUES (3, 'data.csv');
INSERT INTO files VALUES (4, 'photo.png');
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM files WHERE filename SIMILAR TO '%(jpg|png)';
SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_with_quantifiers
-- Source: comparison_operators_not_equal_similar_to_regex.rs:295
-- ============================================================================
DROP TABLE IF EXISTS phones;
CREATE TABLE phones (id INT64 PRIMARY KEY, number STRING);
INSERT INTO phones VALUES (1, '123-4567');
INSERT INTO phones VALUES (2, '123-456-7890');
INSERT INTO phones VALUES (3, '12345');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM phones WHERE number SIMILAR TO '[0-9]+-%';
SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_not_similar_to
-- Source: comparison_operators_not_equal_similar_to_regex.rs:323
-- ============================================================================
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.com');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM emails WHERE email NOT SIMILAR TO '%@example.com';
SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_null_value
-- Source: comparison_operators_not_equal_similar_to_regex.rs:350
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'item1');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'item2');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE name SIMILAR TO '%';
SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_basic
-- Source: comparison_operators_not_equal_similar_to_regex.rs:382
-- ============================================================================
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob.smith@test.org');
INSERT INTO emails VALUES (3, 'invalid-email');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM emails WHERE email ~ '@.*\.com$';
SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_digit_pattern
-- Source: comparison_operators_not_equal_similar_to_regex.rs:405
-- ============================================================================
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC123');
INSERT INTO codes VALUES (2, 'XYZ');
INSERT INTO codes VALUES (3, 'DEF456');
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM codes WHERE code ~ '[0-9]+';
SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_word_boundary
-- Source: comparison_operators_not_equal_similar_to_regex.rs:428
-- ============================================================================
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64 PRIMARY KEY, content STRING);
INSERT INTO texts VALUES (1, 'the quick fox');
INSERT INTO texts VALUES (2, 'quickly moving');
INSERT INTO texts VALUES (3, 'a quick test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM texts WHERE content ~ '(^| )quick( |$)';
SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_case_sensitive
-- Source: comparison_operators_not_equal_similar_to_regex.rs:452
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, name STRING);
INSERT INTO items VALUES (1, 'Apple');
INSERT INTO items VALUES (2, 'APPLE');
INSERT INTO items VALUES (3, 'apple');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE name ~ '^apple$';
SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_start_and_end_anchors
-- Source: comparison_operators_not_equal_similar_to_regex.rs:479
-- ============================================================================
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, '123ABC');
INSERT INTO codes VALUES (2, 'ABC123');
INSERT INTO codes VALUES (3, 'X123ABC');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM codes WHERE code ~ '^[0-9]+[A-Z]+$';
SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_with_null
-- Source: comparison_operators_not_equal_similar_to_regex.rs:506
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'test456');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE value ~ 'test[0-9]+';
SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_not_match_basic
-- Source: comparison_operators_not_equal_similar_to_regex.rs:538
-- ============================================================================
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64 PRIMARY KEY, email STRING);
INSERT INTO emails VALUES (1, 'alice@example.com');
INSERT INTO emails VALUES (2, 'bob@test.org');
INSERT INTO emails VALUES (3, 'charlie@example.org');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM emails WHERE email !~ '\.com$';
SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_not_match_digit_pattern
-- Source: comparison_operators_not_equal_similar_to_regex.rs:565
-- ============================================================================
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64 PRIMARY KEY, code STRING);
INSERT INTO codes VALUES (1, 'ABC');
INSERT INTO codes VALUES (2, 'XYZ123');
INSERT INTO codes VALUES (3, 'DEF');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM codes WHERE code !~ '[0-9]';
SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_not_match_is_opposite_of_match
-- Source: comparison_operators_not_equal_similar_to_regex.rs:588
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test123');
INSERT INTO items VALUES (2, 'test456');
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE value ~ '^test';
SELECT id FROM items WHERE value !~ '^test';
SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_not_match_with_null
-- Source: comparison_operators_not_equal_similar_to_regex.rs:619
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO items VALUES (1, 'test');
INSERT INTO items VALUES (2, NULL);
INSERT INTO items VALUES (3, 'hello');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE value !~ 'test';
SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_similar_to_invalid_pattern_error
-- Source: comparison_operators_not_equal_similar_to_regex.rs:651
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM test WHERE value SIMILAR TO '[abc';
SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_regex_match_invalid_pattern_error
-- Source: comparison_operators_not_equal_similar_to_regex.rs:670
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test VALUES (1, 'test');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM test WHERE value ~ '(abc';
SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_operators_combined_with_and
-- Source: comparison_operators_not_equal_similar_to_regex.rs:686
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64 PRIMARY KEY, code STRING, status STRING);
INSERT INTO items VALUES (1, 'ABC123', 'active');
INSERT INTO items VALUES (2, 'XYZ', 'inactive');
INSERT INTO items VALUES (3, 'DEF456', 'active');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM items WHERE code ~ '[0-9]+' AND status <> 'inactive';
SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_operators_combined_with_or
-- Source: comparison_operators_not_equal_similar_to_regex.rs:713
-- ============================================================================
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64 PRIMARY KEY, sku STRING, category STRING);
INSERT INTO products VALUES (1, 'PROD-123', 'electronics');
INSERT INTO products VALUES (2, 'ITEM-456', 'books');
INSERT INTO products VALUES (3, 'PROD-789', 'toys');

SELECT id FROM products WHERE sku SIMILAR TO 'PROD-%' OR category <> 'books';

-- ============================================================================
-- Test: test_copy_from_basic
-- Source: copy_command_comprehensive_tdd.rs:106
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM users ORDER BY id;
SELECT value FROM data WHERE id = 2;
SELECT * FROM nullable ORDER BY id;
SELECT * FROM partial ORDER BY id;
SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_with_header
-- Source: copy_command_comprehensive_tdd.rs:153
-- ============================================================================
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, price INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT value FROM data WHERE id = 2;
SELECT * FROM nullable ORDER BY id;
SELECT * FROM partial ORDER BY id;
SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_custom_delimiter
-- Source: copy_command_comprehensive_tdd.rs:188
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT value FROM data WHERE id = 2;
SELECT * FROM nullable ORDER BY id;
SELECT * FROM partial ORDER BY id;
SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_null_values
-- Source: copy_command_comprehensive_tdd.rs:223
-- ============================================================================
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM nullable ORDER BY id;
SELECT * FROM partial ORDER BY id;
SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_column_list
-- Source: copy_command_comprehensive_tdd.rs:262
-- ============================================================================
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM partial ORDER BY id;
SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_to_basic
-- Source: copy_command_comprehensive_tdd.rs:307
-- ============================================================================
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_to_with_header
-- Source: copy_command_comprehensive_tdd.rs:341
-- ============================================================================
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_query_to_file
-- Source: copy_command_comprehensive_tdd.rs:376
-- ============================================================================
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_with_quote_option
-- Source: copy_command_comprehensive_tdd.rs:415
-- ============================================================================
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_with_escape_option
-- Source: copy_command_comprehensive_tdd.rs:450
-- ============================================================================
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_binary_format
-- Source: copy_command_comprehensive_tdd.rs:482
-- ============================================================================
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);
DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

SELECT * FROM binary_import ORDER BY id;
COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_empty_file
-- Source: copy_command_comprehensive_tdd.rs:537
-- ============================================================================
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_to_empty_table
-- Source: copy_command_comprehensive_tdd.rs:566
-- ============================================================================
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_large_file
-- Source: copy_command_comprehensive_tdd.rs:598
-- ============================================================================
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_file_not_found
-- Source: copy_command_comprehensive_tdd.rs:637
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test FROM '/nonexistent/file.csv';
COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_from_format_error
-- Source: copy_command_comprehensive_tdd.rs:660
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_copy_to_permission_error
-- Source: copy_command_comprehensive_tdd.rs:688
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

COPY test TO '/root/forbidden.csv';

-- ============================================================================
-- Test: test_timestamp_microseconds
-- Source: date_time_functions_advanced.rs:713
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT TIMESTAMP_ADD(TIMESTAMP '2024-01-15 10:30:00.000000', INTERVAL 500000 MICROSECOND) AS result;
SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_date_add_null_date
-- Source: date_time_functions_advanced.rs:727
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_ADD(dt, INTERVAL 10 DAY) AS result FROM dates;
SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_extract_null_date
-- Source: date_time_functions_advanced.rs:743
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT EXTRACT(YEAR FROM dt) AS year FROM dates;
SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_date_diff_null_operand
-- Source: date_time_functions_advanced.rs:759
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT DATE_DIFF(NULL, DATE '2024-01-01', DAY) AS diff;
SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_format_date_null
-- Source: date_time_functions_advanced.rs:769
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (dt DATE);
INSERT INTO dates VALUES (NULL);

SELECT FORMAT_DATE('%Y-%m-%d', dt) AS formatted FROM dates;
SELECT DATE '2024-02-30' AS result;
SELECT TIMESTAMP '2024-01-15 25:00:00' AS result;
SELECT PARSE_DATE('%Y-%m-%d', 'not-a-date') AS result;
SELECT DATE_ADD(DATE '2024-01-15', INTERVAL 10 INVALID_UNIT) AS result;

-- ============================================================================
-- Test: test_non_leap_year_feb_29_invalid
-- Source: datetime_extreme_edge_cases_tdd.rs:148
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2023-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '1900-02-29');
INSERT INTO events VALUES (2, DATE '2100-02-29');
INSERT INTO events VALUES (3, DATE '2000-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL -1 YEAR) as new_date FROM events;
SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_century_year_not_leap_year
-- Source: datetime_extreme_edge_cases_tdd.rs:164
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '1900-02-29');
INSERT INTO events VALUES (2, DATE '2100-02-29');
INSERT INTO events VALUES (3, DATE '2000-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL -1 YEAR) as new_date FROM events;
SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_add_month_to_jan_31_overflow
-- Source: datetime_extreme_edge_cases_tdd.rs:187
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL -1 YEAR) as new_date FROM events;
SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_add_month_to_mar_31_overflow
-- Source: datetime_extreme_edge_cases_tdd.rs:215
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL -1 YEAR) as new_date FROM events;
SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_sub_year_from_leap_day
-- Source: datetime_extreme_edge_cases_tdd.rs:243
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL -1 YEAR) as new_date FROM events;
SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_invalid_month_13
-- Source: datetime_extreme_edge_cases_tdd.rs:275
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-13-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_invalid_month_00
-- Source: datetime_extreme_edge_cases_tdd.rs:290
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-00-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_invalid_day_32_in_january
-- Source: datetime_extreme_edge_cases_tdd.rs:305
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-32');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_invalid_day_31_in_april
-- Source: datetime_extreme_edge_cases_tdd.rs:320
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-04-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_invalid_day_00
-- Source: datetime_extreme_edge_cases_tdd.rs:335
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-00');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_microsecond_precision
-- Source: datetime_extreme_edge_cases_tdd.rs:354
-- ============================================================================
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT logged_at FROM logs;
SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_nanosecond_truncation
-- Source: datetime_extreme_edge_cases_tdd.rs:381
-- ============================================================================
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456789');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_midnight_boundary
-- Source: datetime_extreme_edge_cases_tdd.rs:402
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 00:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT event_time FROM events;
SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_last_microsecond_of_day
-- Source: datetime_extreme_edge_cases_tdd.rs:422
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 23:59:59.999999');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT event_time FROM events;
SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_invalid_hour_24
-- Source: datetime_extreme_edge_cases_tdd.rs:442
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 24:00:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_invalid_minute_60
-- Source: datetime_extreme_edge_cases_tdd.rs:458
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:60:00');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_timestamp_invalid_second_60
-- Source: datetime_extreme_edge_cases_tdd.rs:474
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_time TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:60');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_interval_negative_days
-- Source: datetime_extreme_edge_cases_tdd.rs:497
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL -5 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_interval_zero
-- Source: datetime_extreme_edge_cases_tdd.rs:524
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 0 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_interval_large_number_of_days
-- Source: datetime_extreme_edge_cases_tdd.rs:548
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 10000 DAY) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_interval_month_vs_30_days
-- Source: datetime_extreme_edge_cases_tdd.rs:576
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 MONTH) as new_date FROM events;
SELECT DATE_ADD(event_date, INTERVAL 30 DAY) as new_date FROM events;
SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_same_date
-- Source: datetime_extreme_edge_cases_tdd.rs:613
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_DIFF(DATE '2024-01-15', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_negative_result
-- Source: datetime_extreme_edge_cases_tdd.rs:634
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_DIFF(DATE '2024-01-10', DATE '2024-01-15', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_across_leap_year
-- Source: datetime_extreme_edge_cases_tdd.rs:655
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_DIFF(DATE '2025-03-01', DATE '2024-02-28', DAY) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_in_months
-- Source: datetime_extreme_edge_cases_tdd.rs:678
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_partial_month
-- Source: datetime_extreme_edge_cases_tdd.rs:700
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_DIFF(DATE '2024-02-20', DATE '2024-01-15', MONTH) as diff FROM test;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_extract_year_from_date
-- Source: datetime_extreme_edge_cases_tdd.rs:728
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_extract_day_of_week
-- Source: datetime_extreme_edge_cases_tdd.rs:749
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT EXTRACT(DAYOFWEEK FROM event_date) as dow FROM events;
SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_extract_day_of_year
-- Source: datetime_extreme_edge_cases_tdd.rs:776
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT id, EXTRACT(DAYOFYEAR FROM event_date) as doy FROM events ORDER BY id;
SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_extract_week_of_year
-- Source: datetime_extreme_edge_cases_tdd.rs:801
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-01');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT EXTRACT(WEEK FROM event_date) as week FROM events;
SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_extract_microsecond_from_timestamp
-- Source: datetime_extreme_edge_cases_tdd.rs:825
-- ============================================================================
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, logged_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT EXTRACT(MICROSECOND FROM logged_at) as us FROM logs;
SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_now_returns_current_timestamp
-- Source: datetime_extreme_edge_cases_tdd.rs:850
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT NOW() as current_time FROM test;
SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_now_is_consistent_within_query
-- Source: datetime_extreme_edge_cases_tdd.rs:869
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT NOW() as t1, NOW() as t2 FROM test;
SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_current_date_vs_now
-- Source: datetime_extreme_edge_cases_tdd.rs:895
-- ============================================================================
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT CURRENT_DATE() as today FROM test;
SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_add_with_null_date
-- Source: datetime_extreme_edge_cases_tdd.rs:931
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, date1 DATE, date2 DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15', NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
INSERT INTO test VALUES (1);

SELECT DATE_ADD(event_date, INTERVAL 1 DAY) as new_date FROM events;
SELECT DATE_DIFF(date1, date2, DAY) as diff FROM events;
SELECT EXTRACT(YEAR FROM event_date) as year FROM events;
SELECT PARSE_DATE('%Y-%m-%d', '2024-01-15') as date1 FROM test;
SELECT PARSE_DATE('%m/%d/%Y', '01/15/2024') as date2 FROM test;
SELECT PARSE_DATE('%d.%m.%Y', '15.01.2024') as date3 FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '01/15/2024') as parsed FROM test;
SELECT PARSE_DATE('%Y-%m-%d', '2024-02-30') as parsed FROM test;

-- ============================================================================
-- Test: test_date_diff_for_age_calculation
-- Source: datetime_functions_comprehensive_tdd.rs:1012
-- ============================================================================
DROP TABLE IF EXISTS people;
CREATE TABLE people (id INT64, name STRING, birth_date DATE);
INSERT INTO people VALUES \ (1, 'Alice', DATE '1990-06-15'), \ (2, 'Bob', DATE '1985-03-20');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-30');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2023-12-31');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64);
INSERT INTO dates VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_ts TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');

SELECT name, \ DATE_DIFF(DATE '2024-01-01', birth_date, YEAR) as age \ FROM people \ ORDER BY name;
SELECT EXTRACT(YEAR FROM DATE_ADD(event_date, INTERVAL 1 YEAR)) as next_year \ FROM events;
SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-01', DAY) as days FROM dates;
SELECT EXTRACT(MICROSECOND FROM event_ts) as microsec FROM events;

-- ============================================================================
-- Test: test_nested_date_functions
-- Source: datetime_functions_comprehensive_tdd.rs:1044
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-30');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2023-12-31');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64);
INSERT INTO dates VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_ts TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');

SELECT EXTRACT(YEAR FROM DATE_ADD(event_date, INTERVAL 1 YEAR)) as next_year \ FROM events;
SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-01', DAY) as days FROM dates;
SELECT EXTRACT(MICROSECOND FROM event_ts) as microsec FROM events;

-- ============================================================================
-- Test: test_leap_year_february_29
-- Source: datetime_functions_comprehensive_tdd.rs:1071
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-29');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-30');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2023-12-31');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64);
INSERT INTO dates VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_ts TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');

SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-01', DAY) as days FROM dates;
SELECT EXTRACT(MICROSECOND FROM event_ts) as microsec FROM events;

-- ============================================================================
-- Test: test_invalid_date_february_30
-- Source: datetime_functions_comprehensive_tdd.rs:1093
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2024-02-30');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2023-12-31');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64);
INSERT INTO dates VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_ts TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');

SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-01', DAY) as days FROM dates;
SELECT EXTRACT(MICROSECOND FROM event_ts) as microsec FROM events;

-- ============================================================================
-- Test: test_date_arithmetic_year_boundary
-- Source: datetime_functions_comprehensive_tdd.rs:1107
-- ============================================================================
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64, date_val DATE);
INSERT INTO dates VALUES (1, DATE '2023-12-31');
DROP TABLE IF EXISTS dates;
CREATE TABLE dates (id INT64);
INSERT INTO dates VALUES (1);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_ts TIMESTAMP);
INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:30:45.123456');

SELECT DATE_ADD(date_val, INTERVAL 1 DAY) as next_day FROM dates;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-01', DAY) as days FROM dates;
SELECT EXTRACT(MICROSECOND FROM event_ts) as microsec FROM events;

-- ============================================================================
-- Test: test_date_sub_days_basic
-- Source: datetime_functions_extended_tdd.rs:24
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(event_date, INTERVAL 5 DAY) as result FROM events;
SELECT DATE_SUB(DATE '2024-03-05', INTERVAL 10 DAY) as result;
SELECT DATE_SUB(DATE '2024-01-05', INTERVAL 10 DAY) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 MONTH) as result;
SELECT DATE_SUB(DATE '2024-05-31', INTERVAL 1 MONTH) as result;
SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_crossing_month_boundary
-- Source: datetime_functions_extended_tdd.rs:54
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-03-05', INTERVAL 10 DAY) as result;
SELECT DATE_SUB(DATE '2024-01-05', INTERVAL 10 DAY) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 MONTH) as result;
SELECT DATE_SUB(DATE '2024-05-31', INTERVAL 1 MONTH) as result;
SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_crossing_year_boundary
-- Source: datetime_functions_extended_tdd.rs:78
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-01-05', INTERVAL 10 DAY) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 MONTH) as result;
SELECT DATE_SUB(DATE '2024-05-31', INTERVAL 1 MONTH) as result;
SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_months_basic
-- Source: datetime_functions_extended_tdd.rs:102
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 MONTH) as result;
SELECT DATE_SUB(DATE '2024-05-31', INTERVAL 1 MONTH) as result;
SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_months_with_day_clamping
-- Source: datetime_functions_extended_tdd.rs:125
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-05-31', INTERVAL 1 MONTH) as result;
SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_months_crossing_year
-- Source: datetime_functions_extended_tdd.rs:148
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-02-15', INTERVAL 3 MONTH) as result;
SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_years_basic
-- Source: datetime_functions_extended_tdd.rs:172
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-06-15', INTERVAL 2 YEAR) as result;
SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_years_leap_year_handling
-- Source: datetime_functions_extended_tdd.rs:195
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-02-29', INTERVAL 1 YEAR) as result;
SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_null_date
-- Source: datetime_functions_extended_tdd.rs:218
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(d, INTERVAL 5 DAY) as result FROM t;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_zero_interval
-- Source: datetime_functions_extended_tdd.rs:241
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 0 DAY) as result;
SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_sub_with_date_add_equivalence
-- Source: datetime_functions_extended_tdd.rs:264
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY) as sub_result, DATE_ADD(DATE '2024-03-15', INTERVAL -5 DAY) as add_result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_days_basic
-- Source: datetime_functions_extended_tdd.rs:292
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-10', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_days_negative
-- Source: datetime_functions_extended_tdd.rs:313
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-10', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_same_date
-- Source: datetime_functions_extended_tdd.rs:334
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-15', DATE '2024-03-15', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_crossing_month_boundary
-- Source: datetime_functions_extended_tdd.rs:355
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-05', DATE '2024-02-25', DAY) as result;
SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_crossing_year_boundary
-- Source: datetime_functions_extended_tdd.rs:377
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-01-05', DATE '2023-12-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_leap_year
-- Source: datetime_functions_extended_tdd.rs:399
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-01', DATE '2024-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_non_leap_year
-- Source: datetime_functions_extended_tdd.rs:421
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2023-03-01', DATE '2023-02-28', DAY) as result;
SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_weeks
-- Source: datetime_functions_extended_tdd.rs:443
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-03-22', DATE '2024-03-01', WEEK) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_months
-- Source: datetime_functions_extended_tdd.rs:465
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-06-15', DATE '2024-03-15', MONTH) as result;
SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_years
-- Source: datetime_functions_extended_tdd.rs:487
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-06-15', DATE '2022-06-15', YEAR) as result;
SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_null_handling
-- Source: datetime_functions_extended_tdd.rs:509
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d1 DATE, d2 DATE);
INSERT INTO t VALUES (1, NULL, DATE '2024-03-15');
INSERT INTO t VALUES (2, DATE '2024-03-15', NULL);
INSERT INTO t VALUES (3, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(d1, d2, DAY) as result FROM t ORDER BY id;
SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_diff_large_span
-- Source: datetime_functions_extended_tdd.rs:540
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF(DATE '2024-01-01', DATE '2014-01-01', DAY) as result;
SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_year
-- Source: datetime_functions_extended_tdd.rs:566
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(YEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_month
-- Source: datetime_functions_extended_tdd.rs:586
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(MONTH FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_day
-- Source: datetime_functions_extended_tdd.rs:606
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(DAY FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_dayofweek
-- Source: datetime_functions_extended_tdd.rs:626
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(DAYOFWEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_dayofyear
-- Source: datetime_functions_extended_tdd.rs:649
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(DAYOFYEAR FROM DATE '2024-03-15') as result;
SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_quarter
-- Source: datetime_functions_extended_tdd.rs:670
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_week
-- Source: datetime_functions_extended_tdd.rs:702
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(WEEK FROM DATE '2024-03-15') as result;
SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_null_handling
-- Source: datetime_functions_extended_tdd.rs:725
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(YEAR FROM d) as result FROM t;
SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_edge_case_jan_1
-- Source: datetime_functions_extended_tdd.rs:748
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(MONTH FROM DATE '2024-01-01') as month, EXTRACT(DAY FROM DATE '2024-01-01') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-01-01') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_edge_case_dec_31
-- Source: datetime_functions_extended_tdd.rs:784
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(MONTH FROM DATE '2024-12-31') as month, EXTRACT(DAY FROM DATE '2024-12-31') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-12-31') as doy;
SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_extract_leap_year_feb_29
-- Source: datetime_functions_extended_tdd.rs:820
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(MONTH FROM DATE '2024-02-29') as month, EXTRACT(DAY FROM DATE '2024-02-29') as day, EXTRACT(DAYOFYEAR FROM DATE '2024-02-29') as doy;
SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_day
-- Source: datetime_functions_extended_tdd.rs:860
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-03-15', DAY) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_week
-- Source: datetime_functions_extended_tdd.rs:883
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-03-15', WEEK) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_month
-- Source: datetime_functions_extended_tdd.rs:908
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-03-15', MONTH) as result;
SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_quarter
-- Source: datetime_functions_extended_tdd.rs:931
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_year
-- Source: datetime_functions_extended_tdd.rs:965
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-03-15', YEAR) as result;
SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_null_handling
-- Source: datetime_functions_extended_tdd.rs:988
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, d DATE);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(d, MONTH) as result FROM t;
SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_edge_case_jan_1
-- Source: datetime_functions_extended_tdd.rs:1011
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-01-01', DAY) as day_trunc, DATE_TRUNC(DATE '2024-01-01', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-01-01', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_edge_case_dec_31
-- Source: datetime_functions_extended_tdd.rs:1043
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-12-31', MONTH) as month_trunc, DATE_TRUNC(DATE '2024-12-31', YEAR) as year_trunc;
SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_date_trunc_leap_year_handling
-- Source: datetime_functions_extended_tdd.rs:1080
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC(DATE '2024-02-29', MONTH) as result;
SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_integration_date_operations_chain
-- Source: datetime_functions_extended_tdd.rs:1107
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_TRUNC( DATE_ADD( DATE_SUB(DATE '2024-03-15', INTERVAL 5 DAY), INTERVAL 1 MONTH ), MONTH ) as result;
SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_integration_extract_with_date_operations
-- Source: datetime_functions_extended_tdd.rs:1142
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT EXTRACT(MONTH FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as month, EXTRACT(DAY FROM DATE_ADD(DATE '2024-01-15', INTERVAL 2 MONTH)) as day;
SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_integration_date_diff_with_date_operations
-- Source: datetime_functions_extended_tdd.rs:1172
-- ============================================================================
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-01');
INSERT INTO events VALUES (2, DATE '2024-03-15');
INSERT INTO events VALUES (3, DATE '2024-03-31');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-03-15');
INSERT INTO events VALUES (2, DATE '2024-01-20');
INSERT INTO events VALUES (3, DATE '2024-02-10');

SELECT DATE_DIFF( DATE_ADD(DATE '2024-01-01', INTERVAL 10 DAY), DATE_SUB(DATE '2024-01-01', INTERVAL 5 DAY), DAY ) as result;
SELECT id FROM events WHERE EXTRACT(DAY FROM event_date) > 10 ORDER BY id;
SELECT id FROM events ORDER BY EXTRACT(MONTH FROM event_date), EXTRACT(DAY FROM event_date);

-- ============================================================================
-- Test: test_distinct_on_order_by_mismatch_error
-- Source: distinct_on_comprehensive_tdd.rs:622
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a STRING, b STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES \ (1, 'alice@example.com', 'Alice A', 1), \ (2, 'alice@example.com', 'Alice B', 2), \ (3, 'bob@example.com', 'Bob', 1), \ (4, 'alice@example.com', 'Alice C', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (a) a, b \ FROM data \ ORDER BY b;
SELECT DISTINCT ON (category) category, id \ FROM data;
SELECT DISTINCT ON (nonexistent) category, id \ FROM data \ ORDER BY nonexistent;
SELECT DISTINCT DISTINCT ON (category) category, id \ FROM data \ ORDER BY category;
SELECT DISTINCT ON (email) email, name, updated_at \ FROM user_snapshots \ ORDER BY email, updated_at DESC;
SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_missing_order_by_error
-- Source: distinct_on_comprehensive_tdd.rs:641
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES \ (1, 'alice@example.com', 'Alice A', 1), \ (2, 'alice@example.com', 'Alice B', 2), \ (3, 'bob@example.com', 'Bob', 1), \ (4, 'alice@example.com', 'Alice C', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (category) category, id \ FROM data;
SELECT DISTINCT ON (nonexistent) category, id \ FROM data \ ORDER BY nonexistent;
SELECT DISTINCT DISTINCT ON (category) category, id \ FROM data \ ORDER BY category;
SELECT DISTINCT ON (email) email, name, updated_at \ FROM user_snapshots \ ORDER BY email, updated_at DESC;
SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_invalid_column_error
-- Source: distinct_on_comprehensive_tdd.rs:659
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES \ (1, 'alice@example.com', 'Alice A', 1), \ (2, 'alice@example.com', 'Alice B', 2), \ (3, 'bob@example.com', 'Bob', 1), \ (4, 'alice@example.com', 'Alice C', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (nonexistent) category, id \ FROM data \ ORDER BY nonexistent;
SELECT DISTINCT DISTINCT ON (category) category, id \ FROM data \ ORDER BY category;
SELECT DISTINCT ON (email) email, name, updated_at \ FROM user_snapshots \ ORDER BY email, updated_at DESC;
SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_and_distinct_on_together_error
-- Source: distinct_on_comprehensive_tdd.rs:676
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING);
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES \ (1, 'alice@example.com', 'Alice A', 1), \ (2, 'alice@example.com', 'Alice B', 2), \ (3, 'bob@example.com', 'Bob', 1), \ (4, 'alice@example.com', 'Alice C', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT DISTINCT ON (category) category, id \ FROM data \ ORDER BY category;
SELECT DISTINCT ON (email) email, name, updated_at \ FROM user_snapshots \ ORDER BY email, updated_at DESC;
SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_deduplication_keep_latest
-- Source: distinct_on_comprehensive_tdd.rs:699
-- ============================================================================
DROP TABLE IF EXISTS user_snapshots;
CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64);
INSERT INTO user_snapshots VALUES \ (1, 'alice@example.com', 'Alice A', 1), \ (2, 'alice@example.com', 'Alice B', 2), \ (3, 'bob@example.com', 'Bob', 1), \ (4, 'alice@example.com', 'Alice C', 3);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (email) email, name, updated_at \ FROM user_snapshots \ ORDER BY email, updated_at DESC;
SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_top_n_per_group
-- Source: distinct_on_comprehensive_tdd.rs:735
-- ============================================================================
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING, sales INT64);
INSERT INTO products VALUES \ (1, 'electronics', 1000), \ (2, 'electronics', 1500), \ (3, 'books', 500), \ (4, 'books', 800);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (category) category, id, sales \ FROM products \ ORDER BY category, sales DESC;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_with_limit
-- Source: distinct_on_comprehensive_tdd.rs:768
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'A', 20), \ (3, 'B', 30), \ (4, 'C', 40);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category, value DESC \ LIMIT 2;
SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_distinct_on_with_offset
-- Source: distinct_on_comprehensive_tdd.rs:799
-- ============================================================================
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, category STRING, value INT64);
INSERT INTO items VALUES \ (1, 'A', 10), \ (2, 'B', 20), \ (3, 'C', 30);

SELECT DISTINCT ON (category) category, value \ FROM items \ ORDER BY category \ OFFSET 1;

-- ============================================================================
-- Test: test_insert_expression_with_null_propagation
-- Source: insert_advanced_features_tdd.rs:605
-- ============================================================================
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (id INT64, result INT64);
INSERT INTO nulls VALUES (1, NULL + 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, result INT64);
INSERT INTO t VALUES (1, 10 / 0);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, result FLOAT64);
INSERT INTO mixed VALUES (1, 5 + 2.5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1, 'Alice'), (2, 'Bob') RETURNING id, name;
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, value INT64);
INSERT INTO t VALUES (1, 10), (2, 20) RETURNING id, value * 2 as doubled;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT result FROM nulls;
SELECT result FROM mixed;
SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_expression_division_by_zero
-- Source: insert_advanced_features_tdd.rs:624
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, result INT64);
INSERT INTO t VALUES (1, 10 / 0);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, result FLOAT64);
INSERT INTO mixed VALUES (1, 5 + 2.5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1, 'Alice'), (2, 'Bob') RETURNING id, name;
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, value INT64);
INSERT INTO t VALUES (1, 10), (2, 20) RETURNING id, value * 2 as doubled;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT result FROM mixed;
SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_expression_type_coercion
-- Source: insert_advanced_features_tdd.rs:638
-- ============================================================================
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (id INT64, result FLOAT64);
INSERT INTO mixed VALUES (1, 5 + 2.5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1, 'Alice'), (2, 'Bob') RETURNING id, name;
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, value INT64);
INSERT INTO t VALUES (1, 10), (2, 20) RETURNING id, value * 2 as doubled;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT result FROM mixed;
SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_returning_basic
-- Source: insert_advanced_features_tdd.rs:664
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, name STRING);
INSERT INTO t VALUES (1, 'Alice'), (2, 'Bob') RETURNING id, name;
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, value INT64);
INSERT INTO t VALUES (1, 10), (2, 20) RETURNING id, value * 2 as doubled;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_returning_computed_columns
-- Source: insert_advanced_features_tdd.rs:683
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, value INT64);
INSERT INTO t VALUES (1, 10), (2, 20) RETURNING id, value * 2 as doubled;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_on_conflict_do_nothing
-- Source: insert_advanced_features_tdd.rs:704
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (1, 'Bob') ON CONFLICT (id) DO NOTHING;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT name FROM users WHERE id = 1;
SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_insert_on_conflict_do_update
-- Source: insert_advanced_features_tdd.rs:734
-- ============================================================================
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64 );
INSERT INTO inventory VALUES (1, 10);
INSERT INTO inventory VALUES (1, 5) ON CONFLICT (product_id) DO UPDATE SET quantity = quantity + EXCLUDED.quantity;

SELECT quantity FROM inventory WHERE product_id = 1;

-- ============================================================================
-- Test: test_upsert_with_uuid_conflict_column
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1264
-- ============================================================================
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (session_id UUID PRIMARY KEY, user_id INT64, active BOOL);
DROP TABLE IF EXISTS prices;
CREATE TABLE prices ( price NUMERIC(10, 2) PRIMARY KEY, product STRING, currency STRING );
INSERT INTO prices VALUES (99.99, 'Widget', 'USD');
INSERT INTO prices VALUES (99.99, 'Widget Pro', 'USD') ON CONFLICT (price) DO UPDATE SET product = EXCLUDED.product;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64, reserved INT64, last_updated TIMESTAMP );
INSERT INTO inventory VALUES (1, 100, 10, TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO inventory VALUES (1, 50, 5, TIMESTAMP '2024-01-02 00:00:00') ON CONFLICT (product_id) DO UPDATE SET quantity = inventory.quantity + EXCLUDED.quantity, reserved = CASE WHEN inventory.reserved > EXCLUDED.reserved THEN inventory.reserved ELSE EXCLUDED.reserved END, last_updated = EXCLUDED.last_updated;
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64 PRIMARY KEY, name STRING, version INT64 );
INSERT INTO users VALUES (1, 'Alice', 5);
INSERT INTO users VALUES (1, 'Alice Old', 3) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, version = EXCLUDED.version WHERE EXCLUDED.version > users.version;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING, created_at TIMESTAMP);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO users VALUES (1, 'Alice Updated', 'newemail@example.com', TIMESTAMP '2024-12-01 00:00:00') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT product FROM prices WHERE price = 99.99;
SELECT quantity, reserved FROM inventory WHERE product_id = 1;
SELECT name, version FROM users WHERE id = 1;
SELECT name, email FROM users WHERE id = 1;
SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_upsert_with_numeric_conflict_column
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1316
-- ============================================================================
DROP TABLE IF EXISTS prices;
CREATE TABLE prices ( price NUMERIC(10, 2) PRIMARY KEY, product STRING, currency STRING );
INSERT INTO prices VALUES (99.99, 'Widget', 'USD');
INSERT INTO prices VALUES (99.99, 'Widget Pro', 'USD') ON CONFLICT (price) DO UPDATE SET product = EXCLUDED.product;
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64, reserved INT64, last_updated TIMESTAMP );
INSERT INTO inventory VALUES (1, 100, 10, TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO inventory VALUES (1, 50, 5, TIMESTAMP '2024-01-02 00:00:00') ON CONFLICT (product_id) DO UPDATE SET quantity = inventory.quantity + EXCLUDED.quantity, reserved = CASE WHEN inventory.reserved > EXCLUDED.reserved THEN inventory.reserved ELSE EXCLUDED.reserved END, last_updated = EXCLUDED.last_updated;
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64 PRIMARY KEY, name STRING, version INT64 );
INSERT INTO users VALUES (1, 'Alice', 5);
INSERT INTO users VALUES (1, 'Alice Old', 3) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, version = EXCLUDED.version WHERE EXCLUDED.version > users.version;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING, created_at TIMESTAMP);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO users VALUES (1, 'Alice Updated', 'newemail@example.com', TIMESTAMP '2024-12-01 00:00:00') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT product FROM prices WHERE price = 99.99;
SELECT quantity, reserved FROM inventory WHERE product_id = 1;
SELECT name, version FROM users WHERE id = 1;
SELECT name, email FROM users WHERE id = 1;
SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_upsert_set_clause_with_complex_expression
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1356
-- ============================================================================
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory ( product_id INT64 PRIMARY KEY, quantity INT64, reserved INT64, last_updated TIMESTAMP );
INSERT INTO inventory VALUES (1, 100, 10, TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO inventory VALUES (1, 50, 5, TIMESTAMP '2024-01-02 00:00:00') ON CONFLICT (product_id) DO UPDATE SET quantity = inventory.quantity + EXCLUDED.quantity, reserved = CASE WHEN inventory.reserved > EXCLUDED.reserved THEN inventory.reserved ELSE EXCLUDED.reserved END, last_updated = EXCLUDED.last_updated;
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64 PRIMARY KEY, name STRING, version INT64 );
INSERT INTO users VALUES (1, 'Alice', 5);
INSERT INTO users VALUES (1, 'Alice Old', 3) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, version = EXCLUDED.version WHERE EXCLUDED.version > users.version;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING, created_at TIMESTAMP);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO users VALUES (1, 'Alice Updated', 'newemail@example.com', TIMESTAMP '2024-12-01 00:00:00') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT quantity, reserved FROM inventory WHERE product_id = 1;
SELECT name, version FROM users WHERE id = 1;
SELECT name, email FROM users WHERE id = 1;
SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_upsert_no_update_when_where_clause_false
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1409
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT64 PRIMARY KEY, name STRING, version INT64 );
INSERT INTO users VALUES (1, 'Alice', 5);
INSERT INTO users VALUES (1, 'Alice Old', 3) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, version = EXCLUDED.version WHERE EXCLUDED.version > users.version;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING, created_at TIMESTAMP);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO users VALUES (1, 'Alice Updated', 'newemail@example.com', TIMESTAMP '2024-12-01 00:00:00') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT name, version FROM users WHERE id = 1;
SELECT name, email FROM users WHERE id = 1;
SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_upsert_preserves_columns_not_in_set_clause
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1459
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING, created_at TIMESTAMP);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com', TIMESTAMP '2024-01-01 00:00:00');
INSERT INTO users VALUES (1, 'Alice Updated', 'newemail@example.com', TIMESTAMP '2024-12-01 00:00:00') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT name, email FROM users WHERE id = 1;
SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_error_excluded_keyword_in_wrong_context
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1499
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT EXCLUDED.name FROM users;
SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_upsert_with_null_excluded_value
-- Source: insert_on_conflict_upsert_comprehensive_tdd.rs:1519
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, name STRING, email STRING);
INSERT INTO users VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO users VALUES (1, 'Alice Updated', NULL) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

SELECT name, email FROM users WHERE id = 1;

-- ============================================================================
-- Test: test_merge_null_handling
-- Source: merge_statement_comprehensive_tdd.rs:651
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
INSERT INTO target VALUES (1, 'one'), (NULL, 'null_target');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'updated'), (NULL, 'null_source');
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
INSERT INTO target VALUES (1), (2);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
INSERT INTO target VALUES (1, 'original');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'update1'), (1, 'update2');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT * FROM target WHERE id IS NOT NULL ORDER BY id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id WHEN NOT MATCHED BY SOURCE THEN DELETE;
MERGE INTO target t USING source s ON t.id = s.id WHEN NOT MATCHED THEN INSERT (id) VALUES (s.id);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value;
MERGE INTO nonexistent t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_empty_source
-- Source: merge_statement_comprehensive_tdd.rs:698
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
INSERT INTO target VALUES (1), (2);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
INSERT INTO target VALUES (1, 'original');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'update1'), (1, 'update2');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id WHEN NOT MATCHED BY SOURCE THEN DELETE;
MERGE INTO target t USING source s ON t.id = s.id WHEN NOT MATCHED THEN INSERT (id) VALUES (s.id);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value;
MERGE INTO nonexistent t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_empty_target
-- Source: merge_statement_comprehensive_tdd.rs:736
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
INSERT INTO source VALUES (1), (2);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
INSERT INTO target VALUES (1, 'original');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'update1'), (1, 'update2');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN NOT MATCHED THEN INSERT (id) VALUES (s.id);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value;
MERGE INTO nonexistent t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_error_duplicate_matches
-- Source: merge_statement_comprehensive_tdd.rs:775
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value STRING);
INSERT INTO target VALUES (1, 'original');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value STRING);
INSERT INTO source VALUES (1, 'update1'), (1, 'update2');
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value;
MERGE INTO nonexistent t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_error_table_not_found
-- Source: merge_statement_comprehensive_tdd.rs:814
-- ============================================================================
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO nonexistent t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = s.id;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_error_type_mismatch
-- Source: merge_statement_comprehensive_tdd.rs:843
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id STRING);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_error_column_not_found
-- Source: merge_statement_comprehensive_tdd.rs:875
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.nonexistent = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_atomicity
-- Source: merge_statement_comprehensive_tdd.rs:911
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64 PRIMARY KEY, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30), (2, 40);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
SELECT value FROM target WHERE id = 1;
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_performance_large_dataset
-- Source: merge_statement_comprehensive_tdd.rs:960
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value);
MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_merge_with_returning
-- Source: merge_statement_comprehensive_tdd.rs:1020
-- ============================================================================
DROP TABLE IF EXISTS target;
CREATE TABLE target (id INT64, value INT64);
INSERT INTO target VALUES (1, 10);
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 20), (2, 30);

MERGE INTO target t USING source s ON t.id = s.id WHEN MATCHED THEN UPDATE SET t.value = s.value WHEN NOT MATCHED THEN INSERT (id, value) VALUES (s.id, s.value) RETURNING t.id, t.value;

-- ============================================================================
-- Test: test_basic_upsert_do_update
-- Source: quick_upsert_test.rs:5
-- ============================================================================
CREATE TABLE test.users (id INT64 PRIMARY KEY, name STRING);
INSERT INTO test.users VALUES (1, 'Alice');
INSERT INTO test.users VALUES (1, 'Alice Updated') ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
CREATE TABLE test.products (id INT64 PRIMARY KEY, name STRING);
INSERT INTO test.products VALUES (1, 'Widget');
INSERT INTO test.products VALUES (1, 'Different Name') ON CONFLICT (id) DO NOTHING;
CREATE TABLE test.items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test.items VALUES (1, 'First');
INSERT INTO test.items VALUES (2, 'Second') ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value;

SELECT id, name FROM test.users;
SELECT id, name FROM test.users;
SELECT id, name FROM test.products;
SELECT id, value FROM test.items ORDER BY id;

-- ============================================================================
-- Test: test_basic_upsert_do_nothing
-- Source: quick_upsert_test.rs:45
-- ============================================================================
CREATE TABLE test.products (id INT64 PRIMARY KEY, name STRING);
INSERT INTO test.products VALUES (1, 'Widget');
INSERT INTO test.products VALUES (1, 'Different Name') ON CONFLICT (id) DO NOTHING;
CREATE TABLE test.items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test.items VALUES (1, 'First');
INSERT INTO test.items VALUES (2, 'Second') ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value;

SELECT id, name FROM test.products;
SELECT id, value FROM test.items ORDER BY id;

-- ============================================================================
-- Test: test_upsert_inserts_new_row
-- Source: quick_upsert_test.rs:75
-- ============================================================================
CREATE TABLE test.items (id INT64 PRIMARY KEY, value STRING);
INSERT INTO test.items VALUES (1, 'First');
INSERT INTO test.items VALUES (2, 'Second') ON CONFLICT (id) DO UPDATE SET value = EXCLUDED.value;

SELECT id, value FROM test.items ORDER BY id;

-- ============================================================================
-- Test: test_returning_preserves_insert_order
-- Source: returning_clause_comprehensive_tdd.rs:673
-- ============================================================================
DROP TABLE IF EXISTS seq;
CREATE TABLE seq (id INT64, value STRING);
INSERT INTO seq VALUES (1, 'first'), (2, 'second'), (3, 'third') \ RETURNING id, value;
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, a STRING, b STRING, c STRING);
INSERT INTO nullable VALUES (1, NULL, NULL, NULL) RETURNING *;

-- ============================================================================
-- Test: test_returning_large_batch
-- Source: returning_clause_comprehensive_tdd.rs:701
-- ============================================================================
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, a STRING, b STRING, c STRING);
INSERT INTO nullable VALUES (1, NULL, NULL, NULL) RETURNING *;

-- ============================================================================
-- Test: test_returning_with_all_null_row
-- Source: returning_clause_comprehensive_tdd.rs:729
-- ============================================================================
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, a STRING, b STRING, c STRING);
INSERT INTO nullable VALUES (1, NULL, NULL, NULL) RETURNING *;
