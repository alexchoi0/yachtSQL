-- Select Without From - SQL:2023
-- Description: Deterministic scalar SELECT statements without FROM clauses.

-- Tag: literal_integer
SELECT 42 AS value;

-- Tag: literal_float
SELECT 3.14159 AS pi_value;

-- Tag: literal_string
SELECT 'hello world' AS greeting;

-- Tag: literal_booleans
SELECT TRUE AS true_value, FALSE AS false_value;

-- Tag: literal_null
SELECT NULL AS missing_value;

-- Tag: arithmetic_basic
SELECT 10 + 5 AS sum_result, 20 - 7 AS diff_result, 6 * 7 AS product_result, 100 / 4 AS quotient_result;

-- Tag: modulo_expression
SELECT 17 % 5 AS remainder;

-- Tag: arithmetic_precedence
SELECT (10 + 5) * 2 - 3 AS expression_result;

-- Tag: floating_arithmetic
SELECT 3.5 + 2.5 AS float_sum;

-- Tag: sqrt_and_power
SELECT SQRT(16) AS sqrt_val, POWER(2, 10) AS pow_val;

-- Tag: text_functions
SELECT UPPER('hello') AS upper_val, LOWER('WORLD') AS lower_val, CONCAT('Hello', ' ', 'World') AS message;

-- Tag: case_expressions
SELECT
    CASE WHEN TRUE THEN 'yes' ELSE 'no' END AS always_yes,
    CASE WHEN FALSE THEN 'yes' ELSE 'no' END AS always_no,
    CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END AS computed_case;

-- Tag: coalesce_expression
SELECT COALESCE(NULL, 'default') AS chose_default, COALESCE('value', 'default') AS keeps_value;

-- Tag: comparison_predicates
SELECT 5 = 5 AS is_equal, 5 != 3 AS is_not_equal, 10 > 5 AS greater_than, 3 < 7 AS less_than;

-- Tag: boolean_logic
SELECT TRUE AND TRUE AS and_true, TRUE OR FALSE AS or_true, NOT FALSE AS not_false;

-- Tag: nested_functions
SELECT UPPER(LOWER('TEST')) AS normalized;

-- Tag: conditional_string
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END AS result_text;

-- Tag: negative_integer
SELECT -42 AS negative;

-- Tag: empty_string
SELECT '' AS empty;

-- Tag: quoted_string
SELECT 'It''s a test' AS quoted;

-- Tag: zero_literal
SELECT 0 AS zero_value;

-- Tag: big_integer_literal
SELECT 9223372036854775807 AS big_int;
