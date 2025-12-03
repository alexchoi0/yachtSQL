-- Json 2023 Enhancements - SQL:2023
-- Description: SQL test cases
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64 PRIMARY KEY,
    profile JSON NOT NULL,
    settings JSON,
    metadata JSON
);

INSERT INTO users VALUES
    (1, JSON '{"name": "Alice", "age": 30, "active": true}',
        JSON '{"theme": "dark", "notifications": true}',
        JSON '{"created": "2020-01-15", "score": 95.5}'),
    (2, JSON '{"name": "Bob", "age": 25, "active": false}',
        JSON '{"theme": "light", "notifications": false}',
        JSON '{"created": "2021-06-20", "score": 87.3}'),
    (3, JSON '{"name": "Charlie", "age": 35, "active": true}',
        JSON '{"theme": "dark", "notifications": true}',
        JSON '{"created": "2019-11-03", "score": 92.1}');

-- ----------------------------------------------------------------------------
-- 1. JSON Data Type (Native Type, not String)
-- ----------------------------------------------------------------------------

-- Direct JSON literal construction
-- Tag: json_json_2023_enhancements_test_select_001
SELECT JSON '{"key": "value"}' AS json_value;

-- JSON NULL is different from SQL NULL
-- Tag: json_json_2023_enhancements_test_select_002
SELECT JSON 'null' AS json_null,
       NULL AS sql_null;

-- JSON arrays
-- Tag: json_json_2023_enhancements_test_select_003
SELECT JSON '[1, 2, 3, 4, 5]' AS json_array;

-- Nested JSON
-- Tag: json_json_2023_enhancements_test_select_004
SELECT JSON '{"user": {"name": "Alice", "contacts": ["email", "phone"]}}' AS nested;

-- JSON with various types
-- Tag: json_json_2023_enhancements_test_select_005
SELECT JSON '{"string": "hello", "number": 42, "float": 3.14, "bool": true, "null": null}' AS types;

-- ----------------------------------------------------------------------------
-- 2. Simplified Dot Notation (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- Access nested fields with dot notation (no JSON_EXTRACT needed!)
-- Tag: json_json_2023_enhancements_test_select_006
SELECT id, profile.name AS name, profile.age AS age
FROM users;

-- Deep nesting with dot notation
-- Tag: json_json_2023_enhancements_test_select_007
SELECT id, settings.theme AS theme
FROM users;

-- Array element access with dot notation
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
    id INT64,
    data JSON
);

INSERT INTO posts VALUES
    (1, JSON '{"title": "First Post", "tags": ["sql", "database", "tutorial"]}'),
    (2, JSON '{"title": "Second Post", "tags": ["json", "advanced"]}');

-- Tag: json_json_2023_enhancements_test_select_008
SELECT id, data.tags[0] AS first_tag
FROM posts;

-- Wildcard access: get all array elements
-- Tag: json_json_2023_enhancements_test_select_009
SELECT id, data.tags[*] AS all_tags
FROM posts;

-- Nested array and object access
DROP TABLE IF EXISTS complex_data;
CREATE TABLE complex_data (
    id INT64,
    info JSON
);

INSERT INTO complex_data VALUES
    (1, JSON '{"users": [{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]}');

-- Tag: json_json_2023_enhancements_test_select_010
SELECT id, info.users[0].name AS first_user_name
FROM complex_data;

-- ----------------------------------------------------------------------------
-- 3. Item Methods for Type Conversion (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- .bigint() - Convert to BIGINT
-- Tag: json_json_2023_enhancements_test_select_011
SELECT id,
       metadata.score.bigint() AS score_int,
       profile.age.bigint() AS age_int
FROM users;

-- .boolean() - Convert to BOOLEAN
-- Tag: json_json_2023_enhancements_test_select_012
SELECT id,
       profile.active.boolean() AS is_active,
       settings.notifications.boolean() AS notify
FROM users;

-- .string() - Convert to STRING
-- Tag: json_json_2023_enhancements_test_select_013
SELECT id,
       profile.name.string() AS name_str,
       profile.age.string() AS age_str
FROM users;

-- .number() - Convert to numeric type
-- Tag: json_json_2023_enhancements_test_select_014
SELECT id,
       metadata.score.number() AS score
FROM users;

-- .date() - Convert to DATE
-- Tag: json_json_2023_enhancements_test_select_015
SELECT id,
       metadata.created.date() AS created_date
FROM users;

-- .timestamp() - Convert to TIMESTAMP
DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id INT64,
    data JSON
);

