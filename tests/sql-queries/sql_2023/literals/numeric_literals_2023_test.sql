-- Numeric Literals 2023 - SQL:2023
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: literals_numeric_literals_2023_test_select_001
SELECT 0x0 AS hex_zero;

-- Tag: literals_numeric_literals_2023_test_select_002
SELECT 0x1 AS hex_one;

-- Tag: literals_numeric_literals_2023_test_select_003
SELECT 0xA AS hex_ten;

-- Tag: literals_numeric_literals_2023_test_select_004
SELECT 0xF AS hex_fifteen;

-- Tag: literals_numeric_literals_2023_test_select_005
SELECT 0x10 AS hex_sixteen;

-- Tag: literals_numeric_literals_2023_test_select_006
SELECT 0xFF AS hex_255;

-- Lowercase hex digits
-- Tag: literals_numeric_literals_2023_test_select_007
SELECT 0xff AS hex_255_lower;

-- Tag: literals_numeric_literals_2023_test_select_008
SELECT 0xdeadbeef AS hex_large;

-- Uppercase hex digits
-- Tag: literals_numeric_literals_2023_test_select_009
SELECT 0xDEADBEEF AS hex_large_upper;

-- Mixed case (valid)
-- Tag: literals_numeric_literals_2023_test_select_010
SELECT 0xDeAdBeEf AS hex_mixed;

-- Common hex values
-- Tag: literals_numeric_literals_2023_test_select_011
SELECT 0x00 AS zero,
       0x01 AS one,
       0x0F AS fifteen,
       0x10 AS sixteen,
       0xFF AS max_byte;

-- Larger hex values
-- Tag: literals_numeric_literals_2023_test_select_012
SELECT 0xFFFF AS max_16bit;

-- Tag: literals_numeric_literals_2023_test_select_013
SELECT 0xFFFFFFFF AS max_32bit;

-- Tag: literals_numeric_literals_2023_test_select_014
SELECT 0xFFFFFFFFFFFFFFFF AS max_64bit;

-- Hex in arithmetic
-- Tag: literals_numeric_literals_2023_test_select_015
SELECT 0x10 + 0x20 AS sum;

-- Tag: literals_numeric_literals_2023_test_select_016
SELECT 0xFF * 0x02 AS product;

-- Tag: literals_numeric_literals_2023_test_select_017
SELECT 0x100 - 0x01 AS difference;

-- Tag: literals_numeric_literals_2023_test_select_018
SELECT 0x10 / 0x04 AS quotient;

-- Hex in comparisons
-- Tag: literals_numeric_literals_2023_test_select_019
SELECT 0xFF > 0x80 AS comparison;

-- Tag: literals_numeric_literals_2023_test_select_020
SELECT 0x10 = 16 AS equal_to_decimal;

-- ----------------------------------------------------------------------------
-- 2. Octal Literals (0o prefix)
-- ----------------------------------------------------------------------------

-- Basic octal literals
-- Tag: literals_numeric_literals_2023_test_select_021
SELECT 0o0 AS octal_zero;

-- Tag: literals_numeric_literals_2023_test_select_022
SELECT 0o1 AS octal_one;

-- Tag: literals_numeric_literals_2023_test_select_023
SELECT 0o7 AS octal_seven;

-- Tag: literals_numeric_literals_2023_test_select_024
SELECT 0o10 AS octal_eight;

-- Tag: literals_numeric_literals_2023_test_select_025
SELECT 0o77 AS octal_63;

-- Common octal values (Unix permissions)
-- Tag: literals_numeric_literals_2023_test_select_026
SELECT 0o644 AS rw_r_r;

-- Tag: literals_numeric_literals_2023_test_select_027
SELECT 0o755 AS rwx_rx_rx;

-- Tag: literals_numeric_literals_2023_test_select_028
SELECT 0o777 AS rwx_rwx_rwx;

-- Tag: literals_numeric_literals_2023_test_select_029
SELECT 0o000 AS no_permissions;

-- Octal arithmetic
-- Tag: literals_numeric_literals_2023_test_select_030
SELECT 0o10 + 0o10 AS sum;

-- Tag: literals_numeric_literals_2023_test_select_031
SELECT 0o100 * 0o2 AS product;

-- Octal comparisons
-- Tag: literals_numeric_literals_2023_test_select_032
SELECT 0o10 = 8 AS equal_to_decimal;

-- Tag: literals_numeric_literals_2023_test_select_033
SELECT 0o10 = 0x08 AS equal_to_hex;

-- ----------------------------------------------------------------------------
-- 3. Binary Literals (0b prefix)
-- ----------------------------------------------------------------------------

-- Basic binary literals
-- Tag: literals_numeric_literals_2023_test_select_034
SELECT 0b0 AS binary_zero;

