-- Test basic ENUM type creation
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');

-- Test ENUM type usage in table
CREATE TABLE person (
    name TEXT,
    current_mood mood
);

-- Insert values using enum literals
INSERT INTO person VALUES ('Alice', 'happy');
INSERT INTO person VALUES ('Bob', 'sad');
INSERT INTO person VALUES ('Carol', 'ok');

-- Select all rows
SELECT * FROM person;
----
Alice,happy
Bob,sad
Carol,ok

-- Filter by enum value
SELECT name FROM person WHERE current_mood = 'happy';
----
Alice

-- Order by enum (should use ordinal position)
SELECT name, current_mood FROM person ORDER BY current_mood;
----
Bob,sad
Carol,ok
Alice,happy

-- Enum comparison
SELECT name FROM person WHERE current_mood > 'sad';
----
Carol
Alice

-- Cast enum to text
SELECT name, current_mood::TEXT FROM person;
----
Alice,happy
Bob,sad
Carol,ok

-- Cast text to enum
SELECT name FROM person WHERE current_mood = 'happy'::mood;
----
Alice

-- Drop the table and type
DROP TABLE person;
DROP TYPE mood;