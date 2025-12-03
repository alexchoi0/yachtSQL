-- Primary Foreign Keys - SQL:2023
-- Description: Primary and foreign key constraints
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT64 PRIMARY KEY,
    name STRING
);

-- Primary key ensures uniqueness
INSERT INTO users VALUES (1, 'Alice');
INSERT INTO users VALUES (2, 'Bob');

-- Duplicate primary key should fail
-- INSERT INTO users VALUES (1, 'Charlie');

-- NULL primary key should fail
-- INSERT INTO users VALUES (NULL, 'Dave');

-- PRIMARY KEY - Named Constraint

-- Named primary key constraint
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
    id INT64,
    name STRING,
    CONSTRAINT pk_equipment PRIMARY KEY (id)
);

INSERT INTO equipment VALUES (1, 'Widget');

-- Duplicate should fail
-- INSERT INTO equipment VALUES (1, 'Gadget');

-- PRIMARY KEY - Composite (Multiple Columns)

-- Composite primary key (multiple columns)
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id INT64,
    item_id INT64,
    quantity INT64,
    PRIMARY KEY (order_id, item_id)
);

-- Valid inserts (unique combinations)
INSERT INTO order_items VALUES (1, 100, 5);
INSERT INTO order_items VALUES (1, 200, 3);
INSERT INTO order_items VALUES (2, 100, 2);

-- Duplicate composite key should fail
-- INSERT INTO order_items VALUES (1, 100, 10);

-- PRIMARY KEY - UUID Type

-- UUID as primary key
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
    session_id UUID PRIMARY KEY,
    user_id INT64,
    created_at TIMESTAMP
);

INSERT INTO sessions VALUES
    (UUID '123e4567-e89b-12d3-a456-426614174000', 1, TIMESTAMP '2024-01-15 10:00:00');

-- Duplicate UUID should fail
-- INSERT INTO sessions VALUES
--     (UUID '123e4567-e89b-12d3-a456-426614174000', 2, TIMESTAMP '2024-01-15 11:00:00');

-- FOREIGN KEY - Basic

-- Parent table with primary key
DROP TABLE IF EXISTS yacht_owners;
CREATE TABLE yacht_owners (
    owner_id INT64 PRIMARY KEY,
    name STRING
);

-- Child table with foreign key
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT64 PRIMARY KEY,
    owner_id INT64,
    amount INT64,
    FOREIGN KEY (owner_id) REFERENCES yacht_owners(owner_id)
);

-- Insert parent record first
INSERT INTO yacht_owners VALUES (1, 'Alice');

-- Insert child record with valid foreign key
INSERT INTO orders VALUES (100, 1, 500);

-- Attempt to insert child with invalid foreign key (should fail)
-- INSERT INTO orders VALUES (101, 999, 600);

-- FOREIGN KEY - Named Constraint

-- Named foreign key constraint
DROP TABLE IF EXISTS fleets;
CREATE TABLE fleets (
    dept_id INT64 PRIMARY KEY,
    dept_name STRING
);

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    crew_id INT64 PRIMARY KEY,
    emp_name STRING,
    dept_id INT64,
    CONSTRAINT fk_crew_member_dept FOREIGN KEY (dept_id) REFERENCES fleets(dept_id)
);

INSERT INTO fleets VALUES (10, 'Engineering');
INSERT INTO crew_members VALUES (1, 'Bob', 10);

-- Invalid fleet reference should fail
-- INSERT INTO crew_members VALUES (2, 'Charlie', 99);

-- FOREIGN KEY - ON DELETE CASCADE

-- Cascade delete to child records
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    author_id INT64 PRIMARY KEY,
    name STRING
);

DROP TABLE IF EXISTS books;
CREATE TABLE books (
    book_id INT64 PRIMARY KEY,
    title STRING,
    author_id INT64,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

INSERT INTO authors VALUES (1, 'John Doe');
INSERT INTO books VALUES (100, 'Book 1', 1);
INSERT INTO books VALUES (101, 'Book 2', 1);

-- Delete parent record
DELETE FROM authors WHERE author_id = 1;

-- Child records should be automatically deleted
-- Tag: constraints_primary_foreign_keys_test_select_001
SELECT COUNT(*) FROM books;

-- FOREIGN KEY - ON DELETE SET NULL

-- Set foreign key to NULL when parent is deleted
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    category_id INT64 PRIMARY KEY,
    category_name STRING
);

