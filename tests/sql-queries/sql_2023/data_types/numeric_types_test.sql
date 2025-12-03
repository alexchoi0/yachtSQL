-- Numeric Types - SQL:2023
-- Description: Numeric data types: INT, FLOAT, DECIMAL, NUMERIC
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id INT64,
    balance NUMERIC
);

INSERT INTO accounts VALUES (1, 100.50);

-- Tag: data_types_numeric_types_test_select_001
SELECT balance FROM accounts WHERE id = 1;

-- NUMERIC with Precision and Scale

-- NUMERIC(precision, scale)
-- precision = total number of digits
-- scale = digits after decimal point
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (
    id INT64,
    amount NUMERIC(10, 2)
);

-- Stores exactly 2 decimal places
INSERT INTO prices VALUES (1, 123.45);
INSERT INTO prices VALUES (2, 999.99);

-- Tag: data_types_numeric_types_test_select_002
SELECT amount FROM prices WHERE id = 1;

-- DECIMAL Type (Alias for NUMERIC)

-- DECIMAL is synonym for NUMERIC
DROP TABLE IF EXISTS test_decimal;
CREATE TABLE test_decimal (
    val DECIMAL(10, 2)
);

INSERT INTO test_decimal VALUES (123.45);

-- Tag: data_types_numeric_types_test_select_003
SELECT val FROM test_decimal;

-- Numeric Rounding

-- Values rounded to specified scale
DROP TABLE IF EXISTS test_rounding;
CREATE TABLE test_rounding (
    val NUMERIC(10, 2)
);

-- 123.456 rounded to 123.46
INSERT INTO test_rounding VALUES (123.456);

-- Tag: data_types_numeric_types_test_select_004
SELECT val FROM test_rounding;

-- Precision Overflow

-- Create table with NUMERIC(5, 2) - max value 999.99
DROP TABLE IF EXISTS test_overflow;
CREATE TABLE test_overflow (
    val NUMERIC(5, 2)
);

-- Valid: within precision
INSERT INTO test_overflow VALUES (999.99);

-- Invalid: exceeds precision (should fail)
-- INSERT INTO test_overflow VALUES (1000.00);

-- INT64 Type (64-bit Integer)

-- Standard integer type
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (
    id INT64,
    value INT64
);

INSERT INTO numbers VALUES (1, 42);
INSERT INTO numbers VALUES (2, -100);
INSERT INTO numbers VALUES (3, 0);

-- Tag: data_types_numeric_types_test_select_005
SELECT * FROM numbers;

-- INT64 Range (Min/Max Values)

-- Test INT64 boundaries
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (
    value INT64
);

-- Maximum INT64: 9223372036854775807
INSERT INTO big_numbers VALUES (9223372036854775807);

-- Minimum INT64: -9223372036854775808
INSERT INTO big_numbers VALUES (-9223372036854775808);

-- Tag: data_types_numeric_types_test_select_006
SELECT * FROM big_numbers;

-- FLOAT64 Type (Double Precision)

-- 64-bit floating point
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (
    id INT64,
    value FLOAT64
);

INSERT INTO measurements VALUES (1, 3.14159);
INSERT INTO measurements VALUES (2, -2.5);
INSERT INTO measurements VALUES (3, 0.0);

-- Tag: data_types_numeric_types_test_select_007
SELECT * FROM measurements;

-- FLOAT64 - Very Small Values

DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (
    value FLOAT64
);

INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);

-- Tag: data_types_numeric_types_test_select_008
SELECT * FROM tiny_numbers;

-- Arithmetic Operations - NUMERIC

-- Exact decimal arithmetic
DROP TABLE IF EXISTS test_arithmetic;
CREATE TABLE test_arithmetic (
    a NUMERIC,
    b NUMERIC
);

INSERT INTO test_arithmetic VALUES (0.1, 0.2);

-- Addition: 0.1 + 0.2 = exactly 0.3
-- Tag: data_types_numeric_types_test_select_009
SELECT a + b FROM test_arithmetic;

-- Arithmetic Operations - Subtraction

