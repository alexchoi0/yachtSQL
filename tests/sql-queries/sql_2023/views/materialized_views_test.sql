-- Materialized Views - SQL:2023
-- Description: Materialized views for query result caching
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS yachts;
CREATE TABLE yachts (
    yacht_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    model STRING,
    length_feet INT64,
    manufacturer STRING,
    year_built INT64,
    purchase_price NUMERIC(12, 2),
    home_marina STRING,
    status STRING
);

INSERT INTO yachts VALUES
    (1, 'Sea Breeze', 'Oceanis 45', 45, 'Beneteau', 2020, 450000.00, 'Newport Harbor', 'active'),
    (2, 'Wind Dancer', 'Sun Odyssey 380', 38, 'Jeanneau', 2019, 320000.00, 'San Diego Bay', 'active'),
    (3, 'Ocean Pearl', 'Bavaria 50', 52, 'Bavaria', 2021, 580000.00, 'Newport Harbor', 'active'),
    (4, 'Blue Horizon', 'Hanse 41', 41, 'Hanse', 2018, 380000.00, 'Marina del Rey', 'maintenance'),
    (5, 'Wave Runner', 'Lagoon 48', 48, 'Lagoon', 2022, 520000.00, 'San Diego Bay', 'active'),
    (6, 'Sunset Cruiser', 'Catalina 42', 42, 'Catalina', 2020, 360000.00, 'Newport Harbor', 'sold');

