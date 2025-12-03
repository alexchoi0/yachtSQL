-- Math Functions - SQL:2023
-- Description: Mathematical functions: ROUND, FLOOR, CEIL, ABS, POWER
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_math_functions_test_select_001
SELECT ABS(42) AS result;

-- Tag: functions_math_functions_test_select_002
SELECT ABS(-42) AS result;

-- Tag: functions_math_functions_test_select_003
SELECT ABS(-3.14159) AS result;

-- Tag: functions_math_functions_test_select_004
SELECT ABS(0) AS result;

-- Tag: functions_math_functions_test_select_005
SELECT ABS(NULL) AS result;

-- SIGN - Sign of number (-1, 0, 1)
-- Tag: functions_math_functions_test_select_006
SELECT SIGN(42) AS result;

-- Tag: functions_math_functions_test_select_007
SELECT SIGN(-42) AS result;

-- Tag: functions_math_functions_test_select_008
SELECT SIGN(0) AS result;

-- Tag: functions_math_functions_test_select_009
SELECT SIGN(3.14) AS result;

-- Tag: functions_math_functions_test_select_010
SELECT SIGN(-0.001) AS result;

-- CEIL/CEILING - Round up
-- Tag: functions_math_functions_test_select_011
SELECT CEIL(3.2) AS result;

-- Tag: functions_math_functions_test_select_012
SELECT CEIL(-3.8) AS result;

-- Tag: functions_math_functions_test_select_013
SELECT CEIL(5.0) AS result;

-- Tag: functions_math_functions_test_select_014
SELECT CEILING(3.14) AS result;

-- Tag: functions_math_functions_test_select_015
SELECT CEIL(1.2) AS c1, CEIL(2.8) AS c2, CEIL(-1.5) AS c3;

-- FLOOR - Round down
-- Tag: functions_math_functions_test_select_016
SELECT FLOOR(3.8) AS result;

-- Tag: functions_math_functions_test_select_017
SELECT FLOOR(-3.2) AS result;

-- Tag: functions_math_functions_test_select_018
SELECT FLOOR(5.0) AS result;

-- Tag: functions_math_functions_test_select_019
SELECT FLOOR(1.2) AS f1, FLOOR(2.8) AS f2, FLOOR(-1.5) AS f3;

-- ROUND - Round to nearest
-- Tag: functions_math_functions_test_select_020
SELECT ROUND(3.5) AS result;

-- Tag: functions_math_functions_test_select_021
SELECT ROUND(3.4) AS result;

-- Tag: functions_math_functions_test_select_022
SELECT ROUND(3.14159, 2) AS result;

-- Tag: functions_math_functions_test_select_023
SELECT ROUND(3.14159, 3) AS result;

-- Tag: functions_math_functions_test_select_024
SELECT ROUND(1234.5678, -2) AS result;

-- Tag: functions_math_functions_test_select_025
SELECT ROUND(1234.5678, -1) AS result;

-- Tag: functions_math_functions_test_select_026
SELECT ROUND(-1.5) AS result;

-- TRUNC/TRUNCATE - Truncate decimals
-- Tag: functions_math_functions_test_select_027
SELECT TRUNC(3.8) AS result;

-- Tag: functions_math_functions_test_select_028
SELECT TRUNC(-3.8) AS result;

-- Tag: functions_math_functions_test_select_029
SELECT TRUNC(3.14159, 2) AS result;

-- Tag: functions_math_functions_test_select_030
SELECT TRUNC(3.14159, 3) AS result;

-- Tag: functions_math_functions_test_select_031
SELECT TRUNCATE(5.9) AS result;

-- MOD - Modulo/Remainder
-- Tag: functions_math_functions_test_select_032
SELECT MOD(10, 3) AS result;

-- Tag: functions_math_functions_test_select_033
SELECT MOD(17, 5) AS result;

-- Tag: functions_math_functions_test_select_034
SELECT MOD(10, 2) AS result;

-- Tag: functions_math_functions_test_select_035
SELECT MOD(-10, 3) AS result;

-- Tag: functions_math_functions_test_select_036
SELECT MOD(10, -3) AS result;

-- Tag: functions_math_functions_test_select_037
SELECT MOD(10.5, 3.0) AS result;

-- ----------------------------------------------------------------------------
-- 2. POWER AND ROOT FUNCTIONS
-- ----------------------------------------------------------------------------

-- POWER - Exponentiation
-- Tag: functions_math_functions_test_select_038
SELECT POWER(2, 3) AS result;

