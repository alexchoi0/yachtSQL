-- Check Constraints - SQL:2023
-- Description: CHECK constraints for data validation
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    price FLOAT64 CHECK (price > 0)
);

-- Valid insert
INSERT INTO equipment VALUES (1, 19.99);

-- Invalid insert - negative price (should fail)
-- INSERT INTO equipment VALUES (2, -10.0);

-- Invalid insert - zero (should fail)
-- INSERT INTO equipment VALUES (3, 0.0);

-- CHECK Constraint - BETWEEN Range

-- CHECK with BETWEEN clause
DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64,
    age INT64 CHECK (age BETWEEN 18 AND 65)
);

-- Valid ages (boundaries inclusive)
INSERT INTO crew_members VALUES (1, 18);
INSERT INTO crew_members VALUES (2, 30);
INSERT INTO crew_members VALUES (3, 65);

-- Invalid - too young (should fail)
-- INSERT INTO crew_members VALUES (4, 17);

-- Invalid - too old (should fail)
-- INSERT INTO crew_members VALUES (5, 66);

-- CHECK Constraint - String Length

-- CHECK with string length validation
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64,
    username STRING CHECK (LENGTH(username) >= 3 AND LENGTH(username) <= 20)
);

-- Valid usernames
INSERT INTO users VALUES (1, 'abc');
INSERT INTO users VALUES (2, 'john_doe_12345');

-- Too short (should fail)
-- INSERT INTO users VALUES (3, 'ab');

-- Too long (should fail)
-- INSERT INTO users VALUES (4, 'this_username_is_way_too_long');

-- CHECK Constraint - IN List

-- CHECK with IN clause for enumerated values
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT64,
    status STRING CHECK (status IN ('pending', 'approved', 'shipped', 'delivered'))
);

-- Valid statuses
INSERT INTO orders VALUES (1, 'pending');
INSERT INTO orders VALUES (2, 'shipped');

-- Invalid status (should fail)
-- INSERT INTO orders VALUES (3, 'cancelled');

-- Case sensitivity check (should fail)
-- INSERT INTO orders VALUES (4, 'PENDING');

-- CHECK Constraint - Boolean Expression

-- CHECK with boolean column
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (
    id INT64,
    is_active BOOL CHECK (is_active = TRUE OR is_active = FALSE)
);

INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);

-- CHECK Constraint - Multiple Columns

-- CHECK referencing multiple columns
DROP TABLE IF EXISTS rectangles;
CREATE TABLE rectangles (
    id INT64,
    width FLOAT64,
    height FLOAT64,
    CHECK (width > 0 AND height > 0 AND width * height <= 1000)
);

-- Valid rectangle
INSERT INTO rectangles VALUES (1, 10.0, 50.0);  -- Area = 500

-- Invalid - area too large (should fail)
-- INSERT INTO rectangles VALUES (2, 50.0, 25.0);  -- Area = 1250

-- Invalid - negative dimension (should fail)
-- INSERT INTO rectangles VALUES (3, -10.0, 50.0);

-- CHECK Constraint - NULL Handling

-- CHECK constraints pass NULL values (three-valued logic)
DROP TABLE IF EXISTS test_null_check;
CREATE TABLE test_null_check (
    id INT64,
    value INT64 CHECK (value > 0)
);

-- NULL is allowed (CHECK passes NULL)
INSERT INTO test_null_check VALUES (1, NULL);

-- Valid positive value
INSERT INTO test_null_check VALUES (2, 10);

-- Invalid zero or negative (should fail)
-- INSERT INTO test_null_check VALUES (3, 0);
-- INSERT INTO test_null_check VALUES (4, -5);

-- CHECK Constraint - Named Constraint

-- Named CHECK constraint
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id INT64,
    balance NUMERIC(10, 2),
    CONSTRAINT check_positive_balance CHECK (balance >= 0)
);

INSERT INTO accounts VALUES (1, 100.00);
INSERT INTO accounts VALUES (2, 0.00);  -- Zero is valid

