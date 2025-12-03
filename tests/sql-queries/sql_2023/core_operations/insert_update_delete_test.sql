-- Insert Update Delete - SQL:2023
-- Description: INSERT, UPDATE, and DELETE operations with focus on row creation, mutation, and removal.

DROP TABLE IF EXISTS users;

CREATE TABLE users (id INT64, name STRING, age INT64);

INSERT INTO users VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25);

-- Tag: insert_initial_rows
SELECT id, name, age FROM users ORDER BY id;

INSERT INTO users (id, name) VALUES (3, 'Charlie');

-- Tag: insert_partial_columns
SELECT id, name, age FROM users ORDER BY id;

DROP TABLE IF EXISTS new_applicants;

CREATE TABLE new_applicants (id INT64, name STRING, age INT64);

INSERT INTO new_applicants VALUES
    (4, 'Diana', 28),
    (5, 'Eve', 32);

INSERT INTO users
SELECT id, name, age FROM new_applicants WHERE age >= 30;

-- Tag: insert_from_select
SELECT id, name, age FROM users ORDER BY id;

UPDATE users SET age = 31 WHERE name = 'Alice';

-- Tag: update_single_row
SELECT id, name, age FROM users WHERE name = 'Alice';

UPDATE users SET age = age + 5 WHERE age < 30;

-- Tag: update_with_expression
SELECT id, name, age FROM users ORDER BY id;

DROP TABLE IF EXISTS senior_users;

CREATE TABLE senior_users (id INT64, name STRING, age INT64);

INSERT INTO senior_users
SELECT id, name, age FROM users WHERE age >= 35;

-- Tag: insert_into_select_target
SELECT id, name, age FROM senior_users ORDER BY id;

DELETE FROM users WHERE age < 30;

-- Tag: delete_matching_rows
SELECT id, name, age FROM users ORDER BY id;

DELETE FROM users WHERE age > 100;

-- Tag: delete_no_match
SELECT COUNT(*) AS remaining FROM users;
