-- Aggregates String - SQL:2023
-- Description: STRING_AGG and ARRAY_AGG demonstrations.

DROP TABLE IF EXISTS names_ordered;

CREATE TABLE names_ordered (id INT64, name STRING);

INSERT INTO names_ordered VALUES (1, 'Alice');
INSERT INTO names_ordered VALUES (2, 'Bob');
INSERT INTO names_ordered VALUES (3, 'Charlie');

-- Tag: string_agg_ordered
SELECT STRING_AGG(name, ', ' ORDER BY id) AS names
FROM names_ordered;

-- Tag: string_agg_reverse
SELECT STRING_AGG(name, ', ' ORDER BY id DESC) AS names
FROM names_ordered;

DROP TABLE IF EXISTS names_grouped;

CREATE TABLE names_grouped (category STRING, id INT64, name STRING);

INSERT INTO names_grouped VALUES ('A', 1, 'Alpha');
INSERT INTO names_grouped VALUES ('A', 2, 'Beta');
INSERT INTO names_grouped VALUES ('B', 1, 'Gamma');

-- Tag: string_agg_grouped
SELECT category, STRING_AGG(name, ', ' ORDER BY id) AS names
FROM names_grouped
GROUP BY category
ORDER BY category;

DROP TABLE IF EXISTS numbers_array;

CREATE TABLE numbers_array (id INT64, value INT64);

INSERT INTO numbers_array VALUES (1, 10);
INSERT INTO numbers_array VALUES (2, 20);
INSERT INTO numbers_array VALUES (3, 30);

-- Tag: array_agg_ordered
SELECT ARRAY_AGG(value ORDER BY id) AS values
FROM numbers_array;

-- Tag: array_agg_reverse
SELECT ARRAY_AGG(value ORDER BY id DESC) AS values
FROM numbers_array;

DROP TABLE IF EXISTS array_grouped;

CREATE TABLE array_grouped (category STRING, id INT64, value INT64);

INSERT INTO array_grouped VALUES ('X', 1, 100);
INSERT INTO array_grouped VALUES ('X', 2, 200);
INSERT INTO array_grouped VALUES ('Y', 1, 300);

-- Tag: array_agg_grouped
SELECT category, ARRAY_AGG(value ORDER BY id) AS values
FROM array_grouped
GROUP BY category
ORDER BY category;
