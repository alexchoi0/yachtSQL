-- Basic Select - SQL:2023
-- Description: Basic SELECT operations including projections, filtering, ordering, and limits.

DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment (id INT64, name STRING, price FLOAT64);

INSERT INTO equipment VALUES
    (1, 'Apple', 1.99),
    (2, 'Banana', 0.99),
    (3, 'Cherry', 2.99),
    (4, 'Date', 3.49);

-- Tag: select_all_equipment
SELECT id, name, price FROM equipment ORDER BY id;

-- Tag: filter_equipment_price_gt_1_5
SELECT id, name, price FROM equipment WHERE price > 1.5 ORDER BY price DESC, id;

-- Tag: order_equipment_by_price_desc_limit_2
SELECT id, name, price FROM equipment ORDER BY price DESC, id LIMIT 2;

DROP TABLE IF EXISTS crew_members;

CREATE TABLE crew_members (id INT64, name STRING, age INT64, salary INT64, fleet STRING);

INSERT INTO crew_members VALUES
    (1, 'Alice', 30, 60000, 'Engineering'),
    (2, 'Bob', 28, 52000, 'Operations'),
    (3, 'Charlie', 35, 58000, 'Engineering'),
    (4, 'Diana', 30, 61000, 'Command');

-- Tag: select_name_salary
SELECT name, salary FROM crew_members ORDER BY name;

-- Tag: select_crewmembers_age_and_salary
SELECT id, name, age, salary FROM crew_members WHERE age = 30 AND salary > 58000 ORDER BY id;

DROP TABLE IF EXISTS users;

CREATE TABLE users (id INT64, name STRING, age INT64, city STRING);

INSERT INTO users VALUES
    (1, 'Alice', 30, 'NYC'),
    (2, 'Bob', 25, 'LA'),
    (3, 'Charlie', 30, 'SF'),
    (4, 'Diana', 27, 'NYC');

-- Tag: select_users_age_30
SELECT id, name, age, city FROM users WHERE age = 30 ORDER BY name;

-- Tag: select_users_in_nyc_or_sf
SELECT id, name, age, city FROM users WHERE city IN ('NYC', 'SF') ORDER BY city, name;

DROP TABLE IF EXISTS scores;

CREATE TABLE scores (name STRING, score INT64);

INSERT INTO scores VALUES
    ('Alice', 85),
    ('Bob', 92),
    ('Charlie', 78);

-- Tag: order_scores_ascending
SELECT name, score FROM scores ORDER BY score ASC, name;

-- Tag: order_scores_descending
SELECT name, score FROM scores ORDER BY score DESC, name;

DROP TABLE IF EXISTS numbers;

CREATE TABLE numbers (value INT64);

INSERT INTO numbers VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10);

-- Tag: numbers_limit_5
SELECT value FROM numbers ORDER BY value LIMIT 5;

DROP TABLE IF EXISTS empty_table;

CREATE TABLE empty_table (id INT64, name STRING);

-- Tag: select_empty_table
SELECT id, name FROM empty_table;

DROP TABLE IF EXISTS nullable_values;

CREATE TABLE nullable_values (id INT64, value STRING);

INSERT INTO nullable_values VALUES
    (1, 'value'),
    (2, NULL),
    (3, 'another');

-- Tag: select_nullable_all
SELECT id, value FROM nullable_values ORDER BY id;

-- Tag: select_nullable_where_null
SELECT id, value FROM nullable_values WHERE value IS NULL ORDER BY id;

-- Tag: select_nullable_where_not_null
SELECT id, value FROM nullable_values WHERE value IS NOT NULL ORDER BY id;

DROP TABLE IF EXISTS data;

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (10, 20);

-- Tag: select_data_sum
SELECT a + b AS sum FROM data;

DROP TABLE IF EXISTS calc;

CREATE TABLE calc (x INT64, y INT64);

INSERT INTO calc VALUES (5, 3);

-- Tag: select_calc_arithmetic
SELECT x + y AS addition, x * y AS multiplication FROM calc;

DROP TABLE IF EXISTS complex;

CREATE TABLE complex (a INT64, b INT64, c INT64);

INSERT INTO complex VALUES
    (1, 2, 3),
    (4, 5, 6),
    (7, 8, 9);

-- Tag: select_complex_condition
SELECT a, b, c FROM complex WHERE (a > 2 AND b < 8) OR c = 3 ORDER BY a;
