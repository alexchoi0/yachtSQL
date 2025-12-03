-- Bitwise Boolean Aggregates - SQL:2023
-- Description: Compact BIT_* and BOOL_* aggregate examples.

DROP TABLE IF EXISTS bit_values;

CREATE TABLE bit_values (
    category STRING,
    value INT64
);

INSERT INTO bit_values VALUES ('A', 7);
INSERT INTO bit_values VALUES ('A', 3);
INSERT INTO bit_values VALUES ('B', 12);
INSERT INTO bit_values VALUES ('B', 6);

-- Tag: bit_and_all
SELECT BIT_AND(value) AS result FROM bit_values;

-- Tag: bit_or_all
SELECT BIT_OR(value) AS result FROM bit_values;

-- Tag: bit_xor_all
SELECT BIT_XOR(value) AS result FROM bit_values;

-- Tag: bit_and_by_category
SELECT category, BIT_AND(value) AS result
FROM bit_values
GROUP BY category
ORDER BY category;

DROP TABLE IF EXISTS bool_flags;

CREATE TABLE bool_flags (
    category STRING,
    flag BOOL
);

INSERT INTO bool_flags VALUES ('X', TRUE);
INSERT INTO bool_flags VALUES ('X', TRUE);
INSERT INTO bool_flags VALUES ('Y', TRUE);
INSERT INTO bool_flags VALUES ('Y', FALSE);

-- Tag: bool_and_by_category
SELECT category, BOOL_AND(flag) AS all_true
FROM bool_flags
GROUP BY category
ORDER BY category;

-- Tag: bool_or_all
SELECT BOOL_OR(flag) AS any_true FROM bool_flags;