DROP TABLE IF EXISTS test_subtraction;
CREATE TABLE test_subtraction (
    val NUMERIC
);

INSERT INTO test_subtraction VALUES (10.50);

-- Tag: data_types_numeric_types_test_select_010
SELECT val - 5.25 FROM test_subtraction;

-- Arithmetic Operations - Multiplication

DROP TABLE IF EXISTS test_multiplication;
CREATE TABLE test_multiplication (
    val NUMERIC
);

INSERT INTO test_multiplication VALUES (3.5);

-- Tag: data_types_numeric_types_test_select_011
SELECT val * 2 FROM test_multiplication;

-- Arithmetic Operations - Division

DROP TABLE IF EXISTS test_division;
CREATE TABLE test_division (
    val NUMERIC
);

INSERT INTO test_division VALUES (10.0);

-- Tag: data_types_numeric_types_test_select_012
SELECT val / 4 FROM test_division;

-- Comparison Operations

DROP TABLE IF EXISTS test_comparison;
CREATE TABLE test_comparison (
    val NUMERIC
);

INSERT INTO test_comparison VALUES (100.50), (99.99), (100.50), (101.00);

-- Equality
-- Tag: data_types_numeric_types_test_select_013
SELECT * FROM test_comparison WHERE val = 100.50;

-- Greater than
-- Tag: data_types_numeric_types_test_select_014
SELECT * FROM test_comparison WHERE val > 100.00;

-- Less than
-- Tag: data_types_numeric_types_test_select_015
SELECT * FROM test_comparison WHERE val < 100.00;

-- Type Conversions - NUMERIC to STRING

DROP TABLE IF EXISTS test_to_string;
CREATE TABLE test_to_string (
    val NUMERIC(10, 2)
);

INSERT INTO test_to_string VALUES (123.45);

-- Tag: data_types_numeric_types_test_select_016
SELECT CAST(val AS STRING) FROM test_to_string;

-- Type Conversions - STRING to NUMERIC

DROP TABLE IF EXISTS test_from_string;
CREATE TABLE test_from_string (
    val NUMERIC
);

INSERT INTO test_from_string VALUES (CAST('123.45' AS NUMERIC));

-- Tag: data_types_numeric_types_test_select_017
SELECT val FROM test_from_string;

-- Type Conversions - INT64 to NUMERIC

DROP TABLE IF EXISTS test_int_to_numeric;
CREATE TABLE test_int_to_numeric (
    int_val INT64,
    num_val NUMERIC
);

INSERT INTO test_int_to_numeric VALUES (100, CAST(100 AS NUMERIC));

-- Tag: data_types_numeric_types_test_select_018
SELECT * FROM test_int_to_numeric WHERE int_val = num_val;

-- Type Conversions - FLOAT64 to NUMERIC

DROP TABLE IF EXISTS test_float_to_numeric;
CREATE TABLE test_float_to_numeric (
    float_val FLOAT64,
    num_val NUMERIC
);

INSERT INTO test_float_to_numeric VALUES (123.45, CAST(123.45 AS NUMERIC));

-- Tag: data_types_numeric_types_test_select_019
SELECT * FROM test_float_to_numeric;

-- NULL Handling

DROP TABLE IF EXISTS test_null;
CREATE TABLE test_null (
    val NUMERIC
);

INSERT INTO test_null VALUES (100.50);
INSERT INTO test_null VALUES (NULL);

-- IS NULL
-- Tag: data_types_numeric_types_test_select_020
SELECT * FROM test_null WHERE val IS NULL;

-- IS NOT NULL
-- Tag: data_types_numeric_types_test_select_021
SELECT * FROM test_null WHERE val IS NOT NULL;

-- Arithmetic with NULL
-- Tag: data_types_numeric_types_test_select_022
SELECT val + 10 FROM test_null;

-- Aggregation Functions - SUM

DROP TABLE IF EXISTS test_sum;
CREATE TABLE test_sum (
    val NUMERIC
);

INSERT INTO test_sum VALUES (10.5), (20.3), (30.2);