DROP TABLE IF EXISTS items;
CREATE TABLE items (
    item_id INT64 PRIMARY KEY,
    item_name STRING,
    category_id INT64,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

INSERT INTO categories VALUES (1, 'Electronics');
INSERT INTO items VALUES (100, 'Laptop', 1);

-- Delete parent
DELETE FROM categories WHERE category_id = 1;

-- Child foreign key should be NULL
-- Tag: constraints_primary_foreign_keys_test_select_002
SELECT category_id FROM items WHERE item_id = 100;

-- FOREIGN KEY - ON DELETE RESTRICT

-- Prevent deletion of parent if children exist (default behavior)
DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers (
    supplier_id INT64 PRIMARY KEY,
    supplier_name STRING
);

DROP TABLE IF EXISTS parts;
CREATE TABLE parts (
    part_id INT64 PRIMARY KEY,
    part_name STRING,
    supplier_id INT64,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE RESTRICT
);

INSERT INTO suppliers VALUES (1, 'Supplier A');
INSERT INTO parts VALUES (100, 'Part X', 1);

-- Attempt to delete parent (should fail because child exists)
-- DELETE FROM suppliers WHERE supplier_id = 1;

-- FOREIGN KEY - ON DELETE SET DEFAULT

-- Set foreign key to default value when parent is deleted
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
    region_id INT64 PRIMARY KEY,
    region_name STRING
);

-- Insert default region
INSERT INTO regions VALUES (0, 'Unknown');

DROP TABLE IF EXISTS stores;
CREATE TABLE stores (
    store_id INT64 PRIMARY KEY,
    store_name STRING,
    region_id INT64 DEFAULT 0,
    FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE SET DEFAULT
);

INSERT INTO regions VALUES (1, 'North');
INSERT INTO stores VALUES (100, 'Store A', 1);

-- Delete parent
DELETE FROM regions WHERE region_id = 1;

-- Child foreign key should be set to default (0)
-- Tag: constraints_primary_foreign_keys_test_select_003
SELECT region_id FROM stores WHERE store_id = 100;

-- FOREIGN KEY - ON UPDATE CASCADE

-- Cascade update to child records
DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
    team_id INT64 PRIMARY KEY,
    team_name STRING
);

DROP TABLE IF EXISTS players;
CREATE TABLE players (
    player_id INT64 PRIMARY KEY,
    player_name STRING,
    team_id INT64,
    FOREIGN KEY (team_id) REFERENCES teams(team_id) ON UPDATE CASCADE
);

INSERT INTO teams VALUES (10, 'Team Alpha');
INSERT INTO players VALUES (1, 'Player 1', 10);
INSERT INTO players VALUES (2, 'Player 2', 10);

-- Update parent primary key
UPDATE teams SET team_id = 20 WHERE team_id = 10;

-- Child foreign keys should be automatically updated
-- Tag: constraints_primary_foreign_keys_test_select_004
SELECT team_id FROM players WHERE player_id = 1;

-- FOREIGN KEY - Self-Referencing

-- Table with foreign key referencing itself (tree structure)
DROP TABLE IF EXISTS crew_members_hierarchy;
CREATE TABLE crew_members_hierarchy (
    crew_id INT64 PRIMARY KEY,
    emp_name STRING,
    manager_id INT64,
    FOREIGN KEY (manager_id) REFERENCES crew_members_hierarchy(crew_id)
);

-- Insert CEO (no manager)
INSERT INTO crew_members_hierarchy VALUES (1, 'CEO', NULL);

-- Insert managers
INSERT INTO crew_members_hierarchy VALUES (2, 'Manager A', 1);
INSERT INTO crew_members_hierarchy VALUES (3, 'Manager B', 1);

-- Insert crew_members
INSERT INTO crew_members_hierarchy VALUES (4, 'Employee 1', 2);
INSERT INTO crew_members_hierarchy VALUES (5, 'Employee 2', 2);

-- Query hierarchy
-- Tag: constraints_primary_foreign_keys_test_select_005
SELECT e.emp_name, m.emp_name as manager_name
FROM crew_members_hierarchy e
LEFT JOIN crew_members_hierarchy m ON e.manager_id = m.crew_id;

-- FOREIGN KEY - Multiple Foreign Keys