INSERT INTO events VALUES
    (1, JSON '{"event": "login", "timestamp": "2023-06-15T10:30:00Z"}'),
    (2, JSON '{"event": "logout", "timestamp": "2023-06-15T18:45:00Z"}');

-- Tag: json_json_2023_enhancements_test_select_016
SELECT id,
       data.event.string() AS event,
       data.timestamp.timestamp() AS event_time
FROM events;

-- .decimal() - Convert to DECIMAL
DROP TABLE IF EXISTS financials;
CREATE TABLE financials (
    id INT64,
    data JSON
);

INSERT INTO financials VALUES
    (1, JSON '{"amount": 1234.56, "tax": 123.45}');

-- Tag: json_json_2023_enhancements_test_select_017
SELECT id,
       data.amount.decimal() AS amount,
       data.tax.decimal() AS tax
FROM financials;

-- .integer() - Convert to INTEGER
-- Tag: json_json_2023_enhancements_test_select_018
SELECT id,
       profile.age.integer() AS age
FROM users;

-- Chaining: access nested field then convert
-- Tag: json_json_2023_enhancements_test_select_019
SELECT id,
       settings.theme.string() AS theme,
       settings.notifications.boolean() AS notify
FROM users;

-- ----------------------------------------------------------------------------
-- 4. JSON Comparison and Ordering (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- JSON equality comparison
-- Tag: json_json_2023_enhancements_test_select_020
SELECT JSON '{"a": 1, "b": 2}' = JSON '{"b": 2, "a": 1}' AS equal;

-- Tag: json_json_2023_enhancements_test_select_021
SELECT JSON '[1, 2, 3]' = JSON '[1, 2, 3]' AS equal;

-- Tag: json_json_2023_enhancements_test_select_022
SELECT JSON '[1, 2, 3]' = JSON '[3, 2, 1]' AS equal;

-- JSON inequality
-- Tag: json_json_2023_enhancements_test_select_023
SELECT JSON '{"a": 1}' <> JSON '{"a": 2}' AS not_equal;

-- JSON ordering (lexicographic)
-- Tag: json_json_2023_enhancements_test_select_024
SELECT JSON '{"a": 1}' < JSON '{"a": 2}' AS less_than;

-- Tag: json_json_2023_enhancements_test_select_025
SELECT JSON '[1, 2]' < JSON '[1, 3]' AS less_than;

-- Sort by JSON values
-- Tag: json_json_2023_enhancements_test_select_026
SELECT id, profile.age AS age
FROM users
ORDER BY profile.age;

-- Group by JSON values
-- Tag: json_json_2023_enhancements_test_select_027
SELECT settings.theme.string() AS theme, COUNT(*) AS user_count
FROM users
GROUP BY settings.theme.string();

-- DISTINCT with JSON
-- Tag: json_json_2023_enhancements_test_select_028
SELECT DISTINCT settings.theme
FROM users;

-- ----------------------------------------------------------------------------
-- 5. JSON_SCALAR Function (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- JSON_SCALAR: Convert SQL value to JSON scalar
-- Tag: json_json_2023_enhancements_test_select_029
SELECT JSON_SCALAR(42) AS num,
       JSON_SCALAR('hello') AS str,
       JSON_SCALAR(true) AS bool,
       JSON_SCALAR(NULL) AS null_val;

-- JSON_SCALAR with dates
-- Tag: json_json_2023_enhancements_test_select_030
SELECT JSON_SCALAR(DATE '2023-06-15') AS date_json;

-- JSON_SCALAR with decimals
-- Tag: json_json_2023_enhancements_test_select_031
SELECT JSON_SCALAR(NUMERIC '123.45') AS decimal_json;

-- Constructing JSON from SQL values
-- Tag: json_json_2023_enhancements_test_select_032
SELECT JSON_OBJECT(
    'id', id,
    'name', profile.name.string(),
    'age_scalar', JSON_SCALAR(profile.age.integer())
) AS user_json
FROM users;

-- ----------------------------------------------------------------------------
-- 6. JSON_SERIALIZE Function (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- JSON_SERIALIZE: Convert JSON type to STRING with formatting options
-- Tag: json_json_2023_enhancements_test_select_033
SELECT JSON_SERIALIZE(JSON '{"a": 1, "b": 2}') AS serialized;

-- Serialize with pretty printing
-- Tag: json_json_2023_enhancements_test_select_034
SELECT JSON_SERIALIZE(
    JSON '{"name": "Alice", "age": 30}',
    FORMATTED
) AS pretty_json;

-- Serialize with specific encoding
-- Tag: json_json_2023_enhancements_test_select_035
SELECT JSON_SERIALIZE(
    JSON '{"unicode": "你好"}',
    ENCODING UTF8
) AS encoded_json;

-- Serialize arrays
-- Tag: json_json_2023_enhancements_test_select_036
SELECT JSON_SERIALIZE(JSON '[1, 2, 3, 4, 5]') AS array_str;

-- ----------------------------------------------------------------------------
-- 7. JSON in WHERE Clauses (Enhanced with SQL:2023)
-- ----------------------------------------------------------------------------

-- Filter by JSON field using dot notation
-- Tag: json_json_2023_enhancements_test_select_037
SELECT id, profile.name.string() AS name
FROM users
WHERE profile.age.integer() > 28;

-- Filter by boolean JSON field
-- Tag: json_json_2023_enhancements_test_select_038
SELECT id, profile.name.string() AS name
FROM users
WHERE profile.active.boolean() = true;

-- Filter by nested JSON field
-- Tag: json_json_2023_enhancements_test_select_039
SELECT id, profile.name.string() AS name
FROM users
WHERE settings.theme.string() = 'dark';

-- Complex WHERE with multiple JSON conditions
-- Tag: json_json_2023_enhancements_test_select_040
SELECT id, profile.name.string() AS name
FROM users
WHERE profile.age.integer() >= 30
  AND settings.notifications.boolean() = true;

-- JSON NULL check
-- Tag: json_json_2023_enhancements_test_select_041
SELECT id FROM users WHERE settings IS NOT NULL;

INSERT INTO users VALUES
    (4, JSON '{"name": "Diana", "age": 28, "active": true}', NULL, NULL);

-- Tag: json_json_2023_enhancements_test_select_042
SELECT id, profile.name.string() AS name
FROM users
WHERE settings IS NULL;

-- ----------------------------------------------------------------------------
-- 8. JSON Unique Key Validation (NEW in SQL:2023)
-- ----------------------------------------------------------------------------

-- JSON with UNIQUE key constraint
DROP TABLE IF EXISTS unique_json;
CREATE TABLE unique_json (
    id INT64,
    data JSON WITH UNIQUE KEYS
);

-- Valid: all keys unique
INSERT INTO unique_json VALUES
    (1, JSON '{"a": 1, "b": 2, "c": 3}');

-- Error case (commented): duplicate keys
-- INSERT INTO unique_json VALUES
--     (2, JSON '{"a": 1, "a": 2}');

-- Nested objects with unique keys
INSERT INTO unique_json VALUES
    (2, JSON '{"user": {"name": "Alice", "age": 30}, "settings": {"theme": "dark"}}');

-- ----------------------------------------------------------------------------
-- 9. JSON Aggregations (Enhanced in SQL:2023)
-- ----------------------------------------------------------------------------

-- JSON_OBJECTAGG: Aggregate into JSON object
-- Tag: json_json_2023_enhancements_test_select_043
SELECT JSON_OBJECTAGG(
    id, profile.name.string()
) AS users_map
FROM users;

-- JSON_ARRAYAGG: Aggregate into JSON array
-- Tag: json_json_2023_enhancements_test_select_044
SELECT JSON_ARRAYAGG(profile.name.string() ORDER BY profile.age.integer()) AS names
FROM users;

-- Aggregate JSON objects
-- Tag: json_json_2023_enhancements_test_select_045
SELECT JSON_ARRAYAGG(profile) AS all_profiles
FROM users;

-- Group and aggregate JSON
-- Tag: json_json_2023_enhancements_test_select_046
SELECT settings.theme.string() AS theme,
       JSON_ARRAYAGG(profile.name.string()) AS users
FROM users
WHERE settings IS NOT NULL
GROUP BY settings.theme.string();

-- ----------------------------------------------------------------------------
-- 10. JSON in JOINs (Enhanced with SQL:2023)
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS user_preferences;
CREATE TABLE user_preferences (
    user_id INT64,
    prefs JSON
);

INSERT INTO user_preferences VALUES
    (1, JSON '{"color": "blue", "font_size": 14}'),
    (2, JSON '{"color": "red", "font_size": 12}'),
    (3, JSON '{"color": "blue", "font_size": 16}');

-- Join using JSON field
-- Tag: json_json_2023_enhancements_test_select_047
SELECT u.id,
       u.profile.name.string() AS name,
       p.prefs.color.string() AS favorite_color
FROM users u
JOIN user_preferences p ON u.id = p.user_id
WHERE p.prefs.color.string() = 'blue';

-- Self-join on JSON values
-- Tag: json_json_2023_enhancements_test_select_048
SELECT u1.profile.name.string() AS user1,
       u2.profile.name.string() AS user2
FROM users u1
JOIN users u2 ON u1.settings.theme = u2.settings.theme
WHERE u1.id < u2.id;

-- ----------------------------------------------------------------------------
-- 11. JSON Window Functions (Enhanced in SQL:2023)
-- ----------------------------------------------------------------------------

-- Rank users by JSON field
-- Tag: json_json_2023_enhancements_test_select_049
SELECT profile.name.string() AS name,
       profile.age.integer() AS age,
       RANK() OVER (ORDER BY profile.age.integer() DESC) AS age_rank
FROM users;

-- Running sum over JSON numeric field
-- Tag: json_json_2023_enhancements_test_select_050
SELECT id,
       metadata.score.number() AS score,
       SUM(metadata.score.number()) OVER (ORDER BY id) AS running_total
FROM users
WHERE metadata IS NOT NULL;

-- Partition by JSON field
-- Tag: json_json_2023_enhancements_test_select_051
SELECT profile.name.string() AS name,
       settings.theme.string() AS theme,
       COUNT(*) OVER (PARTITION BY settings.theme.string()) AS theme_count
FROM users
WHERE settings IS NOT NULL;

-- ----------------------------------------------------------------------------
-- 12. JSON Subqueries (Enhanced in SQL:2023)
-- ----------------------------------------------------------------------------

-- Scalar subquery with JSON
-- Tag: json_json_2023_enhancements_test_select_052
SELECT id,
       profile.name.string() AS name,
       (SELECT AVG(profile.age.integer()) FROM users) AS avg_age
FROM users;

-- EXISTS with JSON condition
-- Tag: json_json_2023_enhancements_test_select_053
SELECT id, profile.name.string() AS name
FROM users u1
WHERE EXISTS (
-- Tag: json_json_2023_enhancements_test_select_054
    SELECT 1 FROM users u2
    WHERE u2.settings.theme = u1.settings.theme
      AND u2.id <> u1.id
);

-- IN subquery with JSON
-- Tag: json_json_2023_enhancements_test_select_055
SELECT id, profile.name.string() AS name
FROM users
WHERE profile.age.integer() IN (
-- Tag: json_json_2023_enhancements_test_select_056
    SELECT profile.age.integer()
    FROM users
    WHERE settings.notifications.boolean() = true
);

-- ----------------------------------------------------------------------------
-- 13. JSON CTEs (Common Table Expressions)
-- ----------------------------------------------------------------------------

WITH active_users AS (
-- Tag: json_json_2023_enhancements_test_select_057
    SELECT id,
           profile.name.string() AS name,
           profile.age.integer() AS age
    FROM users
    WHERE profile.active.boolean() = true
)
-- Tag: json_json_2023_enhancements_test_select_058
SELECT name, age
FROM active_users
WHERE age > 28
ORDER BY age;

-- Recursive CTE with JSON
WITH RECURSIVE age_groups AS (
-- Tag: json_json_2023_enhancements_test_select_059
    SELECT 20 AS min_age, 30 AS max_age
    UNION ALL
-- Tag: json_json_2023_enhancements_test_select_060
    SELECT min_age + 10, max_age + 10
    FROM age_groups
    WHERE max_age < 50
)
-- Tag: json_json_2023_enhancements_test_select_061
SELECT ag.min_age, ag.max_age, COUNT(u.id) AS user_count
FROM age_groups ag
LEFT JOIN users u ON u.profile.age.integer() BETWEEN ag.min_age AND ag.max_age
GROUP BY ag.min_age, ag.max_age
ORDER BY ag.min_age;

-- ----------------------------------------------------------------------------
-- 14. JSON CASE Expressions
-- ----------------------------------------------------------------------------

-- Tag: json_json_2023_enhancements_test_select_062
SELECT id,
       profile.name.string() AS name,
       CASE
           WHEN profile.age.integer() < 25 THEN 'young'
           WHEN profile.age.integer() BETWEEN 25 AND 30 THEN 'adult'
           ELSE 'senior'
       END AS age_group
FROM users;

-- CASE with JSON comparison
-- Tag: json_json_2023_enhancements_test_select_063
SELECT id,
       profile.name.string() AS name,
       CASE settings.theme.string()
           WHEN 'dark' THEN 'Night mode'
           WHEN 'light' THEN 'Day mode'
           ELSE 'Custom'
       END AS theme_description
FROM users
WHERE settings IS NOT NULL;

-- ----------------------------------------------------------------------------
-- 15. JSON NULL Handling (Enhanced in SQL:2023)
-- ----------------------------------------------------------------------------

-- Differentiate between JSON null and SQL NULL
DROP TABLE IF EXISTS nullable_json;
CREATE TABLE nullable_json (
    id INT64,
    data JSON
);

INSERT INTO nullable_json VALUES
    (1, JSON 'null'),           -- JSON null
    (2, NULL),                   -- SQL NULL
    (3, JSON '{"value": null}'); -- Nested JSON null

-- Tag: json_json_2023_enhancements_test_select_064
SELECT id,
       data IS NULL AS is_sql_null,
       data = JSON 'null' AS is_json_null
FROM nullable_json;

-- Access field that doesn't exist
-- Tag: json_json_2023_enhancements_test_select_065
SELECT id,
       data.missing_field AS missing
FROM nullable_json;

-- COALESCE with JSON
-- Tag: json_json_2023_enhancements_test_select_066
SELECT id,
       COALESCE(settings.theme.string(), 'default') AS theme
FROM users;

-- ----------------------------------------------------------------------------
-- 16. Performance: JSON Indexing (Implementation-dependent)
-- ----------------------------------------------------------------------------

-- Note: JSON indexing syntax is implementation-dependent
-- Some databases support functional indexes on JSON paths

-- Example (syntax may vary):
-- CREATE INDEX idx_profile_age ON users ((profile.age.integer()));
-- CREATE INDEX idx_settings_theme ON users ((settings.theme.string()));

-- End of JSON 2023 Enhancements Tests
