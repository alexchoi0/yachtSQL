-- Lateral Joins - SQL:2023
-- Description: LATERAL joins for correlated subqueries in FROM clause
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS yachts;
CREATE TABLE yachts (
    yacht_id INT64 PRIMARY KEY,
    name STRING NOT NULL,
    length_feet INT64,
    home_marina STRING,
    purchase_price NUMERIC(12, 2),
    year_built INT64
);

INSERT INTO yachts VALUES
    (1, 'Sea Breeze', 45, 'Newport Harbor', 450000.00, 2020),
    (2, 'Wind Dancer', 38, 'San Diego Bay', 320000.00, 2019),
    (3, 'Ocean Pearl', 52, 'Newport Harbor', 580000.00, 2021),
    (4, 'Blue Horizon', 41, 'Marina del Rey', 380000.00, 2018),
    (5, 'Wave Runner', 48, 'San Diego Bay', 520000.00, 2022);

DROP TABLE IF EXISTS maintenance_records;
CREATE TABLE maintenance_records (
    record_id INT64 PRIMARY KEY,
    yacht_id INT64,
    service_date DATE,
    service_type STRING,
    cost NUMERIC(10, 2),
    technician STRING,
    FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

INSERT INTO maintenance_records VALUES
    (1, 1, DATE '2024-01-15', 'Engine Service', 2500.00, 'Mike'),
    (2, 1, DATE '2024-02-20', 'Hull Cleaning', 800.00, 'Tom'),
    (3, 1, DATE '2024-03-10', 'Sail Repair', 1200.00, 'Sarah'),
    (4, 2, DATE '2024-01-20', 'Engine Service', 2200.00, 'Mike'),
    (5, 2, DATE '2024-03-15', 'Hull Cleaning', 750.00, 'Tom'),
    (6, 3, DATE '2024-02-05', 'Engine Service', 3000.00, 'Mike'),
    (7, 3, DATE '2024-03-25', 'Electronics Upgrade', 5000.00, 'Dave'),
    (8, 4, DATE '2024-01-10', 'Hull Cleaning', 700.00, 'Tom'),
    (9, 5, DATE '2024-02-15', 'Engine Service', 2800.00, 'Mike');

DROP TABLE IF EXISTS crew_assignments;
CREATE TABLE crew_assignments (
    assignment_id INT64 PRIMARY KEY,
    yacht_id INT64,
    crew_name STRING,
    role STRING,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
);

INSERT INTO crew_assignments VALUES
    (1, 1, 'Captain Jack', 'Captain', DATE '2023-01-01', NULL),
    (2, 1, 'First Mate Sarah', 'First Mate', DATE '2023-02-01', NULL),
    (3, 2, 'Captain Emma', 'Captain', DATE '2023-01-15', NULL),
    (4, 3, 'Captain Tom', 'Captain', DATE '2022-06-01', NULL),
    (5, 3, 'Engineer Bob', 'Engineer', DATE '2023-03-01', NULL),
    (6, 3, 'Deckhand Mike', 'Deckhand', DATE '2023-04-15', DATE '2024-01-31'),
    (7, 4, 'Captain Lisa', 'Captain', DATE '2023-05-01', NULL);

-- ----------------------------------------------------------------------------
-- 1. Basic LATERAL Subquery
-- ----------------------------------------------------------------------------

-- Get each yacht with its most recent maintenance record
-- Tag: joins_lateral_joins_test_select_001
SELECT y.yacht_id, y.name, m.service_date, m.service_type, m.cost
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_002
    SELECT service_date, service_type, cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY service_date DESC
    LIMIT 1
) m;

-- Without LATERAL (for comparison) - this would be more complex with window functions
-- Tag: joins_lateral_joins_test_select_003
SELECT y.yacht_id, y.name, m.service_date, m.service_type, m.cost
FROM yachts y
LEFT JOIN (
-- Tag: joins_lateral_joins_test_select_004
    SELECT *, ROW_NUMBER() OVER (PARTITION BY yacht_id ORDER BY service_date DESC) as rn
    FROM maintenance_records
) m ON y.yacht_id = m.yacht_id AND m.rn = 1;