-- Negative balance should fail
-- INSERT INTO accounts VALUES (3, -50.00);

-- CHECK Constraint - Complex Expression

-- CHECK with complex logical expression
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
    id INT64,
    discount_percent FLOAT64,
    is_active BOOL,
    CHECK (
        (is_active = TRUE AND discount_percent > 0 AND discount_percent <= 50) OR
        (is_active = FALSE)
    )
);

-- Valid: active with valid discount
INSERT INTO discounts VALUES (1, 25.0, TRUE);

-- Valid: inactive (discount ignored)
INSERT INTO discounts VALUES (2, 0.0, FALSE);
INSERT INTO discounts VALUES (3, 100.0, FALSE);  -- Invalid discount but inactive = OK

-- Invalid: active with invalid discount (should fail)
-- INSERT INTO discounts VALUES (4, 60.0, TRUE);  -- Discount > 50%

-- Invalid: active with zero discount (should fail)
-- INSERT INTO discounts VALUES (5, 0.0, TRUE);

-- CHECK Constraint - Date Ranges

-- CHECK with date comparisons
DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id INT64,
    start_date DATE,
    end_date DATE,
    CHECK (end_date >= start_date)
);

-- Valid date range
INSERT INTO events VALUES (1, DATE '2024-01-01', DATE '2024-01-31');

-- Same day (valid)
INSERT INTO events VALUES (2, DATE '2024-02-15', DATE '2024-02-15');

-- Invalid: end before start (should fail)
-- INSERT INTO events VALUES (3, DATE '2024-03-31', DATE '2024-03-01');

-- CHECK Constraint - Numeric Precision

-- CHECK with numeric calculations
DROP TABLE IF EXISTS financial;
CREATE TABLE financial (
    id INT64,
    amount NUMERIC(10, 2),
    tax NUMERIC(10, 2),
    total NUMERIC(10, 2),
    CHECK (total = amount + tax)
);

-- Valid calculation
INSERT INTO financial VALUES (1, 100.00, 8.00, 108.00);

-- Invalid calculation (should fail)
-- INSERT INTO financial VALUES (2, 100.00, 8.00, 100.00);  -- total != amount + tax

-- CHECK Constraint - Pattern Matching

-- CHECK with LIKE pattern (if supported)
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (
    id INT64,
    email STRING CHECK (email LIKE '%@%.%')
);

-- Valid emails
INSERT INTO emails VALUES (1, 'user@example.com');
INSERT INTO emails VALUES (2, 'admin@marina.org');

-- Invalid email format (should fail)
-- INSERT INTO emails VALUES (3, 'invalid-email');

-- CHECK Constraint - Case Expressions

-- CHECK with CASE expression
DROP TABLE IF EXISTS pricing;
CREATE TABLE pricing (
    id INT64,
    product_type STRING,
    price FLOAT64,
    CHECK (
        CASE product_type
            WHEN 'standard' THEN price <= 100
            WHEN 'premium' THEN price > 100 AND price <= 500
            WHEN 'luxury' THEN price > 500
            ELSE FALSE
        END
    )
);

-- Valid: standard product with low price
INSERT INTO pricing VALUES (1, 'standard', 50.0);

-- Valid: premium product with mid price
INSERT INTO pricing VALUES (2, 'premium', 300.0);

-- Valid: luxury product with high price
INSERT INTO pricing VALUES (3, 'luxury', 1000.0);

-- Invalid: standard product with high price (should fail)
-- INSERT INTO pricing VALUES (4, 'standard', 200.0);

-- CHECK Constraint - Multiple Constraints

-- Multiple CHECK constraints on same table
DROP TABLE IF EXISTS multi_check;
CREATE TABLE multi_check (
    id INT64,
    age INT64,
    salary NUMERIC(10, 2),
    email STRING,
    CHECK (age >= 18),
    CHECK (salary > 0),
    CHECK (email LIKE '%@%')
);

-- Valid: passes all checks
INSERT INTO multi_check VALUES (1, 25, 50000.00, 'user@example.com');

