-- Aggregates Array - SQL:2023
-- Description: ARRAY_AGG and STRING_AGG behaviour with ordering, DISTINCT, grouping, and null handling.

DROP TABLE IF EXISTS array_values;

CREATE TABLE array_values (id INT64, value INT64);

INSERT INTO array_values VALUES
    (1, 10),
    (2, 20),
    (3, 20),
    (4, 30);

-- Tag: array_agg_ordered
SELECT ARRAY_AGG(value ORDER BY id) AS values FROM array_values;

-- Tag: array_agg_descending
SELECT ARRAY_AGG(value ORDER BY id DESC) AS values FROM array_values;

-- Tag: array_agg_distinct_ordered
SELECT ARRAY_AGG(DISTINCT value ORDER BY value) AS values FROM array_values;

DROP TABLE IF EXISTS category_values;

CREATE TABLE category_values (category STRING, id INT64, value INT64);

INSERT INTO category_values VALUES
    ('A', 1, 10),
    ('A', 2, 15),
    ('B', 1, 5),
    ('B', 2, 25);

-- Tag: array_agg_group_by
SELECT category, ARRAY_AGG(value ORDER BY id) AS values
FROM category_values
GROUP BY category
ORDER BY category;

DROP TABLE IF EXISTS optional_values;

CREATE TABLE optional_values (id INT64, value INT64);

INSERT INTO optional_values VALUES
    (1, 100),
    (2, NULL),
    (3, 200);

-- Tag: array_agg_with_nulls
SELECT ARRAY_AGG(value ORDER BY id) AS values FROM optional_values;

DROP TABLE IF EXISTS names;

CREATE TABLE names (id INT64, name STRING);

INSERT INTO names VALUES
    (1, 'Alpha'),
    (2, 'Beta'),
    (3, 'Gamma');

-- Tag: string_agg_ordered
SELECT STRING_AGG(name, ', ' ORDER BY id) AS names FROM names;

DROP TABLE IF EXISTS empty_values;

CREATE TABLE empty_values (value INT64);

-- Tag: array_agg_empty
SELECT ARRAY_AGG(value) AS values FROM empty_values;