-- ----------------------------------------------------------------------------
-- 2. LATERAL with Correlated References
-- ----------------------------------------------------------------------------

-- Get yachts with their total maintenance cost
-- Tag: joins_lateral_joins_test_select_005
SELECT y.yacht_id, y.name, costs.total_cost, costs.service_count
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_001
    SELECT
        COUNT(*) AS service_count,
        SUM(cost) AS total_cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) costs;

-- Get yachts with average maintenance cost above threshold
-- Tag: joins_lateral_joins_test_select_006
SELECT y.yacht_id, y.name, avg_costs.avg_cost
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_007
    SELECT AVG(cost) AS avg_cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) avg_costs
WHERE avg_costs.avg_cost > 1000;

-- ----------------------------------------------------------------------------
-- 3. LATERAL with Aggregate Functions
-- ----------------------------------------------------------------------------

-- Get yachts with their top 2 most expensive maintenance services
-- Tag: joins_lateral_joins_test_select_008
SELECT y.name, top_services.service_type, top_services.cost
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_009
    SELECT service_type, cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY cost DESC
    LIMIT 2
) top_services
ORDER BY y.name, top_services.cost DESC;

-- Get crew count and total maintenance for each yacht
-- Tag: joins_lateral_joins_test_select_002
SELECT
    y.yacht_id,
    y.name,
    crew_info.crew_count,
    maint_info.total_maintenance
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_010
    SELECT COUNT(*) AS crew_count
    FROM crew_assignments
    WHERE yacht_id = y.yacht_id AND end_date IS NULL
) crew_info
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_011
    SELECT COALESCE(SUM(cost), 0) AS total_maintenance
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) maint_info;

-- ----------------------------------------------------------------------------
-- 4. LATERAL with Window Functions
-- ----------------------------------------------------------------------------

-- Get each yacht's maintenance with running total
-- Tag: joins_lateral_joins_test_select_003
SELECT
    y.yacht_id,
    y.name,
    maint.service_date,
    maint.cost,
    maint.running_total
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_004
    SELECT
        service_date,
        cost,
        SUM(cost) OVER (ORDER BY service_date) AS running_total
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY service_date
) maint
WHERE y.yacht_id = 1;

-- Rank services by cost within each yacht
-- Tag: joins_lateral_joins_test_select_005
SELECT
    y.name,
    ranked.service_type,
    ranked.cost,
    ranked.cost_rank
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_006
    SELECT
        service_type,
        cost,
        RANK() OVER (ORDER BY cost DESC) AS cost_rank
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) ranked
WHERE ranked.cost_rank <= 3
ORDER BY y.name, ranked.cost_rank;

-- ----------------------------------------------------------------------------
-- 5. LATERAL with LIMIT/TOP
-- ----------------------------------------------------------------------------

-- Get the 3 most recent maintenance records for each yacht
-- Tag: joins_lateral_joins_test_select_012
SELECT y.name, recent.service_date, recent.service_type
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_013
    SELECT service_date, service_type
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY service_date DESC
    LIMIT 3
) recent
ORDER BY y.name, recent.service_date DESC;

-- Get yachts and their most expensive service
-- Tag: joins_lateral_joins_test_select_014
SELECT y.yacht_id, y.name, expensive.service_type, expensive.cost
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_015
    SELECT service_type, cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY cost DESC
    LIMIT 1
) expensive;

-- ----------------------------------------------------------------------------
-- 6. LEFT JOIN LATERAL (Optional Match)
-- ----------------------------------------------------------------------------

-- Get all yachts, with most recent maintenance if available
-- Tag: joins_lateral_joins_test_select_016
SELECT y.yacht_id, y.name, m.service_date, m.service_type
FROM yachts y
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_017
    SELECT service_date, service_type
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY service_date DESC
    LIMIT 1
) m ON true;