DROP TABLE IF EXISTS maintenance_records;
CREATE TABLE maintenance_records (
    record_id INT64 PRIMARY KEY,
    yacht_id INT64,
    service_date DATE,
    service_type STRING,
    cost NUMERIC(10, 2),
    technician STRING,
    completed BOOLEAN DEFAULT false,
    FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

INSERT INTO maintenance_records VALUES
    (1, 1, DATE '2024-01-15', 'Engine Service', 2500.00, 'Mike', true),
    (2, 1, DATE '2024-02-20', 'Hull Cleaning', 800.00, 'Tom', true),
    (3, 2, DATE '2024-01-20', 'Engine Service', 2200.00, 'Mike', true),
    (4, 2, DATE '2024-03-15', 'Hull Cleaning', 750.00, 'Tom', false),
    (5, 3, DATE '2024-02-05', 'Engine Service', 3000.00, 'Mike', true),
    (6, 3, DATE '2024-03-25', 'Electronics Upgrade', 5000.00, 'Dave', true),
    (7, 4, DATE '2024-01-10', 'Hull Cleaning', 700.00, 'Tom', true),
    (8, 5, DATE '2024-02-15', 'Engine Service', 2800.00, 'Mike', true);

DROP TABLE IF EXISTS crew_assignments;
CREATE TABLE crew_assignments (
    assignment_id INT64 PRIMARY KEY,
    yacht_id INT64,
    crew_name STRING,
    role STRING,
    start_date DATE,
    end_date DATE,
    monthly_salary NUMERIC(10, 2),
    FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

INSERT INTO crew_assignments VALUES
    (1, 1, 'Captain Jack', 'Captain', DATE '2023-01-01', NULL, 7500.00),
    (2, 1, 'First Mate Sarah', 'First Mate', DATE '2023-02-01', NULL, 5500.00),
    (3, 2, 'Captain Emma', 'Captain', DATE '2023-01-15', NULL, 8000.00),
    (4, 3, 'Captain Tom', 'Captain', DATE '2022-06-01', NULL, 8500.00),
    (5, 3, 'Engineer Bob', 'Engineer', DATE '2023-03-01', NULL, 6000.00),
    (6, 4, 'Captain Lisa', 'Captain', DATE '2023-05-01', NULL, 7000.00);

-- ----------------------------------------------------------------------------
-- 1. Basic Materialized View Creation
-- ----------------------------------------------------------------------------

-- Simple aggregation: Total maintenance cost per yacht
DROP MATERIALIZED VIEW IF EXISTS yacht_maintenance_summary;
CREATE MATERIALIZED VIEW yacht_maintenance_summary AS
-- Tag: views_materialized_views_test_select_001
SELECT
    y.yacht_id,
    y.name,
    COUNT(m.record_id) AS maintenance_count,
    COALESCE(SUM(m.cost), 0) AS total_maintenance_cost,
    COALESCE(AVG(m.cost), 0) AS avg_maintenance_cost
FROM yachts y
LEFT JOIN maintenance_records m ON y.yacht_id = m.yacht_id
GROUP BY y.yacht_id, y.name;

-- Query the materialized view
-- Tag: views_materialized_views_test_select_001
SELECT * FROM yacht_maintenance_summary
ORDER BY total_maintenance_cost DESC;

-- Materialized view with WHERE clause
DROP MATERIALIZED VIEW IF EXISTS active_yachts_mv;
CREATE MATERIALIZED VIEW active_yachts_mv AS
-- Tag: views_materialized_views_test_select_002
SELECT yacht_id, name, model, length_feet, manufacturer, purchase_price
FROM yachts
WHERE status = 'active';

-- Tag: views_materialized_views_test_select_003
SELECT * FROM active_yachts_mv
ORDER BY purchase_price DESC;

-- ----------------------------------------------------------------------------
-- 2. Materialized Views with Joins
-- ----------------------------------------------------------------------------

-- Join multiple tables
DROP MATERIALIZED VIEW IF EXISTS yacht_crew_costs;
CREATE MATERIALIZED VIEW yacht_crew_costs AS
-- Tag: views_materialized_views_test_select_002
SELECT
    y.yacht_id,
    y.name AS yacht_name,
    y.manufacturer,
    COUNT(DISTINCT c.assignment_id) AS crew_count,
    COALESCE(SUM(c.monthly_salary), 0) AS monthly_crew_cost,
    COALESCE(SUM(m.cost), 0) AS total_maintenance
FROM yachts y
LEFT JOIN crew_assignments c ON y.yacht_id = c.yacht_id AND c.end_date IS NULL
LEFT JOIN maintenance_records m ON y.yacht_id = m.yacht_id
GROUP BY y.yacht_id, y.name, y.manufacturer;

-- Tag: views_materialized_views_test_select_004
SELECT yacht_name, crew_count, monthly_crew_cost, total_maintenance
FROM yacht_crew_costs
WHERE crew_count > 0
ORDER BY monthly_crew_cost DESC;

-- Complex join with calculations
DROP MATERIALIZED VIEW IF EXISTS yacht_profitability;
CREATE MATERIALIZED VIEW yacht_profitability AS
-- Tag: views_materialized_views_test_select_003
SELECT
    y.yacht_id,
    y.name,
    y.purchase_price,
    COALESCE(SUM(m.cost), 0) AS total_maintenance,
    COALESCE(SUM(c.monthly_salary) * 12, 0) AS annual_crew_cost,
    y.purchase_price * 0.05 AS annual_depreciation,
    (y.purchase_price * 0.05) +
    COALESCE(SUM(m.cost), 0) +
    COALESCE(SUM(c.monthly_salary) * 12, 0) AS total_annual_cost
FROM yachts y
LEFT JOIN maintenance_records m ON y.yacht_id = m.yacht_id
LEFT JOIN crew_assignments c ON y.yacht_id = c.yacht_id AND c.end_date IS NULL
GROUP BY y.yacht_id, y.name, y.purchase_price;

-- Tag: views_materialized_views_test_select_005
SELECT * FROM yacht_profitability
ORDER BY total_annual_cost DESC;

-- ----------------------------------------------------------------------------
-- 3. REFRESH MATERIALIZED VIEW
-- ----------------------------------------------------------------------------

-- Add new maintenance record
INSERT INTO maintenance_records VALUES
    (9, 1, DATE '2024-04-10', 'Sail Repair', 1500.00, 'Sarah', true);

-- Before refresh - old data
-- Tag: views_materialized_views_test_select_006
SELECT * FROM yacht_maintenance_summary WHERE yacht_id = 1;

-- Refresh the materialized view
REFRESH MATERIALIZED VIEW yacht_maintenance_summary;

-- After refresh - updated data
-- Tag: views_materialized_views_test_select_007
SELECT * FROM yacht_maintenance_summary WHERE yacht_id = 1;

-- Refresh all related materialized views
REFRESH MATERIALIZED VIEW yacht_crew_costs;
REFRESH MATERIALIZED VIEW yacht_profitability;

-- ----------------------------------------------------------------------------
-- 4. Materialized Views with Window Functions
-- ----------------------------------------------------------------------------

-- Ranking yachts by purchase price
DROP MATERIALIZED VIEW IF EXISTS yacht_price_rankings;
CREATE MATERIALIZED VIEW yacht_price_rankings AS
-- Tag: views_materialized_views_test_select_004
SELECT
    yacht_id,
    name,
    manufacturer,
    purchase_price,
    RANK() OVER (ORDER BY purchase_price DESC) AS price_rank,
    RANK() OVER (PARTITION BY manufacturer ORDER BY purchase_price DESC) AS manuf_rank,
    ROW_NUMBER() OVER (ORDER BY purchase_price DESC) AS row_num
FROM yachts
WHERE status IN ('active', 'maintenance');

-- Tag: views_materialized_views_test_select_008
SELECT * FROM yacht_price_rankings
ORDER BY price_rank;

-- Running totals
DROP MATERIALIZED VIEW IF EXISTS yacht_inventory_trends;
CREATE MATERIALIZED VIEW yacht_inventory_trends AS
-- Tag: views_materialized_views_test_select_005
SELECT
    yacht_id,
    name,
    year_built,
    purchase_price,
    SUM(purchase_price) OVER (ORDER BY year_built, yacht_id) AS cumulative_value,
    AVG(purchase_price) OVER (ORDER BY year_built ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_price
FROM yachts
ORDER BY year_built, yacht_id;

-- Tag: views_materialized_views_test_select_009
SELECT * FROM yacht_inventory_trends
ORDER BY year_built;

-- ----------------------------------------------------------------------------
-- 5. Materialized Views with CTEs
-- ----------------------------------------------------------------------------

-- Complex query with CTE
DROP MATERIALIZED VIEW IF EXISTS marina_statistics;
CREATE MATERIALIZED VIEW marina_statistics AS
WITH marina_yachts AS (
-- Tag: views_materialized_views_test_select_006
    SELECT
        home_marina,
        COUNT(*) AS yacht_count,
        AVG(length_feet) AS avg_length,
        SUM(purchase_price) AS total_value
    FROM yachts
    WHERE status = 'active'
    GROUP BY home_marina
),
marina_maintenance AS (
-- Tag: views_materialized_views_test_select_007
    SELECT
        y.home_marina,
        COUNT(m.record_id) AS total_services,
        SUM(m.cost) AS total_cost
    FROM yachts y
    JOIN maintenance_records m ON y.yacht_id = m.yacht_id
    GROUP BY y.home_marina
)
-- Tag: views_materialized_views_test_select_008
SELECT
    my.home_marina,
    my.yacht_count,
    my.avg_length,
    my.total_value,
    COALESCE(mm.total_services, 0) AS maintenance_services,
    COALESCE(mm.total_cost, 0) AS maintenance_costs
FROM marina_yachts my
LEFT JOIN marina_maintenance mm ON my.home_marina = mm.home_marina;

-- Tag: views_materialized_views_test_select_010
SELECT * FROM marina_statistics
ORDER BY yacht_count DESC;

-- ----------------------------------------------------------------------------
-- 6. Materialized Views for Performance Optimization
-- ----------------------------------------------------------------------------

-- Dashboard summary view (expensive to compute repeatedly)
DROP MATERIALIZED VIEW IF EXISTS fleet_dashboard;
CREATE MATERIALIZED VIEW fleet_dashboard AS
-- Tag: views_materialized_views_test_select_009
SELECT
    (SELECT COUNT(*) FROM yachts WHERE status = 'active') AS active_count,
    (SELECT COUNT(*) FROM yachts WHERE status = 'maintenance') AS maintenance_count,
    (SELECT COUNT(*) FROM yachts WHERE status = 'sold') AS sold_count,
    (SELECT AVG(purchase_price) FROM yachts) AS avg_yacht_value,
    (SELECT SUM(cost) FROM maintenance_records WHERE completed = true) AS total_maintenance_spent,
    (SELECT COUNT(DISTINCT home_marina) FROM yachts) AS marina_count,
    (SELECT SUM(monthly_salary) FROM crew_assignments WHERE end_date IS NULL) AS monthly_payroll;

-- Tag: views_materialized_views_test_select_011
SELECT * FROM fleet_dashboard;

-- Denormalized view for reporting
DROP MATERIALIZED VIEW IF EXISTS yacht_full_details;
CREATE MATERIALIZED VIEW yacht_full_details AS
-- Tag: views_materialized_views_test_select_010
SELECT
    y.yacht_id,
    y.name,
    y.model,
    y.length_feet,
    y.manufacturer,
    y.year_built,
    y.purchase_price,
    y.home_marina,
    y.status,
    COALESCE(crew.crew_count, 0) AS crew_count,
    COALESCE(crew.total_payroll, 0) AS monthly_payroll,
    COALESCE(maint.service_count, 0) AS total_services,
    COALESCE(maint.total_cost, 0) AS total_maintenance_cost,
    COALESCE(maint.last_service, NULL) AS last_service_date
FROM yachts y
LEFT JOIN (
-- Tag: views_materialized_views_test_select_011
    SELECT
        yacht_id,
        COUNT(*) AS crew_count,
        SUM(monthly_salary) AS total_payroll
    FROM crew_assignments
    WHERE end_date IS NULL
    GROUP BY yacht_id
) crew ON y.yacht_id = crew.yacht_id
LEFT JOIN (
-- Tag: views_materialized_views_test_select_012
    SELECT
        yacht_id,
        COUNT(*) AS service_count,
        SUM(cost) AS total_cost,
        MAX(service_date) AS last_service
    FROM maintenance_records
    GROUP BY yacht_id
) maint ON y.yacht_id = maint.yacht_id;

-- Tag: views_materialized_views_test_select_012
SELECT * FROM yacht_full_details
ORDER BY total_maintenance_cost DESC;

-- ----------------------------------------------------------------------------
-- 7. Materialized Views with DISTINCT and Set Operations
-- ----------------------------------------------------------------------------

-- Unique manufacturers with yacht counts
DROP MATERIALIZED VIEW IF EXISTS manufacturer_summary;
CREATE MATERIALIZED VIEW manufacturer_summary AS
-- Tag: views_materialized_views_test_select_013
SELECT
    manufacturer,
    COUNT(DISTINCT yacht_id) AS yacht_count,
    AVG(length_feet) AS avg_length,
    MIN(purchase_price) AS min_price,
    MAX(purchase_price) AS max_price,
    AVG(purchase_price) AS avg_price
FROM yachts
GROUP BY manufacturer
HAVING COUNT(*) > 0;

-- Tag: views_materialized_views_test_select_013
SELECT * FROM manufacturer_summary
ORDER BY yacht_count DESC;

-- ----------------------------------------------------------------------------
-- 8. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Use Case 1: Monthly Reporting View
DROP MATERIALIZED VIEW IF EXISTS monthly_operations_report;
CREATE MATERIALIZED VIEW monthly_operations_report AS
-- Tag: views_materialized_views_test_select_014
SELECT
    DATE_TRUNC('month', m.service_date) AS report_month,
    COUNT(DISTINCT m.yacht_id) AS yachts_serviced,
    COUNT(m.record_id) AS total_services,
    SUM(m.cost) AS total_revenue,
    AVG(m.cost) AS avg_service_cost,
    COUNT(DISTINCT m.technician) AS technicians_active
FROM maintenance_records m
WHERE m.completed = true
GROUP BY DATE_TRUNC('month', m.service_date);

-- Tag: views_materialized_views_test_select_014
SELECT * FROM monthly_operations_report
ORDER BY report_month DESC;

-- Use Case 2: Technician Performance View
DROP MATERIALIZED VIEW IF EXISTS technician_performance;
CREATE MATERIALIZED VIEW technician_performance AS
-- Tag: views_materialized_views_test_select_015
SELECT
    technician,
    COUNT(*) AS jobs_completed,
    SUM(cost) AS total_revenue,
    AVG(cost) AS avg_job_value,
    COUNT(DISTINCT yacht_id) AS unique_clients,
    MIN(service_date) AS first_job,
    MAX(service_date) AS most_recent_job
FROM maintenance_records
WHERE completed = true
GROUP BY technician;

-- Tag: views_materialized_views_test_select_015
SELECT * FROM technician_performance
ORDER BY total_revenue DESC;

-- Use Case 3: Yacht Valuation View (depreciation)
DROP MATERIALIZED VIEW IF EXISTS yacht_valuations;
CREATE MATERIALIZED VIEW yacht_valuations AS
-- Tag: views_materialized_views_test_select_016
SELECT
    yacht_id,
    name,
    purchase_price AS original_price,
    year_built,
    EXTRACT(YEAR FROM CURRENT_DATE) - year_built AS age_years,
    purchase_price * POWER(0.95, EXTRACT(YEAR FROM CURRENT_DATE) - year_built) AS estimated_value,
    purchase_price - (purchase_price * POWER(0.95, EXTRACT(YEAR FROM CURRENT_DATE) - year_built)) AS depreciation
FROM yachts
WHERE status IN ('active', 'maintenance');

-- Tag: views_materialized_views_test_select_016
SELECT * FROM yacht_valuations
ORDER BY estimated_value DESC;

-- ----------------------------------------------------------------------------
-- 9. DROP Materialized Views
-- ----------------------------------------------------------------------------

-- Drop single materialized view

-- Drop with CASCADE (if dependencies exist - implementation dependent)
-- DROP MATERIALIZED VIEW yacht_maintenance_summary CASCADE;

-- Verify dropped
-- SELECT * FROM yacht_price_rankings;  -- Should error

-- ----------------------------------------------------------------------------
-- 10. Refresh Strategies
-- ----------------------------------------------------------------------------

-- Manual refresh (shown earlier)
REFRESH MATERIALIZED VIEW yacht_maintenance_summary;

-- Conditional refresh based on data changes
INSERT INTO yachts VALUES
    (7, 'New Yacht', 'Model X', 50, 'Test Manufacturer', 2024, 500000.00, 'Newport Harbor', 'active');

-- Refresh affected views
REFRESH MATERIALIZED VIEW active_yachts_mv;
REFRESH MATERIALIZED VIEW yacht_full_details;
REFRESH MATERIALIZED VIEW manufacturer_summary;

-- ----------------------------------------------------------------------------
-- 11. Querying and Indexing Materialized Views
-- ----------------------------------------------------------------------------

-- Materialized views can be indexed for better query performance
-- CREATE INDEX idx_mv_yacht_maint ON yacht_maintenance_summary(yacht_id);
-- CREATE INDEX idx_mv_yacht_cost ON yacht_crew_costs(yacht_name);

-- Query with filters (benefits from indexes)
-- Tag: views_materialized_views_test_select_017
SELECT * FROM yacht_maintenance_summary
WHERE total_maintenance_cost > 2000
ORDER BY avg_maintenance_cost DESC;

-- Join materialized views together
-- Tag: views_materialized_views_test_select_017
SELECT
    yms.name,
    yms.total_maintenance_cost,
    ycc.monthly_crew_cost
FROM yacht_maintenance_summary yms
JOIN yacht_crew_costs ycc ON yms.yacht_id = ycc.yacht_id
WHERE ycc.crew_count > 1;

-- ----------------------------------------------------------------------------
-- Cleanup
-- ----------------------------------------------------------------------------


-- End of Materialized Views Tests