-- Tag: functions_math_functions_test_select_039
SELECT POWER(10, 2) AS result;

-- Tag: functions_math_functions_test_select_040
SELECT POWER(2, -2) AS result;

-- Tag: functions_math_functions_test_select_041
SELECT POWER(42, 0) AS result;

-- Tag: functions_math_functions_test_select_042
SELECT POWER(4, 0.5) AS result;

-- Tag: functions_math_functions_test_select_043
SELECT POWER(8, 1.0/3.0) AS result;

-- POW - Alias for POWER
-- Tag: functions_math_functions_test_select_044
SELECT POW(2, 3) AS result;

-- Tag: functions_math_functions_test_select_045
SELECT POW(5, 2) AS result;

-- SQRT - Square root
-- Tag: functions_math_functions_test_select_046
SELECT SQRT(16) AS result;

-- Tag: functions_math_functions_test_select_047
SELECT SQRT(2) AS result;

-- Tag: functions_math_functions_test_select_048
SELECT SQRT(0) AS result;

-- Tag: functions_math_functions_test_select_049
SELECT SQRT(144) AS result;

-- SQRT of negative should error
-- SELECT SQRT(-1) AS result;

-- EXP - e raised to power
-- Tag: functions_math_functions_test_select_050
SELECT EXP(0) AS result;

-- Tag: functions_math_functions_test_select_051
SELECT EXP(1) AS result;

-- Tag: functions_math_functions_test_select_052
SELECT EXP(-1) AS result;

-- Tag: functions_math_functions_test_select_053
SELECT EXP(2) AS result;

-- ----------------------------------------------------------------------------
-- 3. LOGARITHMIC FUNCTIONS
-- ----------------------------------------------------------------------------

-- LN - Natural logarithm (base e)
-- Tag: functions_math_functions_test_select_054
SELECT LN(1) AS result;

-- Tag: functions_math_functions_test_select_055
SELECT LN(EXP(1)) AS result;

-- Tag: functions_math_functions_test_select_056
SELECT LN(10) AS result;

-- Tag: functions_math_functions_test_select_057
SELECT LN(2.718281828) AS result;

-- LN of zero or negative should error
-- SELECT LN(0) AS result;
-- SELECT LN(-1) AS result;

-- LOG - Natural logarithm (in BigQuery) or base-10 (PostgreSQL)
-- Tag: functions_math_functions_test_select_058
SELECT LOG(10) AS result;

-- Tag: functions_math_functions_test_select_059
SELECT LOG(100, 10) AS result;

-- Tag: functions_math_functions_test_select_060
SELECT LOG(8, 2) AS result;

-- Tag: functions_math_functions_test_select_061
SELECT LOG(1000, 10) AS result;

-- LOG10 - Base-10 logarithm
-- Tag: functions_math_functions_test_select_062
SELECT LOG10(100) AS result;

-- Tag: functions_math_functions_test_select_063
SELECT LOG10(1000) AS result;

-- Tag: functions_math_functions_test_select_064
SELECT LOG10(1) AS result;

-- Tag: functions_math_functions_test_select_065
SELECT LOG10(10) AS result;

-- ----------------------------------------------------------------------------
-- 4. TRIGONOMETRIC FUNCTIONS
-- ----------------------------------------------------------------------------

-- SIN - Sine (input in radians)
-- Tag: functions_math_functions_test_select_066
SELECT SIN(0) AS result;

-- Tag: functions_math_functions_test_select_067
SELECT SIN(PI() / 2) AS result;

-- Tag: functions_math_functions_test_select_068
SELECT SIN(PI()) AS result;

-- Tag: functions_math_functions_test_select_069
SELECT SIN(PI() / 6) AS result;

-- COS - Cosine (input in radians)
-- Tag: functions_math_functions_test_select_070
SELECT COS(0) AS result;

-- Tag: functions_math_functions_test_select_071
SELECT COS(PI()) AS result;

-- Tag: functions_math_functions_test_select_072
SELECT COS(PI() / 2) AS result;

-- Tag: functions_math_functions_test_select_073
SELECT COS(PI() / 3) AS result;

-- TAN - Tangent (input in radians)
-- Tag: functions_math_functions_test_select_074
SELECT TAN(0) AS result;

-- Tag: functions_math_functions_test_select_075
SELECT TAN(PI() / 4) AS result;

-- Tag: functions_math_functions_test_select_076
SELECT TAN(PI() / 6) AS result;

