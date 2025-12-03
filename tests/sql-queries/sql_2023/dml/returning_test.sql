-- Returning - SQL:2023
-- Description: RETURNING clause for returning modified rows
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS yachts;
CREATE TABLE yachts (
  yacht_id INT64 PRIMARY KEY,
  name STRING NOT NULL,
  length_feet INT64,
  manufacturer STRING,
  year_built INT64,
  price NUMERIC(12, 2),
  status STRING DEFAULT 'available'
);

DROP TABLE IF EXISTS yacht_maintenance;
CREATE TABLE yacht_maintenance (
  maintenance_id INT64 PRIMARY KEY,
  yacht_id INT64,
  service_date DATE,
  service_type STRING,
  cost NUMERIC(10, 2),
  technician STRING,
  FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
  crew_id INT64 PRIMARY KEY,
  name STRING NOT NULL,
  yacht_id INT64,
  role STRING,
  hire_date DATE,
  salary NUMERIC(10, 2),
  FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

-- ----------------------------------------------------------------------------
-- 1. INSERT ... RETURNING (Basic)
-- ----------------------------------------------------------------------------

-- Return inserted row's primary key
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
VALUES (1, 'Sea Breeze', 45, 'Beneteau', 2020, 450000.00)
RETURNING yacht_id;

-- Return multiple columns from inserted row
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
VALUES (2, 'Wind Dancer', 38, 'Jeanneau', 2019, 320000.00)
RETURNING yacht_id, name, price;

-- Return all columns
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
VALUES (3, 'Ocean Pearl', 52, 'Bavaria', 2021, 580000.00)
RETURNING *;

-- Return computed expression
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
VALUES (4, 'Blue Horizon', 41, 'Hanse', 2018, 380000.00)
RETURNING yacht_id, name, price * 0.10 AS deposit_amount;

-- ----------------------------------------------------------------------------
-- 2. INSERT ... RETURNING (Multiple Rows)
-- ----------------------------------------------------------------------------

-- Insert multiple rows and return results
INSERT INTO crew_members (crew_id, name, yacht_id, role, hire_date, salary)
VALUES
  (1, 'Captain Jack', 1, 'Captain', DATE '2023-01-15', 85000.00),
  (2, 'First Mate Sarah', 1, 'First Mate', DATE '2023-02-01', 65000.00),
  (3, 'Deckhand Mike', 1, 'Deckhand', DATE '2023-03-10', 45000.00)
RETURNING crew_id, name, role;

-- Return with concatenated strings
INSERT INTO crew_members (crew_id, name, yacht_id, role, hire_date, salary)
VALUES
  (4, 'Captain Emma', 2, 'Captain', DATE '2023-01-20', 90000.00),
  (5, 'Engineer Tom', 2, 'Engineer', DATE '2023-02-15', 70000.00)
RETURNING crew_id, name || ' - ' || role AS crew_info;

-- ----------------------------------------------------------------------------
-- 3. UPDATE ... RETURNING
-- ----------------------------------------------------------------------------

-- Update single row and return old and new values
UPDATE yachts
SET price = price * 1.05
WHERE yacht_id = 1
RETURNING yacht_id, name, price AS new_price;

-- Update with status change
UPDATE yachts
SET status = 'sold'
WHERE yacht_id = 2
RETURNING yacht_id, name, status;

-- Update multiple rows
UPDATE yachts
SET price = price * 0.95
WHERE year_built < 2020
RETURNING yacht_id, name, year_built, price;

-- Update with computed columns
UPDATE crew_members
SET salary = salary * 1.10
WHERE role = 'Captain'
RETURNING crew_id, name, role, salary, salary * 12 AS annual_salary;

-- ----------------------------------------------------------------------------
-- 4. DELETE ... RETURNING
-- ----------------------------------------------------------------------------

-- Delete and return deleted row
DELETE FROM yacht_maintenance
WHERE maintenance_id = 999
RETURNING *;

-- Delete with condition and return specific columns
INSERT INTO yacht_maintenance (maintenance_id, yacht_id, service_date, service_type, cost, technician)
VALUES (1, 1, DATE '2024-01-15', 'Engine Service', 2500.00, 'Mike');

DELETE FROM yacht_maintenance
WHERE service_type = 'Engine Service' AND cost > 2000
RETURNING maintenance_id, service_type, cost;

-- Delete multiple rows
INSERT INTO yacht_maintenance (maintenance_id, yacht_id, service_date, service_type, cost, technician)
VALUES
  (2, 1, DATE '2024-02-10', 'Hull Cleaning', 800.00, 'Tom'),
  (3, 2, DATE '2024-02-15', 'Hull Cleaning', 750.00, 'Tom'),
  (4, 3, DATE '2024-02-20', 'Hull Cleaning', 900.00, 'Tom');

DELETE FROM yacht_maintenance
WHERE service_type = 'Hull Cleaning'
RETURNING maintenance_id, yacht_id, cost, technician;

-- ----------------------------------------------------------------------------
-- 5. RETURNING with Expressions and Functions
-- ----------------------------------------------------------------------------

-- INSERT with UPPER function
INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
VALUES (5, 'Wave Runner', 48, 'Lagoon', 2022, 520000.00)
RETURNING yacht_id, UPPER(name) AS name_upper, LENGTH(name) AS name_length;

-- UPDATE with string concatenation
UPDATE yachts
SET manufacturer = manufacturer || ' Yachts'
WHERE yacht_id = 1
RETURNING yacht_id, name, manufacturer;

-- UPDATE with CASE expression
UPDATE yachts
SET status =
  CASE
    WHEN price > 500000 THEN 'premium'
    WHEN price > 300000 THEN 'standard'
    ELSE 'economy'
  END
WHERE yacht_id IN (3, 4, 5)
RETURNING yacht_id, name, price, status;

-- DELETE with date functions
INSERT INTO yacht_maintenance (maintenance_id, yacht_id, service_date, service_type, cost, technician)
VALUES (10, 1, DATE '2023-01-15', 'Old Service', 500.00, 'Bob');

DELETE FROM yacht_maintenance
WHERE service_date < CURRENT_DATE - INTERVAL '6 months'
RETURNING maintenance_id, service_date,
     EXTRACT(YEAR FROM service_date) AS service_year;

-- ----------------------------------------------------------------------------
-- 6. RETURNING with NULL Handling
-- ----------------------------------------------------------------------------

-- Insert with NULL values
INSERT INTO crew_members (crew_id, name, yacht_id, role, hire_date, salary)
VALUES (10, 'Temp Crew', NULL, 'Temporary', DATE '2024-06-01', 40000.00)
RETURNING crew_id, name, COALESCE(yacht_id, -1) AS yacht_id_or_default;

-- Update and return NULL handling
UPDATE crew_members
SET yacht_id = NULL
WHERE crew_id = 3
RETURNING crew_id, name, yacht_id, yacht_id IS NULL AS is_unassigned;

-- ----------------------------------------------------------------------------
-- 7. RETURNING in Subqueries (Implementation-dependent)
-- ----------------------------------------------------------------------------

-- Store returned values in a CTE for further processing
WITH inserted_yachts AS (
  INSERT INTO yachts (yacht_id, name, length_feet, manufacturer, year_built, price)
  VALUES (6, 'Sunset Cruiser', 42, 'Catalina', 2020, 360000.00)
  RETURNING yacht_id, name, price
)
-- Tag: dml_returning_test_select_001
SELECT yacht_id, name, price, price * 0.20 AS down_payment
FROM inserted_yachts;

-- Use RETURNING with join in CTE
WITH deleted_crew AS (
  DELETE FROM crew_members
  WHERE salary < 50000
  RETURNING crew_id, name, yacht_id, salary
)
-- Tag: dml_returning_test_select_002
SELECT dc.crew_id, dc.name, dc.salary, y.name AS yacht_name
FROM deleted_crew dc
LEFT JOIN yachts y ON dc.yacht_id = y.yacht_id;

-- ----------------------------------------------------------------------------
-- 8. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Use Case 1: Get auto-generated ID after insert
DROP TABLE IF EXISTS yacht_bookings;
CREATE TABLE yacht_bookings (
  booking_id INT64 PRIMARY KEY,
  yacht_id INT64,
  customer_name STRING,
  start_date DATE,
  end_date DATE,
  total_cost NUMERIC(10, 2)
);

INSERT INTO yacht_bookings (yacht_id, customer_name, start_date, end_date, total_cost)
VALUES (1, 'John Smith', DATE '2024-07-01', DATE '2024-07-07', 5000.00)
RETURNING booking_id, customer_name;

-- Use Case 2: Audit trail - log what was changed
DROP TABLE IF EXISTS yacht_price_history;
CREATE TABLE yacht_price_history (
  history_id INT64 PRIMARY KEY,
  yacht_id INT64,
  old_price NUMERIC(12, 2),
  new_price NUMERIC(12, 2),
  changed_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

WITH price_updates AS (
  UPDATE yachts
  SET price = price * 1.08
  WHERE status = 'available'
  RETURNING yacht_id, price / 1.08 AS old_price, price AS new_price
)
INSERT INTO yacht_price_history (yacht_id, old_price, new_price)
-- Tag: dml_returning_test_select_003
SELECT yacht_id, old_price, new_price FROM price_updates
RETURNING history_id, yacht_id, old_price, new_price;

-- Use Case 3: Batch operations with result tracking
WITH crew_updates AS (
  UPDATE crew_members
  SET salary = salary * 1.05
  WHERE hire_date < DATE '2023-06-01'
  RETURNING crew_id, name, salary, salary - (salary / 1.05) AS raise_amount
)
-- Tag: dml_returning_test_select_001
SELECT
  COUNT(*) AS total_updated,
  SUM(raise_amount) AS total_raises,
  AVG(salary) AS avg_new_salary
FROM crew_updates;

-- Use Case 4: Cascade delete with tracking
WITH deleted_yachts AS (
  DELETE FROM yachts
  WHERE status = 'sold' AND year_built < 2019
  RETURNING yacht_id, name
)
-- Tag: dml_returning_test_select_004
SELECT dy.yacht_id, dy.name, COUNT(cm.crew_id) AS crew_affected
FROM deleted_yachts dy
LEFT JOIN crew_members cm ON dy.yacht_id = cm.yacht_id
GROUP BY dy.yacht_id, dy.name;

-- ----------------------------------------------------------------------------
-- 9. RETURNING with Conditional Logic
-- ----------------------------------------------------------------------------

-- Return different values based on condition
UPDATE yachts
SET status = 'maintenance'
WHERE length_feet > 45
RETURNING
  yacht_id,
  name,
  CASE
    WHEN length_feet > 50 THEN 'Large Yacht'
    WHEN length_feet > 40 THEN 'Medium Yacht'
    ELSE 'Small Yacht'
  END AS size_category,
  status;

-- Conditional insert with RETURNING
INSERT INTO yacht_maintenance (maintenance_id, yacht_id, service_date, service_type, cost, technician)
VALUES (20, 1, CURRENT_DATE, 'Annual Inspection', 3000.00, 'Chief Mechanic')
RETURNING
  maintenance_id,
  service_type,
  cost,
  CASE
    WHEN cost > 5000 THEN 'High Cost'
    WHEN cost > 2000 THEN 'Medium Cost'
    ELSE 'Low Cost'
  END AS cost_category;

-- ----------------------------------------------------------------------------
-- 10. Edge Cases
-- ----------------------------------------------------------------------------

-- RETURNING with no matching rows (DELETE)
DELETE FROM yachts
WHERE yacht_id = 999999
RETURNING *;

-- RETURNING with no matching rows (UPDATE)
UPDATE yachts
SET price = price * 2
WHERE name = 'Non-Existent Yacht'
RETURNING yacht_id, name, price;

-- RETURNING with NULL values in expression
INSERT INTO crew_members (crew_id, name, yacht_id, role, hire_date, salary)
VALUES (20, 'John Doe', NULL, 'Freelance', DATE '2024-01-01', 50000.00)
RETURNING crew_id, yacht_id, yacht_id * 2 AS doubled_yacht_id;

-- RETURNING all columns with *
DELETE FROM yacht_maintenance
WHERE maintenance_id = 20
RETURNING *;

-- End of RETURNING Clause Tests
