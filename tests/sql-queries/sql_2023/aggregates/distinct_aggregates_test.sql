-- Distinct Aggregates - SQL:2023
-- Description: COUNT/SUM with DISTINCT focus.

DROP TABLE IF EXISTS distinct_numbers;

CREATE TABLE distinct_numbers (value INT64);

INSERT INTO distinct_numbers VALUES (10);
INSERT INTO distinct_numbers VALUES (20);
INSERT INTO distinct_numbers VALUES (10);
INSERT INTO distinct_numbers VALUES (30);

-- Tag: count_distinct_numbers
SELECT COUNT(DISTINCT value) AS distinct_count FROM distinct_numbers;

-- Tag: sum_distinct_numbers
SELECT SUM(DISTINCT value) AS distinct_sum FROM distinct_numbers;

DROP TABLE IF EXISTS distinct_strings;

CREATE TABLE distinct_strings (name STRING);

INSERT INTO distinct_strings VALUES ('Alice');
INSERT INTO distinct_strings VALUES ('Bob');
INSERT INTO distinct_strings VALUES ('Alice');

-- Tag: count_distinct_strings
SELECT COUNT(DISTINCT name) AS distinct_count FROM distinct_strings;

DROP TABLE IF EXISTS nullable_distinct;

CREATE TABLE nullable_distinct (value INT64);

INSERT INTO nullable_distinct VALUES (10);
INSERT INTO nullable_distinct VALUES (NULL);
INSERT INTO nullable_distinct VALUES (20);
INSERT INTO nullable_distinct VALUES (NULL);

-- Tag: count_distinct_with_nulls
SELECT COUNT(DISTINCT value) AS distinct_count FROM nullable_distinct;