-- ASIN - Arcsine (returns radians)
-- Tag: functions_math_functions_test_select_077
SELECT ASIN(0) AS result;

-- Tag: functions_math_functions_test_select_078
SELECT ASIN(1) AS result;

-- Tag: functions_math_functions_test_select_079
SELECT ASIN(0.5) AS result;

-- Tag: functions_math_functions_test_select_080
SELECT ASIN(-1) AS result;

-- ASIN domain is [-1, 1]
-- SELECT ASIN(2) AS result;

-- ACOS - Arccosine (returns radians)
-- Tag: functions_math_functions_test_select_081
SELECT ACOS(1) AS result;

-- Tag: functions_math_functions_test_select_082
SELECT ACOS(0) AS result;

-- Tag: functions_math_functions_test_select_083
SELECT ACOS(-1) AS result;

-- Tag: functions_math_functions_test_select_084
SELECT ACOS(0.5) AS result;

-- ACOS domain is [-1, 1]
-- SELECT ACOS(2) AS result;

-- ATAN - Arctangent (returns radians)
-- Tag: functions_math_functions_test_select_085
SELECT ATAN(0) AS result;

-- Tag: functions_math_functions_test_select_086
SELECT ATAN(1) AS result;

-- Tag: functions_math_functions_test_select_087
SELECT ATAN(-1) AS result;

-- Tag: functions_math_functions_test_select_088
SELECT ATAN(1000) AS result;

-- ATAN2 - Two-argument arctangent
-- Tag: functions_math_functions_test_select_089
SELECT ATAN2(1, 1) AS result;

-- Tag: functions_math_functions_test_select_090
SELECT ATAN2(1, 0) AS result;

-- Tag: functions_math_functions_test_select_091
SELECT ATAN2(0, 1) AS result;

-- Tag: functions_math_functions_test_select_092
SELECT ATAN2(1, -1) AS result;

-- Tag: functions_math_functions_test_select_093
SELECT ATAN2(-1, -1) AS result;

-- ----------------------------------------------------------------------------
-- 5. ANGLE CONVERSION
-- ----------------------------------------------------------------------------

-- DEGREES - Convert radians to degrees
-- Tag: functions_math_functions_test_select_094
SELECT DEGREES(PI()) AS result;

-- Tag: functions_math_functions_test_select_095
SELECT DEGREES(PI() / 2) AS result;

-- Tag: functions_math_functions_test_select_096
SELECT DEGREES(PI() / 4) AS result;

-- Tag: functions_math_functions_test_select_097
SELECT DEGREES(0) AS result;

-- Tag: functions_math_functions_test_select_098
SELECT DEGREES(2 * PI()) AS result;

-- RADIANS - Convert degrees to radians
-- Tag: functions_math_functions_test_select_099
SELECT RADIANS(180) AS result;

-- Tag: functions_math_functions_test_select_100
SELECT RADIANS(90) AS result;

-- Tag: functions_math_functions_test_select_101
SELECT RADIANS(45) AS result;

-- Tag: functions_math_functions_test_select_102
SELECT RADIANS(0) AS result;

-- Tag: functions_math_functions_test_select_103
SELECT RADIANS(360) AS result;

-- Roundtrip conversion
-- Tag: functions_math_functions_test_select_104
SELECT DEGREES(RADIANS(45)) AS result;

-- Tag: functions_math_functions_test_select_105
SELECT RADIANS(DEGREES(1)) AS result;

-- ----------------------------------------------------------------------------
-- 6. CONSTANTS
-- ----------------------------------------------------------------------------

-- PI - Mathematical constant π
-- Tag: functions_math_functions_test_select_106
SELECT PI() AS result;

-- Tag: functions_math_functions_test_select_107
SELECT 2 * PI() AS result;

-- Tag: functions_math_functions_test_select_108
SELECT PI() / 2 AS result;

-- ----------------------------------------------------------------------------
-- 7. COMPARISON FUNCTIONS
-- ----------------------------------------------------------------------------

-- GREATEST - Maximum of arguments
-- Tag: functions_math_functions_test_select_109
SELECT GREATEST(1, 2, 3) AS result;

-- Tag: functions_math_functions_test_select_110
SELECT GREATEST(10, 5, 20, 15) AS result;

-- Tag: functions_math_functions_test_select_111
SELECT GREATEST(-5, -10, -1) AS result;

-- Tag: functions_math_functions_test_select_112
SELECT GREATEST(3.14, 2.71, 1.41) AS result;