-- Get all yachts with active crew count (may be 0)
-- Tag: joins_lateral_joins_test_select_018
SELECT y.yacht_id, y.name, COALESCE(crew.count, 0) AS active_crew
FROM yachts y
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_019
    SELECT COUNT(*) AS count
    FROM crew_assignments
    WHERE yacht_id = y.yacht_id AND end_date IS NULL
) crew ON true;

-- ----------------------------------------------------------------------------
-- 7. CROSS JOIN LATERAL
-- ----------------------------------------------------------------------------

-- Equivalent to LATERAL without LEFT (inner join behavior)
-- Tag: joins_lateral_joins_test_select_020
SELECT y.name, services.service_type
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_021
    SELECT DISTINCT service_type
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) services;

-- Generate series with LATERAL (if supported)
-- Tag: joins_lateral_joins_test_select_022
SELECT y.yacht_id, y.name, months.month_num
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_023
    SELECT 1 AS month_num UNION ALL SELECT 2 UNION ALL SELECT 3
) months
WHERE y.yacht_id <= 2;

-- ----------------------------------------------------------------------------
-- 8. Multiple LATERAL Joins
-- ----------------------------------------------------------------------------

-- Chain multiple LATERAL joins
-- Tag: joins_lateral_joins_test_select_007
SELECT
    y.yacht_id,
    y.name,
    latest_maint.service_date,
    latest_crew.crew_name
FROM yachts y
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_024
    SELECT service_date, service_type
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
    ORDER BY service_date DESC
    LIMIT 1
) latest_maint ON true
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_025
    SELECT crew_name, role
    FROM crew_assignments
    WHERE yacht_id = y.yacht_id AND end_date IS NULL
    ORDER BY start_date
    LIMIT 1
) latest_crew ON true;

-- Complex multi-lateral join
-- Tag: joins_lateral_joins_test_select_008
SELECT
    y.yacht_id,
    y.name,
    stats.total_cost,
    recent.last_service
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_026
    SELECT SUM(cost) AS total_cost, COUNT(*) AS service_count
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) stats
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_027
    SELECT MAX(service_date) AS last_service
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) recent
WHERE stats.service_count > 0;

-- ----------------------------------------------------------------------------
-- 9. LATERAL with Table-Valued Functions (if supported)
-- ----------------------------------------------------------------------------

-- Simulate table-valued function with subquery
-- Tag: joins_lateral_joins_test_select_028
SELECT y.yacht_id, y.name, price_calc.estimated_value
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_009
    SELECT
        y.purchase_price * (1 - (EXTRACT(YEAR FROM CURRENT_DATE) - y.year_built) * 0.05) AS estimated_value
) price_calc
WHERE price_calc.estimated_value > 300000;

-- ----------------------------------------------------------------------------
-- 10. Practical Use Cases
-- ----------------------------------------------------------------------------

-- Use Case 1: Find yachts needing service (no maintenance in 3 months)
-- Tag: joins_lateral_joins_test_select_029
SELECT y.yacht_id, y.name, y.home_marina, last_service.days_since
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_010
    SELECT
        COALESCE(
            CURRENT_DATE - MAX(service_date),
            999
        ) AS days_since
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) last_service
WHERE last_service.days_since > 90;

-- Use Case 2: Calculate maintenance cost per foot of yacht
-- Tag: joins_lateral_joins_test_select_011
SELECT
    y.yacht_id,
    y.name,
    y.length_feet,
    costs.total_cost,
    costs.total_cost / y.length_feet AS cost_per_foot
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_030
    SELECT COALESCE(SUM(cost), 0) AS total_cost
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id
) costs
ORDER BY cost_per_foot DESC;

-- Use Case 3: Find overstaffed/understaffed yachts
-- Tag: joins_lateral_joins_test_select_012
SELECT
    y.yacht_id,
    y.name,
    y.length_feet,
    crew_count.active_crew,
    CASE
        WHEN crew_count.active_crew < y.length_feet / 20 THEN 'Understaffed'
        WHEN crew_count.active_crew > y.length_feet / 10 THEN 'Overstaffed'
        ELSE 'Adequately Staffed'
    END AS staffing_status
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_031
    SELECT COUNT(*) AS active_crew
    FROM crew_assignments
    WHERE yacht_id = y.yacht_id AND end_date IS NULL
) crew_count;

