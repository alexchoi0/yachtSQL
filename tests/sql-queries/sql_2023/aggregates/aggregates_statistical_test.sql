-- Aggregates Statistical - SQL:2023
-- Description: Basic statistical aggregates (AVG, VAR_POP, STDDEV_POP, MIN, MAX).

DROP TABLE IF EXISTS stats;

CREATE TABLE stats (
    sample STRING,
    value INT64
);

INSERT INTO stats VALUES ('A', 10);
INSERT INTO stats VALUES ('A', 20);
INSERT INTO stats VALUES ('A', 30);
INSERT INTO stats VALUES ('B', 5);
INSERT INTO stats VALUES ('B', 15);
INSERT INTO stats VALUES ('B', 25);

-- Tag: stats_overall
SELECT
    AVG(value) AS mean,
    VAR_POP(value) AS variance,
    STDDEV_POP(value) AS stddev,
    MIN(value) AS min_value,
    MAX(value) AS max_value
FROM stats;

-- Tag: stats_by_sample
SELECT
    sample,
    AVG(value) AS mean,
    VAR_POP(value) AS variance,
    STDDEV_POP(value) AS stddev
FROM stats
GROUP BY sample
ORDER BY sample;

DROP TABLE IF EXISTS empty_stats;

CREATE TABLE empty_stats (value INT64);

-- Tag: stats_empty_set
SELECT AVG(value) AS mean, VAR_POP(value) AS variance
FROM empty_stats;
