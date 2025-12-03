-- Aggregates Json - SQL:2023
-- Description: JSON_AGG and JSON_OBJECT_AGG basic behaviours.

DROP TABLE IF EXISTS json_values;

CREATE TABLE json_values (
    key STRING,
    value INT64
);

INSERT INTO json_values VALUES ('a', 1);
INSERT INTO json_values VALUES ('b', 2);
INSERT INTO json_values VALUES ('c', 3);

-- Tag: json_object_all
SELECT JSON_OBJECT_AGG(key, value) AS json_obj FROM json_values;

-- Tag: json_array_all
SELECT JSON_AGG(value ORDER BY key) AS json_array FROM json_values;

DROP TABLE IF EXISTS json_grouped;

CREATE TABLE json_grouped (
    category STRING,
    key STRING,
    value INT64
);

INSERT INTO json_grouped VALUES ('X', 'a', 1);
INSERT INTO json_grouped VALUES ('X', 'b', 2);
INSERT INTO json_grouped VALUES ('Y', 'c', 3);

-- Tag: json_object_by_category
SELECT category, JSON_OBJECT_AGG(key, value ORDER BY key) AS json_obj
FROM json_grouped
GROUP BY category
ORDER BY category;
