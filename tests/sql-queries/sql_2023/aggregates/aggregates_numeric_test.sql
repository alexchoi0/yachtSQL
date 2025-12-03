-- Aggregates Numeric - SQL:2023
-- Description: Numeric aggregate patterns with deterministic outcomes.

DROP TABLE IF EXISTS measurements;

CREATE TABLE measurements (category STRING, reading INT64);

INSERT INTO measurements VALUES ('temp', 20);
INSERT INTO measurements VALUES ('temp', 22);
INSERT INTO measurements VALUES ('temp', 18);
INSERT INTO measurements VALUES ('pressure', 30);
INSERT INTO measurements VALUES ('pressure', 28);
INSERT INTO measurements VALUES ('humidity', 45);

-- Tag: sum_by_category
SELECT category, SUM(reading) AS total
FROM measurements
GROUP BY category
ORDER BY category;

-- Tag: avg_by_category
SELECT category, AVG(reading) AS average
FROM measurements
GROUP BY category
ORDER BY category;

-- Tag: min_max_overall
SELECT MIN(reading) AS min_reading, MAX(reading) AS max_reading
FROM measurements;

-- Tag: sum_filter_high
SELECT SUM(CASE WHEN reading >= 25 THEN reading ELSE 0 END) AS high_sum
FROM measurements;

DROP TABLE IF EXISTS empty_numeric;

CREATE TABLE empty_numeric (value INT64);

-- Tag: empty_set_aggregates
SELECT SUM(value) AS sum_value, AVG(value) AS avg_value
FROM empty_numeric;