-- Tag: literals_numeric_literals_2023_test_select_035
SELECT 0b1 AS binary_one;

-- Tag: literals_numeric_literals_2023_test_select_036
SELECT 0b10 AS binary_two;

-- Tag: literals_numeric_literals_2023_test_select_037
SELECT 0b11 AS binary_three;

-- Tag: literals_numeric_literals_2023_test_select_038
SELECT 0b100 AS binary_four;

-- Tag: literals_numeric_literals_2023_test_select_039
SELECT 0b1111 AS binary_fifteen;

-- 8-bit binary values
-- Tag: literals_numeric_literals_2023_test_select_040
SELECT 0b00000000 AS zero_byte;

-- Tag: literals_numeric_literals_2023_test_select_041
SELECT 0b11111111 AS max_byte;

-- Tag: literals_numeric_literals_2023_test_select_042
SELECT 0b10101010 AS alternating;

-- Tag: literals_numeric_literals_2023_test_select_043
SELECT 0b01010101 AS alternating_inverse;

-- Powers of 2 in binary
-- Tag: literals_numeric_literals_2023_test_select_044
SELECT 0b1 AS pow_2_0;

-- Tag: literals_numeric_literals_2023_test_select_045
SELECT 0b10 AS pow_2_1;

-- Tag: literals_numeric_literals_2023_test_select_046
SELECT 0b100 AS pow_2_2;

-- Tag: literals_numeric_literals_2023_test_select_047
SELECT 0b1000 AS pow_2_3;

-- Tag: literals_numeric_literals_2023_test_select_048
SELECT 0b10000 AS pow_2_4;

-- Tag: literals_numeric_literals_2023_test_select_049
SELECT 0b100000 AS pow_2_5;

-- Tag: literals_numeric_literals_2023_test_select_050
SELECT 0b1000000 AS pow_2_6;

-- Tag: literals_numeric_literals_2023_test_select_051
SELECT 0b10000000 AS pow_2_7;

-- Binary arithmetic
-- Tag: literals_numeric_literals_2023_test_select_052
SELECT 0b1010 + 0b0101 AS sum;

-- Tag: literals_numeric_literals_2023_test_select_053
SELECT 0b1111 * 0b10 AS product;

-- Binary comparisons
-- Tag: literals_numeric_literals_2023_test_select_054
SELECT 0b1010 = 10 AS equal_to_decimal;

-- Tag: literals_numeric_literals_2023_test_select_055
SELECT 0b1010 = 0xA AS equal_to_hex;

-- Tag: literals_numeric_literals_2023_test_select_056
SELECT 0b1010 = 0o12 AS equal_to_octal;

-- Bitwise operations (if supported)
-- Tag: literals_numeric_literals_2023_test_select_057
SELECT 0b1100 | 0b1010 AS bitwise_or;

-- Tag: literals_numeric_literals_2023_test_select_058
SELECT 0b1100 & 0b1010 AS bitwise_and;

-- Tag: literals_numeric_literals_2023_test_select_059
SELECT 0b1100 ^ 0b1010 AS bitwise_xor;

-- ----------------------------------------------------------------------------
-- 4. Underscored Numeric Literals (for readability)
-- ----------------------------------------------------------------------------

-- Decimal with underscores
-- Tag: literals_numeric_literals_2023_test_select_060
SELECT 1_000 AS one_thousand;

-- Tag: literals_numeric_literals_2023_test_select_061
SELECT 1_000_000 AS one_million;

-- Tag: literals_numeric_literals_2023_test_select_062
SELECT 1_234_567_890 AS large_number;

-- Underscores in different positions
-- Tag: literals_numeric_literals_2023_test_select_063
SELECT 1000_000 AS also_one_million;

-- Tag: literals_numeric_literals_2023_test_select_064
SELECT 1_2_3_4 AS separated;

-- Floating point with underscores
-- Tag: literals_numeric_literals_2023_test_select_065
SELECT 3.141_592_653 AS pi;

-- Tag: literals_numeric_literals_2023_test_select_066
SELECT 1_234.567_89 AS decimal_with_underscores;

-- Tag: literals_numeric_literals_2023_test_select_067
SELECT 0.000_001 AS one_millionth;

-- Scientific notation with underscores
-- Tag: literals_numeric_literals_2023_test_select_068
SELECT 6.022_140_76e23 AS avogadro;

-- Tag: literals_numeric_literals_2023_test_select_069
SELECT 1.609_344e3 AS meters_per_mile;

-- Hexadecimal with underscores
-- Tag: literals_numeric_literals_2023_test_select_070
SELECT 0xFF_FF_FF_FF AS max_32bit_readable;

-- Tag: literals_numeric_literals_2023_test_select_071
SELECT 0xDEAD_BEEF AS readable_hex;

-- Tag: literals_numeric_literals_2023_test_select_072
SELECT 0x00_11_22_33 AS color_hex;