-- Use Case 4: Technician workload analysis
DROP TABLE IF EXISTS technicians;
CREATE TABLE technicians (
    tech_id INT64 PRIMARY KEY,
    name STRING,
    specialty STRING
);

INSERT INTO technicians VALUES
    (1, 'Mike', 'Engine'),
    (2, 'Tom', 'Hull'),
    (3, 'Sarah', 'Sails'),
    (4, 'Dave', 'Electronics');

-- Tag: joins_lateral_joins_test_select_013
SELECT
    t.name AS technician,
    t.specialty,
    workload.job_count,
    workload.total_revenue
FROM technicians t
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_014
    SELECT
        COUNT(*) AS job_count,
        SUM(cost) AS total_revenue
    FROM maintenance_records
    WHERE technician = t.name
) workload ON true
ORDER BY workload.total_revenue DESC NULLS LAST;

-- Use Case 5: Marina occupancy with yacht details
DROP TABLE IF EXISTS marinas;
CREATE TABLE marinas (
    marina_id INT64 PRIMARY KEY,
    name STRING,
    location STRING,
    total_slips INT64
);

INSERT INTO marinas VALUES
    (1, 'Newport Harbor', 'Newport Beach, CA', 150),
    (2, 'San Diego Bay', 'San Diego, CA', 200),
    (3, 'Marina del Rey', 'Los Angeles, CA', 180);

-- Tag: joins_lateral_joins_test_select_015
SELECT
    m.name AS marina,
    m.total_slips,
    occupancy.yacht_count,
    occupancy.avg_length,
    (occupancy.yacht_count::FLOAT / m.total_slips * 100) AS occupancy_rate
FROM marinas m
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_016
    SELECT
        COUNT(*) AS yacht_count,
        AVG(length_feet) AS avg_length
    FROM yachts
    WHERE home_marina = m.name
) occupancy ON true
ORDER BY occupancy_rate DESC;

-- ----------------------------------------------------------------------------
-- 11. LATERAL with CTEs
-- ----------------------------------------------------------------------------

-- Combine CTE with LATERAL
WITH yacht_categories AS (
-- Tag: joins_lateral_joins_test_select_017
    SELECT
        yacht_id,
        name,
        CASE
            WHEN length_feet > 50 THEN 'Large'
            WHEN length_feet > 40 THEN 'Medium'
            ELSE 'Small'
        END AS category
    FROM yachts
)
-- Tag: joins_lateral_joins_test_select_018
SELECT
    yc.name,
    yc.category,
    maint_stats.avg_cost
FROM yacht_categories yc
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_032
    SELECT AVG(cost) AS avg_cost
    FROM maintenance_records
    WHERE yacht_id = yc.yacht_id
) maint_stats
WHERE maint_stats.avg_cost IS NOT NULL
ORDER BY yc.category, maint_stats.avg_cost DESC;

-- ----------------------------------------------------------------------------
-- 12. Edge Cases
-- ----------------------------------------------------------------------------

-- LATERAL with no matching rows
-- Tag: joins_lateral_joins_test_select_033
SELECT y.yacht_id, y.name, fake.value
FROM yachts y
LEFT JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_034
    SELECT 'no data' AS value
    FROM maintenance_records
    WHERE yacht_id = y.yacht_id AND cost > 1000000
    LIMIT 1
) fake ON true;

-- LATERAL with DISTINCT
-- Tag: joins_lateral_joins_test_select_035
SELECT DISTINCT y.home_marina, crew_roles.role
FROM yachts y
CROSS JOIN LATERAL (
-- Tag: joins_lateral_joins_test_select_036
    SELECT DISTINCT role
    FROM crew_assignments
    WHERE yacht_id = y.yacht_id
) crew_roles
ORDER BY y.home_marina, crew_roles.role;

-- End of LATERAL Joins Tests