-- Invalid: fails age check (should fail)
-- INSERT INTO multi_check VALUES (2, 16, 50000.00, 'user@example.com');

-- Invalid: fails salary check (should fail)
-- INSERT INTO multi_check VALUES (3, 25, -1000.00, 'user@example.com');

-- Invalid: fails email check (should fail)
-- INSERT INTO multi_check VALUES (4, 25, 50000.00, 'invalid');

-- CHECK Constraint - With UPDATE

-- CHECK constraints also apply to UPDATEs
DROP TABLE IF EXISTS update_check;
CREATE TABLE update_check (
    id INT64,
    quantity INT64 CHECK (quantity >= 0)
);

INSERT INTO update_check VALUES (1, 10);

-- Valid update
UPDATE update_check SET quantity = 20 WHERE id = 1;

-- Invalid update (should fail)
-- UPDATE update_check SET quantity = -5 WHERE id = 1;

-- CHECK Constraint - Mathematical Functions

-- CHECK with mathematical functions
DROP TABLE IF EXISTS geometry;
CREATE TABLE geometry (
    id INT64,
    radius FLOAT64,
    area FLOAT64,
    CHECK (ABS(area - (3.14159 * radius * radius)) < 0.01)
);

-- Valid: area matches πr²
INSERT INTO geometry VALUES (1, 5.0, 78.54);

-- Invalid: area doesn't match (should fail)
-- INSERT INTO geometry VALUES (2, 5.0, 100.0);

-- ALTER TABLE - ADD CHECK Constraint

-- Add CHECK constraint to existing table
DROP TABLE IF EXISTS add_check;
CREATE TABLE add_check (
    id INT64,
    age INT64
);

INSERT INTO add_check VALUES (1, 30);

-- Add constraint
ALTER TABLE add_check ADD CONSTRAINT check_age CHECK (age >= 0);

-- Future inserts are constrained
-- INSERT INTO add_check VALUES (2, -5);

-- ALTER TABLE - DROP CHECK Constraint

-- Drop CHECK constraint
DROP TABLE IF EXISTS drop_check;
CREATE TABLE drop_check (
    id INT64,
    age INT64,
    CONSTRAINT check_age CHECK (age >= 0)
);

-- Drop the constraint
ALTER TABLE drop_check DROP CONSTRAINT check_age;

-- Can now insert invalid values
INSERT INTO drop_check VALUES (1, -10);

-- CHECK Constraint - Edge Cases

-- Empty string check
DROP TABLE IF EXISTS test_empty_string;
CREATE TABLE test_empty_string (
    id INT64,
    code STRING CHECK (LENGTH(code) > 0)
);

INSERT INTO test_empty_string VALUES (1, 'ABC');

-- Empty string should fail
-- INSERT INTO test_empty_string VALUES (2, '');

-- Boundary value checks
DROP TABLE IF EXISTS test_boundary;
CREATE TABLE test_boundary (
    id INT64,
    percentage FLOAT64 CHECK (percentage >= 0.0 AND percentage <= 100.0)
);

-- Boundaries are inclusive
INSERT INTO test_boundary VALUES (1, 0.0);
INSERT INTO test_boundary VALUES (2, 100.0);

-- Just outside boundaries (should fail)
-- INSERT INTO test_boundary VALUES (3, -0.1);
-- INSERT INTO test_boundary VALUES (4, 100.1);

-- CHECK Constraint - Subqueries (NOT ALLOWED)

-- Subqueries are NOT allowed in CHECK constraints
-- This should fail at table creation time:
-- CREATE TABLE invalid_check (
--     id INT64,
--     category_id INT64,
--     CHECK (category_id IN (SELECT id FROM categories))
-- );

-- CHECK Constraint - Non-Deterministic Functions

-- Some databases restrict non-deterministic functions in CHECK
-- Examples of functions that may not be allowed:
-- - CURRENT_DATE()
-- - CURRENT_TIMESTAMP()
-- - RANDOM()
-- - GEN_RANDOM_UUID()

-- This behavior is database-specific

-- End of File