-- Binary with underscores (for byte grouping)
-- Tag: literals_numeric_literals_2023_test_select_073
SELECT 0b1111_1111 AS byte_grouped;

-- Tag: literals_numeric_literals_2023_test_select_074
SELECT 0b1111_0000_1010_1100 AS word_grouped;

-- Tag: literals_numeric_literals_2023_test_select_075
SELECT 0b1010_1010_1010_1010 AS pattern;

-- Octal with underscores
-- Tag: literals_numeric_literals_2023_test_select_076
SELECT 0o777_777 AS octal_grouped;

-- Tag: literals_numeric_literals_2023_test_select_077
SELECT 0o1_234_567 AS large_octal;

-- Mixing underscores in different bases
-- Tag: literals_numeric_literals_2023_test_select_078
SELECT 0b1111_1111 AS binary_byte,
       0xFF AS hex_byte,
       0o377 AS octal_byte,
       255 AS decimal_byte;

-- Financial numbers with underscores
-- Tag: literals_numeric_literals_2023_test_select_079
SELECT 1_000_000.00 AS one_million_dollars;

-- Tag: literals_numeric_literals_2023_test_select_080
SELECT 50_000.50 AS salary;

-- Large integers with underscores
-- Tag: literals_numeric_literals_2023_test_select_081
SELECT 9_223_372_036_854_775_807 AS max_int64;

-- ----------------------------------------------------------------------------
-- 5. Combining Different Literal Types
-- ----------------------------------------------------------------------------

-- All representations of the same value
-- Tag: literals_numeric_literals_2023_test_select_082
SELECT 255 AS decimal,
       0xFF AS hex,
       0o377 AS octal,
       0b11111111 AS binary;

-- All representations with underscores
-- Tag: literals_numeric_literals_2023_test_select_083
SELECT 1_000 AS decimal,
       0x3_E8 AS hex,
       0o1_750 AS octal,
       0b11_1110_1000 AS binary;

-- Arithmetic mixing different bases
-- Tag: literals_numeric_literals_2023_test_select_084
SELECT 0x10 + 0o10 + 0b10 + 10 AS sum;

-- Tag: literals_numeric_literals_2023_test_select_085
SELECT (0xFF + 0o377 + 0b11111111) / 3 AS average;

-- ----------------------------------------------------------------------------
-- 6. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Table for configuration values
DROP TABLE IF EXISTS system_config;
CREATE TABLE system_config (
    config_id INT64,
    config_name STRING,
    flags INT64,
    permissions INT64,
    color_code INT64
);

-- Insert with various literal types
INSERT INTO system_config VALUES
    (1, 'user_flags', 0b1010_1010, 0o755, 0xFF_00_00),
    (2, 'admin_flags', 0b1111_1111, 0o777, 0x00_FF_00),
    (3, 'guest_flags', 0b0000_0001, 0o644, 0x00_00_FF);

-- Tag: literals_numeric_literals_2023_test_select_086
SELECT config_name,
       flags,
       permissions,
       color_code
FROM system_config;

-- Bit masks and flags
DROP TABLE IF EXISTS feature_flags;
CREATE TABLE feature_flags (
    feature_id INT64,
    enabled_features INT64
);

-- Feature bits: 0b0001=A, 0b0010=B, 0b0100=C, 0b1000=D
INSERT INTO feature_flags VALUES
    (1, 0b1111),  -- All features enabled
    (2, 0b1010),  -- Features B and D
    (3, 0b0101);  -- Features A and C

-- Check if feature A is enabled (bit 0)
-- Tag: literals_numeric_literals_2023_test_select_087
SELECT feature_id,
       (enabled_features & 0b0001) > 0 AS has_feature_a,
       (enabled_features & 0b0010) > 0 AS has_feature_b,
       (enabled_features & 0b0100) > 0 AS has_feature_c,
       (enabled_features & 0b1000) > 0 AS has_feature_d
FROM feature_flags;

-- Color codes in hex
DROP TABLE IF EXISTS colors;
CREATE TABLE colors (
    color_id INT64,
    color_name STRING,
    rgb_value INT64
);

INSERT INTO colors VALUES
    (1, 'Red', 0xFF_00_00),
    (2, 'Green', 0x00_FF_00),
    (3, 'Blue', 0x00_00_FF),
    (4, 'White', 0xFF_FF_FF),
    (5, 'Black', 0x00_00_00),
    (6, 'Yellow', 0xFF_FF_00),
    (7, 'Cyan', 0x00_FF_FF),
    (8, 'Magenta', 0xFF_00_FF);

-- Extract RGB components
-- Tag: literals_numeric_literals_2023_test_select_088
SELECT color_name,
       (rgb_value >> 16) & 0xFF AS red,
       (rgb_value >> 8) & 0xFF AS green,
       rgb_value & 0xFF AS blue