-- Table with multiple foreign keys
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_id INT64 PRIMARY KEY,
    country_name STRING
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
    city_id INT64 PRIMARY KEY,
    city_name STRING,
    country_id INT64,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses (
    address_id INT64 PRIMARY KEY,
    street STRING,
    city_id INT64,
    country_id INT64,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

INSERT INTO countries VALUES (1, 'USA');
INSERT INTO cities VALUES (100, 'New York', 1);
INSERT INTO addresses VALUES (1000, '123 Main St', 100, 1);

-- FOREIGN KEY - Composite Foreign Key

-- Composite foreign key (multiple columns)
DROP TABLE IF EXISTS order_headers;
CREATE TABLE order_headers (
    order_id INT64,
    marina_id INT64,
    order_date DATE,
    PRIMARY KEY (order_id, marina_id)
);

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    detail_id INT64 PRIMARY KEY,
    order_id INT64,
    marina_id INT64,
    equipment_id INT64,
    FOREIGN KEY (order_id, marina_id) REFERENCES order_headers(order_id, marina_id)
);

INSERT INTO order_headers VALUES (1, 100, DATE '2024-01-15');
INSERT INTO order_details VALUES (1, 1, 100, 500);

-- Invalid composite reference should fail
-- INSERT INTO order_details VALUES (2, 1, 999, 501);

-- FOREIGN KEY - NULL Values

-- Foreign key can be NULL (optional relationship)
DROP TABLE IF EXISTS optional_parent;
CREATE TABLE optional_parent (
    id INT64 PRIMARY KEY,
    name STRING
);

DROP TABLE IF EXISTS optional_child;
CREATE TABLE optional_child (
    id INT64 PRIMARY KEY,
    parent_id INT64,
    FOREIGN KEY (parent_id) REFERENCES optional_parent(id)
);

-- Insert child with NULL foreign key (valid)
INSERT INTO optional_child VALUES (1, NULL);

-- Insert child with valid foreign key
INSERT INTO optional_parent VALUES (100, 'Parent');
INSERT INTO optional_child VALUES (2, 100);

-- PRIMARY KEY - ALTER TABLE ADD

-- Add primary key to existing table
DROP TABLE IF EXISTS add_pk;
CREATE TABLE add_pk (
    id INT64,
    name STRING
);

INSERT INTO add_pk VALUES (1, 'First');

-- Add primary key constraint
ALTER TABLE add_pk ADD CONSTRAINT pk_add_pk PRIMARY KEY (id);

-- Duplicate insert should now fail
-- INSERT INTO add_pk VALUES (1, 'Duplicate');

-- FOREIGN KEY - ALTER TABLE ADD

-- Add foreign key to existing table
DROP TABLE IF EXISTS fk_parent;
CREATE TABLE fk_parent (
    id INT64 PRIMARY KEY,
    name STRING
);

DROP TABLE IF EXISTS fk_child;
CREATE TABLE fk_child (
    id INT64 PRIMARY KEY,
    parent_id INT64
);

-- Add foreign key constraint
ALTER TABLE fk_child ADD CONSTRAINT fk_child_parent
    FOREIGN KEY (parent_id) REFERENCES fk_parent(id);

-- Now foreign key is enforced
INSERT INTO fk_parent VALUES (1, 'Parent');
INSERT INTO fk_child VALUES (1, 1);  -- Valid

-- INSERT INTO fk_child VALUES (2, 999);  -- Invalid

-- DROP CONSTRAINT

-- Drop primary key constraint
DROP TABLE IF EXISTS drop_pk;
CREATE TABLE drop_pk (
    id INT64,
    name STRING,
    CONSTRAINT pk_drop_pk PRIMARY KEY (id)
);

ALTER TABLE drop_pk DROP CONSTRAINT pk_drop_pk;

-- Can now insert duplicates
INSERT INTO drop_pk VALUES (1, 'First');
INSERT INTO drop_pk VALUES (1, 'Duplicate');

-- Drop foreign key constraint
DROP TABLE IF EXISTS drop_fk_parent;
CREATE TABLE drop_fk_parent (
    id INT64 PRIMARY KEY
);

DROP TABLE IF EXISTS drop_fk_child;
CREATE TABLE drop_fk_child (
    id INT64,
    parent_id INT64,
    CONSTRAINT fk_test FOREIGN KEY (parent_id) REFERENCES drop_fk_parent(id)
);

ALTER TABLE drop_fk_child DROP CONSTRAINT fk_test;

-- Can now insert invalid foreign keys
INSERT INTO drop_fk_child VALUES (1, 999);

-- End of File