-- Tag: data_types_numeric_types_test_select_023
SELECT SUM(val) FROM test_sum;

-- Aggregation Functions - AVG

DROP TABLE IF EXISTS test_avg;
CREATE TABLE test_avg (
    val NUMERIC
);

INSERT INTO test_avg VALUES (10), (20), (30);

-- Tag: data_types_numeric_types_test_select_024
SELECT AVG(val) FROM test_avg;

-- Aggregation Functions - MIN/MAX

DROP TABLE IF EXISTS test_min_max;
CREATE TABLE test_min_max (
    val NUMERIC
);

INSERT INTO test_min_max VALUES (10.5), (99.9), (5.1), (50.0);

-- Tag: data_types_numeric_types_test_select_025
SELECT MIN(val), MAX(val) FROM test_min_max;

-- ORDER BY with NUMERIC

DROP TABLE IF EXISTS test_order;
CREATE TABLE test_order (
    id INT64,
    val NUMERIC
);

INSERT INTO test_order VALUES (1, 50.5), (2, 10.1), (3, 99.9), (4, 25.0);

-- Ascending order
-- Tag: data_types_numeric_types_test_select_026
SELECT * FROM test_order ORDER BY val ASC;

-- Descending order
-- Tag: data_types_numeric_types_test_select_027
SELECT * FROM test_order ORDER BY val DESC;

-- GROUP BY with NUMERIC

DROP TABLE IF EXISTS test_group;
CREATE TABLE test_group (
    category STRING,
    amount NUMERIC
);

INSERT INTO test_group VALUES
    ('A', 100.00),
    ('B', 200.00),
    ('A', 150.00),
    ('B', 50.00);

-- Tag: data_types_numeric_types_test_select_028
SELECT category, SUM(amount) as total
FROM test_group
GROUP BY category
ORDER BY category;
-- A: 250.00
-- B: 250.00

-- Financial Calculations

-- Precise money calculations
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    id INT64,
    amount NUMERIC(15, 2),
    tax_rate NUMERIC(5, 4)
);

INSERT INTO transactions VALUES (1, 1000.00, 0.0825);

-- Calculate tax (exact)
-- Tag: data_types_numeric_types_test_select_001
SELECT
    id,
    amount,
    amount * tax_rate as tax,
    amount + (amount * tax_rate) as total
FROM transactions;
-- id: 1
-- amount: 1000.00
-- tax: 82.50
-- total: 1082.50

-- Scale Promotion in Operations

DROP TABLE IF EXISTS test_scale;
CREATE TABLE test_scale (
    val1 NUMERIC(10, 2),
    val2 NUMERIC(10, 4)
);

INSERT INTO test_scale VALUES (100.50, 0.1234);

-- Result should have sufficient scale
-- Tag: data_types_numeric_types_test_select_029
SELECT val1 * val2 FROM test_scale;

-- Integer Types - Aliases

-- INTEGER (alias for INT64)
DROP TABLE IF EXISTS test_integer;
CREATE TABLE test_integer (
    val INTEGER
);

INSERT INTO test_integer VALUES (42);

-- BIGINT (alias for INT64)
DROP TABLE IF EXISTS test_bigint;
CREATE TABLE test_bigint (
    val BIGINT
);

INSERT INTO test_bigint VALUES (9223372036854775807);

-- DOUBLE PRECISION (alias for FLOAT64)

DROP TABLE IF EXISTS test_double;
CREATE TABLE test_double (
    val DOUBLE PRECISION
);

INSERT INTO test_double VALUES (3.14159);

-- REAL (smaller precision float)
DROP TABLE IF EXISTS test_real;
CREATE TABLE test_real (
    val REAL
);

INSERT INTO test_real VALUES (3.14);

-- Negative Zero and Special Cases

DROP TABLE IF EXISTS test_special;
CREATE TABLE test_special (
    val NUMERIC
);

INSERT INTO test_special VALUES (0);
INSERT INTO test_special VALUES (-0);

-- Both should be equal
-- Tag: data_types_numeric_types_test_select_030
SELECT * FROM test_special WHERE val = 0;

-- End of File