FROM colors;

-- File permissions (Unix-style)
DROP TABLE IF EXISTS file_permissions;
CREATE TABLE file_permissions (
    file_id INT64,
    filename STRING,
    permissions INT64
);

INSERT INTO file_permissions VALUES
    (1, 'script.sh', 0o755),    -- rwxr-xr-x
    (2, 'config.txt', 0o644),   -- rw-r--r--
    (3, 'secret.key', 0o600),   -- rw-------
    (4, 'public.html', 0o644);  -- rw-r--r--

-- Tag: literals_numeric_literals_2023_test_select_089
SELECT filename,
       permissions,
       (permissions & 0o700) >> 6 AS owner_perms,
       (permissions & 0o070) >> 3 AS group_perms,
       (permissions & 0o007) AS other_perms
FROM file_permissions;

-- Large numbers for financial data
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT64,
    amount NUMERIC(20, 2)
);

INSERT INTO transactions VALUES
    (1, 1_000_000.00),
    (2, 500_000.50),
    (3, 10_000_000.00);

-- Tag: literals_numeric_literals_2023_test_select_090
SELECT transaction_id,
       amount,
       amount * 1.05 AS with_5_percent_increase
FROM transactions
WHERE amount > 750_000.00;

-- ----------------------------------------------------------------------------
-- 7. Edge Cases and Limits
-- ----------------------------------------------------------------------------

-- Minimum values
-- Tag: literals_numeric_literals_2023_test_select_091
SELECT 0x0 AS hex_min,
       0o0 AS octal_min,
       0b0 AS binary_min;

-- Maximum single-digit values in each base
-- Tag: literals_numeric_literals_2023_test_select_092
SELECT 0xF AS hex_max_digit,
       0o7 AS octal_max_digit,
       0b1 AS binary_max_digit;

-- Leading zeros (valid)
-- Tag: literals_numeric_literals_2023_test_select_093
SELECT 0x00FF AS hex_leading_zeros,
       0o0077 AS octal_leading_zeros,
       0b00001111 AS binary_leading_zeros;

-- Maximum practical values
-- Tag: literals_numeric_literals_2023_test_select_094
SELECT 0xFFFFFFFFFFFFFFFF AS max_64bit_hex;

-- Underscores at various positions (all valid)
-- Tag: literals_numeric_literals_2023_test_select_095
SELECT 1_0 AS ten,
       10_0 AS hundred,
       1_00 AS also_hundred;

-- Multiple consecutive underscores (implementation may vary)
-- SELECT 1__000 AS double_underscore;
-- Note: May not be valid in all implementations

-- Underscore at start/end (invalid - would cause syntax error)
-- SELECT _1000 AS invalid_start;
-- SELECT 1000_ AS invalid_end;

-- ----------------------------------------------------------------------------
-- 8. Comparison and Conversion Tests
-- ----------------------------------------------------------------------------

-- All equivalent values
-- Tag: literals_numeric_literals_2023_test_select_001
SELECT
    CASE WHEN 0xFF = 255 THEN 'hex matches decimal' END AS test1,
    CASE WHEN 0o377 = 255 THEN 'octal matches decimal' END AS test2,
    CASE WHEN 0b11111111 = 255 THEN 'binary matches decimal' END AS test3,
    CASE WHEN 0xFF = 0o377 THEN 'hex matches octal' END AS test4,
    CASE WHEN 0xFF = 0b11111111 THEN 'hex matches binary' END AS test5;

-- Type compatibility
-- Tag: literals_numeric_literals_2023_test_select_096
SELECT typeof(0xFF) AS hex_type,
       typeof(0o77) AS octal_type,
       typeof(0b11) AS binary_type,
       typeof(100) AS decimal_type;

-- CAST and CONVERT
-- Tag: literals_numeric_literals_2023_test_select_097
SELECT CAST(0xFF AS STRING) AS hex_as_string,
       CAST(0o77 AS FLOAT64) AS octal_as_float,
       CAST(0b11 AS NUMERIC) AS binary_as_numeric;

-- ----------------------------------------------------------------------------
-- 9. Performance Notes
-- ----------------------------------------------------------------------------

-- Note: Different literal formats are compile-time constants
-- They all convert to the same runtime value, so there's no
-- performance difference between:
--   SELECT 255
--   SELECT 0xFF
--   SELECT 0o377
--   SELECT 0b11111111
--   SELECT 2_5_5

-- However, using appropriate formats improves code readability:
-- - Use 0x for memory addresses, color codes, bit patterns
-- - Use 0o for Unix permissions
-- - Use 0b for bit flags and binary protocols
-- - Use underscores for large numbers: 1_000_000 vs 1000000

-- End of Numeric Literals Tests
