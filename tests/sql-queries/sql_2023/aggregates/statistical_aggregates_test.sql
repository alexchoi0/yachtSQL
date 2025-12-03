-- Statistical Aggregates - SQL:2023
-- Description: Deterministic AVG, VAR_POP, STDDEV_POP examples.

DROP TABLE IF EXISTS stats_small;

CREATE TABLE stats_small (value INT64);

INSERT INTO stats_small VALUES (10);
INSERT INTO stats_small VALUES (20);
INSERT INTO stats_small VALUES (30);

-- Tag: stats_small_overall
SELECT AVG(value) AS mean,
       VAR_POP(value) AS variance,
       STDDEV_POP(value) AS stddev
FROM stats_small;

DROP TABLE IF EXISTS stats_by_group;

CREATE TABLE stats_by_group (category STRING, value INT64);

INSERT INTO stats_by_group VALUES ('A', 10);
INSERT INTO stats_by_group VALUES ('A', 30);
INSERT INTO stats_by_group VALUES ('B', 5);
INSERT INTO stats_by_group VALUES ('B', 15);

-- Tag: stats_grouped
SELECT category,
       AVG(value) AS mean,
       VAR_POP(value) AS variance
FROM stats_by_group
GROUP BY category
ORDER BY category;
