-- ============================================================================
-- Dml - GoogleSQL/BigQuery
-- ============================================================================
-- Source: Migrated from data_types.rs, safe_functions_comprehensive_tdd.rs
-- Description: Data Manipulation Language: INSERT, UPDATE, DELETE, MERGE
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM events;
SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_timestamp_type
-- Source: data_types.rs:114
-- ============================================================================
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_null_values
-- Source: data_types.rs:134
-- ============================================================================
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_mixed_types_in_table
-- Source: data_types.rs:160
-- ============================================================================
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_numeric_type
-- Source: data_types.rs:186
-- ============================================================================
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_bytes_type
-- Source: data_types.rs:206
-- ============================================================================
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_array_type
-- Source: data_types.rs:223
-- ============================================================================
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_struct_type
-- Source: data_types.rs:243
-- ============================================================================
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_nested_safe_functions
-- Source: safe_functions_comprehensive_tdd.rs:494
-- ============================================================================
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, 1);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2), (10, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT SAFE_MULTIPLY(SAFE_ADD(a, b), SAFE_SUBTRACT(a, b)) as result FROM nums;
SELECT SAFE_MULTIPLY(SAFE_ADD(a, b), 2) as result FROM nums;
SELECT SAFE_ADD(a, b) as add_result, SAFE_MULTIPLY(a, b) as mul_result, SAFE_DIVIDE(a, b) as div_result FROM nums;
SELECT a / b as result FROM nums ORDER BY b;
SELECT SAFE_DIVIDE(a, b) as result FROM nums ORDER BY b;
SELECT a * b as result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as result FROM nums ORDER BY a;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_safe_function_with_overflow_in_nested
-- Source: safe_functions_comprehensive_tdd.rs:517
-- ============================================================================
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (9223372036854775807, 1);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2), (10, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT SAFE_MULTIPLY(SAFE_ADD(a, b), 2) as result FROM nums;
SELECT SAFE_ADD(a, b) as add_result, SAFE_MULTIPLY(a, b) as mul_result, SAFE_DIVIDE(a, b) as div_result FROM nums;
SELECT a / b as result FROM nums ORDER BY b;
SELECT SAFE_DIVIDE(a, b) as result FROM nums ORDER BY b;
SELECT a * b as result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as result FROM nums ORDER BY a;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_safe_functions_preserve_null
-- Source: safe_functions_comprehensive_tdd.rs:537
-- ============================================================================
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (NULL, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2), (10, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT SAFE_ADD(a, b) as add_result, SAFE_MULTIPLY(a, b) as mul_result, SAFE_DIVIDE(a, b) as div_result FROM nums;
SELECT a / b as result FROM nums ORDER BY b;
SELECT SAFE_DIVIDE(a, b) as result FROM nums ORDER BY b;
SELECT a * b as result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as result FROM nums ORDER BY a;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_safe_vs_regular_divide
-- Source: safe_functions_comprehensive_tdd.rs:562
-- ============================================================================
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (10, 2), (10, 5);
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT a / b as result FROM nums ORDER BY b;
SELECT SAFE_DIVIDE(a, b) as result FROM nums ORDER BY b;
SELECT a * b as result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as result FROM nums ORDER BY a;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_safe_vs_regular_multiply
-- Source: safe_functions_comprehensive_tdd.rs:592
-- ============================================================================
DROP TABLE IF EXISTS nums;
CREATE TABLE nums (a INT64, b INT64);
INSERT INTO nums VALUES (5, 10), (3, 7);
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT a * b as result FROM nums ORDER BY a;
SELECT SAFE_MULTIPLY(a, b) as result FROM nums ORDER BY a;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_try_cast_valid
-- Source: safe_functions_comprehensive_tdd.rs:625
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_try_cast_invalid
-- Source: safe_functions_comprehensive_tdd.rs:644
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (text STRING);
INSERT INTO data VALUES ('abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT TRY_CAST(text AS INT64) as result FROM data;
SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;

-- ============================================================================
-- Test: test_try_cast_in_table
-- Source: safe_functions_comprehensive_tdd.rs:666
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '100'), (2, 'invalid'), (3, '200'), (4, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

SELECT id, TRY_CAST(text AS INT64) as num FROM data ORDER BY id;
SELECT id, SAFE_DIVIDE(id, value) as result FROM data WHERE id < 50;
