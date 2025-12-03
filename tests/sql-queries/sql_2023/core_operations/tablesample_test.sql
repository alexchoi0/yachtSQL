-- Tablesample - SQL:2023
-- Description: TABLESAMPLE parsing currently not supported; verify graceful error handling.

DROP TABLE IF EXISTS fleet_samples;

CREATE TABLE fleet_samples (
    id INT64,
    name STRING
);

INSERT INTO fleet_samples VALUES
    (1, 'Sea Breeze'),
    (2, 'Wind Dancer'),
    (3, 'Ocean Pearl');

-- ERROR: TABLESAMPLE is not yet supported in YachtSQL
-- Tag: tablesample_not_supported
SELECT id, name FROM fleet_samples TABLESAMPLE BERNOULLI (50) REPEATABLE (12345);
