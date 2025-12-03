-- Aggregates Operators - SQL:2023
-- Description: BIT_AND/BIT_OR/BIT_XOR aggregates over simple datasets.

DROP TABLE IF EXISTS bit_values;

CREATE TABLE bit_values (value INT64);

INSERT INTO bit_values VALUES (7);
INSERT INTO bit_values VALUES (3);
INSERT INTO bit_values VALUES (5);

-- Tag: bit_and_all
SELECT BIT_AND(value) AS result FROM bit_values;

-- Tag: bit_or_all
SELECT BIT_OR(value) AS result FROM bit_values;

-- Tag: bit_xor_all
SELECT BIT_XOR(value) AS result FROM bit_values;

DROP TABLE IF EXISTS bit_grouped;

CREATE TABLE bit_grouped (category STRING, value INT64);

INSERT INTO bit_grouped VALUES ('A', 7);
INSERT INTO bit_grouped VALUES ('A', 3);
INSERT INTO bit_grouped VALUES ('B', 5);
INSERT INTO bit_grouped VALUES ('B', 1);

-- Tag: bit_and_by_category
SELECT category, BIT_AND(value) AS result
FROM bit_grouped
GROUP BY category
ORDER BY category;

-- Tag: bit_or_by_category
SELECT category, BIT_OR(value) AS result
FROM bit_grouped
GROUP BY category
ORDER BY category;

-- Tag: bit_xor_by_category
SELECT category, BIT_XOR(value) AS result
FROM bit_grouped
GROUP BY category
ORDER BY category;
