-- Core Operations - SQL:2023
-- Description: Core arithmetic and math functions using literal values and simple tables.

DROP TABLE IF EXISTS math_inputs;

CREATE TABLE math_inputs (angle FLOAT64);

INSERT INTO math_inputs VALUES (0.5);

-- Tag: arithmetic_literals
SELECT -5 AS negative, 42 / 1 AS div_one, 42 / 42 AS div_self;

-- Tag: modulo_operations
SELECT MOD(10, 3) AS mod_func, 10 % 3 AS mod_op;

-- Tag: power_positive
SELECT POWER(2, 10) AS pow_int;

-- Tag: power_negative
SELECT ROUND(POWER(10, -2), 6) AS pow_fractional;

-- Tag: power_zero
SELECT POWER(0, 0) AS pow_zero;

-- Tag: trig_identity
SELECT ROUND(POWER(SIN(angle), 2) + POWER(COS(angle), 2), 6) AS identity
FROM math_inputs;

-- Tag: cosine_zero
SELECT COS(0) AS cos_zero;

-- Tag: sqrt_exact
SELECT SQRT(16) AS sqrt_val;

-- Tag: translate_ascii
SELECT TRANSLATE('cafe', 'ae', 'ea') AS translated;
