-- Any Value - SQL:2023
-- Description: Minimal ANY_VALUE aggregates including NULL and DISTINCT examples.

DROP TABLE IF EXISTS crew_rollup;

CREATE TABLE crew_rollup (
    fleet STRING,
    manager STRING,
    office STRING
);

INSERT INTO crew_rollup VALUES ('Engineering', 'mgr-eng', 'Building A');
INSERT INTO crew_rollup VALUES ('Engineering', 'mgr-eng', 'Building A');
INSERT INTO crew_rollup VALUES ('Sales', 'mgr-sales', 'Building B');

-- Tag: any_value_manager
SELECT fleet, ANY_VALUE(manager) AS manager
FROM crew_rollup
GROUP BY fleet
ORDER BY fleet;

-- Tag: any_value_office
SELECT fleet, ANY_VALUE(office) AS office
FROM crew_rollup
GROUP BY fleet
ORDER BY fleet;

UPDATE crew_rollup SET office = NULL WHERE fleet = 'Sales';

-- Tag: any_value_office_with_null
SELECT fleet, ANY_VALUE(office) AS office
FROM crew_rollup
GROUP BY fleet
ORDER BY fleet;

DROP TABLE IF EXISTS category_suppliers;

CREATE TABLE category_suppliers (
    category STRING,
    supplier STRING
);

INSERT INTO category_suppliers VALUES ('Electronics', 'SupplyCo');
INSERT INTO category_suppliers VALUES ('Electronics', 'MegaSupply');
INSERT INTO category_suppliers VALUES ('Furniture', 'FurnishPlus');
INSERT INTO category_suppliers VALUES ('Furniture', 'FurnishPlus');

-- Tag: any_value_distinct_supplier
SELECT category, ANY_VALUE(DISTINCT supplier) AS any_supplier
FROM category_suppliers
GROUP BY category
ORDER BY category;