-- Tag: functions_math_functions_test_select_113
SELECT GREATEST(NULL, 5, 10) AS result;

-- Tag: functions_math_functions_test_select_114
SELECT GREATEST(1) AS result;

-- LEAST - Minimum of arguments
-- Tag: functions_math_functions_test_select_115
SELECT LEAST(1, 2, 3) AS result;

-- Tag: functions_math_functions_test_select_116
SELECT LEAST(10, 5, 20, 15) AS result;

-- Tag: functions_math_functions_test_select_117
SELECT LEAST(-5, -10, -1) AS result;

-- Tag: functions_math_functions_test_select_118
SELECT LEAST(3.14, 2.71, 1.41) AS result;

-- Tag: functions_math_functions_test_select_119
SELECT LEAST(NULL, 5, 10) AS result;

-- Tag: functions_math_functions_test_select_120
SELECT LEAST(100) AS result;

-- ----------------------------------------------------------------------------
-- 8. RANDOM FUNCTIONS
-- ----------------------------------------------------------------------------

-- RANDOM - Random number [0, 1)
-- Tag: functions_math_functions_test_select_121
SELECT RANDOM() AS result;

-- Tag: functions_math_functions_test_select_122
SELECT RANDOM() >= 0 AND RANDOM() < 1 AS in_range;

-- RAND - Alias for RANDOM
-- Tag: functions_math_functions_test_select_123
SELECT RAND() AS result;

-- Random with seed (for reproducibility)
-- SELECT RANDOM(42) AS result;

-- ----------------------------------------------------------------------------
-- 9. INTEGRATION SCENARIOS
-- ----------------------------------------------------------------------------

-- Nested math functions
-- Tag: functions_math_functions_test_select_124
SELECT SQRT(POWER(3, 2) + POWER(4, 2)) AS hypotenuse;

-- Tag: functions_math_functions_test_select_125
SELECT ROUND(PI(), 2) AS pi_rounded;

-- Tag: functions_math_functions_test_select_126
SELECT ABS(CEIL(-3.7)) AS result;

-- Trigonometric identity: sin²(x) + cos²(x) = 1
-- Tag: functions_math_functions_test_select_127
SELECT POWER(SIN(PI() / 4), 2) + POWER(COS(PI() / 4), 2) AS trig_identity;

-- Convert between degrees and radians
-- Tag: functions_math_functions_test_select_128
SELECT SIN(RADIANS(30)) AS sine_30_degrees;

-- Tag: functions_math_functions_test_select_129
SELECT DEGREES(ASIN(0.5)) AS arcsin_half;

-- Logarithm properties: ln(a*b) = ln(a) + ln(b)
-- Tag: functions_math_functions_test_select_130
SELECT LN(2 * 3) AS ln_product, LN(2) + LN(3) AS ln_sum;

-- Exponential and logarithm inverse
-- Tag: functions_math_functions_test_select_131
SELECT EXP(LN(42)) AS roundtrip;

-- Tag: functions_math_functions_test_select_132
SELECT LN(EXP(3.5)) AS roundtrip;

-- Using GREATEST and LEAST
-- Tag: functions_math_functions_test_select_133
SELECT GREATEST(ABS(-5), ABS(3)) AS max_abs;

-- Tag: functions_math_functions_test_select_134
SELECT LEAST(CEIL(3.2), FLOOR(4.8)) AS min_rounded;

-- NULL handling in math functions
-- Tag: functions_math_functions_test_select_135
SELECT ABS(NULL) AS abs_null,
       SQRT(NULL) AS sqrt_null,
       POWER(NULL, 2) AS power_null,
       SIN(NULL) AS sin_null;

-- Division and modulo relationship: a = (a DIV b) * b + (a MOD b)
-- Tag: functions_math_functions_test_select_136
SELECT 17 = (17 / 5) * 5 + MOD(17, 5) AS division_identity;

-- Distance formula
-- Tag: functions_math_functions_test_select_137
SELECT SQRT(POWER(4 - 1, 2) + POWER(6 - 2, 2)) AS distance;

-- Rounding to different precisions
-- Tag: functions_math_functions_test_select_138
SELECT ROUND(1234.5678, 3) AS r3,
       ROUND(1234.5678, 2) AS r2,
       ROUND(1234.5678, 1) AS r1,
       ROUND(1234.5678, 0) AS r0,
       ROUND(1234.5678, -1) AS r_neg1,
       ROUND(1234.5678, -2) AS r_neg2;

-- End of Math Functions Tests
